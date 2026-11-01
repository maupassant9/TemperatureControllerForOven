/**
 * @file      circular_buf_f.h
 * @brief     Fast implementation of circular buffer
 *            Limitation:
 *             - The length of buffer element is 2**N ( 2 to the power n)
 * @author    Dong Xia
 * @version   0.1
 * @date      21/01/2025
 * @warning   Improper use can crash your application
 * @copyright GNU Public License.
 */

/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef __QUEUE_ARR_H__
#define __QUEUE_ARR_H__
/* Includes ------------------------------------------------------------------*/
#include <stdint.h>
#include <stdbool.h>
/* Exported macro ------------------------------------------------------------*/
#define CB_ISEMPTY(pcb) ((pcb)->head == (pcb)->tail)
#define CB_ISFULL(pcb) (MAX((pcb)->head,(pcb)->tail) - MIN((pcb)->head,(pcb)->tail) == pcb->ele_no)
/* Exported constants --------------------------------------------------------*/
/* Exported types ------------------------------------------------------------*/
typedef struct cir_buf_str{
    uint16_t head;
    uint16_t tail;
    uint8_t * mem;
    uint16_t ele_sz;
    uint16_t ele_no;
    bool allow_of;
}cb_mem_t;
/* Exported macro ------------------------------------------------------------*/
typedef struct cir_buf_str *cb_t;
typedef uint8_t * cb_ele_t;
////////////////////////////////////////////////
/// Descriptions                             ///
////////////////////////////////////////////////
/* Exported functions ------------------------------------------------------- */
void cirbuf_init(cb_t pcb, uint16_t ele_no, uint16_t ele_sz, uint8_t *buf, bool allow_overf);
int8_t cirbuf_put (cb_t pcb, cb_ele_t ele);
int8_t cirbuf_get (cb_t pcb, cb_ele_t ele);

#endif

