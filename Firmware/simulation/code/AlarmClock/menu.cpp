#include <stdint.h>
#include <string.h>
#include "sevenSeg.h"
#include "menu.h"
/* configure menu */
//https://steve-p.org/led/
// menu - main //
// 0. mode setting
// [0][-][1] button press (alarm mode)
// [0][-][2] button press (regressive mode)
//  button long press to confirm

//manul mode
//button press: on/off toggle
//button long press: configuration
//
//alarm mode
// set current year, month, day, hour, minute, second (button press add), button long press confirm
// set current time
// [1] - [year1][year2]
// [1] - [month1][month2]
// [1] - [day1][day2]
// [1] - [hour1][hour2]
// [1] - [minute1][minute2]
// [1] - [second1][second2]
// set alarm time
// [2] - [year1][year2]
// [2] - [month1][month2]
// [2] - [day1][day2]
// [2] - [hour1][hour2]
// [2] - [minute1][minute2]
// [2] - [second1][second2]
// set repeate pattern
// [3][-][1][y/n]
// [3][-][2][y/n]
// [3][-][3][y/n]
// [3][-][4][y/n]
// [3][-][5][y/n]
// [3][-][6][y/n]
// [3][-][7][y/n]

//regressive mode
// set regressive time
// [1] - [hour1][hour2]
// [1] - [minute1][minute2]
// [1] - [second1][second2]
// set regressive period time
// [2] - [hour1][hour2]
// [2] - [minute1][minute2]
// [2] - [second1][second2]
// set regressive on time
// [1][-][1][0] //ten minutes

static const uint8_t datetime_unit_map[] = {17,15,19,13,20,21};

enum menu_st_t{
    MODE_SELECT_MENU = 0,
    ALARM_MODE_MENU,
    REGRESSIVE_MODE_MENU
};


extern config_t cfg;

void menu_init()
{
    cfg.mode = 0;
}

//true when menu show finished
//false when menu show still inside
bool menu_show(but_msg_t msg)
{
    enum mode_t m;
    static enum menu_st_t st = MODE_SELECT_MENU;
    switch(st)
    {
        case MODE_SELECT_MENU:
            if(NO_MODE_SELECTED != (m = menu_select_sm_next(msg))) {
                if(m == ALARM_MODE)
                    st = ALARM_MODE_MENU;
                else
                    st = REGRESSIVE_MODE_MENU;
            }
            return false;
        case ALARM_MODE_MENU: 
            if(menu_alarm_next(msg)){
                st = MODE_SELECT_MENU;
                cfg.mode = ALARM_MODE;
                return true;
            }
            return false;
        case REGRESSIVE_MODE_MENU: 
            if(menu_regressive_next(msg)) {
                st = MODE_SELECT_MENU;
                cfg.mode = REGRESSIVE_MODE;
                return true;
            };
            return false;
    }
}

enum mode_t menu_select_sm_next(but_msg_t msg)
{
    static uint8_t st = 0;
    Drv7SegSetDigit(&cfg.disp, 0, 0);
    Drv7SegSetDigit(&cfg.disp, 11, 1);
    Drv7SegSetDigit(&cfg.disp, 12, 2);

    switch(st)
    {
        case 0:
                st++;
                msg.evt = BUTTON_NOT_PRESSED;
                Drv7SegSetDigit(&cfg.disp, 1, 3);
        case 1: 
            if(msg.evt == BUTTON_SHT_PRESSED) {
                st++;
                Drv7SegSetDigit(&cfg.disp, st, 3);
            }
            else if(msg.evt == BUTTON_LNG_PRESSED) {
                st = 0;
                menu_regressive_next(msg);
                return REGRESSIVE_MODE;
            }
            break;
        case 2: 
            if(msg.evt == BUTTON_SHT_PRESSED) {
                st = 1;
                Drv7SegSetDigit(&cfg.disp, st, 3);
            }
            else if(msg.evt == BUTTON_LNG_PRESSED) {
                st = 0; 
                //msg.evt = BUTTON_NOT_PRESSED;
                menu_alarm_next(msg);
                return ALARM_MODE;
            }
            break;
    }
    return NO_MODE_SELECTED;
}


bool menu_alarm_next(but_msg_t msg)
{
    static uint8_t st = 0;
    static alarm_t alarm;
    static menu_digital_input_t editor;
    date_t *d = &alarm.alarm_datetime.date;
    time_t *t = &alarm.alarm_datetime.time;
    uint8_t * p = &alarm.repeate_pattern;
    static bool mark = false;
   
    switch(st)
    {
        case 0: 
            msg.evt = BUTTON_NOT_PRESSED;
            Drv7SegSetDigit(&cfg.disp, 24, 3);
            Drv7SegSetDigit(&cfg.disp, 24, 2);
            Drv7SegSetDigit(&cfg.disp, 23, 1);
            Drv7SegSetDigit(&cfg.disp, 22, 0);
            delay(1000);
            memcpy(&alarm.alarm_datetime, &cfg.curr_dt, sizeof(datetime_t));
            menu_digital_input_init(&editor, d->year, 99, 26);
            menu_show_alarm_item(&editor,  1,  datetime_unit_map[st%6]);
            st++;
        case 1:
            menu_alarm_next_aux_cfg_date(msg, &st, &d->year, d->month, &editor, 12, 1);
            break;
        case 2:
            menu_alarm_next_aux_cfg_date(msg, &st, &d->month, d->day, &editor, t_last_day_of_month(d->month, d->year), 1);
            break;
        case 3:
            menu_alarm_next_aux_cfg_date(msg, &st, &d->day, t->hour, &editor, 23, 0);
            break;
        case 4:
            menu_alarm_next_aux_cfg_date(msg, &st, &t->hour, t->minute, &editor, 59, 0);
            break;
        case 5:
            menu_alarm_next_aux_cfg_date(msg, &st, &t->minute, t->second, &editor, 59, 0);
            break;
        case 6: 
            if(msg.evt == BUTTON_SHT_PRESSED|| msg.evt == BUTTON_NOT_RELEASED) {
                menu_digital_input_inc(&editor);
                menu_show_alarm_item(&editor, 1,  datetime_unit_map[(st-1)%6]);
            } else if(msg.evt == BUTTON_LNG_PRESSED) { 
                t->second = 0; // t->second = editor.val;
                memcpy(&cfg.curr_dt, &alarm.alarm_datetime, sizeof(datetime_t));
                #if DEBUG > 0
                alarm_print(&alarm);
                #endif
                memcpy(&alarm, &cfg.alarm, sizeof(alarm_t));
                memcpy(&alarm.alarm_datetime.date, &cfg.curr_dt.date, sizeof(date_t));
                Drv7SegSetDigit(&cfg.disp, 25, 3);
                Drv7SegSetDigit(&cfg.disp, 26, 2);
                Drv7SegSetDigit(&cfg.disp, 25, 1);
                Drv7SegSetDigit(&cfg.disp, 12, 0);
                delay(1000);
                menu_digital_input_init(&editor, d->year, 99, 26);
                menu_show_alarm_item(&editor,  1,  datetime_unit_map[st%6]);
                msg.evt = BUTTON_NOT_PRESSED;
                st++;
            }
        case 7:
            menu_alarm_next_aux_cfg_date(msg, &st, &d->year, d->month, &editor, 12, 1);
            break;
        case 8:
            menu_alarm_next_aux_cfg_date(msg, &st, &d->month, d->day, &editor, t_last_day_of_month(d->month, d->year), 1);
            break;
        case 9:
            menu_alarm_next_aux_cfg_date(msg, &st, &d->day, t->hour, &editor, 23, 0);
            break;
        case 10:
            menu_alarm_next_aux_cfg_date(msg, &st, &t->hour, t->minute, &editor, 59, 0);
            break;
        case 11:
            // menu_alarm_next_aux_cfg_date(msg, &st, &t->minute, t->second, &editor, 59, 0);
            if(msg.evt == BUTTON_SHT_PRESSED || msg.evt == BUTTON_NOT_RELEASED) {
                menu_digital_input_inc(&editor);
                menu_show_alarm_item(&editor, 1,  datetime_unit_map[(st-1)%6]);
            } else if(msg.evt == BUTTON_LNG_PRESSED) {
                st+=2; 
                t->minute = editor.val;
                t->second = 0;// t->second = editor.val;
                mark = ((*p) & 1)?1:0;
                menu_show_repeate_item(0, mark);
            }
            break;
        case 12:
            // if(msg.evt == BUTTON_SHT_PRESSED || msg.evt == BUTTON_NOT_RELEASED) {
            //     menu_digital_input_inc(&editor);
            //     menu_show_alarm_item(&editor, 1,  datetime_unit_map[(st-1)%6]);
            // } else if(msg.evt == BUTTON_LNG_PRESSED) {
            //     st++; 
            //     t->second = 0;// t->second = editor.val;
            //     mark = ((*p) & 1)?1:0;
            //     menu_show_repeate_item(0, mark);
            // }
            // break;
        case 13:
        case 14:
        case 15:
        case 16:
        case 17:
        case 18:
            menu_alarm_next_aux_cfg_repeate_pattern(msg, &st, st-13, &mark, p);
            break;
        case 19:
            if(msg.evt == BUTTON_SHT_PRESSED){
                mark = !mark;
                menu_show_repeate_item(6, mark);
            }else if(msg.evt == BUTTON_LNG_PRESSED) {
                st = 0;
                if(mark) *p |= (1<<6);
                else *p &= (~(1<<6));
                mark = false;
                memcpy(&cfg.alarm, &alarm, sizeof(alarm_t));
                #if DEBUG > 0
                alarm_print(&alarm);
                #endif
                alarm.mark = false;
                return true;
            }
        default:
            return false;        
    }
    return false;
}

bool menu_regressive_next(but_msg_t msg)
{
    static uint8_t st = 0;
    static menu_digital_input_t editor;
    static time_t t = {0,0,0};
   
    switch(st)
    {
        case 0: 
            t_convert_sec_to_time(cfg.rc.delay_in_sec, &t);
            msg.evt = BUTTON_NOT_PRESSED;
            Drv7SegSetDigit(&cfg.disp, 12, 3);
            Drv7SegSetDigit(&cfg.disp, 12, 2);
            Drv7SegSetDigit(&cfg.disp, 27, 1);
            Drv7SegSetDigit(&cfg.disp, 24, 0);
            delay(1000);
            menu_digital_input_init(&editor, t.hour, 23, 0);
            menu_show_alarm_item(&editor,  1,  datetime_unit_map[3]);
            st+=4;
        case 4:
            menu_alarm_next_aux_cfg_date(msg, &st, &t.hour, t.minute, &editor, 59, 0);
            break;
        case 5:
            //menu_alarm_next_aux_cfg_date(msg, &st, &t.minute, t.second, &editor, 59, 0);
            if(msg.evt == BUTTON_SHT_PRESSED|| msg.evt == BUTTON_NOT_RELEASED) {
                menu_digital_input_inc(&editor);
                menu_show_alarm_item(&editor, 1,  datetime_unit_map[(st-1)%6]);
            } else if(msg.evt == BUTTON_LNG_PRESSED) { 
                t.minute = editor.val;
                t.second = 0;
                cfg.rc.delay_in_sec = t.hour*3600+t.minute*60;
                cfg.rc.mode = INITIAL;
                st = 0;
                return true;
            }
            break;
        // case 6: 
            // if(msg.evt == BUTTON_SHT_PRESSED|| msg.evt == BUTTON_NOT_RELEASED) {
            //     menu_digital_input_inc(&editor);
            //     menu_show_alarm_item(&editor, 1,  datetime_unit_map[(st-1)%6]);
            // } else if(msg.evt == BUTTON_LNG_PRESSED) { 
                // t.second = 0;// t.second = editor.val;
                // cfg.rc.delay_in_sec = t.hour*3600+t.minute*60+t.second;
                // cfg.rc.mode = INITIAL;
                // st = 0;
                // return true;
            // }
        default:
            return false;        
    }
    return false;
}


void menu_alarm_next_aux_cfg_repeate_pattern(but_msg_t msg, uint8_t *pst, uint8_t id, bool *pmark, uint8_t *ppattern)
{
    if(msg.evt == BUTTON_SHT_PRESSED){
        *pmark = !*pmark;
        menu_show_repeate_item(id, *pmark);
    }else if(msg.evt == BUTTON_LNG_PRESSED) {
        if(*pmark) *ppattern |= (1<<id);
        else *ppattern &= (~(1<<id));
        *pmark = (*ppattern & (1<<(id+1)))?1:0;
        menu_show_repeate_item(id+1, *pmark);
        (*pst)++;
    }
}


void menu_alarm_next_aux_cfg_date(but_msg_t msg, 
    uint8_t *pst, 
    int8_t *pval, 
    int8_t val, 
    menu_digital_input_t* ed,
    int8_t max,
    int8_t min)
{
    if(msg.evt == BUTTON_SHT_PRESSED  || msg.evt == BUTTON_NOT_RELEASED) {
        menu_digital_input_inc(ed);
        menu_show_alarm_item(ed, 1, datetime_unit_map[(*pst-1)% 6]);
    }
    else if(msg.evt == BUTTON_LNG_PRESSED) {
        *pval = ed->val;
        menu_digital_input_init(ed, val, max, min);
        menu_show_alarm_item(ed,  1, datetime_unit_map[*pst % 6]);
        (*pst)++;
    }
}

void menu_show_alarm_item(menu_digital_input_t * ed, uint8_t idx, uint8_t unit)
{
    menu_show_digital_input(ed);
    Drv7SegSetDigit(&cfg.disp, unit, 0);
    Drv7SegSetDigit(&cfg.disp, 11, 1);
}

void menu_show_repeate_item(uint8_t day, bool ismarked)
{
    Drv7SegSetDigit(&cfg.disp, day, 2);
    Drv7SegSetDigit(&cfg.disp, 18, 0);
    Drv7SegSetDigit(&cfg.disp, 11, 1);
    Drv7SegSetDigit(&cfg.disp, ismarked?17:15 ,3);
}

void menu_digital_input_init(menu_digital_input_t * t, uint16_t def_val, uint16_t max, uint16_t min)
{
    t->val = def_val;
    if(max < min) {max = min;};
    t->maxval = max;
    t->minval = min;
    t->step = 1;
}

void menu_digital_input_inc(menu_digital_input_t *t)
{
    t->val += t->step;
    if(t->val > t->maxval){
        //rotate to the min
        t->val = t->minval;
    }
}

void menu_show_digital_input(menu_digital_input_t * t)
{
    Drv7SegSetNum(&cfg.disp, t->val);
}

