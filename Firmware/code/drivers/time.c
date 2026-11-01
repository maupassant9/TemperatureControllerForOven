/** 
 *  @file      time.c
 *  @brief     time structure and some basic function for time manupulation.
 *  @details   This class is used to demonstrate a number of section commands.
 *  @author    Dong Xia
 *  @version   0.1
 *  @date      26/10/2026
 *  @warning   Improper use can crash your application
 *  @copyright GNU Public License.
 *  @note
 *  @todo 
 */
/* Includes ------------------------------------------------------------------*/
#include <stdint.h>
#include <string.h>
#include "time.h"
/* Private define ------------------------------------------------------------*/
/* Private macro -------------------------------------------------------------*/
/* Private typedef -----------------------------------------------------------*/
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
 * Add one day to data_t 
 * @param [inout] d date to add
 * @return None.
 *
 */
void t_date_inc(date_t * d)
{
    d->day++;
    if(d->day <= t_last_day_of_month(d->month, d->year)) return;
    d->day = 1;
    d->month++;
    if(d->month <= 12) return;
    d->month = 1;
    d->year++;
}
/**
 * @details
 * Add some day to data
 * Limitations:
 * The day added should never pass the next month
 * If the day to add is limited to 28, it is
 * normally save.
 * @param [inout] d date to be added
 * @param [inout] day days to add
 * @return None.
 *
 */
void t_date_add(date_t * d, uint8_t day)
{
    int8_t iday = (int8_t)day;
    int8_t maxday = t_last_day_of_month(d->month, d->year);
    d->day += day;
    if(d->day <= maxday) return;
    d->day = d->day - maxday;
    d->month++;
    if(d->month <= 12) return;
    d->month = 1;
    d->year++;
}

/**
 * @details
 * Add one seccond to time_t 
 * @param [inout] t time to add to
 * @return 
 * true when overflow a day.
 * false when no overflow occurred.
 *
 */
bool t_time_inc(time_t * t)
{
    t->second++;
    if(t->second < 60) return false;
    t->second = 0;
    t->minute++;
    if(t->minute < 60) return false;
    t->minute = 0;
    t->hour++;
    if(t->hour < 24) return false;
    t->hour = 0;
    return true;
}

/**
 * @details
 * Add one second to datatime_t 
 * @param [in] sz the size of task array
 * @return time line handler.
 *
 * @todo
 * Test - OK
 */
//add one second to date and time
void t_datetime_inc(datetime_t * dt)
{
    if(t_time_inc(&dt->time)) t_date_inc(&dt->date);
}

/**
 * @details
 * Decrease one second to time_t 
 * @param [inout] t time to decrease
 * @param [in] is_permit_overflow true for hour overflow from 0 to 23
 * @return None.
 *
 */
bool t_time_dec(time_t * t, bool is_permit_overflow)
{
    t->second--;
    if(t->second >= 0) return false;
    t->second = 59;
    t->minute--;
    if(t->minute >= 0) return false;
    t->minute = 59;
    t->hour--;
    if(t->hour >= 0) return false;
    if(is_permit_overflow) t->hour = 23;
    else {t->hour = 0; t->minute = 0; t->second = 0;}
    return true;
}

/**
 * @details
 * The last day of certain month and year 
 * @param [in] month month
 * @param [in] year year
 * @return the last day of the given month and year.
 *
 */
int8_t t_last_day_of_month(int8_t month, int8_t year)
{
    int16_t y = year + YEAR_BASE;
    if(month == 2) return (y % 4)?28:29;
    if((month <= 7)&&(month % 2 == 1)) return 31;
    if((month >= 8)&&(month % 2 == 0)) return 31;
    return 30;
}

/**
 * @details
 * Compare the two time
 * @param [in] t1 time 1
 * @param [in] t2 time 2
 * @retval 1: t1 > t2
 * @retval -1: t1 < t2
 * @retval 0: t1 == t2
 *
 */
int8_t t_time_compare(time_t * t1, time_t * t2)
{
    if(t1->hour > t2->hour) return 1;
    if(t1->hour < t2->hour) return -1;
    if(t1->minute > t2->minute) return 1;
    if(t1->minute < t2->minute) return -1;
    if(t1->second > t2->second) return 1;
    if(t1->second < t2->second) return -1;
    return 0;
}
/**
 * @details
 * Compare the two dates
 * @param [in] d1 date 1
 * @param [in] d2 date 2
 * @retval 1: d1 > d2
 * @retval -1: d1 < d2
 * @retval 0: d1 == d2
 *
 */
int8_t t_date_compare(date_t *d1, date_t *d2)
{
    if(d1->year > d2->year) return 1;
    if(d1->year < d2->year) return -1;
    if(d1->month > d2->month) return 1;
    if(d1->month < d2->month) return -1;
    if(d1->day > d2->day) return 1;
    if(d1->day < d2->day) return -1;
    return 0;
}

/**
 * @details
 * Compare the two date and time
 * @param [in] dt1 date and time 1
 * @param [in] dt2 date and time 2
 * @retval 1: dt1 > dt2
 * @retval -1: dt1 < dt2
 * @retval 0: dt1 == dt2
 *
 */
int8_t t_datetime_compare(datetime_t * dt1, datetime_t * dt2)
{
    int8_t result = t_date_compare(&dt1->date, &dt2->date);
    if(result != 0) return result;
    return t_time_compare(&dt1->time, &dt2->time);
}

/**
 * @details
 * Get the day of the week with given day, month and year
 * @param [in] d day
 * @param [in] m month
 * @param [in] year year
 * @return the day of the week with given date information
 *
 */
int8_t t_get_day_of_week(int8_t d, int8_t m, int8_t year) {
    int16_t y = YEAR_BASE + year;
    // Month adjustment codes for Gregorian calendar
    static int8_t t[] = {0, 3, 2, 5, 0, 3, 5, 1, 4, 6, 2, 4};
    
    // If month is January or February, treat as previous year
    if (m < 3) {
        y -= 1;
    }
    
    // Sakamoto's formula
    return (y + y/4 - y/100 + y/400 + t[m-1] + d) % 7;
}

/**
 * @details
 * Convert the second to time_t format
 * @param [in] sec second
 * @param [out] t time_t structure to save result
 * @return None.
 *
 */
void t_convert_sec_to_time(uint32_t sec, time_t * t)
{
    int8_t h, m, s;
    t->second = sec % 60;
    t->minute = (sec / 60) % 60;
    t->hour = sec / 3600;
}