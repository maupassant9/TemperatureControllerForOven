/*
 * @file      button.h
 * @brief     An input button.
 * After BUTTON_LNG_PRESSED, every N tick generate a BUTTON_NOT_RELEASED event
 * 
 * 
 * @author    Dong Xia
 * @version   1.0
 * @date      05/03/2025
 * @warning   Improper use can crash your application
 * @copyright GNU Public License.
 */

/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef __BUTTON_H__
#define __BUTTON_H__

/* Includes ------------------------------------------------------------------*/
#include <stdint.h>
#include "circular_buf_f.h"
/* Exported constants --------------------------------------------------------*/
/* Exported macro ------------------------------------------------------------*/
#define BUTTON_LNG_PRESSED_TIME_IN_TICK (30)  //> minimum button long pressed event time
#define BUTTON_SHT_PRESSED_TIME_IN_TICK (5)   //> minimum button short pressed event time
#define BUTTON_LNG_NOT_RELEASE_TIME     (100)
#define BUTTON_NOT_RELEASED_EVT_INTERVAL_IN_TICK (10) //> time interval for generating button long pressed event

/* Exported types ------------------------------------------------------------*/
//////////////////////////////////////////////
/// Button event                           ///
//////////////////////////////////////////////
typedef enum{
    BUTTON_NOT_PRESSED = 0,
    BUTTON_SHT_PRESSED,
    BUTTON_LNG_PRESSED,
    BUTTON_NOT_RELEASED,
}but_evt_t;
//////////////////////////////////////////////
/// Button structure                       ///
//////////////////////////////////////////////
typedef struct {
    uint16_t id;
    //a cnter for pressed event
    uint32_t pressed_cnter;
    int8_t (*get_val)(uint16_t id);
}but_t;
//////////////////////////////////////////////
/// Button event msg for circular buffer   ///
//////////////////////////////////////////////
typedef struct{
    uint16_t but_id;
    but_evt_t evt;
}but_msg_t;

/* Exported functions ------------------------------------------------------- */
void bt_init(but_t *b, uint16_t id, int8_t (*get)(uint16_t));
void bt_update( but_t * b, cb_t cb); 

#endif