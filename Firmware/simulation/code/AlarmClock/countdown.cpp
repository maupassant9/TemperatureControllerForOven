/** 
 *  @file      regressive_counter.c
 *  @brief     A count down timer implementation
 *  @details   This class is used to demonstrate a number of section commands.
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
#include <string.h>
#include "countdown.h"
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
/* Private functions ---------------------------------------------------------*/
/* Public functions ---------------------------------------------------------*/
/**
 * @details
 * Count down timer initialization
 * @param [in] rgc Pointer of countdown timer structure
 * @param [in] delay time in second for a countdown timer delay
 * @param [in] period time in second for a countdown timer period
 * @param [in] on_time_in_sec time in second for a countdown timer stay in trigger mode
 * @return None.
 *
 */
void rc_init(countdown_t * rgc, uint32_t delay, uint32_t period, uint32_t on_time_in_sec)
{
    rgc->delay_in_sec = delay;
    rgc->period_in_sec = period;
    rgc->on_time_in_sec = on_time_in_sec;
    rgc->cnter = 0;
    rgc->on_func = NULL;
    rgc->off_func = NULL;
    rgc->mode = INITIAL;
}

/**
 * @details
 * Attach an on_func, called when countdown is triggered on
 *
 * @param [in] rgc Pointer of countdown structure
 * @param [in] func a on function
 * @return None.
 *
 */
void rc_attach_on_func(countdown_t * rgc, void (*func)(void))
{
    rgc->on_func = func;
}
/**
 * @details
 * Attach an off_func, called when countdown is triggered off
 *
 * @param [in] rgc Pointer of countdown structure
 * @param [in] func a off function
 * @return None.
 *
 */
void rc_attach_off_func(countdown_t * rgc, void (*func)(void))
{
    rgc->off_func = func;
}

//call every second
/**
 * @details
 * This function should be called periodically every 1 second
 * Check if countdown should be trigger or not.
 * The countdown timer is trigger if the delay time is passed when 
 * the timer never triggered before, or when period time is passed
 * otherwise.
 * If the timer is triggered, call the on_func callback function
 * stay in trigger state until the on time is passed, and then
 * call the off_func callback.
 * @param [in] rgc Pointer of countdown structure
 * @return None.
 *
 */
void rc_check(countdown_t * rgc)
{
    switch(rgc->mode)
    {
        case INITIAL:
            if(rgc->cnter++ == rgc->delay_in_sec){
                rgc->mode = ARMED;
                rgc->cnter = 0;
                if(rgc->on_func != NULL) rgc->on_func();
            }
            break;
        case ARMED:
            if(rgc->cnter++ == rgc->on_time_in_sec){
                if(rgc->period_in_sec != 0){
                    rgc->mode = WAIT;
                } else {
                    rgc->mode = STOP;
                }
                rgc->cnter = 0;
                if(rgc->off_func != NULL) rgc->off_func();
            }
            break;
        case WAIT:
            if(rgc->cnter++ == rgc->period_in_sec){
                rgc->mode = ARMED;
                rgc->cnter = 0;
                if(rgc->on_func != NULL) rgc->on_func();
            }
            break;
        case STOP:
            break;
    }
}

/**
 * @details
 * Check the distance in time_t between the current time and the next event
 * @param [in] rgc Pointer of countdown structure
 * @param [out] t the distance in time_t
 * @return None.
 *
 */
void rc_get_left_time(countdown_t * rgc, time_t * t)
{
    switch(rgc->mode)
    {
        case INITIAL: t_convert_sec_to_time(rgc->delay_in_sec - rgc->cnter,t); return;
        case ARMED: t_convert_sec_to_time(rgc->on_time_in_sec - rgc->cnter, t); return;
        case WAIT: t_convert_sec_to_time(rgc->period_in_sec - rgc->cnter, t); return;
        case STOP: memset(t, 0, sizeof(time_t));return;
    }
}