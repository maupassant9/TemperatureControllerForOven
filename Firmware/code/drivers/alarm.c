/** 
 *  @file      alarm.c
 *  @brief     Pretty nice class.
 *  @details   An alarm timer.
 *  @author    Dong Xia
 *  @version   0.1
 *  @date      26/10/2026
 *  @warning   Improper use can crash your application
 *  @copyright GNU Public License.
 *  @note
 *  @todo 
 */

/* Includes ------------------------------------------------------------------*/
#include <stdint.h>
#include "alarm.h"
#include "string.h"

/* Private define ------------------------------------------------------------*/
/* Private macro -------------------------------------------------------------*/
/* Private typedef -----------------------------------------------------------*/

/* Private variables ---------------------------------------------------------*/
//////////////////////////////////////////////
/// Descriptions                           ///
//////////////////////////////////////////////

/* Global variable -----------------------------------------------------------*/
/* External variable ---------------------------------------------------------*/
/* Private function prototypes -----------------------------------------------*/
static int8_t alarm_get_last_alarm_interval(alarm_t *al, datetime_t * dt);
/* Private functions ---------------------------------------------------------*/
/**
 * @details
 * Get the next alarm in days.
 * Get day of the week for dt (current day), then
 * find the next alarm day by repetition setting in 
 * pattern, return how many days between then.
 * This is a help function for alarm_update_alarm_datetime
 *
 * @param [in] al Pointer of alarm structure
 * @param [in] dt current date and time
 * @return None.
 *
 */
static int8_t alarm_get_last_alarm_interval(alarm_t *al, datetime_t * dt)
{
    int8_t day = t_get_day_of_week(dt->date.day, dt->date.month, dt->date.year);
    uint8_t i;
    for(i = 1; i <= 7; i++){
        day = (++day) % 7;
        if((al->repeate_pattern & (1 << day)) != 0) return i;
    }
    return -1;
}
/* Public functions ---------------------------------------------------------*/
/**
 * @details
 * Initialization of alarm structure
 *
 * @param [in] al Pointer of alarm structure
 * @param [in] dt Pointer of data and time to set alarm
 * @param [in] pattern alarm pattern
 * @param [in] t when alarm is triggered, alarm calls on_func attached and 
 *               stay t seconds in this on state
 * @return None.
 *
 */
void alarm_init(alarm_t * al, datetime_t *dt, uint8_t pattern, uint32_t t)
{
    memcpy(&al->alarm_datetime, dt, sizeof(datetime_t));
    al->repeate_pattern = pattern;
    al->on_time_in_sec = t;
    al->on_time_cnter = 0;
    al->on_func = NULL;
    al->off_func = NULL;
    al->mark = false;
}
/**
 * @details
 * Attach an on_func, called when alarm is triggered on
 *
 * @param [in] al Pointer of alarm structure
 * @param [in] func a on function
 * @return None.
 *
 */
void alarm_attach_on_func(alarm_t * al, void (*func)(void))
{
    al->on_func = func;
}
/**
 * @details
 * Attach an off_func, called when alarm is triggered off
 *
 * @param [in] al Pointer of alarm structure
 * @param [in] func a off function
 * @return None.
 *
 */
void alarm_attach_off_func(alarm_t * al, void (*func)(void))
{
    al->off_func = func;
}
/**
 * @details
 * This function should be called periodically every 1 second
 * Check if the alarm time is passed or not by passing the current time
 * If the alarm time is already passed, check and update the next alarm 
 * time, and call the on_func callback function
 * then increase the on_timer_cnter until the on time is passed, and then
 * call the off_func callback.
 * After finished all the job, wait for the next alarm to arrive.
 * @param [in] al Pointer of alarm structure
 * @param [in] dt the current time
 * @return None.
 *
 */
void alarm_check(alarm_t *al, datetime_t * dt)
{
    //chcek if alarm is marked
    if(al->mark){
        //check whether the on time is over
        if(al->on_time_cnter++ == al->on_time_in_sec){
            al->mark = false;
            if(al->off_func != NULL) al->off_func();
        }
    } else {
        //check if passed the alarm datetime
        if(t_datetime_compare(dt, &al->alarm_datetime) > 0){
            alarm_update_alarm_datetime(al, dt);
            al->mark = true;
            //execute on function
            if(al->on_func != NULL) al->on_func();
            al->on_time_cnter = 0;
        }
    }
}

/**
 * @details
 * Update the next alarm time by checking alarm pattern.
 * If no alarm repetition bit is set, then set next alarm
 * time to the maxdt.
 * @param [in] al Pointer of alarm structure
 * @param [in] dt a on function
 * @return None.
 *
 */
void alarm_update_alarm_datetime(alarm_t * al, datetime_t * dt)
{
    int8_t interval = 0;
    datetime_t maxdt = {{99,12,31},{23,59,59}};
    //check the pattern
    if((al->repeate_pattern&0x7f) == 0) {
        //set to the max date to cancel the alarm
        memcpy(&al->alarm_datetime, &maxdt, sizeof(datetime_t));
        return;
    }
    //there is some repeate pattern here
    if((interval = alarm_get_last_alarm_interval(al, dt)) >= 0){
        t_date_add(&al->alarm_datetime.date, interval);
        
    }
}