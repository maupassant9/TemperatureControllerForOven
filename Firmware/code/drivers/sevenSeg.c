/*
* FileName: 7seg.c
* Author: Dong Xia
* This is source file of the driver of 7seg using 
* 74HC595.
* The connection between 74HC595 and 7seg:
* A(P10) - QB
* B(P9) - QC
* C(P7) - QD
* D(P5) - QE
* E(P4) - QF
* F(P2) - QG
* G(P1) - QH
* DP(P6) - QA
* Change Records:
*      >> (30/Dec/2017): Creation of file
*      >> (30/Dec/2017): Finished the driver
*
*/

/********************************************
 * Include
 ********************************************/
#include <stdint.h>
#include <stm8s.h>
#include "sevenSeg.h"
#include "stm8s_gpio.h"


#define FALSE 0
#define TRUE 1
/********************************************
 * Internal Function Declaration
 ********************************************/
static void Drv7SegCtrInit( void );
static void Drv7SegCtrClearAll( void );
/********************************************
 * Internal Types and Variables
 ********************************************/
//The code of numbers to write to 74HC595
// codes_number[0] = number '0' code
// codes_number[1] = number '1' code
// .....
// codes_number[9] = number '9' code
// codes_number[10] = '.' code
// ....
////////////////////////////////////
//    ----(1a)----
//    |          |
//(2f)|          | (3b)
//    |          |
//    |          |
//    ----(4g)----
//    |          |
//(8e)|          | (5c)
//    |          |
//    |          |
//    ----(7d)----   * (6h)
////////////////////////////////////
const uint8_t codes_number[] = {
    0x3, //'0': B,C,D,E,F,G = 0; 10000001b
    0x9f, //'1': C,D = 0; 11001111b
    0x25, //'2': B,C,E,F,H = 0; 10010010b
    0x0d, //'3': B,C,D,E,H = 0; 10000110b
    0x99, //'4': C,D,G,H = 0; 11001100b
    0x49, //'5': B,D,E,G,H = 0; 10100100b
    0x41, //'6': B,D,E,F,G,H = 0; 10100000b
    0x1f, //'7': B,C,D = 0; 10001111b
    0x1, //'8': B,C,D,E,F,G,H = 0; 10000000b
    0x9, //'9': B,C,D,E,G,H = 0; 10000100b
    0xfe, //'.': 01111111b 10
    0xfd,  // -    11
    0xff, // clear 12
    0xd1, // 'h'  13
    0x39,  // 'o'  14
    0xd5, // 'n'   15
    0x91, // 'H'   16
    0x89,  // 'y'   17
    0x31, //  P    18
    0x85,  // d    19
    0xbf,  // '    20
    0xbb,  // ''   21
    0x63,  // C    22
    0x83,  // U    23
    0x73,   // r   24
    0x11,  // A    25
    0xe3,  // L    26
    0x61,  // E    27
};
// const uint8_t codes_number[20] = {
//     0x00,//0x14, //'0': B,C,D,E,F,G = 0; 10000001b
//     0xd7, //'1': C,D = 0; 11001111b
//     0x4c, //'2': B,C,E,F,H = 0; 10010010b
//     0x45, //'3': B,C,D,E,H = 0; 10000110b
//     0x87, //'4': C,D,G,H = 0; 11001100b
//     0x25, //'5': B,D,E,G,H = 0; 10100100b
//     0x24, //'6': B,D,E,F,G,H = 0; 10100000b
//     0x57, //'7': B,C,D = 0; 10001111b
//     0x04, //'8': B,C,D,E,F,G,H = 0; 10000000b
//     0x05, //'9': B,C,D,E,G,H = 0; 10000100b
//     0xfb, //'.': 01111111b 10
// 		0xef,  // -    11
// 		0xff, // clear 12
// 		0xec, // 'c'  13
// 		0xe7,  // 'o'  14
// 		0xe6, // 'n'   15
// 		0x2e, // 'F'   16
// 		0x7f,  //'first temp'    17
// 		0xef,   //'second temp'   18
// 		0xfd   //'third temp'   19
// };

int32_t regNum = 0;
static uint8_t data[DISP_DIGITAL_NO] = {0xff};
static volatile uint8_t lock = FALSE;
//static uint8_t ledState = 0x3; //Bit 0: 0x01 - off, bit 1: 0x01 - off
/********************************************
 * External Variables
 ********************************************/


typedef uint8_t boolean_t;
/********************************************
 * Functions
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
void Drv7SegInit(hc595_handle_t *handle){
    DrvHc595Init(handle);
    Drv7SegCtrInit();
}

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
									uint8_t devId){
		data[devId] = codes_number[digit];
}

void Drv7SegSetRawCode(hc595_handle_t *handle, 
									uint8_t code,
									uint8_t devId){
		data[devId] = code;
}

void Drv7SegSetDp(hc595_handle_t *handle,
									uint8_t devId){
								
		data[devId] = (uint8_t)(data[devId]&((uint8_t)codes_number[10]));
}


void Drv7SegSetNum(hc595_handle_t * handle, int16_t num)
{
	uint8_t residual, id = 0;
  uint16_t divider = 1000;
	//check if it is negtive
	if(num < 0) {
		id = 1;
		num = (-1*num);
    divider = divider / 10;
    Drv7SegSetDigit(handle, 11, 0);
	}
	for(; id < DISP_DIGITAL_NO; id++)
	{
		residual = (num/divider);
		Drv7SegSetDigit(handle, residual, id);
		num -= (divider*residual);
		divider = (divider/10);
	}
}

void Drv7SegShow(hc595_handle_t * handle,
									uint8_t devId){
    Drv7SegCtrClearAll();
    DrvHc595Write(handle, &data[devId]);
    Drv7SegCtrSet(devId, TRUE);
}

uint8_t Drv7SegGetDisplayCode(uint8_t devId)
{
  return data[devId];
}
/*------------------------------------------------
* Drv7SegClear();
* Clear the display.
* Paras:
*  >> hc595_handle_t*: a handle pointer to 74Hc595
* Return:
*  >> 
* Change Records:
*  >> (30/Dec/2017): Create the function
*----------------------------------------------*/
void Drv7SegClear(hc595_handle_t *handle, uint8_t devId){

	data[devId] = codes_number[12];
}

void Drv7SegClearAll(hc595_handle_t *handle)
{
    uint8_t i = 0;
    for(i = 0; i < DISP_DIGITAL_NO; i++) Drv7SegClear(handle, i);
}

static void Drv7SegCtrInit()
{
    DIG1_PORT->ODR &= ~DIG1_PIN;
    DIG1_PORT->DDR |= DIG1_PIN;
    DIG1_PORT->CR1 |= DIG1_PIN;
    DIG1_PORT->CR2 |= DIG1_PIN;
    
    DIG1_PORT->ODR &= ~DIG1_PIN;
    DIG1_PORT->DDR |= DIG1_PIN;
    DIG1_PORT->CR1 |= DIG1_PIN;
    DIG1_PORT->CR2 |= DIG1_PIN;
    
    DIG1_PORT->ODR &= ~DIG1_PIN;
    DIG1_PORT->DDR |= DIG1_PIN;
    DIG1_PORT->CR1 |= DIG1_PIN;
    DIG1_PORT->CR2 |= DIG1_PIN;

    DIG1_PORT->ODR &= ~DIG1_PIN;
    DIG1_PORT->DDR |= DIG1_PIN;
    DIG1_PORT->CR1 |= DIG1_PIN;
    DIG1_PORT->CR2 |= DIG1_PIN;
}

void Drv7SegCtrSet(uint8_t pinNum, uint8_t is_on)
{
    GPIO_Pin_TypeDef pinNo = -1;
    GPIO_TypeDef * pinPort;
    switch(pinNum)
    {
        case 0: 
            pinNo = DIG1_PIN;
            pinPort = DIG1_PORT;
            break;
        case 1:
            pinNo = DIG2_PIN;
            pinPort = DIG2_PORT;
            break;
        case 2:
            pinNo = DIG3_PIN;
            pinPort = DIG3_PORT;
            break;
        case 3:
            pinNo = DIG4_PIN;
            pinPort = DIG4_PORT;
            break;
        default:
            break;
    }

    if(pinNum != -1)
    {
        //Drv7SegCtrClearAll();
        if(!is_on)
            pinPort->DDR |= pinNo;
        else 
           pinPort->DDR &= ~pinNo;
    }
}

static void Drv7SegCtrClearAll()
{
    DIG1_PORT->DDR |= DIG1_PIN;
    DIG2_PORT->DDR |= DIG2_PIN;
    DIG3_PORT->DDR |= DIG3_PIN;
    DIG4_PORT->DDR |= DIG4_PIN;
}