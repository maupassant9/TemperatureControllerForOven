/**
 * @file      alarm.h
 * @brief     Pretty nice class.
 * @author    Dong Xia
 * @version   0.1
 * @date      26/10/2026
 * @warning   Improper use can crash your application
 * @copyright GNU Public License.
 */

/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef __ALARM_H__
#define __ALARM_H__

/* Includes ------------------------------------------------------------------*/
#include <stdint.h>
#include "time.h"
/* Exported macro ------------------------------------------------------------*/
#define DEBUG (0)
/* Exported constants --------------------------------------------------------*/
/* Exported types ------------------------------------------------------------*/
////////////////////////////////////////////////
/// alarm structure                          ///
////////////////////////////////////////////////
typedef struct{
    bool mark;  ///<-- mark true if alarm is in trigger state
    volatile datetime_t alarm_datetime;  ///<--- alarm date and time
    ////////////////////////////////////////////////
    /// alarm repetition pattern                 ///
    /// bit0 - bit6: sunday, monday, tuesday,    ///
    /// wensday, thursday, friday, saturday      ///
    /// the alarm is repeated at the same time   ///
    /// for the day that set the bit             ///
    ////////////////////////////////////////////////
    uint8_t repeate_pattern;
    uint32_t on_time_in_sec;  ///<---  alarm stays time in second for alarm trigger state
    uint32_t on_time_cnter;   ///<--- internal use, a cnter
    void (*on_func)(void);    ///<--- function called when alarm triggered
    void (*off_func)(void);   ///<--- function called when on_time_in_sec passed
}alarm_t;

/* Exported functions ------------------------------------------------------- */
void alarm_init(alarm_t * al, datetime_t *dt, uint8_t pattern, uint32_t t);
void alarm_check(alarm_t *al, datetime_t *dt);
void alarm_attach_on_func(alarm_t * al, void (*func)(void));
void alarm_attach_off_func(alarm_t * al, void (*func)(void));
void alarm_update_alarm_datetime(alarm_t * al, datetime_t * dt);
#if DEBUG > 0
void alarm_print(alarm_t * al);
#endif


#endif /*__ALARM_H__*/

