/*
* FileName: 74HC595
* Author: Dong Xia
* This is source file of the driver of 74HC595
*
* Change Records:
*      >> (29/Dec/2017): Creation of file
*      >> (30/Dec/2017): Finished the driver
*
*/

/********************************************
 * Include
 ********************************************/
#include "74hc595.h"
#include <Arduino.h>

/********************************************
 * Internal Function Declaration
 ********************************************/
static void Hc595GpioWrite(int8_t pin_number, unsigned char val);
static void Hc595GpiosWriteAll(hc595_handle_t * handle, unsigned char val);
static  void Hc595Wait(unsigned char mini_seg);
static void digitalPut(int8_t pinNum, uint8_t value);
static void gpioPinsInit( void );
/********************************************
 * Internal Types and Variables
 ********************************************/
//a gpio table in following order:
//   OE_PIN: 13
//   SER_PIN: 14
//   SRCLK_PIN:11
//   SRCLR_PIN:10
//   RCLK_PIN:12
//GPIO_TypeDef * gpioPort[5] = {0,HC595_SDI_PIN_PORT,HC595_RCLK_PIN_PORT,HC595_CLR_PIN_PORT,HC595_CLK_PIN_PORT};
int8_t gpioPin[5] = {
    0,   /* OE */
    10,   /* SER 14 */ 
    12,   /* SRCLK 11 */
    13,   /* SRCLR 10 */
    11    /* RCLK 12 */
};

/********************************************
 * External Variables
 ********************************************/


/********************************************
 * Functions
 ********************************************/
/*------------------------------------------------
* Drv595Init();
* Initialize the 74HC595 Device.
* Paras:
*  >> 
* Return:
*  >> 
* Change Records:
*  >> (29/Dec/2017): Create the function
*----------------------------------------------*/
void DrvHc595Init(hc595_handle_t *handle)
{
    unsigned char cnt, ser = DEFAULT_VALUE;

    handle->pins_number[0] = SER_PIN;
    handle->pins_number[1] = SRCLK_PIN;
    handle->pins_number[2] = RCLK_PIN;
    handle->pins_number[3] = SRCLR_PIN;
    handle->pins_number[4] = OE_PIN;

    gpioPinsInit();
    //Reset the 74HC595 into default mode
    Hc595GpiosWriteAll(handle,(uint8_t)(0x18|ser));
    Hc595GpiosWriteAll(handle,(uint8_t)(0x18|ser));
    Hc595GpiosWriteAll(handle,(uint8_t)(0x10|ser));
    Hc595GpiosWriteAll(handle,(uint8_t)(0x0c|ser));
    DrvHc595Clear(handle);
}

/*------------------------------------------------
* Hc595GpiosWriteAll();
* Write one bit to all the GPIOs
* Paras:
*  >> unsigned char: Set all the gpios state
*           Bit0: GPIO_SER
*           Bit1: GPIO_SRCLK
*           Bit2: GPIO_RCLK
*           Bit3: GPIO_SRCLR
*           Bit4: GPIO_OE
* Return:
*  >> 
* Change Records:
*  >> (29/Dec/2017): Create the function
*----------------------------------------------*/
static void Hc595GpiosWriteAll(hc595_handle_t * handle, uint8_t val)
{
    unsigned char cnt = 0;
    for(;cnt < 5; cnt++){
        Hc595GpioWrite(handle->pins_number[cnt], (uint8_t)(val&0x01));
        val = (uint8_t)(val >> 1);
    }
    //wait for one freq
    //Hc595Wait(WAIT_TIME);
}


/*------------------------------------------------
* Hc595GpioWrite();
* Write to one GPIO
* Paras:
*  >> unsigned char: the pin number that write to;
*  >> unsigned char: a valor write to gpio
* Return:
*  >> 
* Change Records:
*  >> (29/Dec/2017): Create the function
*----------------------------------------------*/
static void Hc595GpioWrite(int8_t pin_number,
                        unsigned char val)
{
    if(val == 1){
        digitalPut(pin_number, HIGH_VOLT);
    } else {
        digitalPut(pin_number,LOW_VOLT);
    }
}


/*------------------------------------------------
* DrvHc595Write();
* Write serial data (8 bits) to Hc595.
*           Bit0: GPIO_SER
*           Bit1: GPIO_SRCLK
*           Bit2: GPIO_RCLK
*           Bit3: GPIO_SRCLR
*           Bit4: GPIO_OE
* Check the waveform in /waveform/write.png
* Paras:
*  >> hc595_handle_t: a handle for 74HC595 dev
*  >> unsigned char: a valor write to gpio
* Return:
*  >> 
* Change Records:
*  >> (29/Dec/2017): Create the function
*----------------------------------------------*/
void DrvHc595Write(hc595_handle_t * handle,
														uint8_t * pval)
{
    unsigned char ser, cnt, devNo, val;
		for(devNo = 0; devNo < DEV_NO; devNo++)
		{
      val = pval[devNo];
			for(cnt = 0; cnt < 8; cnt++){
				ser = (uint8_t)(val&0x01);
				Hc595GpiosWriteAll(handle,(uint8_t)(0x08|ser));
				Hc595GpiosWriteAll(handle,(uint8_t)(0x0a|ser));
				val = (uint8_t)(val >> 1);
			}
		}
    Hc595GpiosWriteAll(handle,0x0c);
    Hc595GpiosWriteAll(handle,0x08);        
}   

/*------------------------------------------------
* DrvHc595Clear();
* Clear the display.
* Paras:
*  >> hc595_handle_t: a handle for 74HC595 dev
* Return:
*  >> 
* Change Records:
*  >> (31/Dec/2017): Create the function
*----------------------------------------------*/
void DrvHc595Clear(hc595_handle_t * handle){
	uint8_t data[DEV_NO];
	uint8_t cnt;
	
	for(cnt = 0; cnt < DEV_NO; cnt++)
	{
		#if DEFAULT_VALUE == HIGH_VOLT
		data[cnt] = 0xff;
		#elif DEFAULT_VALUE == LOW_VOLT
		data[cnt] = 0x00;
		#endif
	}
	DrvHc595Write(handle,data);
}

/*------------------------------------------------
* Hc595Wait();
* Wait for a while
* Check the waveform in /waveform/write.png
* Paras:
*  >> unsigned char: the miniseconds that needs to
*  wait
* Return:
*  >> 
* Change Records:
*  >> (30/Dec/2017): Create the function
*----------------------------------------------*/
static void Hc595Wait(unsigned char mini_seg)
{
   delayMicroseconds(mini_seg);
}

/*------------------------------------------------
* digitalWrite
* write a value into a sepecific gpio
* Paras:
*    >> pinNum: a number for a pin used to identify this 
*               pin for this library
*    >> value: the value of this pin: HIGH_VOLT or LOW_VOLT
*  wait
* Return:
*  >> 
* Change Records:
*  >> (18/Abr/2020): Create the function
*----------------------------------------------*/
static void digitalPut(int8_t pinNum, uint8_t value)
{
    {
        if(value == HIGH_VOLT){
          digitalWrite(gpioPin[pinNum], HIGH);
        } else {
          digitalWrite(gpioPin[pinNum], LOW);
        }
    }
}

/*------------------------------------------------
* gpioPinsInit
* initialize the gpio pins used by this library to
* output mode
* Paras:
*    >> 
* Return:
*  >> 
* Change Records:
*  >> (18/Abr/2020): Create the function
*----------------------------------------------*/
static void gpioPinsInit()
{
	uint8_t cnt;
	//init all the pins to output mode
	for(cnt = 0; cnt < 5; cnt++){
    if(gpioPin[cnt] > 0)
      pinMode(gpioPin[cnt], OUTPUT);
	}
}