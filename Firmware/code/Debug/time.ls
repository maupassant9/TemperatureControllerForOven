   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.13.3 - 22 May 2025
   3                     ; Generator (Limited) V4.6.6 - 07 Jan 2026
   4                     ; Optimizer V4.6.6 - 07 Jan 2026
  90                     ; 37 void t_date_inc(date_t * d)
  90                     ; 38 {
  91                     	switch	.text
  92  0000               f_t_date_inc:
  94  0000 89            	pushw	x
  95       00000001      OFST:	set	1
  98                     ; 39     d->day++;
 100  0001 6c02          	inc	(2,x)
 101  0003 88            	push	a
 102                     ; 40     if(d->day <= t_last_day_of_month(d->month, d->year)) return;
 104  0004 f6            	ld	a,(x)
 105  0005 1602          	ldw	y,(OFST+1,sp)
 106  0007 97            	ld	xl,a
 107  0008 90e601        	ld	a,(1,y)
 108  000b 95            	ld	xh,a
 109  000c 8dc000c0      	callf	f_t_last_day_of_month
 111  0010 6b01          	ld	(OFST+0,sp),a
 113  0012 1e02          	ldw	x,(OFST+1,sp)
 114  0014 e602          	ld	a,(2,x)
 115  0016 1101          	cp	a,(OFST+0,sp)
 116  0018 2d0c          	jrsle	L01
 119                     ; 41     d->day = 1;
 121  001a a601          	ld	a,#1
 122  001c e702          	ld	(2,x),a
 123                     ; 42     d->month++;
 125  001e 6c01          	inc	(1,x)
 126                     ; 43     if(d->month <= 12) return;
 128  0020 e601          	ld	a,(1,x)
 129  0022 a10d          	cp	a,#13
 130  0024 2e03          	jrsge	L54
 132  0026               L01:
 135  0026 5b03          	addw	sp,#3
 136  0028 87            	retf	
 137  0029               L54:
 138                     ; 44     d->month = 1;
 140  0029 a601          	ld	a,#1
 141  002b e701          	ld	(1,x),a
 142                     ; 45     d->year++;
 144  002d 7c            	inc	(x)
 145                     ; 46 }
 147  002e 20f6          	jra	L01
 205                     ; 59 void t_date_add(date_t * d, uint8_t day)
 205                     ; 60 {
 206                     	switch	.text
 207  0030               f_t_date_add:
 209  0030 89            	pushw	x
 210  0031 89            	pushw	x
 211       00000002      OFST:	set	2
 214                     ; 61     int8_t iday = (int8_t)day;
 216                     ; 62     int8_t maxday = t_last_day_of_month(d->month, d->year);
 218  0032 f6            	ld	a,(x)
 219  0033 1603          	ldw	y,(OFST+1,sp)
 220  0035 97            	ld	xl,a
 221  0036 90e601        	ld	a,(1,y)
 222  0039 95            	ld	xh,a
 223  003a 8dc000c0      	callf	f_t_last_day_of_month
 225  003e 6b02          	ld	(OFST+0,sp),a
 227                     ; 63     d->day += day;
 229  0040 1e03          	ldw	x,(OFST+1,sp)
 230  0042 e602          	ld	a,(2,x)
 231  0044 1b08          	add	a,(OFST+6,sp)
 232  0046 e702          	ld	(2,x),a
 233                     ; 64     if(d->day <= maxday) return;
 235  0048 1002          	sub	a,(OFST+0,sp)
 236  004a 2d0a          	jrsle	L61
 239                     ; 65     d->day = d->day - maxday;
 241  004c e702          	ld	(2,x),a
 242                     ; 66     d->month++;
 244  004e 6c01          	inc	(1,x)
 245                     ; 67     if(d->month <= 12) return;
 247  0050 e601          	ld	a,(1,x)
 248  0052 a10d          	cp	a,#13
 249  0054 2e03          	jrsge	L77
 251  0056               L61:
 254  0056 5b04          	addw	sp,#4
 255  0058 87            	retf	
 256  0059               L77:
 257                     ; 68     d->month = 1;
 259  0059 a601          	ld	a,#1
 260  005b e701          	ld	(1,x),a
 261                     ; 69     d->year++;
 263  005d 7c            	inc	(x)
 264                     ; 70 }
 266  005e 20f6          	jra	L61
 331                     ; 81 bool t_time_inc(time_t * t)
 331                     ; 82 {
 332                     	switch	.text
 333  0060               f_t_time_inc:
 335       00000000      OFST:	set	0
 338                     ; 83     t->second++;
 340  0060 6c02          	inc	(2,x)
 341                     ; 84     if(t->second < 60) return false;
 343  0062 e602          	ld	a,(2,x)
 344  0064 a13c          	cp	a,#60
 347  0066 2f0a          	jrslt	LC001
 348                     ; 85     t->second = 0;
 350  0068 6f02          	clr	(2,x)
 351                     ; 86     t->minute++;
 353  006a 6c01          	inc	(1,x)
 354                     ; 87     if(t->minute < 60) return false;
 356  006c e601          	ld	a,(1,x)
 357  006e a13c          	cp	a,#60
 358  0070 2e02          	jrsge	L531
 361  0072               LC001:
 364  0072 4f            	clr	a
 367  0073 87            	retf	
 368  0074               L531:
 369                     ; 88     t->minute = 0;
 371  0074 6f01          	clr	(1,x)
 372                     ; 89     t->hour++;
 374  0076 7c            	inc	(x)
 375                     ; 90     if(t->hour < 24) return false;
 377  0077 f6            	ld	a,(x)
 378  0078 a118          	cp	a,#24
 381  007a 2ff6          	jrslt	LC001
 382                     ; 91     t->hour = 0;
 384  007c 7f            	clr	(x)
 385                     ; 92     return true;
 387  007d a601          	ld	a,#1
 390  007f 87            	retf	
 455                     ; 105 void t_datetime_inc(datetime_t * dt)
 455                     ; 106 {
 456                     	switch	.text
 457  0080               f_t_datetime_inc:
 459  0080 89            	pushw	x
 460       00000000      OFST:	set	0
 463                     ; 107     if(t_time_inc(&dt->time)) t_date_inc(&dt->date);
 465  0081 1c0003        	addw	x,#3
 466  0084 8d600060      	callf	f_t_time_inc
 468  0088 4d            	tnz	a
 469  0089 2706          	jreq	L571
 472  008b 1e01          	ldw	x,(OFST+1,sp)
 473  008d 8d000000      	callf	f_t_date_inc
 475  0091               L571:
 476                     ; 108 }
 479  0091 85            	popw	x
 480  0092 87            	retf	
 527                     ; 118 bool t_time_dec(time_t * t, bool is_permit_overflow)
 527                     ; 119 {
 528                     	switch	.text
 529  0093               f_t_time_dec:
 531       fffffffe      OFST: set -2
 534                     ; 120     t->second--;
 536  0093 6a02          	dec	(2,x)
 537                     ; 121     if(t->second >= 0) return false;
 539  0095 e602          	ld	a,(2,x)
 542  0097 2a0a          	jrpl	LC002
 543                     ; 122     t->second = 59;
 545  0099 a63b          	ld	a,#59
 546  009b e702          	ld	(2,x),a
 547                     ; 123     t->minute--;
 549  009d 6a01          	dec	(1,x)
 550                     ; 124     if(t->minute >= 0) return false;
 552  009f e601          	ld	a,(1,x)
 553  00a1 2b02          	jrmi	L522
 556  00a3               LC002:
 559  00a3 4f            	clr	a
 562  00a4 87            	retf	
 563  00a5               L522:
 564                     ; 125     t->minute = 59;
 566  00a5 a63b          	ld	a,#59
 567  00a7 e701          	ld	(1,x),a
 568                     ; 126     t->hour--;
 570  00a9 7a            	dec	(x)
 571                     ; 127     if(t->hour >= 0) return false;
 573  00aa f6            	ld	a,(x)
 576  00ab 2af6          	jrpl	LC002
 577                     ; 128     if(is_permit_overflow) t->hour = 23;
 579  00ad 7b04          	ld	a,(OFST+6,sp)
 580  00af a501          	bcp	a,#1
 581  00b1 2705          	jreq	L132
 584  00b3 a617          	ld	a,#23
 585  00b5 f7            	ld	(x),a
 587  00b6 2005          	jra	L332
 588  00b8               L132:
 589                     ; 129     else {t->hour = 0; t->minute = 0; t->second = 0;}
 591  00b8 7f            	clr	(x)
 594  00b9 6f01          	clr	(1,x)
 597  00bb 6f02          	clr	(2,x)
 598  00bd               L332:
 599                     ; 130     return true;
 601  00bd a601          	ld	a,#1
 604  00bf 87            	retf	
 650                     ; 141 int8_t t_last_day_of_month(int8_t month, int8_t year)
 650                     ; 142 {
 651                     	switch	.text
 652  00c0               f_t_last_day_of_month:
 654  00c0 89            	pushw	x
 655  00c1 89            	pushw	x
 656       00000002      OFST:	set	2
 659                     ; 143     int16_t y = year + YEAR_BASE;
 661  00c2 9f            	ld	a,xl
 662  00c3 5f            	clrw	x
 663  00c4 4d            	tnz	a
 664  00c5 2a01          	jrpl	L04
 665  00c7 53            	cplw	x
 666  00c8               L04:
 667  00c8 97            	ld	xl,a
 668  00c9 1c07d0        	addw	x,#2000
 669  00cc 1f01          	ldw	(OFST-1,sp),x
 671                     ; 144     if(month == 2) return (y % 4)?28:29;
 673  00ce 7b03          	ld	a,(OFST+1,sp)
 674  00d0 a102          	cp	a,#2
 675  00d2 2611          	jrne	L552
 678  00d4 a604          	ld	a,#4
 679  00d6 8d000000      	callf	d_smodx
 681  00da 5d            	tnzw	x
 682  00db 2704          	jreq	L24
 683  00dd a61c          	ld	a,#28
 684  00df 2019          	jra	L25
 685  00e1               L24:
 686  00e1 a61d          	ld	a,#29
 688  00e3 2015          	jra	L25
 689  00e5               L552:
 690                     ; 145     if((month <= 7)&&(month % 2 == 1)) return 31;
 692  00e5 a108          	cp	a,#8
 693  00e7 2e14          	jrsge	L752
 695  00e9 5f            	clrw	x
 696  00ea 4d            	tnz	a
 697  00eb 2a01          	jrpl	L64
 698  00ed 53            	cplw	x
 699  00ee               L64:
 700  00ee 97            	ld	xl,a
 701  00ef a602          	ld	a,#2
 702  00f1 8d000000      	callf	d_smodx
 704  00f5 5a            	decw	x
 705  00f6 2605          	jrne	L752
 708  00f8               LC003:
 710  00f8 a61f          	ld	a,#31
 712  00fa               L25:
 714  00fa 5b04          	addw	sp,#4
 715  00fc 87            	retf	
 716  00fd               L752:
 717                     ; 146     if((month >= 8)&&(month % 2 == 0)) return 31;
 719  00fd 7b03          	ld	a,(OFST+1,sp)
 720  00ff a108          	cp	a,#8
 721  0101 2f0f          	jrslt	L162
 723  0103 5f            	clrw	x
 724  0104 4d            	tnz	a
 725  0105 2a01          	jrpl	L05
 726  0107 53            	cplw	x
 727  0108               L05:
 728  0108 97            	ld	xl,a
 729  0109 a602          	ld	a,#2
 730  010b 8d000000      	callf	d_smodx
 732  010f 5d            	tnzw	x
 735  0110 27e6          	jreq	LC003
 736  0112               L162:
 737                     ; 147     return 30;
 739  0112 a61e          	ld	a,#30
 741  0114 20e4          	jra	L25
 789                     ; 160 int8_t t_time_compare(time_t * t1, time_t * t2)
 789                     ; 161 {
 790                     	switch	.text
 791  0116               f_t_time_compare:
 793  0116 89            	pushw	x
 794       00000000      OFST:	set	0
 797                     ; 162     if(t1->hour > t2->hour) return 1;
 799  0117 f6            	ld	a,(x)
 800  0118 1e06          	ldw	x,(OFST+6,sp)
 801  011a f1            	cp	a,(x)
 804  011b 2c2a          	jrsgt	LC005
 805                     ; 163     if(t1->hour < t2->hour) return -1;
 807  011d 1e01          	ldw	x,(OFST+1,sp)
 808  011f f6            	ld	a,(x)
 809  0120 1e06          	ldw	x,(OFST+6,sp)
 810  0122 f1            	cp	a,(x)
 811  0123 2e04          	jrsge	L313
 814  0125               LC004:
 817  0125 a6ff          	ld	a,#255
 819  0127               L65:
 821  0127 85            	popw	x
 822  0128 87            	retf	
 823  0129               L313:
 824                     ; 164     if(t1->minute > t2->minute) return 1;
 826  0129 1e01          	ldw	x,(OFST+1,sp)
 827  012b e601          	ld	a,(1,x)
 828  012d 1e06          	ldw	x,(OFST+6,sp)
 829  012f e101          	cp	a,(1,x)
 832  0131 2c14          	jrsgt	LC005
 833                     ; 165     if(t1->minute < t2->minute) return -1;
 835  0133 1e01          	ldw	x,(OFST+1,sp)
 836  0135 e601          	ld	a,(1,x)
 837  0137 1e06          	ldw	x,(OFST+6,sp)
 838  0139 e101          	cp	a,(1,x)
 841  013b 2fe8          	jrslt	LC004
 842                     ; 166     if(t1->second > t2->second) return 1;
 844  013d 1e01          	ldw	x,(OFST+1,sp)
 845  013f e602          	ld	a,(2,x)
 846  0141 1e06          	ldw	x,(OFST+6,sp)
 847  0143 e102          	cp	a,(2,x)
 848  0145 2d04          	jrsle	L123
 851  0147               LC005:
 854  0147 a601          	ld	a,#1
 856  0149 20dc          	jra	L65
 857  014b               L123:
 858                     ; 167     if(t1->second < t2->second) return -1;
 860  014b 1e01          	ldw	x,(OFST+1,sp)
 861  014d e602          	ld	a,(2,x)
 862  014f 1e06          	ldw	x,(OFST+6,sp)
 863  0151 e102          	cp	a,(2,x)
 866  0153 2fd0          	jrslt	LC004
 867                     ; 168     return 0;
 869  0155 4f            	clr	a
 871  0156 20cf          	jra	L65
 919                     ; 180 int8_t t_date_compare(date_t *d1, date_t *d2)
 919                     ; 181 {
 920                     	switch	.text
 921  0158               f_t_date_compare:
 923  0158 89            	pushw	x
 924       00000000      OFST:	set	0
 927                     ; 182     if(d1->year > d2->year) return 1;
 929  0159 f6            	ld	a,(x)
 930  015a 1e06          	ldw	x,(OFST+6,sp)
 931  015c f1            	cp	a,(x)
 934  015d 2c2a          	jrsgt	LC007
 935                     ; 183     if(d1->year < d2->year) return -1;
 937  015f 1e01          	ldw	x,(OFST+1,sp)
 938  0161 f6            	ld	a,(x)
 939  0162 1e06          	ldw	x,(OFST+6,sp)
 940  0164 f1            	cp	a,(x)
 941  0165 2e04          	jrsge	L553
 944  0167               LC006:
 947  0167 a6ff          	ld	a,#255
 949  0169               L26:
 951  0169 85            	popw	x
 952  016a 87            	retf	
 953  016b               L553:
 954                     ; 184     if(d1->month > d2->month) return 1;
 956  016b 1e01          	ldw	x,(OFST+1,sp)
 957  016d e601          	ld	a,(1,x)
 958  016f 1e06          	ldw	x,(OFST+6,sp)
 959  0171 e101          	cp	a,(1,x)
 962  0173 2c14          	jrsgt	LC007
 963                     ; 185     if(d1->month < d2->month) return -1;
 965  0175 1e01          	ldw	x,(OFST+1,sp)
 966  0177 e601          	ld	a,(1,x)
 967  0179 1e06          	ldw	x,(OFST+6,sp)
 968  017b e101          	cp	a,(1,x)
 971  017d 2fe8          	jrslt	LC006
 972                     ; 186     if(d1->day > d2->day) return 1;
 974  017f 1e01          	ldw	x,(OFST+1,sp)
 975  0181 e602          	ld	a,(2,x)
 976  0183 1e06          	ldw	x,(OFST+6,sp)
 977  0185 e102          	cp	a,(2,x)
 978  0187 2d04          	jrsle	L363
 981  0189               LC007:
 984  0189 a601          	ld	a,#1
 986  018b 20dc          	jra	L26
 987  018d               L363:
 988                     ; 187     if(d1->day < d2->day) return -1;
 990  018d 1e01          	ldw	x,(OFST+1,sp)
 991  018f e602          	ld	a,(2,x)
 992  0191 1e06          	ldw	x,(OFST+6,sp)
 993  0193 e102          	cp	a,(2,x)
 996  0195 2fd0          	jrslt	LC006
 997                     ; 188     return 0;
 999  0197 4f            	clr	a
1001  0198 20cf          	jra	L26
1058                     ; 201 int8_t t_datetime_compare(datetime_t * dt1, datetime_t * dt2)
1058                     ; 202 {
1059                     	switch	.text
1060  019a               f_t_datetime_compare:
1062  019a 89            	pushw	x
1063  019b 88            	push	a
1064       00000001      OFST:	set	1
1067                     ; 203     int8_t result = t_date_compare(&dt1->date, &dt2->date);
1069  019c 1e07          	ldw	x,(OFST+6,sp)
1070  019e 89            	pushw	x
1071  019f 1e04          	ldw	x,(OFST+3,sp)
1072  01a1 8d580158      	callf	f_t_date_compare
1074  01a5 85            	popw	x
1075  01a6 6b01          	ld	(OFST+0,sp),a
1077                     ; 204     if(result != 0) return result;
1082  01a8 2610          	jrne	L27
1083                     ; 205     return t_time_compare(&dt1->time, &dt2->time);
1085  01aa 1e07          	ldw	x,(OFST+6,sp)
1086  01ac 1c0003        	addw	x,#3
1087  01af 89            	pushw	x
1088  01b0 1e04          	ldw	x,(OFST+3,sp)
1089  01b2 1c0003        	addw	x,#3
1090  01b5 8d160116      	callf	f_t_time_compare
1092  01b9 85            	popw	x
1094  01ba               L27:
1096  01ba 5b03          	addw	sp,#3
1097  01bc 87            	retf	
1099                     	switch	.data
1100  0000               L124_t:
1101  0000 00            	dc.b	0
1102  0001 03            	dc.b	3
1103  0002 02            	dc.b	2
1104  0003 05            	dc.b	5
1105  0004 00            	dc.b	0
1106  0005 03            	dc.b	3
1107  0006 05            	dc.b	5
1108  0007 01            	dc.b	1
1109  0008 04            	dc.b	4
1110  0009 06            	dc.b	6
1111  000a 02            	dc.b	2
1112  000b 04            	dc.b	4
1173                     ; 217 int8_t t_get_day_of_week(int8_t d, int8_t m, int8_t year) {
1174                     	switch	.text
1175  01bd               f_t_get_day_of_week:
1177  01bd 89            	pushw	x
1178  01be 520a          	subw	sp,#10
1179       0000000a      OFST:	set	10
1182                     ; 218     int16_t y = YEAR_BASE + year;
1184  01c0 7b10          	ld	a,(OFST+6,sp)
1185  01c2 5f            	clrw	x
1186  01c3 4d            	tnz	a
1187  01c4 2a01          	jrpl	L67
1188  01c6 53            	cplw	x
1189  01c7               L67:
1190  01c7 97            	ld	xl,a
1191  01c8 1c07d0        	addw	x,#2000
1193                     ; 223     if (m < 3) {
1195  01cb 7b0c          	ld	a,(OFST+2,sp)
1196  01cd a103          	cp	a,#3
1197  01cf 2e01          	jrsge	L154
1198                     ; 224         y -= 1;
1200  01d1 5a            	decw	x
1202  01d2               L154:
1203  01d2 1f09          	ldw	(OFST-1,sp),x
1204                     ; 228     return (y + y/4 - y/100 + y/400 + t[m-1] + d) % 7;
1206  01d4 5f            	clrw	x
1207  01d5 7b0b          	ld	a,(OFST+1,sp)
1208  01d7 4d            	tnz	a
1209  01d8 2a01          	jrpl	L001
1210  01da 53            	cplw	x
1211  01db               L001:
1212  01db 97            	ld	xl,a
1213  01dc 1f07          	ldw	(OFST-3,sp),x
1215  01de 90ae0190      	ldw	y,#400
1216  01e2 1e09          	ldw	x,(OFST-1,sp)
1217  01e4 8d000000      	callf	d_idiv
1219  01e8 1f05          	ldw	(OFST-5,sp),x
1221  01ea a664          	ld	a,#100
1222  01ec 1e09          	ldw	x,(OFST-1,sp)
1223  01ee 8d000000      	callf	d_sdivx
1225  01f2 1f03          	ldw	(OFST-7,sp),x
1227  01f4 a604          	ld	a,#4
1228  01f6 1e09          	ldw	x,(OFST-1,sp)
1229  01f8 8d000000      	callf	d_sdivx
1231  01fc 72fb09        	addw	x,(OFST-1,sp)
1232  01ff 72f003        	subw	x,(OFST-7,sp)
1233  0202 72fb05        	addw	x,(OFST-5,sp)
1234  0205 1f01          	ldw	(OFST-9,sp),x
1236  0207 5f            	clrw	x
1237  0208 7b0c          	ld	a,(OFST+2,sp)
1238  020a 4d            	tnz	a
1239  020b 2a01          	jrpl	L201
1240  020d 53            	cplw	x
1241  020e               L201:
1242  020e 97            	ld	xl,a
1243  020f 5a            	decw	x
1244  0210 d60000        	ld	a,(L124_t,x)
1245  0213 5f            	clrw	x
1246  0214 4d            	tnz	a
1247  0215 2a01          	jrpl	L401
1248  0217 53            	cplw	x
1249  0218               L401:
1250  0218 97            	ld	xl,a
1251  0219 72fb01        	addw	x,(OFST-9,sp)
1252  021c 72fb07        	addw	x,(OFST-3,sp)
1253  021f a607          	ld	a,#7
1254  0221 8d000000      	callf	d_smodx
1256  0225 9f            	ld	a,xl
1259  0226 5b0c          	addw	sp,#12
1260  0228 87            	retf	
1304                     .const:	section	.text
1305  0000               L011:
1306  0000 0000003c      	dc.l	60
1307  0004               L211:
1308  0004 00000e10      	dc.l	3600
1309                     ; 239 void t_convert_sec_to_time(uint32_t sec, time_t * t)
1309                     ; 240 {
1310                     	switch	.text
1311  0229               f_t_convert_sec_to_time:
1313       00000000      OFST:	set	0
1316                     ; 242     t->second = sec % 60;
1318  0229 96            	ldw	x,sp
1319  022a 8d630263      	callf	LC008
1320  022e 8d000000      	callf	d_lumd
1322  0232 1e08          	ldw	x,(OFST+8,sp)
1323  0234 b603          	ld	a,c_lreg+3
1324  0236 e702          	ld	(2,x),a
1325                     ; 243     t->minute = (sec / 60) % 60;
1327  0238 96            	ldw	x,sp
1328  0239 8d630263      	callf	LC008
1329  023d 8d000000      	callf	d_ludv
1331  0241 ae0000        	ldw	x,#L011
1332  0244 8d000000      	callf	d_lumd
1334  0248 1e08          	ldw	x,(OFST+8,sp)
1335  024a b603          	ld	a,c_lreg+3
1336  024c e701          	ld	(1,x),a
1337                     ; 244     t->hour = sec / 3600;
1339  024e 96            	ldw	x,sp
1340  024f 1c0004        	addw	x,#OFST+4
1341  0252 8d000000      	callf	d_ltor
1343  0256 ae0004        	ldw	x,#L211
1344  0259 8d000000      	callf	d_ludv
1346  025d 1e08          	ldw	x,(OFST+8,sp)
1347  025f b603          	ld	a,c_lreg+3
1348  0261 f7            	ld	(x),a
1349                     ; 245 }
1352  0262 87            	retf	
1353  0263               LC008:
1354  0263 1c0004        	addw	x,#OFST+4
1355  0266 8d000000      	callf	d_ltor
1357  026a ae0000        	ldw	x,#L011
1358  026d 87            	retf	
1370                     	xdef	f_t_convert_sec_to_time
1371                     	xdef	f_t_get_day_of_week
1372                     	xdef	f_t_datetime_compare
1373                     	xdef	f_t_time_compare
1374                     	xdef	f_t_date_compare
1375                     	xdef	f_t_datetime_inc
1376                     	xdef	f_t_date_inc
1377                     	xdef	f_t_date_add
1378                     	xdef	f_t_time_inc
1379                     	xdef	f_t_time_dec
1380                     	xdef	f_t_last_day_of_month
1381                     	xref.b	c_lreg
1382                     	xref.b	c_x
1401                     	xref	d_ludv
1402                     	xref	d_lumd
1403                     	xref	d_ltor
1404                     	xref	d_idiv
1405                     	xref	d_sdivx
1406                     	xref	d_sdivy
1407                     	xref	d_smodx
1408                     	end
