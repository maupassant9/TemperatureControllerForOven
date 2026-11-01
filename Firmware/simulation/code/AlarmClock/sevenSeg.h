/*
* FileName: 7seg.h
* Author: Dong Xia
* This is source file of the driver of 7seg.h 
* using 74HC595.
* The connection between 74HC595 and 7seg:
* A(P10) - QB
* B(P9) - QC
* C(P7) - QD
* D(P5) - QE
* E(P4) - QF
* F(P2) - QG
* G(P1) - QH
* DP(P6) - QA
*
* Change Records:
*      >> (30/Dec/2017): Creation of file
*
*/

#ifndef _7SEG_H
#define _7SEG_H
/********************************************
* Include
********************************************/
#include "74hc595.h"

/********************************************
* Macro
********************************************/
#define DISP_DIGITAL_NO 4

#define DIG1_PIN (3)
#define DIG2_PIN (4)
#define DIG3_PIN (5)
#define DIG4_PIN (6)
/********************************************
* External Variables
********************************************/


/********************************************
* Type definition
********************************************/


/********************************************
* Function prototype
********************************************/
/*------------------------------------------------
 * Drv7SegInit();
 * Initialize the 7Seg Device.
 * This function just call the init function 
 * of 74HC595.
 * Paras:
 *  >> hc595_handle_t*: a handle pointer to 74Hc595
 * Return:
 *  >> 
 * Change Records:
 *  >> (30/Dec/2017): Create the function
 *----------------------------------------------*/
 void Drv7SegInit(hc595_handle_t *handle);

/*------------------------------------------------
 * Drv7SegDisp();
 * Display the number 
 * Paras:
 *  >> hc595_handle_t*: a handle pointer to 74Hc595
 *  >> unsigned char: the number to display, should be
 *     between 0-9.
 * Return:
 *  >> 
 * Change Records:
 *  >> (30/Dec/2017): Create the function
 *----------------------------------------------*/
void Drv7SegSetDigit(hc595_handle_t *handle, 
								uint8_t digit,
								uint8_t devId);

void Drv7SegSetRawCode(hc595_handle_t *handle, 
	uint8_t code,
	uint8_t devId);
								
void Drv7SegSetNum(hc595_handle_t * handle, int16_t num);
/*------------------------------------------------
 * Drv7SegDispWithDp();
 * Display the number 
 * Paras:
 *  >> hc595_handle_t*: a handle pointer to 74Hc595
 *  >> unsigned char: the number to display, should be
 *     between 0-9, and this function will also display
 *     the point.
 * Return:
 *  >> 
 * Change Records:
 *  >> (30/Dec/2017): Create the function
 *----------------------------------------------*/
void Drv7SegSetDp(hc595_handle_t *handle,
									uint8_t devId);
									
void Drv7SegShow(hc595_handle_t * handle,
									uint8_t devId);
									
void Drv7SegClear(hc595_handle_t *handle, uint8_t devId);
void Drv7SegClearAll(hc595_handle_t *handle);
uint8_t Drv7SegGetDisplayCode(uint8_t devId);
void Drv7SegCtrSet(uint8_t pinNum, bool is_on);
//void DrvLedControl(hc595_handle_t *handle, uint8_t ledNo, bool isOn);
//void DrvDispTemp(hc595_handle_t * handle, int8_t temp);
//bool DrvDispTemp(hc595_handle_t * handle, int16_t temp, uint8_t unit);
//void DrvDispTemp_unsafe(hc595_handle_t * handle, int16_t temp, uint8_t unit);


//void DrvGetLedState(hc595_handle_t *handle, uint8_t ledNo);
#endif