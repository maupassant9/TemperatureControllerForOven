/** 
 *  @file      sm.c
 *  @brief     Pretty nice class.
 *  @details   This class is used to demonstrate a number of section commands.
 *  @author    Dong Xia
 *  @version   0.1
 *  @date      30/10/2026
 *  @warning   Improper use can crash your application
 *  @copyright GNU Public License.
 *  @note
 *  @todo 
 */
/* Includes ------------------------------------------------------------------*/
#include <stdint.h>
#include "board.h"
#include "menu.h"
#include "tl_pico.h"
#include "time.h"
#include "sm.h"

#define USE_TIMER_1 true
#include "TimerInterrupt.h"
/* Private define ------------------------------------------------------------*/
#define TIMER1_INTERVAL_MS 1
//#define TIMER_INTERVAL_MS 2000
#define TIME_SLICE_NO (8)
/* Private macro -------------------------------------------------------------*/
/* Private typedef -----------------------------------------------------------*/
/* Private variables ---------------------------------------------------------*/
//////////////////////////////////////////////
/// Descriptions                           ///
//////////////////////////////////////////////

static const uint8_t datetime_unit_map[] = {17,15,19,13,20,21};
config_t cfg;

//volatile time_t time = {0};
static const datetime_t current_datetime = {{26, 11, 10}, {0, 0, 0}};
static const datetime_t dt = {{26, 11, 10}, {7, 30, 0}};

/* Global variable -----------------------------------------------------------*/
/* External variable ---------------------------------------------------------*/
/* Private function prototypes -----------------------------------------------*/
static void led_on();
static void led_off();
static int8_t get_but(uint16_t id);
static void but_check(void * p);
static void sev_seg_update(void *p);
static uint8_t count_bits(uint8_t n);
static void seven_seg_show(void *p);
static void check_up(void *p);
static void TimerHandler1(void);

static enum state_t sm_init();
static enum state_t sm_config();
static enum state_t sm_waiting();
static enum state_t sm_working();
static enum state_t sm_idle();
/* Private functions ---------------------------------------------------------*/
static void TimerHandler1(void)
{
  tl_update(&cfg.tl);
}

static enum state_t sm_init()
{
  but_msg_t msg = {1, BUTTON_LNG_PRESSED};
  Drv7SegInit(&cfg.disp);
  Drv7SegClear(&cfg.disp, 0);
  Drv7SegClear(&cfg.disp, 1);
  Drv7SegClear(&cfg.disp, 2);
  Drv7SegClear(&cfg.disp, 3);
  tl_init(&cfg.tl, 10, &cfg.tl_task[0]);
  tl_add(&cfg.tl, sev_seg_update, 1, 1, TL_READY, NULL);
  cfg.tltask_7seg_show = tl_add(&cfg.tl, seven_seg_show, 1, 1000, TL_READY, &cfg.dtshow);
  // Drv7SegSetNum(&cfg.disp, cnt++);

  pinMode(8, OUTPUT);
  pinMode(7, OUTPUT);
  digitalWrite(7, LOW);
  #if DEBUG > 0
  Serial.begin(9600);
  #endif

  //init default current time
  memcpy(&cfg.curr_dt, &current_datetime, sizeof(datetime_t));
  //initialize the alaram
  alarm_init(&cfg.alarm, &dt, 0, 10*60);
  alarm_attach_on_func(&cfg.alarm, led_on);
  alarm_attach_off_func(&cfg.alarm, led_off);
  cfg.tltask_alarm_chk = tl_add_singleton(&cfg.tl, check_up, 1, 1000, TL_PAUSED, NULL);

  rc_init(&cfg.rc, 0, 0, 10*60);
  rc_attach_on_func(&cfg.rc, led_on);
  rc_attach_off_func(&cfg.rc, led_off);

  pinMode(2, INPUT_PULLUP);
  bt_init(&cfg.but, 1, get_but);
  cirbuf_init(&cfg.cbuf, 2, sizeof(but_msg_t), (cb_ele_t)&cfg.but_msgs[0], false);
  tl_add(&cfg.tl, but_check, 1, 20, TL_READY, NULL);

  ITimer1.init();
  ITimer1.attachInterruptInterval(TIMER1_INTERVAL_MS, TimerHandler1);
  menu_init();
  menu_show(msg);
  return ST_CONFIG;
}


static enum state_t sm_config()
{
    static bool finished = false;
    tl_pause(&cfg.tl, cfg.tltask_7seg_show);
    tl_pause(&cfg.tl, cfg.tltask_alarm_chk);
    but_msg_t msg = {0,0};
    // put your main code here, to run repeatedl
    if(cirbuf_get(&cfg.cbuf, (cb_ele_t)&msg) == 0)
    {
      finished = menu_show(msg);
    }

    if(finished) {
      finished = false;
      #if DEBUG > 0
      Serial.println("From ST_CONFIG enter into ST_WAITING");
      #endif
      return ST_WAITING;
    } else {
      return ST_CONFIG;
    }
}


static enum state_t sm_waiting()
{
  but_msg_t msg;
  static bool firsttime = true;
  cfg.dtshow.blink = false;

  if(firsttime)
  {
    tl_resume(&cfg.tl, cfg.tltask_7seg_show);
    tl_resume(&cfg.tl, cfg.tltask_alarm_chk);
    if(cfg.mode == ALARM_MODE)
    {
      cfg.dtshow.whichpart = 1;
      cfg.dtshow.pdt = &cfg.alarm.alarm_datetime;
      cfg.dtshow.blink = false;
    } else if(cfg.mode == REGRESSIVE_MODE){
      cfg.dtshow.pdt = &dt;
      cfg.dtshow.whichpart = 0;
      cfg.dtshow.blink = false;
      rc_get_left_time(&cfg.rc, &dt.time);
    }
    firsttime = false;
  }

  if(cirbuf_get(&cfg.cbuf, (cb_ele_t)&msg) == 0)
  {
    if(msg.evt == BUTTON_LNG_PRESSED){
      menu_show(msg);
      firsttime = true;
      #if DEBUG > 0
      Serial.println("From ST_WAITING enter into ST_CONFIG");
      #endif
      return ST_CONFIG;
    }
  }
  //wait until alarm the alarm
  if(cfg.mode == ALARM_MODE)
  {
    if(cfg.alarm.mark) {
      firsttime = true; 
      #if DEBUG > 0
      Serial.println("From ST_WAITING enter into ST_WORKING");
      #endif
      return ST_WORKING;
    }
    else return ST_WAITING;
  } else if(cfg.mode == REGRESSIVE_MODE){
    rc_get_left_time(&cfg.rc, &dt.time);
    if(cfg.rc.mode == ARMED) {
      firsttime = true;
      #if DEBUG > 0
      Serial.println("From ST_WAITING enter into ST_WORKING");
      #endif
      return ST_WORKING;
    }
  }
  return ST_WAITING;
}

static enum state_t sm_working()
{
    but_msg_t msg;
    cfg.dtshow.blink = true;
    if(cirbuf_get(&cfg.cbuf, (cb_ele_t)&msg) == 0)
    {
      if(msg.evt == BUTTON_LNG_PRESSED){
        #if DEBUG > 0
        Serial.println("From ST_WORKING enter into ST_CONFIG");
        #endif
        return ST_CONFIG;
      }
    }
    if(cfg.mode == ALARM_MODE)
    {
      cfg.dtshow.pdt = &cfg.curr_dt;
      if(cfg.alarm.mark) return ST_WORKING;
    } else if (cfg.mode == REGRESSIVE_MODE)
    {
      rc_get_left_time(&cfg.rc, &dt.time);
      if(cfg.rc.mode == STOP) {
        #if DEBUG > 0
        Serial.println("From ST_WORKING enter into ST_WAITING");
        #endif
        return ST_WAITING;
      }
    }
    return ST_WORKING;
}

static enum state_t sm_idle()
{
  but_msg_t msg;
  cfg.dtshow.blink = false;
  if(cirbuf_get(&cfg.cbuf, (cb_ele_t)&msg) == 0)
  {
    if(msg.evt == BUTTON_LNG_PRESSED){
      while(cirbuf_get(&cfg.cbuf, (cb_ele_t)&msg) == 0);
      #if DEBUG > 0
      Serial.println("From ST_IDLE enter into ST_WAITING");
      #endif
      return ST_CONFIG;
    }
  }
   return ST_IDLE;
}


static void led_on()
{
  digitalWrite(7, HIGH);
}
static void led_off()
{
  digitalWrite(7, LOW);
}

/**
 * @details
 * The button get state function, required by button driver
 * true for button pressed, false for button not pressed
 * @param [in] id Pointer of circuit buffer structure
 * @return None.
 *
 * @todo
 *
 */
static int8_t get_but(uint16_t id)
{
  int8_t r = digitalRead(2);
  return r?0:1;
}

/**
 * @details
 * The button tl task to periodically update the button state
 *
 * @param [in] p not used
 * @return None.
 *
 * @todo
 *
 */
static void but_check(void * p)
{
  bt_update(&cfg.but, &cfg.cbuf);
}

/**
 * @details
 * Timeline task for seven segment, write the video buffer value
 * to the actually seven segment
 *
 * @param [in] p not used
 * @return None.
 *
 * @todo
 *
 */
static void sev_seg_update(void *p)
{
  static uint8_t timeslice = 0;
  static uint8_t dev = 0;
  if (timeslice < 8 - count_bits(Drv7SegGetDisplayCode(dev)))
  {
    Drv7SegShow(&cfg.disp, dev);
  }
  else
  {
    Drv7SegCtrSet(dev, 0); // stop
  }

  if (timeslice++ > TIME_SLICE_NO)
  {
    dev++;
    if (dev >= 4)
      dev = 0;
    timeslice = 0;
  }
}

/**
 * @details
 * Count the number of bit 1 for a given uint8_t number
 *
 * @param [in] n value to count
 * @return Number of bit 1.
 *
 * @todo
 *
 */
static uint8_t count_bits(uint8_t n)
{
  n = (n & 0x55) + ((n >> 1) & 0x55); // 每2位为一组，统计1的个数
  n = (n & 0x33) + ((n >> 2) & 0x33); // 每4位为一组
  n = (n & 0x0F) + ((n >> 4) & 0x0F); // 每8位为一组
  return n;
}

/**
 * @details
 * The timeline task to write to video buffer of 7 seg
 * The behavior is controlled by cfg.dtshow structure
 * Shows year, month, day, hour, minute, second one by
 * one in sequence with blink or not.
 * @param [in] p &cfg.dtshow
 * @return None.
 *
 * @todo
 *
 */
static void seven_seg_show(void *p)
{
  dtshow_t * pdt = (dtshow_t *)p;
  static uint8_t st = 0;
  static bool shouldshow = true;
  if(pdt->whichpart == 0 && st < 3) st = 3;
  if(pdt->blink) {shouldshow = !shouldshow;}
  else shouldshow = true;
  if(!shouldshow) {Drv7SegClearAll(&cfg.disp); return;}
  switch(st)
  {
    case 0:
      Drv7SegSetNum(&cfg.disp, pdt->pdt->date.year); 
      break;
    case 1:
      Drv7SegSetNum(&cfg.disp, pdt->pdt->date.month); 
      break;
    case 2:
      Drv7SegSetNum(&cfg.disp, pdt->pdt->date.day); 
      break;
    case 3:
      Drv7SegSetNum(&cfg.disp, pdt->pdt->time.hour); 
      break;
    case 4:
      Drv7SegSetNum(&cfg.disp, pdt->pdt->time.minute); 
      break;
    case 5:
      Drv7SegSetNum(&cfg.disp, pdt->pdt->time.second); 
      break;
  }
  Drv7SegSetDigit(&cfg.disp, 11, 1);
  Drv7SegSetDigit(&cfg.disp, datetime_unit_map[st], 0);
  st++;
  if(st == 6)
  {
    if(pdt->whichpart == 0) st = 3;
    else st = 0;
  }
}

/**
 * @details
 * The timeline task running once per second, used to
 * offer tick for alarm and countdown, call the alarm or
 * countdown check function, and also inscrease 1 second 
 * for current date time.
 * @param [in] p &cfg.dtshow
 * @return None.
 *
 * @todo
 *
 */
static void check_up(void *p)
{
  if(cfg.mode == ALARM_MODE){
    t_datetime_inc(&cfg.curr_dt);
    alarm_check(&cfg.alarm, &cfg.curr_dt);
  }else if(cfg.mode == REGRESSIVE_MODE)
    rc_check(&cfg.rc);
}



/* Public functions ---------------------------------------------------------*/
enum state_t main_sm(enum state_t s)
{
  switch(s)
  {
    case ST_INIT:
        return sm_init();
    case ST_CONFIG:
        return sm_config();   
    case ST_WAITING:
        return sm_waiting();
    case ST_WORKING:
        return sm_working();
    case ST_IDLE:
        return sm_idle();
  }
}



