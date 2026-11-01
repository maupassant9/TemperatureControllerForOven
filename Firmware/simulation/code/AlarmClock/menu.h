/**
 * @file      menu.h
 * @brief     Pretty nice class.
 * @author    Dong Xia
 * @version   0.1
 * @date      28/10/2026
 * @warning   Improper use can crash your application
 * @copyright GNU Public License.
 */

/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef __MENU_H__
#define __MENU_H__
/* Includes ------------------------------------------------------------------*/
#include <stdint.h>
#include "button.h"
#include "board.h"
/* Exported macro ------------------------------------------------------------*/
/* Exported constants --------------------------------------------------------*/
/* Exported types ------------------------------------------------------------*/
typedef struct {
    uint16_t val;
    uint16_t maxval;
    uint16_t minval;
    uint8_t step;
}menu_digital_input_t;


////////////////////////////////////////////////
/// Descriptions                             ///
////////////////////////////////////////////////
/* Exported functions ------------------------------------------------------- */
void menu_init();
bool menu_show(but_msg_t evt);
enum mode_t menu_select_sm_next(but_msg_t evt);
bool menu_alarm_next(but_msg_t msg);
void menu_alarm_next_aux_cfg_repeate_pattern(but_msg_t msg, uint8_t *pst, uint8_t id, bool *pmark, uint8_t *ppattern);
void menu_alarm_next_aux_cfg_date(but_msg_t msg, 
    uint8_t *pst, 
    int8_t *pval, 
    int8_t val, 
    menu_digital_input_t* ed,
    int8_t max,
    int8_t min);
void menu_show_alarm_item(menu_digital_input_t * ed, uint8_t idx, uint8_t unit);
void menu_show_repeate_item(uint8_t day, bool ismarked);
void menu_digital_input_init(menu_digital_input_t * t, uint16_t def_val, uint16_t max, uint16_t min);
void menu_digital_input_inc(menu_digital_input_t *t);
void menu_show_digital_input(menu_digital_input_t * t);
uint16_t menu_power(uint16_t base, uint8_t exponent);
bool menu_regressive_next(but_msg_t msg);
#endif /*__MENU_H__*/



