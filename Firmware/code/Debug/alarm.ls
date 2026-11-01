   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.13.3 - 22 May 2025
   3                     ; Generator (Limited) V4.6.6 - 07 Jan 2026
   4                     ; Optimizer V4.6.6 - 07 Jan 2026
 242                     ; 46 static int8_t alarm_get_last_alarm_interval(alarm_t *al, datetime_t * dt)
 242                     ; 47 {
 243                     	switch	.text
 244  0000               L3f_alarm_get_last_alarm_interval:
 246  0000 89            	pushw	x
 247  0001 5204          	subw	sp,#4
 248       00000004      OFST:	set	4
 251                     ; 48     int8_t day = t_get_day_of_week(dt->date.day, dt->date.month, dt->date.year);
 253  0003 1e0a          	ldw	x,(OFST+6,sp)
 254  0005 f6            	ld	a,(x)
 255  0006 88            	push	a
 256  0007 e601          	ld	a,(1,x)
 257  0009 160b          	ldw	y,(OFST+7,sp)
 258  000b 97            	ld	xl,a
 259  000c 90e602        	ld	a,(2,y)
 260  000f 95            	ld	xh,a
 261  0010 8d000000      	callf	f_t_get_day_of_week
 263  0014 5b01          	addw	sp,#1
 264  0016 6b03          	ld	(OFST-1,sp),a
 266                     ; 50     for(i = 1; i <= 7; i++){
 268  0018 a601          	ld	a,#1
 269  001a 6b04          	ld	(OFST+0,sp),a
 271  001c               L731:
 272                     ; 51         day = (++day) % 7;
 274  001c 0c03          	inc	(OFST-1,sp)
 276  001e 90ae0007      	ldw	y,#7
 277  0022 7b03          	ld	a,(OFST-1,sp)
 278  0024 5f            	clrw	x
 279  0025 4d            	tnz	a
 280  0026 2a01          	jrpl	L01
 281  0028 5a            	decw	x
 282  0029               L01:
 283  0029 02            	rlwa	x,a
 284  002a 8d000000      	callf	d_idiv
 286  002e 909f          	ld	a,yl
 287  0030 6b03          	ld	(OFST-1,sp),a
 289                     ; 52         if((al->repeate_pattern & (1 << day)) != 0) return i;
 291  0032 1e05          	ldw	x,(OFST+1,sp)
 292  0034 e607          	ld	a,(7,x)
 293  0036 5f            	clrw	x
 294  0037 97            	ld	xl,a
 295  0038 1f01          	ldw	(OFST-3,sp),x
 297  003a ae0001        	ldw	x,#1
 298  003d 7b03          	ld	a,(OFST-1,sp)
 299  003f 2704          	jreq	L21
 300  0041               L41:
 301  0041 58            	sllw	x
 302  0042 4a            	dec	a
 303  0043 26fc          	jrne	L41
 304  0045               L21:
 305  0045 01            	rrwa	x,a
 306  0046 1402          	and	a,(OFST-2,sp)
 307  0048 01            	rrwa	x,a
 308  0049 1401          	and	a,(OFST-3,sp)
 309  004b 01            	rrwa	x,a
 310  004c 5d            	tnzw	x
 311  004d 2704          	jreq	L541
 314  004f 7b04          	ld	a,(OFST+0,sp)
 316  0051 200a          	jra	L61
 317  0053               L541:
 318                     ; 50     for(i = 1; i <= 7; i++){
 320  0053 0c04          	inc	(OFST+0,sp)
 324  0055 7b04          	ld	a,(OFST+0,sp)
 325  0057 a108          	cp	a,#8
 326  0059 25c1          	jrult	L731
 327                     ; 54     return -1;
 329  005b a6ff          	ld	a,#255
 331  005d               L61:
 333  005d 5b06          	addw	sp,#6
 334  005f 87            	retf	
 397                     ; 69 void alarm_init(alarm_t * al, datetime_t *dt, uint8_t pattern, uint32_t t)
 397                     ; 70 {
 398                     	switch	.text
 399  0060               f_alarm_init:
 401  0060 89            	pushw	x
 402       00000000      OFST:	set	0
 405                     ; 71     memcpy(&al->alarm_datetime, dt, sizeof(datetime_t));
 407  0061 ae0006        	ldw	x,#6
 408  0064 89            	pushw	x
 409  0065 1e08          	ldw	x,(OFST+8,sp)
 410  0067 89            	pushw	x
 411  0068 1e05          	ldw	x,(OFST+5,sp)
 412  006a 5c            	incw	x
 413  006b 8d000000      	callf	f_memcpy
 415  006f 5b04          	addw	sp,#4
 416                     ; 72     al->repeate_pattern = pattern;
 418  0071 1e01          	ldw	x,(OFST+1,sp)
 419  0073 7b08          	ld	a,(OFST+8,sp)
 420  0075 e707          	ld	(7,x),a
 421                     ; 73     al->on_time_in_sec = t;
 423  0077 7b0c          	ld	a,(OFST+12,sp)
 424  0079 e70b          	ld	(11,x),a
 425  007b 7b0b          	ld	a,(OFST+11,sp)
 426  007d e70a          	ld	(10,x),a
 427  007f 7b0a          	ld	a,(OFST+10,sp)
 428  0081 e709          	ld	(9,x),a
 429  0083 7b09          	ld	a,(OFST+9,sp)
 430  0085 e708          	ld	(8,x),a
 431                     ; 74     al->on_time_cnter = 0;
 433  0087 4f            	clr	a
 434  0088 e70f          	ld	(15,x),a
 435  008a e70e          	ld	(14,x),a
 436  008c e70d          	ld	(13,x),a
 437  008e e70c          	ld	(12,x),a
 438                     ; 75     al->on_func = NULL;
 440  0090 6f10          	clr	(16,x)
 441  0092 905f          	clrw	y
 442  0094 ef11          	ldw	(17,x),y
 443                     ; 76     al->off_func = NULL;
 445  0096 6f13          	clr	(19,x)
 446  0098 ef14          	ldw	(20,x),y
 447                     ; 77     al->mark = false;
 449  009a f6            	ld	a,(x)
 450  009b a4fe          	and	a,#254
 451  009d f7            	ld	(x),a
 452                     ; 78 }
 455  009e 85            	popw	x
 456  009f 87            	retf	
 504                     ; 88 void alarm_attach_on_func(alarm_t * al, void (*func)(void))
 504                     ; 89 {
 505                     	switch	.text
 506  00a0               f_alarm_attach_on_func:
 508       fffffffe      OFST: set -2
 511                     ; 90     al->on_func = func;
 513  00a0 7b04          	ld	a,(OFST+6,sp)
 514  00a2 e710          	ld	(16,x),a
 515  00a4 7b05          	ld	a,(OFST+7,sp)
 516  00a6 e711          	ld	(17,x),a
 517  00a8 7b06          	ld	a,(OFST+8,sp)
 518  00aa e712          	ld	(18,x),a
 519                     ; 91 }
 522  00ac 87            	retf	
 570                     ; 101 void alarm_attach_off_func(alarm_t * al, void (*func)(void))
 570                     ; 102 {
 571                     	switch	.text
 572  00ad               f_alarm_attach_off_func:
 574       fffffffe      OFST: set -2
 577                     ; 103     al->off_func = func;
 579  00ad 7b04          	ld	a,(OFST+6,sp)
 580  00af e713          	ld	(19,x),a
 581  00b1 7b05          	ld	a,(OFST+7,sp)
 582  00b3 e714          	ld	(20,x),a
 583  00b5 7b06          	ld	a,(OFST+8,sp)
 584  00b7 e715          	ld	(21,x),a
 585                     ; 104 }
 588  00b9 87            	retf	
 638                     ; 119 void alarm_check(alarm_t *al, datetime_t * dt)
 638                     ; 120 {
 639                     	switch	.text
 640  00ba               f_alarm_check:
 642  00ba 89            	pushw	x
 643       00000000      OFST:	set	0
 646                     ; 122     if(al->mark){
 648  00bb f6            	ld	a,(x)
 649  00bc a501          	bcp	a,#1
 650  00be 2739          	jreq	L772
 651                     ; 124         if(al->on_time_cnter++ == al->on_time_in_sec){
 653  00c0 89            	pushw	x
 654  00c1 1c000c        	addw	x,#12
 655  00c4 8d000000      	callf	d_ltor
 657  00c8 85            	popw	x
 658  00c9 1c000c        	addw	x,#12
 659  00cc a601          	ld	a,#1
 660  00ce 8d000000      	callf	d_lgadc
 662  00d2 1e01          	ldw	x,(OFST+1,sp)
 663  00d4 1c0008        	addw	x,#8
 664  00d7 8d000000      	callf	d_lcmp
 666  00db 2658          	jrne	L503
 667                     ; 125             al->mark = false;
 669  00dd 1e01          	ldw	x,(OFST+1,sp)
 670  00df f6            	ld	a,(x)
 671  00e0 a4fe          	and	a,#254
 672  00e2 f7            	ld	(x),a
 673                     ; 126             if(al->off_func != NULL) al->off_func();
 675  00e3 e615          	ld	a,(21,x)
 676  00e5 ea14          	or	a,(20,x)
 677  00e7 ea13          	or	a,(19,x)
 678  00e9 274a          	jreq	L503
 681  00eb e613          	ld	a,(19,x)
 682  00ed b700          	ld	c_x,a
 683  00ef ee14          	ldw	x,(20,x)
 684  00f1 bf01          	ldw	c_x+1,x
 685  00f3 928d0000      	callf	[c_x.e]
 687  00f7 203c          	jra	L503
 688  00f9               L772:
 689                     ; 130         if(t_datetime_compare(dt, &al->alarm_datetime) > 0){
 691  00f9 5c            	incw	x
 692  00fa 89            	pushw	x
 693  00fb 1e08          	ldw	x,(OFST+8,sp)
 694  00fd 8d000000      	callf	f_t_datetime_compare
 696  0101 9c            	rvf	
 697  0102 4d            	tnz	a
 698  0103 85            	popw	x
 699  0104 2d2f          	jrsle	L503
 700                     ; 131             alarm_update_alarm_datetime(al, dt);
 702  0106 1e06          	ldw	x,(OFST+6,sp)
 703  0108 89            	pushw	x
 704  0109 1e03          	ldw	x,(OFST+3,sp)
 705  010b 8d370137      	callf	f_alarm_update_alarm_datetime
 707  010f 85            	popw	x
 708                     ; 132             al->mark = true;
 710  0110 1e01          	ldw	x,(OFST+1,sp)
 711  0112 f6            	ld	a,(x)
 712  0113 aa01          	or	a,#1
 713  0115 f7            	ld	(x),a
 714                     ; 134             if(al->on_func != NULL) al->on_func();
 716  0116 e612          	ld	a,(18,x)
 717  0118 ea11          	or	a,(17,x)
 718  011a ea10          	or	a,(16,x)
 719  011c 270c          	jreq	L113
 722  011e e610          	ld	a,(16,x)
 723  0120 b700          	ld	c_x,a
 724  0122 ee11          	ldw	x,(17,x)
 725  0124 bf01          	ldw	c_x+1,x
 726  0126 928d0000      	callf	[c_x.e]
 728  012a               L113:
 729                     ; 135             al->on_time_cnter = 0;
 731  012a 1e01          	ldw	x,(OFST+1,sp)
 732  012c 4f            	clr	a
 733  012d e70f          	ld	(15,x),a
 734  012f e70e          	ld	(14,x),a
 735  0131 e70d          	ld	(13,x),a
 736  0133 e70c          	ld	(12,x),a
 737  0135               L503:
 738                     ; 138 }
 741  0135 85            	popw	x
 742  0136 87            	retf	
 744                     .const:	section	.text
 745  0000               L313_maxdt:
 746  0000 63            	dc.b	99
 747  0001 0c            	dc.b	12
 748  0002 1f            	dc.b	31
 749  0003 17            	dc.b	23
 750  0004 3b            	dc.b	59
 751  0005 3b            	dc.b	59
 819                     ; 150 void alarm_update_alarm_datetime(alarm_t * al, datetime_t * dt)
 819                     ; 151 {
 820                     	switch	.text
 821  0137               f_alarm_update_alarm_datetime:
 823  0137 89            	pushw	x
 824  0138 5207          	subw	sp,#7
 825       00000007      OFST:	set	7
 828                     ; 152     int8_t interval = 0;
 830                     ; 153     datetime_t maxdt = {{99,12,31},{23,59,59}};
 832  013a 96            	ldw	x,sp
 833  013b 5c            	incw	x
 834  013c 90ae0000      	ldw	y,#L313_maxdt
 835  0140 a606          	ld	a,#6
 836  0142 8d000000      	callf	d_xymov
 838                     ; 155     if((al->repeate_pattern&0x7f) == 0) {
 840  0146 1e08          	ldw	x,(OFST+1,sp)
 841  0148 e607          	ld	a,(7,x)
 842  014a a57f          	bcp	a,#127
 843  014c 2614          	jrne	L153
 844                     ; 157         memcpy(&al->alarm_datetime, &maxdt, sizeof(datetime_t));
 846  014e ae0006        	ldw	x,#6
 847  0151 89            	pushw	x
 848  0152 96            	ldw	x,sp
 849  0153 1c0003        	addw	x,#OFST-4
 850  0156 89            	pushw	x
 851  0157 1e0c          	ldw	x,(OFST+5,sp)
 852  0159 5c            	incw	x
 853  015a 8d000000      	callf	f_memcpy
 855  015e 5b04          	addw	sp,#4
 856                     ; 158         return;
 858  0160 2017          	jra	L353
 859  0162               L153:
 860                     ; 161     if((interval = alarm_get_last_alarm_interval(al, dt)) >= 0){
 862  0162 1e0d          	ldw	x,(OFST+6,sp)
 863  0164 89            	pushw	x
 864  0165 1e0a          	ldw	x,(OFST+3,sp)
 865  0167 8d000000      	callf	L3f_alarm_get_last_alarm_interval
 867  016b 85            	popw	x
 868  016c 6b07          	ld	(OFST+0,sp),a
 870  016e 2b09          	jrmi	L353
 871                     ; 162         t_date_add(&al->alarm_datetime.date, interval);
 873  0170 88            	push	a
 874  0171 1e09          	ldw	x,(OFST+2,sp)
 875  0173 5c            	incw	x
 876  0174 8d000000      	callf	f_t_date_add
 878  0178 84            	pop	a
 879  0179               L353:
 880                     ; 165 }
 883  0179 5b09          	addw	sp,#9
 884  017b 87            	retf	
 896                     	xref	f_memcpy
 897                     	xdef	f_alarm_update_alarm_datetime
 898                     	xdef	f_alarm_attach_off_func
 899                     	xdef	f_alarm_attach_on_func
 900                     	xdef	f_alarm_check
 901                     	xdef	f_alarm_init
 902                     	xref	f_t_get_day_of_week
 903                     	xref	f_t_datetime_compare
 904                     	xref	f_t_date_add
 905                     	xref.b	c_x
 924                     	xref	d_xymov
 925                     	xref	d_lcmp
 926                     	xref	d_lgadc
 927                     	xref	d_ltor
 928                     	xref	d_idiv
 929                     	end
