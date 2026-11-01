/*
* FileName: 74HC595
* Author: Dong Xia
* This is source file of the driver of 74HC595
*
* Change Records:
*      >> (29/Dec/2017): Creation of file
*
*/

#ifndef  _74HC595_H
#define _74HC595_H
/********************************************
 * Include
 ********************************************/
 #include <stdint.h>
 
/********************************************
 * Macro
 ********************************************/
 #define WAIT_TIME 20
 #define DEV_NO 1 //how many 595 used
 
 #define OE_PIN 0   //595: PIN13 
 #define SER_PIN 1  //595: SDI, PIN14
 #define SRCLK_PIN 2 //595: Pin 11 Shift Clock
 #define SRCLR_PIN 3 //595: pin 10
 #define RCLK_PIN 4  //595: pin 12 Latch clock
 
 //Define the default value of 74HC545 output
 #define HIGH_VOLT 1
 #define LOW_VOLT 0
 #define DEFAULT_VALUE HIGH_VOLT
 /********************************************
 * Type definition
 ********************************************/
 //74HC545 handle
 typedef struct {
     //The list of pin_number, in order:
     //*           GPIO_SER
     //*           GPIO_SRCLK
     //*           GPIO_RCLK
     //*           GPIO_SRCLR
     //*           GPIO_OE
     char pins_number[5];
     
     //Function pointers     
 } hc595_handle_t;


/********************************************
 * Function prototype
 ********************************************/
  /*------------------------------------------------
   * Drv595Init();
   * Initialize the 74HC595 Device.
   * Paras:
   *  >> hc595_handle_t: a handle for 74HC595 dev
   * Return:
   *  >> 
   * Change Records:
   *  >> (29/Dec/2017): Create the function
   *----------------------------------------------*/
void DrvHc595Init(hc595_handle_t *handle);

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
void DrvHc595Write(hc595_handle_t * handle,uint8_t * val);


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
    void DrvHc595Clear(hc595_handle_t * handle);

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
   void DrvHc595Clear(hc595_handle_t *handle);

#endif


