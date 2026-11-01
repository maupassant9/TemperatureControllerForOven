/**
 * @file      tl_pico.h
 * @brief     A very simple time line tool
 * @author    Dong Xia
 * @version   1.0
 * @date      16/01/2025
 * @warning   Improper use can crash your application
 * @copyright Perkons S.A.
 */

/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef __TL_H_
#define __TL_H_
/* Includes ------------------------------------------------------------------*/
#include <stdint.h>

/* Exported macro ------------------------------------------------------------*/
#define _ENTER_CRITICAL_SECTION()   {}
#define _LEAVE_CRITICAL_SECTION() {}

#define TL_PICO_STATIC (1)

#define MAX_TASK_SZ (5)
/* Exported constants --------------------------------------------------------*/
/* Exported types ------------------------------------------------------------*/
enum task_state_t{
    TL_READY = 0,
    TL_PAUSED,
    TL_DEAD
};

typedef void * tl_task_param_t;

typedef struct tl_task_str{
	void (*run)(tl_task_param_t param);
    tl_task_param_t param;
    uint32_t period;
    uint32_t next_exe_ts;
    enum task_state_t st;
    struct tl_str * belong_to;
}tl_ele_t;

typedef void (*run_t)(tl_task_param_t param);

typedef struct tl_str{
    tl_ele_t *tasks;
    uint8_t task_sz;
    uint8_t max_sz;
    uint32_t tick;
    uint8_t disable;
}tl_mem_t;

typedef struct tl_task_str * tl_task_t;
typedef enum task_state_t task_st_t;
typedef struct tl_str *tl_t;
////////////////////////////////////////////////
/// Descriptions                             ///
////////////////////////////////////////////////
/* Exported functions ------------------------------------------------------- */
#if TL_PICO_STATIC == 0
tl_t tl_create(uint8_t sz);
void tl_init(tl_t tl, uint8_t max_sz);
#else
void tl_init(tl_t tl, uint8_t max_sz, tl_task_t buf);
#endif
tl_task_t tl_add(tl_t tl, run_t run, uint32_t delay, uint32_t period, task_st_t st, tl_task_param_t param);
tl_task_t tl_add_singleton(tl_t tl, run_t run, uint32_t delay, uint32_t period, task_st_t st, tl_task_param_t param);
void tl_remove(tl_t tl, tl_task_t task);
void tl_pause(tl_t tl, tl_task_t task);
void tl_pause_all(tl_t tl);
void tl_resume(tl_t tl, tl_task_t task);
void tl_resume_all(tl_t tl);
void tl_update(tl_t tl);
uint32_t tl_get_timestamp(tl_t tl);
#endif

