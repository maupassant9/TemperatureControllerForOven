/**
 *  @file      circular_buf.c
 *  @brief     Fast implementation of circular buffer
 *             Limitation:
 *             - The length of buffer element is 2**N ( 2 to the power n)
 *  @details   This class is used to demonstrate a number of section commands.
 *  @author    Dong Xia
 *  @version   0.1
 *  @date      21/01/2025
 *  @warning   Improper use can crash your application
 *  @copyright GNU Public License.
 *  @note
 *  @todo
 */
/* Includes ------------------------------------------------------------------*/
#include <string.h>
#include "circular_buf_f.h"
/* Private typedef -----------------------------------------------------------*/

/* Private define ------------------------------------------------------------*/
#define ASSERT(expr) while(expr)
#define MAX(a,b) (a>b?a:b)
#define MIN(a,b) (a>b?b:a)
#define CB_CIR_INC(p, N) (p = (p+1)&(2*N - 1))
#define CB_COPY_ELEMENT(dst, src) (memcpy(dst, src, pcb->ele_sz))
#define CB_ADDR_ELEMENT(pcb, idx) (&pcb->mem[pcb->ele_sz*idx])
#define CB_ALLOW_OVERFLOW(pcb) (pcb->allow_of != 0)
#define CB_INDEX(pcb, idx) (idx & (pcb->ele_no - 1))

/* Private macro -------------------------------------------------------------*/
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
 * Initialization of circuit buffer structure
 *
 * @param [in] pcb Pointer of circuit buffer structure
 * @param [in] ele_no Maximum number of elements number that fit in buffer, must be 2**N
 * @param [in] ele_sz Size of element in bytes
 * @param [in] buf Pointer to the buffer given by user, buffer size should be 2**N
 * @param [in] allow_overf True for allowing over overflow (overwrite the elements)
 * @return None.
 *
 * @todo
 *
 */
void cirbuf_init(cb_t pcb, uint16_t ele_no, uint16_t ele_sz, uint8_t *buf, bool allow_overf)
{
    ASSERT(NULL == pcb);
    ASSERT(NULL == buf);
    ASSERT(((ele_no & (ele_no - 1)) != 0));
    pcb->head = 0;
    pcb->tail = 0;
    pcb->mem = buf;
    pcb->ele_sz = ele_sz;
    pcb->ele_no = ele_no;
    pcb->allow_of = allow_overf;

}

/**
 * @details
 * Put an element into the circuit buffer.
 *
 * @param [in] pcb Pointer of circuit buffer structure
 * @param [in] ele Pointer to elements to be added
 * @retval -1: error, not added to cb.
 * @retval 0: added with success.
 *
 * @todo
 *
 */
int8_t cirbuf_put(cb_t pcb, cb_ele_t ele)
{
  if (CB_ISFULL(pcb))
  {
     if(!CB_ALLOW_OVERFLOW(pcb)) return -1;
     CB_CIR_INC(pcb->head, pcb->ele_no);
  }
  CB_COPY_ELEMENT(CB_ADDR_ELEMENT(pcb,CB_INDEX(pcb,pcb->tail)), ele);
  CB_CIR_INC(pcb->tail, pcb->ele_no);
  return 0;
}

/**
 * @details
 * Get an element from the circuit buffer.
 *
 * @param [in] pcb Pointer of circuit buffer structure
 * @param [out] ele Pointer to elements
 * @retval -1: error, not added to cb.
 * @retval 0: added with success.
 *
 * @todo
 *
 */
int8_t cirbuf_get(cb_t pcb, cb_ele_t ele)
{
  if (CB_ISEMPTY(pcb)) return -1;

  CB_COPY_ELEMENT(ele, CB_ADDR_ELEMENT(pcb, CB_INDEX(pcb,pcb->head)));
  CB_CIR_INC(pcb->head, pcb->ele_no);
  return 0;
}
