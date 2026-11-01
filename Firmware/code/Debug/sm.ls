   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.13.3 - 22 May 2025
   3                     ; Generator (Limited) V4.6.6 - 07 Jan 2026
   4                     ; Optimizer V4.6.6 - 07 Jan 2026
  19                     .const:	section	.text
  20  0000               L3_datetime_unit_map:
  21  0000 11            	dc.b	17
  22  0001 0f            	dc.b	15
  23  0002 13            	dc.b	19
  24  0003 0d            	dc.b	13
  25  0004 14            	dc.b	20
  26  0005 15            	dc.b	21
  27  0006               L5_dt:
  28  0006 1a            	dc.b	26
  29  0007 0b            	dc.b	11
  30  0008 0a            	dc.b	10
  31  0009 07            	dc.b	7
  32  000a 1e            	dc.b	30
  33  000b 00            	dc.b	0
  62                     ; 70 static void tim4Init( void )
  62                     ; 71 {	
  63                     	switch	.text
  64  0000               L14f_tim4Init:
  68                     ; 72     TIM4->CR1 = (TIM4_CR1_ARPE|TIM4_CR1_URS);
  70  0000 35845340      	mov	21312,#132
  71                     ; 76     TIM4->PSCR = TIM4_PRESCALER_128;
  73  0004 35075347      	mov	21319,#7
  74                     ; 77     TIM4->ARR = 125;
  76  0008 357d5348      	mov	21320,#125
  77                     ; 78     TIM4->EGR |= TIM4_EGR_UG;
  79  000c 72105345      	bset	21317,#0
  80                     ; 79     TIM4->CR1 |= TIM4_CR1_CEN;
  82  0010 72105340      	bset	21312,#0
  83                     ; 80 }
  86  0014 87            	retf	
 110                     ; 82 @far @svlreg @interrupt void TimerHandler1( void )
 110                     ; 83 {
 111                     	switch	.text
 112  0015               f_TimerHandler1:
 114  0015 8a            	push	cc
 115  0016 84            	pop	a
 116  0017 a4bf          	and	a,#191
 117  0019 88            	push	a
 118  001a 86            	pop	cc
 119  001b 3b0002        	push	c_x+2
 120  001e be00          	ldw	x,c_x
 121  0020 89            	pushw	x
 122  0021 3b0002        	push	c_y+2
 123  0024 be00          	ldw	x,c_y
 124  0026 89            	pushw	x
 125  0027 be02          	ldw	x,c_lreg+2
 126  0029 89            	pushw	x
 127  002a be00          	ldw	x,c_lreg
 128  002c 89            	pushw	x
 131                     ; 84     tl_update(&cfg.tl);
 133  002d ae0097        	ldw	x,#_cfg+151
 134  0030 8d000000      	callf	f_tl_update
 136                     ; 85 }
 139  0034 85            	popw	x
 140  0035 bf00          	ldw	c_lreg,x
 141  0037 85            	popw	x
 142  0038 bf02          	ldw	c_lreg+2,x
 143  003a 85            	popw	x
 144  003b bf00          	ldw	c_y,x
 145  003d 320002        	pop	c_y+2
 146  0040 85            	popw	x
 147  0041 bf00          	ldw	c_x,x
 148  0043 320002        	pop	c_x+2
 149  0046 80            	iret	
 151                     	switch	.const
 152  000c               L17_msg:
 153  000c 0001          	dc.w	1
 154  000e 02            	dc.b	2
 329                     ; 87 static enum state_t sm_init()
 329                     ; 88 {
 330                     	switch	.text
 331  0047               L72f_sm_init:
 333  0047 5203          	subw	sp,#3
 334       00000003      OFST:	set	3
 337                     ; 89     but_msg_t msg = {1, BUTTON_LNG_PRESSED};
 339  0049 96            	ldw	x,sp
 340  004a 5c            	incw	x
 341  004b 90ae000c      	ldw	y,#L17_msg
 342  004f a603          	ld	a,#3
 343  0051 8d000000      	callf	d_xymov
 345                     ; 90     Drv7SegInit(&cfg.disp);
 347  0055 ae0034        	ldw	x,#_cfg+52
 348  0058 8d000000      	callf	f_Drv7SegInit
 350                     ; 91     Drv7SegClear(&cfg.disp, 0);
 352  005c 4b00          	push	#0
 353  005e ae0034        	ldw	x,#_cfg+52
 354  0061 8d000000      	callf	f_Drv7SegClear
 356  0065 84            	pop	a
 357                     ; 92     Drv7SegClear(&cfg.disp, 1);
 359  0066 4b01          	push	#1
 360  0068 ae0034        	ldw	x,#_cfg+52
 361  006b 8d000000      	callf	f_Drv7SegClear
 363  006f 84            	pop	a
 364                     ; 93     Drv7SegClear(&cfg.disp, 2);
 366  0070 4b02          	push	#2
 367  0072 ae0034        	ldw	x,#_cfg+52
 368  0075 8d000000      	callf	f_Drv7SegClear
 370  0079 84            	pop	a
 371                     ; 94     Drv7SegClear(&cfg.disp, 3);
 373  007a 4b03          	push	#3
 374  007c ae0034        	ldw	x,#_cfg+52
 375  007f 8d000000      	callf	f_Drv7SegClear
 377  0083 ae0057        	ldw	x,#_cfg+87
 378  0086 84            	pop	a
 379                     ; 95     tl_init(&cfg.tl, 10, &cfg.tl_task[0]);
 381  0087 89            	pushw	x
 382  0088 4b0a          	push	#10
 383  008a ae0097        	ldw	x,#_cfg+151
 384  008d 8d000000      	callf	f_tl_init
 386  0091 5b03          	addw	sp,#3
 387                     ; 96     tl_add(&cfg.tl, sev_seg_update, 1, 1, TL_READY, (void *)0);
 389  0093 5f            	clrw	x
 390  0094 89            	pushw	x
 391  0095 4b00          	push	#0
 392  0097 5c            	incw	x
 393  0098 89            	pushw	x
 394  0099 5f            	clrw	x
 395  009a 89            	pushw	x
 396  009b 5c            	incw	x
 397  009c 89            	pushw	x
 398  009d 5f            	clrw	x
 399  009e 89            	pushw	x
 400  009f ae0358        	ldw	x,#L71f_sev_seg_update
 401  00a2 89            	pushw	x
 402  00a3 4b58          	push	#page(L71f_sev_seg_update)
 403  00a5 ae0097        	ldw	x,#_cfg+151
 404  00a8 8d000000      	callf	f_tl_add
 406  00ac 5b0e          	addw	sp,#14
 407                     ; 97     cfg.tltask_7seg_show = tl_add(&cfg.tl, seven_seg_show, 1, 1000, TL_READY, &cfg.dtshow);
 409  00ae ae00a0        	ldw	x,#_cfg+160
 410  00b1 89            	pushw	x
 411  00b2 4b00          	push	#0
 412  00b4 ae03e8        	ldw	x,#1000
 413  00b7 89            	pushw	x
 414  00b8 5f            	clrw	x
 415  00b9 89            	pushw	x
 416  00ba 5c            	incw	x
 417  00bb 89            	pushw	x
 418  00bc 5f            	clrw	x
 419  00bd 89            	pushw	x
 420  00be ae03dd        	ldw	x,#L32f_seven_seg_show
 421  00c1 89            	pushw	x
 422  00c2 4bdd          	push	#page(L32f_seven_seg_show)
 423  00c4 ae0097        	ldw	x,#_cfg+151
 424  00c7 8d000000      	callf	f_tl_add
 426  00cb 5b0e          	addw	sp,#14
 427  00cd bf53          	ldw	_cfg+83,x
 428                     ; 102     RELAY_PORT->ODR &= ~RELAY_PIN;
 430  00cf 7217500a      	bres	20490,#3
 431                     ; 103     RELAY_PORT->DDR &= ~RELAY_PIN;
 433  00d3 7217500c      	bres	20492,#3
 434                     ; 104     RELAY_PORT->CR1 |= RELAY_PIN;
 436  00d7 7216500d      	bset	20493,#3
 437                     ; 105     RELAY_PORT->CR2 |= RELAY_PIN;
 439  00db 7216500e      	bset	20494,#3
 440                     ; 107     BUTTON_PORT->ODR |= BUTTON_PIN;
 442  00df 7218500a      	bset	20490,#4
 443                     ; 115     alarm_init(&cfg.alarm, &dt, 0, 10*60);
 445  00e3 ae0258        	ldw	x,#600
 446  00e6 89            	pushw	x
 447  00e7 5f            	clrw	x
 448  00e8 89            	pushw	x
 449  00e9 4b00          	push	#0
 450  00eb ae0006        	ldw	x,#L5_dt
 451  00ee 89            	pushw	x
 452  00ef ae0007        	ldw	x,#_cfg+7
 453  00f2 8d000000      	callf	f_alarm_init
 455  00f6 5b07          	addw	sp,#7
 456                     ; 116     alarm_attach_on_func(&cfg.alarm, led_on);
 458  00f8 ae0336        	ldw	x,#L7f_led_on
 459  00fb 89            	pushw	x
 460  00fc 4b36          	push	#page(L7f_led_on)
 461  00fe ae0007        	ldw	x,#_cfg+7
 462  0101 8d000000      	callf	f_alarm_attach_on_func
 464  0105 5b03          	addw	sp,#3
 465                     ; 117     alarm_attach_off_func(&cfg.alarm, led_off);
 467  0107 ae033b        	ldw	x,#L11f_led_off
 468  010a 89            	pushw	x
 469  010b 4b3b          	push	#page(L11f_led_off)
 470  010d ae0007        	ldw	x,#_cfg+7
 471  0110 8d000000      	callf	f_alarm_attach_off_func
 473  0114 5b03          	addw	sp,#3
 474                     ; 118     cfg.tltask_alarm_chk = tl_add_singleton(&cfg.tl, check_up, 1, 1000, TL_PAUSED, (void *)0);
 476  0116 5f            	clrw	x
 477  0117 89            	pushw	x
 478  0118 4b01          	push	#1
 479  011a ae03e8        	ldw	x,#1000
 480  011d 89            	pushw	x
 481  011e 5f            	clrw	x
 482  011f 89            	pushw	x
 483  0120 5c            	incw	x
 484  0121 89            	pushw	x
 485  0122 5f            	clrw	x
 486  0123 89            	pushw	x
 487  0124 ae04a3        	ldw	x,#L52f_check_up
 488  0127 89            	pushw	x
 489  0128 4ba3          	push	#page(L52f_check_up)
 490  012a ae0097        	ldw	x,#_cfg+151
 491  012d 8d000000      	callf	f_tl_add_singleton
 493  0131 5b0e          	addw	sp,#14
 494  0133 bf55          	ldw	_cfg+85,x
 495                     ; 120     rc_init(&cfg.rc, 0, 0, 10*60);
 497  0135 ae0258        	ldw	x,#600
 498  0138 89            	pushw	x
 499  0139 5f            	clrw	x
 500  013a 89            	pushw	x
 501  013b 89            	pushw	x
 502  013c 89            	pushw	x
 503  013d 89            	pushw	x
 504  013e 89            	pushw	x
 505  013f ae001d        	ldw	x,#_cfg+29
 506  0142 8d000000      	callf	f_rc_init
 508  0146 5b0c          	addw	sp,#12
 509                     ; 121     rc_attach_on_func(&cfg.rc, led_on);
 511  0148 ae0336        	ldw	x,#L7f_led_on
 512  014b 89            	pushw	x
 513  014c 4b36          	push	#page(L7f_led_on)
 514  014e ae001d        	ldw	x,#_cfg+29
 515  0151 8d000000      	callf	f_rc_attach_on_func
 517  0155 5b03          	addw	sp,#3
 518                     ; 122     rc_attach_off_func(&cfg.rc, led_off);
 520  0157 ae033b        	ldw	x,#L11f_led_off
 521  015a 89            	pushw	x
 522  015b 4b3b          	push	#page(L11f_led_off)
 523  015d ae001d        	ldw	x,#_cfg+29
 524  0160 8d000000      	callf	f_rc_attach_off_func
 526  0164 5b03          	addw	sp,#3
 527                     ; 125     bt_init(&cfg.but, 1, get_but);
 529  0166 ae0340        	ldw	x,#L31f_get_but
 530  0169 89            	pushw	x
 531  016a 4b40          	push	#page(L31f_get_but)
 532  016c ae0001        	ldw	x,#1
 533  016f 89            	pushw	x
 534  0170 ae0039        	ldw	x,#_cfg+57
 535  0173 8d000000      	callf	f_bt_init
 537  0177 5b05          	addw	sp,#5
 538                     ; 126     cirbuf_init(&cfg.cbuf, 2, sizeof(but_msg_t), (cb_ele_t)&cfg.but_msgs[0], false);
 540  0179 4b00          	push	#0
 541  017b ae004d        	ldw	x,#_cfg+77
 542  017e 89            	pushw	x
 543  017f ae0003        	ldw	x,#3
 544  0182 89            	pushw	x
 545  0183 5a            	decw	x
 546  0184 89            	pushw	x
 547  0185 ae0042        	ldw	x,#_cfg+66
 548  0188 8d000000      	callf	f_cirbuf_init
 550  018c 5b07          	addw	sp,#7
 551                     ; 127     tl_add(&cfg.tl, but_check, 1, 20, TL_READY, (void *)0);
 553  018e 5f            	clrw	x
 554  018f 89            	pushw	x
 555  0190 4b00          	push	#0
 556  0192 ae0014        	ldw	x,#20
 557  0195 89            	pushw	x
 558  0196 5f            	clrw	x
 559  0197 89            	pushw	x
 560  0198 5c            	incw	x
 561  0199 89            	pushw	x
 562  019a 5f            	clrw	x
 563  019b 89            	pushw	x
 564  019c ae034b        	ldw	x,#L51f_but_check
 565  019f 89            	pushw	x
 566  01a0 4b4b          	push	#page(L51f_but_check)
 567  01a2 ae0097        	ldw	x,#_cfg+151
 568  01a5 8d000000      	callf	f_tl_add
 570  01a9 5b0e          	addw	sp,#14
 571                     ; 131     menu_init();
 573  01ab 8d000000      	callf	f_menu_init
 575                     ; 132     menu_show(msg);
 577  01af 7b03          	ld	a,(OFST+0,sp)
 578  01b1 88            	push	a
 579  01b2 7b03          	ld	a,(OFST+0,sp)
 580  01b4 88            	push	a
 581  01b5 7b03          	ld	a,(OFST+0,sp)
 582  01b7 88            	push	a
 583  01b8 8d000000      	callf	f_menu_show
 585  01bc 5b03          	addw	sp,#3
 586                     ; 133     tim4Init();
 588  01be 8d000000      	callf	L14f_tim4Init
 590                     ; 134     return ST_CONFIG;
 592  01c2 a601          	ld	a,#1
 595  01c4 5b03          	addw	sp,#3
 596  01c6 87            	retf	
 598                     	switch	.data
 599  0000               L751_finished:
 600  0000 00            	dc.b	0
 601                     	switch	.const
 602  000f               L161_msg:
 603  000f 0000          	dc.w	0
 604  0011 00            	dc.b	0
 649                     ; 138 static enum state_t sm_config()
 649                     ; 139 {
 650                     	switch	.text
 651  01c7               L13f_sm_config:
 653  01c7 5203          	subw	sp,#3
 654       00000003      OFST:	set	3
 657                     ; 141     but_msg_t msg = {0,0};
 659  01c9 96            	ldw	x,sp
 660  01ca 5c            	incw	x
 661  01cb 90ae000f      	ldw	y,#L161_msg
 662  01cf a603          	ld	a,#3
 663  01d1 8d000000      	callf	d_xymov
 665                     ; 142     tl_pause(&cfg.tl, cfg.tltask_7seg_show);
 667  01d5 be53          	ldw	x,_cfg+83
 668  01d7 89            	pushw	x
 669  01d8 ae0097        	ldw	x,#_cfg+151
 670  01db 8d000000      	callf	f_tl_pause
 672  01df 85            	popw	x
 673                     ; 143     tl_pause(&cfg.tl, cfg.tltask_alarm_chk);
 675  01e0 be55          	ldw	x,_cfg+85
 676  01e2 89            	pushw	x
 677  01e3 ae0097        	ldw	x,#_cfg+151
 678  01e6 8d000000      	callf	f_tl_pause
 680  01ea 85            	popw	x
 681                     ; 146     if(cirbuf_get(&cfg.cbuf, (cb_ele_t)&msg) == 0)
 683  01eb 96            	ldw	x,sp
 684  01ec 5c            	incw	x
 685  01ed 89            	pushw	x
 686  01ee ae0042        	ldw	x,#_cfg+66
 687  01f1 8d000000      	callf	f_cirbuf_get
 689  01f5 4d            	tnz	a
 690  01f6 85            	popw	x
 691  01f7 2612          	jrne	L302
 692                     ; 148       finished = menu_show(msg);
 694  01f9 7b03          	ld	a,(OFST+0,sp)
 695  01fb 88            	push	a
 696  01fc 7b03          	ld	a,(OFST+0,sp)
 697  01fe 88            	push	a
 698  01ff 7b03          	ld	a,(OFST+0,sp)
 699  0201 88            	push	a
 700  0202 8d000000      	callf	f_menu_show
 702  0206 5b03          	addw	sp,#3
 703  0208 c70000        	ld	L751_finished,a
 704  020b               L302:
 705                     ; 151     if(finished) {
 707  020b c60000        	ld	a,L751_finished
 708  020e 2708          	jreq	L502
 709                     ; 152       finished = false;
 711  0210 725f0000      	clr	L751_finished
 712                     ; 156       return ST_WAITING;
 714  0214 a603          	ld	a,#3
 716  0216 2001          	jra	L001
 717  0218               L502:
 718                     ; 158       return ST_CONFIG;
 720  0218 4c            	inc	a
 722  0219               L001:
 724  0219 5b03          	addw	sp,#3
 725  021b 87            	retf	
 727                     	switch	.data
 728  0001               L112_firsttime:
 729  0001 01            	dc.b	1
 776                     ; 163 static enum state_t sm_waiting()
 776                     ; 164 {
 777                     	switch	.text
 778  021c               L33f_sm_waiting:
 780  021c 5203          	subw	sp,#3
 781       00000003      OFST:	set	3
 784                     ; 167     cfg.dtshow.blink = false;
 786  021e 3fa3          	clr	_cfg+163
 787                     ; 169     if(firsttime)
 789  0220 c60001        	ld	a,L112_firsttime
 790  0223 2743          	jreq	L332
 791                     ; 171         tl_resume(&cfg.tl, cfg.tltask_7seg_show);
 793  0225 be53          	ldw	x,_cfg+83
 794  0227 89            	pushw	x
 795  0228 ae0097        	ldw	x,#_cfg+151
 796  022b 8d000000      	callf	f_tl_resume
 798  022f 85            	popw	x
 799                     ; 172         tl_resume(&cfg.tl, cfg.tltask_alarm_chk);
 801  0230 be55          	ldw	x,_cfg+85
 802  0232 89            	pushw	x
 803  0233 ae0097        	ldw	x,#_cfg+151
 804  0236 8d000000      	callf	f_tl_resume
 806  023a b600          	ld	a,_cfg
 807  023c 85            	popw	x
 808                     ; 173         if(cfg.mode == ALARM_MODE)
 810  023d 260d          	jrne	L532
 811                     ; 175             cfg.dtshow.whichpart = 1;
 813  023f 350100a2      	mov	_cfg+162,#1
 814                     ; 176             cfg.dtshow.pdt = &cfg.alarm.alarm_datetime;
 816  0243 ae0008        	ldw	x,#_cfg+8
 817  0246 bfa0          	ldw	_cfg+160,x
 818                     ; 177             cfg.dtshow.blink = false; 
 820  0248 3fa3          	clr	_cfg+163
 822  024a 2018          	jra	L732
 823  024c               L532:
 824                     ; 178         } else if(cfg.mode == REGRESSIVE_MODE){
 826  024c 4a            	dec	a
 827  024d 2615          	jrne	L732
 828                     ; 179             cfg.dtshow.pdt = &dt;
 830  024f ae0006        	ldw	x,#L5_dt
 831  0252 bfa0          	ldw	_cfg+160,x
 832                     ; 180             cfg.dtshow.whichpart = 0;
 834  0254 b7a2          	ld	_cfg+162,a
 835                     ; 181             cfg.dtshow.blink = false;
 837  0256 b7a3          	ld	_cfg+163,a
 838                     ; 182             rc_get_left_time(&cfg.rc, &dt.time);
 840  0258 ae0009        	ldw	x,#L5_dt+3
 841  025b 89            	pushw	x
 842  025c ae001d        	ldw	x,#_cfg+29
 843  025f 8d000000      	callf	f_rc_get_left_time
 845  0263 85            	popw	x
 846  0264               L732:
 847                     ; 184         firsttime = false;
 849  0264 725f0001      	clr	L112_firsttime
 850  0268               L332:
 851                     ; 187     if(cirbuf_get(&cfg.cbuf, (cb_ele_t)&msg) == 0)
 853  0268 96            	ldw	x,sp
 854  0269 5c            	incw	x
 855  026a 89            	pushw	x
 856  026b ae0042        	ldw	x,#_cfg+66
 857  026e 8d000000      	callf	f_cirbuf_get
 859  0272 4d            	tnz	a
 860  0273 85            	popw	x
 861  0274 261b          	jrne	L342
 862                     ; 189         if(msg.evt == BUTTON_LNG_PRESSED){
 864  0276 7b03          	ld	a,(OFST+0,sp)
 865  0278 a102          	cp	a,#2
 866  027a 2615          	jrne	L342
 867                     ; 190           menu_show(msg);
 869  027c 88            	push	a
 870  027d 7b03          	ld	a,(OFST+0,sp)
 871  027f 88            	push	a
 872  0280 7b03          	ld	a,(OFST+0,sp)
 873  0282 88            	push	a
 874  0283 8d000000      	callf	f_menu_show
 876  0287 5b03          	addw	sp,#3
 877                     ; 191           firsttime = true;
 879  0289 35010001      	mov	L112_firsttime,#1
 880                     ; 195           return ST_CONFIG;
 882  028d a601          	ld	a,#1
 884  028f 200f          	jra	L021
 885  0291               L342:
 886                     ; 199     if(cfg.mode == ALARM_MODE)
 888  0291 b600          	ld	a,_cfg
 889  0293 2610          	jrne	L742
 890                     ; 201         if(cfg.alarm.mark) {
 892  0295 7201000709    	btjf	_cfg+7,#0,L152
 893                     ; 202             firsttime = true; 
 895                     ; 206             return ST_WORKING;
 897  029a               LC001:
 899  029a 35010001      	mov	L112_firsttime,#1
 901  029e a604          	ld	a,#4
 903  02a0               L021:
 905  02a0 5b03          	addw	sp,#3
 906  02a2 87            	retf	
 907  02a3               L152:
 908                     ; 208         else return ST_WAITING;
 910  02a3 2014          	jpf	L552
 911  02a5               L742:
 912                     ; 209     } else if(cfg.mode == REGRESSIVE_MODE){
 914  02a5 4a            	dec	a
 915  02a6 2611          	jrne	L552
 916                     ; 210         rc_get_left_time(&cfg.rc, &dt.time);
 918  02a8 ae0009        	ldw	x,#L5_dt+3
 919  02ab 89            	pushw	x
 920  02ac ae001d        	ldw	x,#_cfg+29
 921  02af 8d000000      	callf	f_rc_get_left_time
 923  02b3 b61d          	ld	a,_cfg+29
 924  02b5 4a            	dec	a
 925  02b6 85            	popw	x
 926                     ; 211         if(cfg.rc.mode == ARMED) {
 928                     ; 212             firsttime = true;
 929                     ; 216             return ST_WORKING;
 931  02b7 27e1          	jreq	LC001
 932  02b9               L552:
 933                     ; 219     return ST_WAITING;
 936  02b9 a603          	ld	a,#3
 938  02bb 20e3          	jra	L021
 977                     ; 222 static enum state_t sm_working()
 977                     ; 223 {
 978                     	switch	.text
 979  02bd               L53f_sm_working:
 981  02bd 5203          	subw	sp,#3
 982       00000003      OFST:	set	3
 985                     ; 225     cfg.dtshow.blink = true;
 987  02bf 350100a3      	mov	_cfg+163,#1
 988                     ; 226     if(cirbuf_get(&cfg.cbuf, (cb_ele_t)&msg) == 0)
 990  02c3 96            	ldw	x,sp
 991  02c4 5c            	incw	x
 992  02c5 89            	pushw	x
 993  02c6 ae0042        	ldw	x,#_cfg+66
 994  02c9 8d000000      	callf	f_cirbuf_get
 996  02cd 4d            	tnz	a
 997  02ce 85            	popw	x
 998  02cf 260a          	jrne	L103
 999                     ; 228         if(msg.evt == BUTTON_LNG_PRESSED){
1001  02d1 7b03          	ld	a,(OFST+0,sp)
1002  02d3 a102          	cp	a,#2
1003  02d5 2604          	jrne	L103
1004                     ; 232             return ST_CONFIG;
1006  02d7 a601          	ld	a,#1
1008  02d9 2010          	jra	L031
1009  02db               L103:
1010                     ; 235     if(cfg.mode == ALARM_MODE)
1012  02db b600          	ld	a,_cfg
1013  02dd 260f          	jrne	L503
1014                     ; 237         cfg.dtshow.pdt = &cfg.curr_dt;
1016  02df ae0001        	ldw	x,#_cfg+1
1017  02e2 bfa0          	ldw	_cfg+160,x
1018                     ; 238         if(cfg.alarm.mark) return ST_WORKING;
1020  02e4 720100071e    	btjf	_cfg+7,#0,L113
1023  02e9               LC003:
1025  02e9 a604          	ld	a,#4
1027  02eb               L031:
1029  02eb 5b03          	addw	sp,#3
1030  02ed 87            	retf	
1031  02ee               L503:
1032                     ; 239     } else if (cfg.mode == REGRESSIVE_MODE)
1034  02ee 4a            	dec	a
1035  02ef 26f8          	jrne	LC003
1036                     ; 241         rc_get_left_time(&cfg.rc, &dt.time);
1038  02f1 ae0009        	ldw	x,#L5_dt+3
1039  02f4 89            	pushw	x
1040  02f5 ae001d        	ldw	x,#_cfg+29
1041  02f8 8d000000      	callf	f_rc_get_left_time
1043  02fc b61d          	ld	a,_cfg+29
1044  02fe a103          	cp	a,#3
1045  0300 85            	popw	x
1046                     ; 242         if(cfg.rc.mode == STOP) {
1048  0301 26e6          	jrne	LC003
1049                     ; 246             return ST_WAITING;
1051  0303 a603          	ld	a,#3
1053  0305 20e4          	jra	L031
1054  0307               L113:
1055                     ; 249     return ST_WORKING;
1057  0307 20e0          	jpf	LC003
1094                     ; 252 static enum state_t sm_idle()
1094                     ; 253 {
1095                     	switch	.text
1096  0309               L73f_sm_idle:
1098  0309 5203          	subw	sp,#3
1099       00000003      OFST:	set	3
1102                     ; 255     cfg.dtshow.blink = false;
1104  030b 3fa3          	clr	_cfg+163
1105                     ; 256     if(cirbuf_get(&cfg.cbuf, (cb_ele_t)&msg) == 0)
1107  030d 96            	ldw	x,sp
1108  030e 8d2a032a      	callf	LC004
1109  0312 2611          	jrne	L533
1110                     ; 258         if(msg.evt == BUTTON_LNG_PRESSED){
1112  0314 7b03          	ld	a,(OFST+0,sp)
1113  0316 a102          	cp	a,#2
1114  0318 260b          	jrne	L533
1116  031a               L343:
1117                     ; 259             while(cirbuf_get(&cfg.cbuf, (cb_ele_t)&msg) == 0);
1119  031a 96            	ldw	x,sp
1120  031b 8d2a032a      	callf	LC004
1121  031f 27f9          	jreq	L343
1122                     ; 263             return ST_CONFIG;
1124  0321 a601          	ld	a,#1
1126  0323 2002          	jra	L041
1127  0325               L533:
1128                     ; 266    return ST_IDLE;
1130  0325 a602          	ld	a,#2
1132  0327               L041:
1134  0327 5b03          	addw	sp,#3
1135  0329 87            	retf	
1136  032a               LC004:
1137  032a 5c            	incw	x
1138  032b 89            	pushw	x
1139  032c ae0042        	ldw	x,#_cfg+66
1140  032f 8d000000      	callf	f_cirbuf_get
1142  0333 4d            	tnz	a
1143  0334 85            	popw	x
1144  0335 87            	retf	
1166                     ; 270 static void led_on()
1166                     ; 271 {
1167                     	switch	.text
1168  0336               L7f_led_on:
1172                     ; 272     RELAY_PORT->DDR |= RELAY_PIN;
1174  0336 7216500c      	bset	20492,#3
1175                     ; 273 }
1178  033a 87            	retf	
1200                     ; 274 static void led_off()
1200                     ; 275 {
1201                     	switch	.text
1202  033b               L11f_led_off:
1206                     ; 276     RELAY_PORT->DDR &= ~RELAY_PIN;
1208  033b 7217500c      	bres	20492,#3
1209                     ; 277 }
1212  033f 87            	retf	
1250                     ; 289 static int8_t get_but(uint16_t id)
1250                     ; 290 {
1251                     	switch	.text
1252  0340               L31f_get_but:
1254       00000001      OFST:	set	1
1257                     ; 291     int8_t r = (BUTTON_PORT->IDR & BUTTON_PIN);
1259  0340 c6500b        	ld	a,20491
1260  0343 a410          	and	a,#16
1262                     ; 292     return r?0:1;
1264  0345 2702          	jreq	L051
1265  0347 4f            	clr	a
1267  0348 87            	retf	
1268  0349               L051:
1269  0349 4c            	inc	a
1272  034a 87            	retf	
1308                     ; 305 static void but_check(void * p)
1308                     ; 306 {
1309                     	switch	.text
1310  034b               L51f_but_check:
1314                     ; 307     bt_update(&cfg.but, &cfg.cbuf);
1316  034b ae0042        	ldw	x,#_cfg+66
1317  034e 89            	pushw	x
1318  034f ae0039        	ldw	x,#_cfg+57
1319  0352 8d000000      	callf	f_bt_update
1321  0356 85            	popw	x
1322                     ; 308 }
1325  0357 87            	retf	
1327                     	switch	.data
1328  0002               L324_timeslice:
1329  0002 00            	dc.b	0
1330  0003               L524_dev:
1331  0003 00            	dc.b	0
1383                     ; 321 static void sev_seg_update(void *p)
1383                     ; 322 {
1384                     	switch	.text
1385  0358               L71f_sev_seg_update:
1387  0358 5203          	subw	sp,#3
1388       00000003      OFST:	set	3
1391                     ; 325     if (timeslice < 8 - count_bits(Drv7SegGetDisplayCode(dev)))
1393  035a c60002        	ld	a,L324_timeslice
1394  035d 5f            	clrw	x
1395  035e 97            	ld	xl,a
1396  035f 1f02          	ldw	(OFST-1,sp),x
1398  0361 c60003        	ld	a,L524_dev
1399  0364 8d000000      	callf	f_Drv7SegGetDisplayCode
1401  0368 8db303b3      	callf	L12f_count_bits
1403  036c 6b01          	ld	(OFST-2,sp),a
1405  036e 4f            	clr	a
1406  036f 97            	ld	xl,a
1407  0370 a608          	ld	a,#8
1408  0372 1001          	sub	a,(OFST-2,sp)
1409  0374 2401          	jrnc	L661
1410  0376 5a            	decw	x
1411  0377               L661:
1412  0377 02            	rlwa	x,a
1413  0378 1302          	cpw	x,(OFST-1,sp)
1414  037a 2d0d          	jrsle	L154
1415                     ; 327         Drv7SegShow(&cfg.disp, dev);
1417  037c 3b0003        	push	L524_dev
1418  037f ae0034        	ldw	x,#_cfg+52
1419  0382 8d000000      	callf	f_Drv7SegShow
1421  0386 84            	pop	a
1423  0387 2009          	jra	L354
1424  0389               L154:
1425                     ; 331         Drv7SegCtrSet(dev, 0); // stop
1427  0389 c60003        	ld	a,L524_dev
1428  038c 5f            	clrw	x
1429  038d 95            	ld	xh,a
1430  038e 8d000000      	callf	f_Drv7SegCtrSet
1432  0392               L354:
1433                     ; 334     if (timeslice++ > TIME_SLICE_NO)
1435  0392 c60002        	ld	a,L324_timeslice
1436  0395 725c0002      	inc	L324_timeslice
1437  0399 a109          	cp	a,#9
1438  039b 2513          	jrult	L554
1439                     ; 336         dev++;
1441  039d 725c0003      	inc	L524_dev
1442                     ; 337         if (dev >= 4)
1444  03a1 c60003        	ld	a,L524_dev
1445  03a4 a104          	cp	a,#4
1446  03a6 2504          	jrult	L754
1447                     ; 338           dev = 0;
1449  03a8 725f0003      	clr	L524_dev
1450  03ac               L754:
1451                     ; 339         timeslice = 0;
1453  03ac 725f0002      	clr	L324_timeslice
1454  03b0               L554:
1455                     ; 341 }
1458  03b0 5b03          	addw	sp,#3
1459  03b2 87            	retf	
1490                     ; 353 static uint8_t count_bits(uint8_t n)
1490                     ; 354 {
1491                     	switch	.text
1492  03b3               L12f_count_bits:
1494  03b3 88            	push	a
1495  03b4 88            	push	a
1496       00000001      OFST:	set	1
1499                     ; 355     n = (n & 0x55) + ((n >> 1) & 0x55); // 每2位为一组，统计1的个数
1501  03b5 a4aa          	and	a,#170
1502  03b7 44            	srl	a
1503  03b8 6b01          	ld	(OFST+0,sp),a
1505  03ba 7b02          	ld	a,(OFST+1,sp)
1506  03bc a455          	and	a,#85
1507  03be 1b01          	add	a,(OFST+0,sp)
1508  03c0 6b02          	ld	(OFST+1,sp),a
1509                     ; 356     n = (n & 0x33) + ((n >> 2) & 0x33); // 每4位为一组
1511  03c2 a4cc          	and	a,#204
1512  03c4 44            	srl	a
1513  03c5 44            	srl	a
1514  03c6 6b01          	ld	(OFST+0,sp),a
1516  03c8 7b02          	ld	a,(OFST+1,sp)
1517  03ca a433          	and	a,#51
1518  03cc 1b01          	add	a,(OFST+0,sp)
1519  03ce 6b02          	ld	(OFST+1,sp),a
1520                     ; 357     n = (n & 0x0F) + ((n >> 4) & 0x0F); // 每8位为一组
1522  03d0 4e            	swap	a
1523  03d1 a40f          	and	a,#15
1524  03d3 6b01          	ld	(OFST+0,sp),a
1526  03d5 7b02          	ld	a,(OFST+1,sp)
1527  03d7 a40f          	and	a,#15
1528  03d9 1b01          	add	a,(OFST+0,sp)
1529                     ; 358     return n;
1533  03db 85            	popw	x
1534  03dc 87            	retf	
1536                     	switch	.data
1537  0004               L574_st:
1538  0004 00            	dc.b	0
1539  0005               L774_shouldshow:
1540  0005 01            	dc.b	1
1720                     ; 373 static void seven_seg_show(void *p)
1720                     ; 374 {
1721                     	switch	.text
1722  03dd               L32f_seven_seg_show:
1724  03dd 89            	pushw	x
1725       00000002      OFST:	set	2
1728                     ; 375     dtshow_t * pdt = (dtshow_t *)p;
1730  03de 1f01          	ldw	(OFST-1,sp),x
1732                     ; 378     if(pdt->whichpart == 0 && st < 3) st = 3;
1734  03e0 e602          	ld	a,(2,x)
1735  03e2 260b          	jrne	L326
1737  03e4 c60004        	ld	a,L574_st
1738  03e7 a103          	cp	a,#3
1739  03e9 2404          	jruge	L326
1742  03eb 35030004      	mov	L574_st,#3
1743  03ef               L326:
1744                     ; 379     if(pdt->blink) {shouldshow = !shouldshow;}
1746  03ef e603          	ld	a,(3,x)
1747  03f1 270e          	jreq	L526
1750  03f3 c60005        	ld	a,L774_shouldshow
1751  03f6 2603          	jrne	L002
1752  03f8 4c            	inc	a
1753  03f9 2001          	jra	L202
1754  03fb               L002:
1755  03fb 4f            	clr	a
1756  03fc               L202:
1757  03fc c70005        	ld	L774_shouldshow,a
1759  03ff 2004          	jra	L726
1760  0401               L526:
1761                     ; 380     else shouldshow = true;
1763  0401 35010005      	mov	L774_shouldshow,#1
1764  0405               L726:
1765                     ; 381     if(!shouldshow) {Drv7SegClearAll(&cfg.disp); return;}
1767  0405 c60005        	ld	a,L774_shouldshow
1768  0408 2609          	jrne	L136
1771  040a ae0034        	ldw	x,#_cfg+52
1772  040d 8d000000      	callf	f_Drv7SegClearAll
1777  0411 85            	popw	x
1778  0412 87            	retf	
1779  0413               L136:
1780                     ; 382     switch(st)
1782  0413 c60004        	ld	a,L574_st
1784                     ; 401           break;
1785  0416 2711          	jreq	L105
1786  0418 4a            	dec	a
1787  0419 2716          	jreq	L305
1788  041b 4a            	dec	a
1789  041c 271c          	jreq	L505
1790  041e 4a            	dec	a
1791  041f 2722          	jreq	L705
1792  0421 4a            	dec	a
1793  0422 2728          	jreq	L115
1794  0424 4a            	dec	a
1795  0425 272e          	jreq	L315
1796  0427 203e          	jra	L536
1797  0429               L105:
1798                     ; 384         case 0:
1798                     ; 385           Drv7SegSetNum(&cfg.disp, pdt->pdt->date.year); 
1800  0429 fe            	ldw	x,(x)
1801  042a f6            	ld	a,(x)
1802  042b 5f            	clrw	x
1803  042c 4d            	tnz	a
1804  042d 2a2e          	jrpl	L432
1806                     ; 386           break;
1808  042f 202b          	jpf	LC006
1809  0431               L305:
1810                     ; 387         case 1:
1810                     ; 388           Drv7SegSetNum(&cfg.disp, pdt->pdt->date.month); 
1812  0431 fe            	ldw	x,(x)
1813  0432 e601          	ld	a,(1,x)
1814  0434 5f            	clrw	x
1815  0435 4d            	tnz	a
1816  0436 2a25          	jrpl	L432
1818                     ; 389           break;
1820  0438 2022          	jpf	LC006
1821  043a               L505:
1822                     ; 390         case 2:
1822                     ; 391           Drv7SegSetNum(&cfg.disp, pdt->pdt->date.day); 
1824  043a fe            	ldw	x,(x)
1825  043b e602          	ld	a,(2,x)
1826  043d 5f            	clrw	x
1827  043e 4d            	tnz	a
1828  043f 2a1c          	jrpl	L432
1830                     ; 392           break;
1832  0441 2019          	jpf	LC006
1833  0443               L705:
1834                     ; 393         case 3:
1834                     ; 394           Drv7SegSetNum(&cfg.disp, pdt->pdt->time.hour); 
1836  0443 fe            	ldw	x,(x)
1837  0444 e603          	ld	a,(3,x)
1838  0446 5f            	clrw	x
1839  0447 4d            	tnz	a
1840  0448 2a13          	jrpl	L432
1842                     ; 395           break;
1844  044a 2010          	jpf	LC006
1845  044c               L115:
1846                     ; 396         case 4:
1846                     ; 397           Drv7SegSetNum(&cfg.disp, pdt->pdt->time.minute); 
1848  044c fe            	ldw	x,(x)
1849  044d e604          	ld	a,(4,x)
1850  044f 5f            	clrw	x
1851  0450 4d            	tnz	a
1852  0451 2a0a          	jrpl	L432
1854                     ; 398           break;
1856  0453 2007          	jpf	LC006
1857  0455               L315:
1858                     ; 399         case 5:
1858                     ; 400           Drv7SegSetNum(&cfg.disp, pdt->pdt->time.second); 
1860  0455 fe            	ldw	x,(x)
1861  0456 e605          	ld	a,(5,x)
1862  0458 5f            	clrw	x
1863  0459 4d            	tnz	a
1864  045a 2a01          	jrpl	L432
1865  045c               LC006:
1866  045c 53            	cplw	x
1867  045d               L432:
1869  045d 97            	ld	xl,a
1870  045e 89            	pushw	x
1871  045f ae0034        	ldw	x,#_cfg+52
1872  0462 8d000000      	callf	f_Drv7SegSetNum
1873  0466 85            	popw	x
1874                     ; 401           break;
1876  0467               L536:
1877                     ; 403     Drv7SegSetDigit(&cfg.disp, 11, 1);
1879  0467 4b01          	push	#1
1880  0469 4b0b          	push	#11
1881  046b ae0034        	ldw	x,#_cfg+52
1882  046e 8d000000      	callf	f_Drv7SegSetDigit
1884  0472 85            	popw	x
1885                     ; 404     Drv7SegSetDigit(&cfg.disp, datetime_unit_map[st], 0);
1887  0473 4b00          	push	#0
1888  0475 c60004        	ld	a,L574_st
1889  0478 5f            	clrw	x
1890  0479 97            	ld	xl,a
1891  047a d60000        	ld	a,(L3_datetime_unit_map,x)
1892  047d 88            	push	a
1893  047e ae0034        	ldw	x,#_cfg+52
1894  0481 8d000000      	callf	f_Drv7SegSetDigit
1896  0485 725c0004      	inc	L574_st
1897  0489 c60004        	ld	a,L574_st
1898  048c a106          	cp	a,#6
1899  048e 85            	popw	x
1900                     ; 405     st++;
1902                     ; 406     if(st == 6)
1904  048f 2610          	jrne	L736
1905                     ; 408         if(pdt->whichpart == 0) st = 3;
1907  0491 1e01          	ldw	x,(OFST-1,sp)
1908  0493 e602          	ld	a,(2,x)
1909  0495 2606          	jrne	L146
1912  0497 35030004      	mov	L574_st,#3
1914  049b 2004          	jra	L736
1915  049d               L146:
1916                     ; 409         else st = 0;
1918  049d 725f0004      	clr	L574_st
1919  04a1               L736:
1920                     ; 411 }
1923  04a1 85            	popw	x
1924  04a2 87            	retf	
1962                     ; 425 static void check_up(void *p)
1962                     ; 426 {
1963                     	switch	.text
1964  04a3               L52f_check_up:
1968                     ; 427     if(cfg.mode == ALARM_MODE){
1970  04a3 b600          	ld	a,_cfg
1971  04a5 2614          	jrne	L366
1972                     ; 428         t_datetime_inc(&cfg.curr_dt);
1974  04a7 ae0001        	ldw	x,#_cfg+1
1975  04aa 8d000000      	callf	f_t_datetime_inc
1977                     ; 429         alarm_check(&cfg.alarm, &cfg.curr_dt);
1979  04ae ae0001        	ldw	x,#_cfg+1
1980  04b1 89            	pushw	x
1981  04b2 ae0007        	ldw	x,#_cfg+7
1982  04b5 8d000000      	callf	f_alarm_check
1984  04b9 85            	popw	x
1987  04ba 87            	retf	
1988  04bb               L366:
1989                     ; 430     }else if(cfg.mode == REGRESSIVE_MODE)
1991  04bb 4a            	dec	a
1992  04bc 2607          	jrne	L566
1993                     ; 431         rc_check(&cfg.rc);
1995  04be ae001d        	ldw	x,#_cfg+29
1996  04c1 8d000000      	callf	f_rc_check
1998  04c5               L566:
1999                     ; 432 }
2002  04c5 87            	retf	
2042                     ; 437 enum state_t main_sm(enum state_t s)
2042                     ; 438 {
2043                     	switch	.text
2044  04c6               f_main_sm:
2048                     ; 439     switch(s)
2051                     ; 449         case ST_IDLE:
2051                     ; 450             return sm_idle();
2052  04c6 4d            	tnz	a
2053  04c7 270d          	jreq	L176
2054  04c9 4a            	dec	a
2055  04ca 270e          	jreq	L376
2056  04cc 4a            	dec	a
2057  04cd 2717          	jreq	L107
2058  04cf 4a            	dec	a
2059  04d0 270c          	jreq	L576
2060  04d2 4a            	dec	a
2061  04d3 270d          	jreq	L776
2063  04d5 87            	retf	
2064  04d6               L176:
2065                     ; 441         case ST_INIT:
2065                     ; 442             return sm_init();
2070  04d6 ac470047      	jpf	L72f_sm_init
2071  04da               L376:
2072                     ; 443         case ST_CONFIG:
2072                     ; 444             return sm_config();   
2077  04da acc701c7      	jpf	L13f_sm_config
2078  04de               L576:
2079                     ; 445         case ST_WAITING:
2079                     ; 446             return sm_waiting();
2084  04de ac1c021c      	jpf	L33f_sm_waiting
2085  04e2               L776:
2086                     ; 447         case ST_WORKING:
2086                     ; 448             return sm_working();
2091  04e2 acbd02bd      	jpf	L53f_sm_working
2092  04e6               L107:
2093                     ; 449         case ST_IDLE:
2093                     ; 450             return sm_idle();
2098                     ; 452 }
2101  04e6 ac090309      	jpf	L73f_sm_idle
2730                     	switch	.ubsct
2731  0000               _cfg:
2732  0000 000000000000  	ds.b	164
2733                     	xdef	_cfg
2734                     	xdef	f_TimerHandler1
2735                     	xdef	f_main_sm
2736                     	xref	f_menu_show
2737                     	xref	f_menu_init
2738                     	xref	f_tl_update
2739                     	xref	f_tl_resume
2740                     	xref	f_tl_pause
2741                     	xref	f_tl_add_singleton
2742                     	xref	f_tl_add
2743                     	xref	f_tl_init
2744                     	xref	f_bt_update
2745                     	xref	f_bt_init
2746                     	xref	f_cirbuf_get
2747                     	xref	f_cirbuf_init
2748                     	xref	f_Drv7SegCtrSet
2749                     	xref	f_Drv7SegGetDisplayCode
2750                     	xref	f_Drv7SegClearAll
2751                     	xref	f_Drv7SegClear
2752                     	xref	f_Drv7SegShow
2753                     	xref	f_Drv7SegSetNum
2754                     	xref	f_Drv7SegSetDigit
2755                     	xref	f_Drv7SegInit
2756                     	xref	f_rc_get_left_time
2757                     	xref	f_rc_check
2758                     	xref	f_rc_attach_off_func
2759                     	xref	f_rc_attach_on_func
2760                     	xref	f_rc_init
2761                     	xref	f_alarm_attach_off_func
2762                     	xref	f_alarm_attach_on_func
2763                     	xref	f_alarm_check
2764                     	xref	f_alarm_init
2765                     	xref	f_t_datetime_inc
2766                     	xref.b	c_lreg
2767                     	xref.b	c_x
2768                     	xref.b	c_y
2788                     	xref	d_xymov
2789                     	end
