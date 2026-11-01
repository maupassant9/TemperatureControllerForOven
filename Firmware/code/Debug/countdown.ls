   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.13.3 - 22 May 2025
   3                     ; Generator (Limited) V4.6.6 - 07 Jan 2026
   4                     ; Optimizer V4.6.6 - 07 Jan 2026
 183                     ; 41 void rc_init(countdown_t * rgc, uint32_t delay, uint32_t period, uint32_t on_time_in_sec)
 183                     ; 42 {
 184                     	switch	.text
 185  0000               f_rc_init:
 187       fffffffe      OFST: set -2
 190                     ; 43     rgc->delay_in_sec = delay;
 192  0000 7b07          	ld	a,(OFST+9,sp)
 193  0002 e704          	ld	(4,x),a
 194  0004 7b06          	ld	a,(OFST+8,sp)
 195  0006 e703          	ld	(3,x),a
 196  0008 7b05          	ld	a,(OFST+7,sp)
 197  000a e702          	ld	(2,x),a
 198  000c 7b04          	ld	a,(OFST+6,sp)
 199  000e e701          	ld	(1,x),a
 200                     ; 44     rgc->period_in_sec = period;
 202  0010 7b0b          	ld	a,(OFST+13,sp)
 203  0012 e708          	ld	(8,x),a
 204  0014 7b0a          	ld	a,(OFST+12,sp)
 205  0016 e707          	ld	(7,x),a
 206  0018 7b09          	ld	a,(OFST+11,sp)
 207  001a e706          	ld	(6,x),a
 208  001c 7b08          	ld	a,(OFST+10,sp)
 209  001e e705          	ld	(5,x),a
 210                     ; 45     rgc->on_time_in_sec = on_time_in_sec;
 212  0020 7b0f          	ld	a,(OFST+17,sp)
 213  0022 e70c          	ld	(12,x),a
 214  0024 7b0e          	ld	a,(OFST+16,sp)
 215  0026 e70b          	ld	(11,x),a
 216  0028 7b0d          	ld	a,(OFST+15,sp)
 217  002a e70a          	ld	(10,x),a
 218  002c 7b0c          	ld	a,(OFST+14,sp)
 219  002e e709          	ld	(9,x),a
 220                     ; 46     rgc->cnter = 0;
 222  0030 4f            	clr	a
 223  0031 e710          	ld	(16,x),a
 224  0033 e70f          	ld	(15,x),a
 225  0035 e70e          	ld	(14,x),a
 226  0037 e70d          	ld	(13,x),a
 227                     ; 47     rgc->on_func = NULL;
 229  0039 6f11          	clr	(17,x)
 230  003b 905f          	clrw	y
 231  003d ef12          	ldw	(18,x),y
 232                     ; 48     rgc->off_func = NULL;
 234  003f 6f14          	clr	(20,x)
 235  0041 ef15          	ldw	(21,x),y
 236                     ; 49     rgc->mode = INITIAL;
 238  0043 7f            	clr	(x)
 239                     ; 50 }
 242  0044 87            	retf	
 289                     ; 61 void rc_attach_on_func(countdown_t * rgc, void (*func)(void))
 289                     ; 62 {
 290                     	switch	.text
 291  0045               f_rc_attach_on_func:
 293       fffffffe      OFST: set -2
 296                     ; 63     rgc->on_func = func;
 298  0045 7b04          	ld	a,(OFST+6,sp)
 299  0047 e711          	ld	(17,x),a
 300  0049 7b05          	ld	a,(OFST+7,sp)
 301  004b e712          	ld	(18,x),a
 302  004d 7b06          	ld	a,(OFST+8,sp)
 303  004f e713          	ld	(19,x),a
 304                     ; 64 }
 307  0051 87            	retf	
 354                     ; 74 void rc_attach_off_func(countdown_t * rgc, void (*func)(void))
 354                     ; 75 {
 355                     	switch	.text
 356  0052               f_rc_attach_off_func:
 358       fffffffe      OFST: set -2
 361                     ; 76     rgc->off_func = func;
 363  0052 7b04          	ld	a,(OFST+6,sp)
 364  0054 e714          	ld	(20,x),a
 365  0056 7b05          	ld	a,(OFST+7,sp)
 366  0058 e715          	ld	(21,x),a
 367  005a 7b06          	ld	a,(OFST+8,sp)
 368  005c e716          	ld	(22,x),a
 369                     ; 77 }
 372  005e 87            	retf	
 408                     ; 94 void rc_check(countdown_t * rgc)
 408                     ; 95 {
 409                     	switch	.text
 410  005f               f_rc_check:
 412  005f 89            	pushw	x
 413       00000000      OFST:	set	0
 416                     ; 96     switch(rgc->mode)
 418  0060 f6            	ld	a,(x)
 420                     ; 123         case STOP:
 420                     ; 124             break;
 421  0061 2708          	jreq	L351
 422  0063 4a            	dec	a
 423  0064 270e          	jreq	L551
 424  0066 4a            	dec	a
 425  0067 2749          	jreq	L751
 426  0069 2078          	jra	L502
 427  006b               L351:
 428                     ; 98         case INITIAL:
 428                     ; 99             if(rgc->cnter++ == rgc->delay_in_sec){
 430  006b 8de500e5      	callf	LC003
 432  006f 1e01          	ldw	x,(OFST+1,sp)
 433  0071 5c            	incw	x
 435                     ; 100                 rgc->mode = ARMED;
 436                     ; 101                 rgc->cnter = 0;
 437                     ; 102                 if(rgc->on_func != NULL) rgc->on_func();
 440  0072 2047          	jpf	LC002
 441  0074               L551:
 442                     ; 105         case ARMED:
 442                     ; 106             if(rgc->cnter++ == rgc->on_time_in_sec){
 444  0074 8de500e5      	callf	LC003
 446  0078 1e01          	ldw	x,(OFST+1,sp)
 447  007a 1c0009        	addw	x,#9
 448  007d 8d000000      	callf	d_lcmp
 450  0081 2660          	jrne	L502
 451                     ; 107                 if(rgc->period_in_sec != 0){
 453  0083 1e01          	ldw	x,(OFST+1,sp)
 454  0085 1c0005        	addw	x,#5
 455  0088 8d000000      	callf	d_lzmp
 457  008c 2706          	jreq	L512
 458                     ; 108                     rgc->mode = WAIT;
 460  008e 1e01          	ldw	x,(OFST+1,sp)
 461  0090 a602          	ld	a,#2
 463  0092 2004          	jra	L712
 464  0094               L512:
 465                     ; 110                     rgc->mode = STOP;
 467  0094 1e01          	ldw	x,(OFST+1,sp)
 468  0096 a603          	ld	a,#3
 469  0098               L712:
 470  0098 f7            	ld	(x),a
 471                     ; 112                 rgc->cnter = 0;
 473  0099 4f            	clr	a
 474  009a e710          	ld	(16,x),a
 475  009c e70f          	ld	(15,x),a
 476  009e e70e          	ld	(14,x),a
 477  00a0 e70d          	ld	(13,x),a
 478                     ; 113                 if(rgc->off_func != NULL) rgc->off_func();
 480  00a2 e616          	ld	a,(22,x)
 481  00a4 ea15          	or	a,(21,x)
 482  00a6 ea14          	or	a,(20,x)
 483  00a8 2739          	jreq	L502
 486  00aa e614          	ld	a,(20,x)
 487  00ac b700          	ld	c_x,a
 488  00ae ee15          	ldw	x,(21,x)
 490  00b0 202b          	jpf	LC001
 491  00b2               L751:
 492                     ; 116         case WAIT:
 492                     ; 117             if(rgc->cnter++ == rgc->period_in_sec){
 494  00b2 8de500e5      	callf	LC003
 496  00b6 1e01          	ldw	x,(OFST+1,sp)
 497  00b8 1c0005        	addw	x,#5
 499                     ; 118                 rgc->mode = ARMED;
 501                     ; 119                 rgc->cnter = 0;
 503                     ; 120                 if(rgc->on_func != NULL) rgc->on_func();
 507  00bb               LC002:
 508  00bb 8d000000      	callf	d_lcmp
 509  00bf 2622          	jrne	L502
 511  00c1 1e01          	ldw	x,(OFST+1,sp)
 512  00c3 a601          	ld	a,#1
 513  00c5 f7            	ld	(x),a
 515  00c6 4f            	clr	a
 516  00c7 e710          	ld	(16,x),a
 517  00c9 e70f          	ld	(15,x),a
 518  00cb e70e          	ld	(14,x),a
 519  00cd e70d          	ld	(13,x),a
 521  00cf e613          	ld	a,(19,x)
 522  00d1 ea12          	or	a,(18,x)
 523  00d3 ea11          	or	a,(17,x)
 524  00d5 270c          	jreq	L502
 526  00d7 e611          	ld	a,(17,x)
 527  00d9 b700          	ld	c_x,a
 528  00db ee12          	ldw	x,(18,x)
 529  00dd               LC001:
 530  00dd bf01          	ldw	c_x+1,x
 531  00df 928d0000      	callf	[c_x.e]
 533                     ; 123         case STOP:
 533                     ; 124             break;
 535  00e3               L502:
 536                     ; 126 }
 539  00e3 85            	popw	x
 540  00e4 87            	retf	
 541  00e5               LC003:
 542  00e5 89            	pushw	x
 543  00e6 1c000d        	addw	x,#13
 544  00e9 8d000000      	callf	d_ltor
 546  00ed 85            	popw	x
 547  00ee 1c000d        	addw	x,#13
 548  00f1 4c            	inc	a
 549  00f2 ac000000      	jpf	d_lgadc
 627                     ; 136 void rc_get_left_time(countdown_t * rgc, time_t * t)
 627                     ; 137 {
 628                     	switch	.text
 629  00f6               f_rc_get_left_time:
 631  00f6 89            	pushw	x
 632       00000000      OFST:	set	0
 635                     ; 138     switch(rgc->mode)
 637  00f7 f6            	ld	a,(x)
 639                     ; 143         case STOP: memset(t, 0, sizeof(time_t));return;
 640  00f8 270b          	jreq	L722
 641  00fa 4a            	dec	a
 642  00fb 2710          	jreq	L132
 643  00fd 4a            	dec	a
 644  00fe 2730          	jreq	L332
 645  0100 4a            	dec	a
 646  0101 2737          	jreq	L532
 647  0103 2029          	jra	L43
 648  0105               L722:
 649                     ; 140         case INITIAL: t_convert_sec_to_time(rgc->delay_in_sec - rgc->cnter,t); return;
 651  0105 1e06          	ldw	x,(OFST+6,sp)
 652  0107 89            	pushw	x
 653  0108 1e03          	ldw	x,(OFST+3,sp)
 654  010a 5c            	incw	x
 660  010b 2008          	jpf	LC004
 661  010d               L132:
 662                     ; 141         case ARMED: t_convert_sec_to_time(rgc->on_time_in_sec - rgc->cnter, t); return;
 664  010d 1e06          	ldw	x,(OFST+6,sp)
 665  010f 89            	pushw	x
 666  0110 1e03          	ldw	x,(OFST+3,sp)
 667  0112 1c0009        	addw	x,#9
 671  0115               LC004:
 672  0115 8d000000      	callf	d_ltor
 673  0119 1e03          	ldw	x,(OFST+3,sp)
 674  011b 1c000d        	addw	x,#13
 675  011e 8d000000      	callf	d_lsub
 676  0122 be02          	ldw	x,c_lreg+2
 677  0124 89            	pushw	x
 678  0125 be00          	ldw	x,c_lreg
 679  0127 89            	pushw	x
 680  0128 8d000000      	callf	f_t_convert_sec_to_time
 681  012c 5b06          	addw	sp,#6
 683  012e               L43:
 686  012e 85            	popw	x
 687  012f 87            	retf	
 688  0130               L332:
 689                     ; 142         case WAIT: t_convert_sec_to_time(rgc->period_in_sec - rgc->cnter, t); return;
 691  0130 1e06          	ldw	x,(OFST+6,sp)
 692  0132 89            	pushw	x
 693  0133 1e03          	ldw	x,(OFST+3,sp)
 694  0135 1c0005        	addw	x,#5
 700  0138 20db          	jpf	LC004
 701  013a               L532:
 702                     ; 143         case STOP: memset(t, 0, sizeof(time_t));return;
 704  013a ae0003        	ldw	x,#3
 705  013d 89            	pushw	x
 706  013e 4b00          	push	#0
 707  0140 1e09          	ldw	x,(OFST+9,sp)
 708  0142 8d000000      	callf	f_memset
 710  0146 5b03          	addw	sp,#3
 713  0148 20e4          	jra	L43
 714                     ; 145 }
 727                     	xdef	f_rc_get_left_time
 728                     	xdef	f_rc_check
 729                     	xdef	f_rc_attach_off_func
 730                     	xdef	f_rc_attach_on_func
 731                     	xdef	f_rc_init
 732                     	xref	f_t_convert_sec_to_time
 733                     	xref	f_memset
 734                     	xref.b	c_lreg
 735                     	xref.b	c_x
 754                     	xref	d_lsub
 755                     	xref	d_lzmp
 756                     	xref	d_lcmp
 757                     	xref	d_lgadc
 758                     	xref	d_ltor
 759                     	end
