/** 
 *  @file      button.c
 *  @brief     An input for button
 *  @details   This class is used to demonstrate a number of section commands.
 *  @author    Dong Xia
 *  @version   1.0
 *  @date      05/03/2025
 *  @warning   Improper use can crash your application
 *  @copyright GNU Public License.
 *  @note
 *  @todo 
 */
/* Includes ------------------------------------------------------------------*/
#include "button.h"
#include <Arduino.h>
//#include "board.h"
/* Private typedef -----------------------------------------------------------*/
/* Private define ------------------------------------------------------------*/
/* Private macro -------------------------------------------------------------*/
/* Private variables ---------------------------------------------------------*/
/* Global variable -----------------------------------------------------------*/
/* External variable ---------------------------------------------------------*/
/* Private function prototypes -----------------------------------------------*/
/* Private functions ---------------------------------------------------------*/
/* Public functions ---------------------------------------------------------*/
/**
 * @details
 * Initialize the button.
 * 
 * @param [in] b Button structure
 * @param [in] id Button ID
 * @param [in] get Button get the button pin value
 * @return 
 * None.
 * 
 */
void bt_init(but_t *b, uint16_t id, int8_t (*get)(uint16_t))
{
    b->get_val = get;
    b->id = id;
    b->pressed_cnter = 0;
}
/**
 * @details
 * Update the button, and save the button event.
 * Function should be called periodically.
 * 
 * @param [in] b Button structure
 * @param [in] cb_but Circular buffer to save the event
 * @return 
 * None.
 * 
 */
// void bt_update(but_t *b, cb_t cb_but)
// {
//     uint32_t pressed_cnter_cp = 0;
//     but_msg_t msg = {.but_id = b->id, .evt = 0};
//     if(b->get_val(b->id)){
//         //pressed
//         b->pressed_cnter++;
//         if(b->pressed_cnter > BUTTON_LNG_PRESSED_TIME_IN_TICK){
//             if(0 == (b->pressed_cnter)%BUTTON_NOT_RELEASED_EVT_INTERVAL_IN_TICK){
//                 //b->pressed_cnter = BUTTON_LNG_PRESSED_TIME_IN_TICK;
//                 msg.evt = BUTTON_NOT_RELEASED;
//                 cirbuf_put(cb_but, (cb_ele_t)&msg);
//             }
//         }
//         if(b->pressed_cnter == BUTTON_LNG_PRESSED_TIME_IN_TICK){
//             msg.evt = BUTTON_LNG_PRESSED;
//             cirbuf_put(cb_but, (cb_ele_t)&msg);
//         }
//     } else {
//         //released or not pressed at all
//          if(b->pressed_cnter >= BUTTON_SHT_PRESSED_TIME_IN_TICK && b->pressed_cnter < BUTTON_LNG_PRESSED_TIME_IN_TICK){
//             msg.evt = BUTTON_SHT_PRESSED;
//             cirbuf_put(cb_but, (cb_ele_t)&msg);
//         } 
//         b->pressed_cnter = 0;
//     }
// }

void bt_update(but_t *b, cb_t cb_but)
{
    uint32_t pressed_cnter_cp = 0;
    but_msg_t msg = {.but_id = b->id, .evt = 0};
    if(b->get_val(b->id)){
        //pressed
        b->pressed_cnter++;
        if(b->pressed_cnter >= BUTTON_LNG_NOT_RELEASE_TIME){
            if(0 == (b->pressed_cnter)%BUTTON_NOT_RELEASED_EVT_INTERVAL_IN_TICK){
                //b->pressed_cnter = BUTTON_LNG_PRESSED_TIME_IN_TICK;
                msg.evt = BUTTON_NOT_RELEASED;
                cirbuf_put(cb_but, (cb_ele_t)&msg);
            }
        }
    } else {
        //released or not pressed at all
         if(b->pressed_cnter >= BUTTON_SHT_PRESSED_TIME_IN_TICK && b->pressed_cnter < BUTTON_LNG_PRESSED_TIME_IN_TICK){
            msg.evt = BUTTON_SHT_PRESSED;
            cirbuf_put(cb_but, (cb_ele_t)&msg);
        } else if(b->pressed_cnter >= BUTTON_LNG_PRESSED_TIME_IN_TICK && b->pressed_cnter < (BUTTON_LNG_NOT_RELEASE_TIME)){
            msg.evt = BUTTON_LNG_PRESSED;
            cirbuf_put(cb_but, (cb_ele_t)&msg);
        }

        b->pressed_cnter = 0;
    }
}