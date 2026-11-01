/**
 * @file      board.h
 * @brief     Pretty nice class.
 * @author    Dong Xia
 * @version   0.1
 * @date      26/10/2026
 * @warning   Improper use can crash your application
 * @copyright GNU Public License.
 */

/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef __BOARD_H__
#define __BOARD_H__
/* Includes ------------------------------------------------------------------*/
#include <stdint.h>
#include <Arduino.h>
#include "alarm.h"
#include "countdown.h"
#include "sevenSeg.h"
#include "74hc595.h"
#include "button.h"
#include "tl_pico.h"
#include "circular_buf_f.h"
/* Exported macro ------------------------------------------------------------*/
#define DEBUG (1)
/* Exported constants --------------------------------------------------------*/
/* Exported types ------------------------------------------------------------*/
////////////////////////////////////////////////
/// Descriptions                             ///
////////////////////////////////////////////////
enum mode_t {
    NO_MODE_SELECTED = -1,
    ALARM_MODE = 0,
    REGRESSIVE_MODE
};

////////////////////////////////////////////////
/// structure used to pass the information   ///
/// to control the tltask_7seg_show          ///
////////////////////////////////////////////////
typedef struct{
  datetime_t *pdt; ///<--- datetime to show
  uint8_t whichpart; ///<--- internal use, which parts to show:
                     /// 0 for only time
                     /// 1 for both time and date
  bool blink; ///<--- true to blink the 7 seg
}dtshow_t;

////////////////////////////////////////////////
/// board config structure                   ///
////////////////////////////////////////////////
typedef struct{
    enum mode_t mode;
    datetime_t curr_dt; ///<--- current date and time
    alarm_t alarm; ///<--- alarm structure
    countdown_t rc; ///<--- counterdown structure
    hc595_handle_t disp; ///<--- a seven seg led handler
    but_t but; ///<--- a button structure
    cb_mem_t cbuf; ///<--- circular buffer structure for button event
    but_msg_t but_msgs[2]; ///<--- memory for cbuf

    tl_task_t tltask_7seg_show; ///<--- task to show the 7seg led
    tl_task_t tltask_alarm_chk; ///<--- task to check the alarm

    tl_ele_t tl_task[10]; ///<--- memory to save the timeline tasks
    tl_mem_t tl; ///<--- timeline for system

    volatile dtshow_t dtshow; ///<--- dtshow structure used to control tltask_7seg_show

}config_t;
/* Exported functions ------------------------------------------------------- */

#endif /*__BOARD_H__*/

