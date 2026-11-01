/**
 * @file      time.h
 * @brief     Pretty nice class.
 * @author    Dong Xia
 * @version   0.1
 * @date      26/10/2026
 * @warning   Improper use can crash your application
 * @copyright GNU Public License.
 */

/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef __TIME_H__
#define __TIME_H__
#ifdef __cplusplus
extern "C" {
#endif
/* Includes ------------------------------------------------------------------*/
#include <stdbool.h>
/* Exported macro ------------------------------------------------------------*/
#define NULL ((void *)0)
#define YEAR_BASE (2000)
/* Exported constants --------------------------------------------------------*/
/* Exported types ------------------------------------------------------------*/
typedef struct{
    int8_t hour;
    int8_t minute;
    int8_t second;
}time_t; 

typedef struct{
    int8_t year;
    int8_t month;
    int8_t day;
}date_t;

typedef struct{
    date_t date;
    time_t time;
}datetime_t;
////////////////////////////////////////////////
/// Descriptions                             ///
////////////////////////////////////////////////
/* Exported functions ------------------------------------------------------- */
int8_t t_last_day_of_month(int8_t month, int8_t year);
bool t_time_dec(time_t * t, bool is_permit_overflow);
bool t_time_inc(time_t * t);
void t_date_add(date_t * d, uint8_t day);
void t_date_inc(date_t * d);
void t_datetime_inc(datetime_t * dt);
int8_t t_date_compare(date_t *d1, date_t *d2);
int8_t t_time_compare(time_t * t1, time_t * t2);
int8_t t_datetime_compare(datetime_t * dt1, datetime_t * dt2);
int8_t t_get_day_of_week(int8_t d, int8_t m, int8_t y);
void t_convert_sec_to_time(uint32_t sec, time_t * t);

#ifdef __cplusplus
}
#endif
#endif /*__TIME_H__*/

