/**
 *  @file      tl.c
 *  @brief     timeline based on array.
 *  @details   task type:
 *             periodic task: execute periodically
 *             oneshot task: execute only once (period = 0)
 *             Three state of a function:
 *             1. ready state: the tasks in ready state with be called when
 *                             the execution time is arrived
 *             2. pause state: the task will not execute during pause state.
 *                             Example, a task f1 with perido of p1, is paused
 *                             when at tick t1, at the moment of t1, the f1 waited
 *                             w1 ticks, and still have (p1-w1) ticks to be executed
 *                             again. After f1 is resumed at tick t2, f1 will have
 *                             to wait (p1-w1) ticks to execte again at t2+p1-w1.
 *             3. dead state: a task in dead state will be destroyed and can not
 *                            be used again.
 *             In this implementation, oneshot function can also be paused and resumed.
 *  @author    Dong Xia
 *  @version   1.0
 *  @date      16/01/2025
 *  @warning   Improper use can crash your application
 *  @copyright Perkons S.A.
 *  @note
 *  @todo
 */
/* Includes ------------------------------------------------------------------*/
#include <stdio.h>
#include "tl_pico.h"
#include "string.h"

/* Private typedef -----------------------------------------------------------*/
/* Private define ------------------------------------------------------------*/
#define CHK_TASK(tl, task) ((task != NULL) && (task->belong_to == tl))
#define CHK_TL(tl) (tl != NULL)
/* Private macro -------------------------------------------------------------*/
/* Private variables ---------------------------------------------------------*/
//////////////////////////////////////////////
/// Descriptions                           ///
//////////////////////////////////////////////

/* Global variable -----------------------------------------------------------*/
/* External variable ---------------------------------------------------------*/
/* Private function prototypes -----------------------------------------------*/
static tl_task_t tl_get_taskmem(tl_t tl);
static tl_task_t tl_find(tl_t tl, run_t run);
/* Private functions ---------------------------------------------------------*/
/* Public functions ---------------------------------------------------------*/
#if TL_PICO_STATIC == 0
/**
 * @details
 * Create a time line.
 * @param [in] sz the size of task array
 * @return time line handler.
 *
 * @todo
 * Test - OK
 */
tl_t tl_create(uint8_t sz)
{
    size_t size = sizeof(struct tl_str);
    tl_t t = (tl_t)malloc(sizeof(struct tl_str));
    tl_init(t, sz);
    return t;
}

/**
 * @details
 * Initialization of time line
 * @param [in] tl timeline
 * @param [in] tstart function pointer to start a timer
 * @return None.
 *
 * @todo
 * Test - OK
 */
void tl_init(tl_t tl, uint8_t max_sz)
{
    size_t sz = sizeof(tl_ele_t)*max_sz;
    tl->tasks = (tl_ele_t *)malloc(sz);
    memset(tl->tasks, 0, sz);
    tl->tick = 0;
    tl->task_sz = 0;
    tl->max_sz = max_sz;
}
#else
void tl_init(tl_t tl, uint8_t max_sz, tl_task_t buf)
{
	size_t sz = 0;
	if(!CHK_TL(tl)) return;
	if(buf == NULL) return;
    sz = sizeof(tl_ele_t)*max_sz;
    tl->tasks = buf;
    memset(tl->tasks, 0, sz);
    tl->tick = 0;
    tl->task_sz = 0;
    tl->max_sz = max_sz;
    tl->disable = 0;
}
#endif


/**
 * @details
 * Add a task to and put it into ready state.
 *
 * @param [in] tl timeline that the task be added to
 * @param [in] run callback function
 * @param [in] delay delay in ticks
 * @param [in] period period in ticks
 *            0, the task execute only once, it is a oneshot task
 * @param [in] st task state when created
 * @param [in] parm task parameter
 * @return a task handler
 *
 */
tl_task_t tl_add(tl_t tl, run_t run, uint32_t delay, uint32_t period, task_st_t st, tl_task_param_t param)
{
    tl_task_t tsk = NULL;
	if(!CHK_TL(tl)) return NULL;
    if(st == TL_DEAD) return NULL;
    tsk = tl_get_taskmem(tl);
    if(tsk == NULL) return NULL;
    tsk->belong_to = tl;
    tsk->run = run;
    tsk->period = period;
    tsk->next_exe_ts = tl->tick + delay + 1;
    tsk->st = st;
    tsk->param = param;
    _ENTER_CRITICAL_SECTION();
    tl->task_sz++;
    _LEAVE_CRITICAL_SECTION();
    return tsk;
}

/**
 * @details
 * Add a singleton task, only should exist one task in the timeline
 * update the task parameter if already exist
 *
 * @param [in] tl timeline that the task be added to
 * @param [in] run callback function
 * @param [in] delay delay in ticks
 * @param [in] period period in ticks
 *            0, the task execute only once, it is a oneshot task
 * @param [in] st task state when created
 * @param [in] parm task parameter
 * @return a task handler
 *
 */
tl_task_t tl_add_singleton(tl_t tl, run_t run, uint32_t delay, uint32_t period, task_st_t st, tl_task_param_t param){
    //first check if the task is already exist
    tl_task_t task = tl_find(tl, run);

    if(task != NULL)
    {
        task->next_exe_ts = tl->tick + delay + 1;
        task->period = period;
        task->st = st;
        task->param = param;
    } else {
        return tl_add(tl, run, delay, period, st, param);
    }
}

/**
 * @details
 * Find a tl_task from a timeline using run function
 *
 * @param [in] tl timeline that the task be added to
 * @param [in] run callback function
 * @return a task handler that first found
 *
 */
static tl_task_t tl_find(tl_t tl, run_t run){
    tl_task_t task;
    uint8_t i = 0;
    for(i = 0; i < tl->max_sz; i++){
        task = &tl->tasks[i];
        if((task->run == run) && (task->st != TL_DEAD)) return task;
    }
    return NULL;
}
/**
 * @details
 * Get a unused task memory buffer
 *
 * @param [in] tl find in the memory buffer in tl
 * @return an empty task handler memoryfound
 *
 */
static tl_task_t tl_get_taskmem(tl_t tl)
{
    tl_task_t task; uint8_t i = 0;
	if(!CHK_TL(tl)) return NULL;
	//check the last task, if it is not belong
	//to tl or if it is dead, then it is a free space
	if(tl->task_sz + 1 > tl->max_sz) return NULL;
	
	for(i = 0; i < tl->max_sz; i++)
	{
		task = &tl->tasks[i];
	    if((task->belong_to != tl) || (task->st == TL_DEAD)){
	    	return task;
		}
	}
	return NULL;
}

/**
 * @details
 * Remove a task (put it into dead state)
 *
 * @param [in] tl timeline
 * @param [in] task a task handler
 * @return None.
 *
 * @todo
 * Test - OK
 */
void tl_remove(tl_t tl, tl_task_t task)
{
	if(task == NULL) return;
    //should check if task is belong to timeline
    if(task->belong_to != tl) return;
    task->st = TL_DEAD;
    _ENTER_CRITICAL_SECTION();
    tl->task_sz--;
    _LEAVE_CRITICAL_SECTION();
}

/**
 * @details
 * Pause a task (put it into pause state)
 *
 * @param [in] tl timeline
 * @param [in] task a task handler
 * @return None.
 *
 * @todo
 * Test - OK
 */
void tl_pause(tl_t tl, tl_task_t task)
{
    if(task == NULL) return;
    if(task->belong_to != tl) return;
	if(task->st == TL_DEAD) return;
    task->st = TL_PAUSED;
}

/**
 * @details
 * Pause a task (put it into pause state)
 *
 * @param [in] tl timeline
 * @param [in] task a task handler
 * @return None.
 *
 * @todo
 * Test - OK
 */
void tl_pause_all(tl_t tl)
{
    if(tl == NULL) return;
    tl->disable = 1;
}


/**
 * @details
 * Pause a task (put it into pause state)
 *
 * @param [in] tl timeline
 * @param [in] task a task handler
 * @return None.
 *
 * @todo
 * Test - OK
 */
void tl_resume_all(tl_t tl)
{
    if(tl == NULL) return;
    tl->disable = 0;
}

/**
 * @details
 * Resume a task (put it into ready state)
 *
 * @param [in] tl timeline
 * @param [in] task a task handler
 * @return None.
 *
 * @todo
 * Test - OK
 */
void tl_resume(tl_t tl, tl_task_t task)
{
	if(task == NULL) return;
	if(tl != task->belong_to) return;
    if(TL_DEAD == task->st) return;
    task->st = TL_READY;

}

/**
 * @details
 * Timeline update function, this function should
 * be called periodically, for example in a timer ISR.
 * It checks the tasks in ready state and execte
 * the task at correct time;
 *
 * @param [in] tl timeline
 * @return None.
 *
 * @todo
 * Test - OK
 */
//in isr you should call this function
void tl_update(tl_t tl)
{
    uint8_t i = 0;
    tl_ele_t * tlele = NULL;
	if(tl == NULL) return;
	if(tl->disable) return;
    tl->tick++;

    //iterate in ready task
    for(i = 0;i < tl->task_sz; i++)
    {

        tlele = &tl->tasks[i];
        if(tlele->st ==  TL_PAUSED)
        {
            tlele->next_exe_ts++;
        } else if((tlele->st == TL_READY) && (tl->tick == tlele->next_exe_ts)) {
            tlele->run(tlele->param);
            if(tlele->period != 0)
            {
                tlele->next_exe_ts = (tlele->period + tl->tick);
            } else {
                tlele->st = TL_DEAD;
                tl->task_sz--;
            }
        }
    }
}

/**
 * @details
 * Get the timeline tick number
 *
 * @param [in] tl timeline
 * @return tick number
 *
 */
uint32_t tl_get_timestamp(tl_t tl)
{
    return tl->tick;
}
