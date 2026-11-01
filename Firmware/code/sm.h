/**
 * @file      sm.h
 * @brief     Pretty nice class.
 * @author    Dong Xia
 * @version   0.1
 * @date      30/10/2026
 * @warning   Improper use can crash your application
 * @copyright GNU Public License.
 */

/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef __SM_H__
#define __SM_H__
/* Includes ------------------------------------------------------------------*/
/* Exported macro ------------------------------------------------------------*/
/* Exported constants --------------------------------------------------------*/
/* Exported types ------------------------------------------------------------*/
////////////////////////////////////////////////
/// Descriptions                             ///
////////////////////////////////////////////////
enum state_t{
  ST_INIT = 0,
  ST_CONFIG,
  ST_IDLE,
  ST_WAITING,
  ST_WORKING,
  ST_CANCEL
};

enum evt_t {
  EVT_BUT_LNG_PRESS = 0,
  EVT_BUT_SHT_PRESS,
  EVT_BUT_REPEAT_PRESS,
  EVT_TIMEOUT,
  EVT_VALID_CFG
};
/* Exported functions ------------------------------------------------------- */
enum state_t main_sm(enum state_t s);
@far @svlreg @interrupt void TimerHandler1(void);
#endif /*__SM_H__*/



