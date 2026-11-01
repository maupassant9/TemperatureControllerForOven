/**
 * @file      countdown.h
 * @brief     Pretty nice class.
 * @author    Dong Xia
 * @version   0.1
 * @date      26/10/2026
 * @warning   Improper use can crash your application
 * @copyright GNU Public License.
 */

/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef __COUNTDOWN_COUNTER_H__
#define __COUNTDOWN_COUNTER_H__
#ifdef __cplusplus
extern "C" {
#endif
/* Includes ------------------------------------------------------------------*/
#include "time.h"
/* Exported macro ------------------------------------------------------------*/
/* Exported constants --------------------------------------------------------*/
/* Exported types ------------------------------------------------------------*/
////////////////////////////////////////////////
/// countdowntimer internal states           ///
////////////////////////////////////////////////
enum rc_mode_t{
    INITIAL = 0,  ///<--- countdown timer start here
    ARMED,  ///<--- state when countdown is trigger
    WAIT,  ///<--- state when a periodic countdown finished and start again
    STOP
};
////////////////////////////////////////////////
/// countdowntimer structure                 ///
////////////////////////////////////////////////
typedef struct{
    enum rc_mode_t mode; ///<--- countdown timer mode
    uint32_t delay_in_sec; ///<--- countdown delay time (time for first trigger)
    uint32_t period_in_sec; ///<---- countdown periodic time (0: oneshot timer, >0 periodic timer)
    uint32_t on_time_in_sec; ///<---- on time after triggered
    uint32_t cnter; ///<--- internal use, a counter
    void (*on_func)(void); ///<--- on_fucn, called when timer is triggered
    void (*off_func)(void); ///<--- off_fucn, called when on_time_in_sec is passed since last trigger
}countdown_t;

/* Exported functions ------------------------------------------------------- */
/* Public functions ---------------------------------------------------------*/
void rc_init(countdown_t * rgc, uint32_t delay, uint32_t period, uint32_t on_time_in_sec);
void rc_attach_on_func(countdown_t * rgc, void (*func)(void));
void rc_attach_off_func(countdown_t * rgc, void (*func)(void));
void rc_check(countdown_t * rgc);
void rc_get_left_time(countdown_t * rgc, time_t * t);
#ifdef __cplusplus
}
#endif
#endif /*__COUNTDOWN_COUNTER_H__*/

