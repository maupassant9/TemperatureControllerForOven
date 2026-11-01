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
  56                     ; 65 void menu_init()
  56                     ; 66 {
  57                     	switch	.text
  58  0000               f_menu_init:
  62                     ; 67     cfg.mode = 0;
  64  0000 725f0000      	clr	_cfg
  65                     ; 68 }
  68  0004 87            	retf	
  70                     	switch	.data
  71  0000               L32_st:
  72  0000 00            	dc.b	0
 243                     ; 72 uint8_t menu_show(but_msg_t msg)
 243                     ; 73 {
 244                     	switch	.text
 245  0005               f_menu_show:
 247  0005 88            	push	a
 248       00000001      OFST:	set	1
 251                     ; 76     switch (st)
 253  0006 c60000        	ld	a,L32_st
 255                     ; 99         return false;
 256  0009 2708          	jreq	L52
 257  000b 4a            	dec	a
 258  000c 272b          	jreq	L72
 259  000e 4a            	dec	a
 260  000f 274a          	jreq	L13
 261  0011 206a          	jra	L531
 262  0013               L52:
 263                     ; 78     case MODE_SELECT_MENU:
 263                     ; 79         if (NO_MODE_SELECTED != (m = menu_select_sm_next(msg))) {
 265  0013 7b07          	ld	a,(OFST+6,sp)
 266  0015 88            	push	a
 267  0016 7b07          	ld	a,(OFST+6,sp)
 268  0018 88            	push	a
 269  0019 7b07          	ld	a,(OFST+6,sp)
 270  001b 88            	push	a
 271  001c 8d800080      	callf	f_menu_select_sm_next
 273  0020 5b03          	addw	sp,#3
 274  0022 6b01          	ld	(OFST+0,sp),a
 276  0024 4c            	inc	a
 277  0025 270e          	jreq	L731
 278                     ; 80             if (m == ALARM_MODE)
 280  0027 7b01          	ld	a,(OFST+0,sp)
 281  0029 2606          	jrne	L141
 282                     ; 81                 st = ALARM_MODE_MENU;
 284  002b 35010000      	mov	L32_st,#1
 286  002f 2004          	jra	L731
 287  0031               L141:
 288                     ; 83                 st = REGRESSIVE_MODE_MENU;
 290  0031 35020000      	mov	L32_st,#2
 291  0035               L731:
 292                     ; 85         return false;
 294  0035 4f            	clr	a
 297  0036 5b01          	addw	sp,#1
 298  0038 87            	retf	
 299  0039               L72:
 300                     ; 86     case ALARM_MODE_MENU:
 300                     ; 87         if (menu_alarm_next(msg)) {
 302  0039 7b07          	ld	a,(OFST+6,sp)
 303  003b 88            	push	a
 304  003c 7b07          	ld	a,(OFST+6,sp)
 305  003e 88            	push	a
 306  003f 7b07          	ld	a,(OFST+6,sp)
 307  0041 88            	push	a
 308  0042 8d1e011e      	callf	f_menu_alarm_next
 310  0046 5b03          	addw	sp,#3
 311  0048 4d            	tnz	a
 312  0049 270d          	jreq	L541
 313                     ; 88             st = MODE_SELECT_MENU;
 315  004b 725f0000      	clr	L32_st
 316                     ; 89             cfg.mode = ALARM_MODE;
 318  004f 725f0000      	clr	_cfg
 319                     ; 90             return true;
 321  0053 a601          	ld	a,#1
 324  0055 5b01          	addw	sp,#1
 325  0057 87            	retf	
 326  0058               L541:
 327                     ; 92         return false;
 331  0058 5b01          	addw	sp,#1
 332  005a 87            	retf	
 333  005b               L13:
 334                     ; 93     case REGRESSIVE_MODE_MENU:
 334                     ; 94         if (menu_regressive_next(msg)) {
 336  005b 7b07          	ld	a,(OFST+6,sp)
 337  005d 88            	push	a
 338  005e 7b07          	ld	a,(OFST+6,sp)
 339  0060 88            	push	a
 340  0061 7b07          	ld	a,(OFST+6,sp)
 341  0063 88            	push	a
 342  0064 8df904f9      	callf	f_menu_regressive_next
 344  0068 5b03          	addw	sp,#3
 345  006a 4d            	tnz	a
 346  006b 270d          	jreq	L741
 347                     ; 95             st = MODE_SELECT_MENU;
 349  006d 725f0000      	clr	L32_st
 350                     ; 96             cfg.mode = REGRESSIVE_MODE;
 352  0071 35010000      	mov	_cfg,#1
 353                     ; 97             return true;
 355  0075 a601          	ld	a,#1
 358  0077 5b01          	addw	sp,#1
 359  0079 87            	retf	
 360  007a               L741:
 361                     ; 99         return false;
 366  007a 5b01          	addw	sp,#1
 367  007c 87            	retf	
 368  007d               L531:
 369                     ; 101 }
 372  007d 5b01          	addw	sp,#1
 373  007f 87            	retf	
 375                     	switch	.data
 376  0001               L151_st:
 377  0001 00            	dc.b	0
 423                     ; 103 enum mode_t menu_select_sm_next(but_msg_t msg)
 423                     ; 104 {
 424                     	switch	.text
 425  0080               f_menu_select_sm_next:
 427       00000000      OFST:	set	0
 430                     ; 106     Drv7SegSetDigit(&cfg.disp, 0, 0);
 432  0080 4b00          	push	#0
 433  0082 4b00          	push	#0
 434  0084 ae0034        	ldw	x,#_cfg+52
 435  0087 8d000000      	callf	f_Drv7SegSetDigit
 437  008b 85            	popw	x
 438                     ; 107     Drv7SegSetDigit(&cfg.disp, 11, 1);
 440  008c 4b01          	push	#1
 441  008e 4b0b          	push	#11
 442  0090 ae0034        	ldw	x,#_cfg+52
 443  0093 8d000000      	callf	f_Drv7SegSetDigit
 445  0097 85            	popw	x
 446                     ; 108     Drv7SegSetDigit(&cfg.disp, 12, 2);
 448  0098 4b02          	push	#2
 449  009a 4b0c          	push	#12
 450  009c ae0034        	ldw	x,#_cfg+52
 451  009f 8d000000      	callf	f_Drv7SegSetDigit
 453  00a3 c60001        	ld	a,L151_st
 454  00a6 85            	popw	x
 455                     ; 110     switch (st)
 458                     ; 138         break;
 459  00a7 2708          	jreq	L351
 460  00a9 4a            	dec	a
 461  00aa 2717          	jreq	L551
 462  00ac 4a            	dec	a
 463  00ad 273d          	jreq	L751
 464  00af 206a          	jra	L302
 465  00b1               L351:
 466                     ; 112     case 0:
 466                     ; 113         st++;
 468  00b1 725c0001      	inc	L151_st
 469                     ; 114         msg.evt = BUTTON_NOT_PRESSED;
 471  00b5 0f06          	clr	(OFST+6,sp)
 472                     ; 115         Drv7SegSetDigit(&cfg.disp, 1, 3);
 474  00b7 4b03          	push	#3
 475  00b9 4b01          	push	#1
 476  00bb ae0034        	ldw	x,#_cfg+52
 477  00be 8d000000      	callf	f_Drv7SegSetDigit
 479  00c2 85            	popw	x
 480  00c3               L551:
 481                     ; 116     case 1:
 481                     ; 117         if (msg.evt == BUTTON_SHT_PRESSED) {
 483  00c3 7b06          	ld	a,(OFST+6,sp)
 484  00c5 a101          	cp	a,#1
 485  00c7 260b          	jrne	L502
 486                     ; 118             st++;
 488  00c9 725c0001      	inc	L151_st
 489                     ; 119             Drv7SegSetDigit(&cfg.disp, st, 3);
 491  00cd 4b03          	push	#3
 492  00cf 3b0001        	push	L151_st
 495  00d2 2026          	jpf	LC001
 496  00d4               L502:
 497                     ; 121         else if (msg.evt == BUTTON_LNG_PRESSED) {
 499  00d4 a102          	cp	a,#2
 500  00d6 2643          	jrne	L302
 501                     ; 122             st = 0;
 503  00d8 725f0001      	clr	L151_st
 504                     ; 123             menu_regressive_next(msg);
 506  00dc 88            	push	a
 507  00dd 7b06          	ld	a,(OFST+6,sp)
 508  00df 88            	push	a
 509  00e0 7b06          	ld	a,(OFST+6,sp)
 510  00e2 88            	push	a
 511  00e3 8df904f9      	callf	f_menu_regressive_next
 513  00e7 5b03          	addw	sp,#3
 514                     ; 124             return REGRESSIVE_MODE;
 516  00e9 a601          	ld	a,#1
 519  00eb 87            	retf	
 520  00ec               L751:
 521                     ; 127     case 2:
 521                     ; 128         if (msg.evt == BUTTON_SHT_PRESSED) {
 523  00ec 7b06          	ld	a,(OFST+6,sp)
 524  00ee a101          	cp	a,#1
 525  00f0 2612          	jrne	L312
 526                     ; 129             st = 1;
 528  00f2 35010001      	mov	L151_st,#1
 529                     ; 130             Drv7SegSetDigit(&cfg.disp, st, 3);
 531  00f6 4b03          	push	#3
 532  00f8 4b01          	push	#1
 534  00fa               LC001:
 535  00fa ae0034        	ldw	x,#_cfg+52
 536  00fd 8d000000      	callf	f_Drv7SegSetDigit
 537  0101 85            	popw	x
 539  0102 2017          	jra	L302
 540  0104               L312:
 541                     ; 132         else if (msg.evt == BUTTON_LNG_PRESSED) {
 543  0104 a102          	cp	a,#2
 544  0106 2613          	jrne	L302
 545                     ; 133             st = 0;
 547  0108 725f0001      	clr	L151_st
 548                     ; 135             menu_alarm_next(msg);
 550  010c 88            	push	a
 551  010d 7b06          	ld	a,(OFST+6,sp)
 552  010f 88            	push	a
 553  0110 7b06          	ld	a,(OFST+6,sp)
 554  0112 88            	push	a
 555  0113 8d1e011e      	callf	f_menu_alarm_next
 557  0117 5b03          	addw	sp,#3
 558                     ; 136             return ALARM_MODE;
 560  0119 4f            	clr	a
 563  011a 87            	retf	
 564  011b               L302:
 565                     ; 140     return NO_MODE_SELECTED;
 567  011b a6ff          	ld	a,#255
 570  011d 87            	retf	
 572                     	switch	.data
 573  0002               L122_st:
 574  0002 00            	dc.b	0
 575  0003               L722_mark:
 576  0003 00            	dc.b	0
 577                     	switch	.bss
 578  0000               L522_editor:
 579  0000 000000000000  	ds.b	7
 580  0007               L322_alarm:
 581  0007 000000000000  	ds.b	22
 881                     ; 144 uint8_t menu_alarm_next(but_msg_t msg)
 881                     ; 145 {
 882                     	switch	.text
 883  011e               f_menu_alarm_next:
 885  011e 5206          	subw	sp,#6
 886       00000006      OFST:	set	6
 889                     ; 149     date_t* d = &alarm.alarm_datetime.date;
 891  0120 ae0008        	ldw	x,#L322_alarm+1
 892  0123 1f05          	ldw	(OFST-1,sp),x
 894                     ; 150     time_t* t = &alarm.alarm_datetime.time;
 896  0125 ae000b        	ldw	x,#L322_alarm+4
 897  0128 1f03          	ldw	(OFST-3,sp),x
 899                     ; 151     uint8_t* p = &alarm.repeate_pattern;
 901  012a ae000e        	ldw	x,#L322_alarm+7
 902  012d 1f01          	ldw	(OFST-5,sp),x
 904                     ; 154     switch (st)
 906  012f c60002        	ld	a,L122_st
 908                     ; 257     default:
 908                     ; 258         return false;
 909  0132 a114          	cp	a,#20
 910  0134 2504acc304c3  	jruge	L762
 911  013a 8d000000      	callf	d_jctab
 913  013e               L071:
 914  013e 002c          	dc.w	L132-L071
 915  0140 009d          	dc.w	L332-L071
 916  0142 00c2          	dc.w	L532-L071
 917  0144 00f5          	dc.w	L732-L071
 918  0146 011e          	dc.w	L142-L071
 919  0148 0143          	dc.w	L342-L071
 920  014a 0169          	dc.w	L542-L071
 921  014c 020d          	dc.w	L742-L071
 922  014e 0232          	dc.w	L152-L071
 923  0150 0265          	dc.w	L352-L071
 924  0152 028e          	dc.w	L552-L071
 925  0154 02b3          	dc.w	L752-L071
 926  0156 02d9          	dc.w	L162-L071
 927  0158 0315          	dc.w	L362-L071
 928  015a 0315          	dc.w	L362-L071
 929  015c 0315          	dc.w	L362-L071
 930  015e 0315          	dc.w	L362-L071
 931  0160 0315          	dc.w	L362-L071
 932  0162 0315          	dc.w	L362-L071
 933  0164 0337          	dc.w	L562-L071
 934  0166 acc304c3      	jra	L762
 935  016a               L132:
 936                     ; 156     case 0:
 936                     ; 157         msg.evt = BUTTON_NOT_PRESSED;
 938  016a 0f0c          	clr	(OFST+6,sp)
 939                     ; 158         Drv7SegSetDigit(&cfg.disp, 24, 3);
 941  016c 4b03          	push	#3
 942  016e 4b18          	push	#24
 943  0170 ae0034        	ldw	x,#_cfg+52
 944  0173 8d000000      	callf	f_Drv7SegSetDigit
 946  0177 85            	popw	x
 947                     ; 159         Drv7SegSetDigit(&cfg.disp, 24, 2);
 949  0178 4b02          	push	#2
 950  017a 4b18          	push	#24
 951  017c ae0034        	ldw	x,#_cfg+52
 952  017f 8d000000      	callf	f_Drv7SegSetDigit
 954  0183 85            	popw	x
 955                     ; 160         Drv7SegSetDigit(&cfg.disp, 23, 1);
 957  0184 4b01          	push	#1
 958  0186 4b17          	push	#23
 959  0188 ae0034        	ldw	x,#_cfg+52
 960  018b 8d000000      	callf	f_Drv7SegSetDigit
 962  018f 85            	popw	x
 963                     ; 161         Drv7SegSetDigit(&cfg.disp, 22, 0);
 965  0190 4b00          	push	#0
 966  0192 4b16          	push	#22
 967  0194 ae0034        	ldw	x,#_cfg+52
 968  0197 8d000000      	callf	f_Drv7SegSetDigit
 970  019b 85            	popw	x
 971                     ; 163         memcpy(&alarm.alarm_datetime, &cfg.curr_dt, sizeof(datetime_t));
 973  019c ae0006        	ldw	x,#6
 974  019f 8ddc04dc      	callf	LC005
 975                     ; 164         menu_digital_input_init(&editor, d->year, 99, 26);
 977  01a3 ae001a        	ldw	x,#26
 978  01a6 89            	pushw	x
 979  01a7 ae0063        	ldw	x,#99
 980  01aa 89            	pushw	x
 981  01ab 1e09          	ldw	x,(OFST+3,sp)
 982  01ad f6            	ld	a,(x)
 983  01ae 5f            	clrw	x
 984  01af 4d            	tnz	a
 985  01b0 2a01          	jrpl	L65
 986  01b2 53            	cplw	x
 987  01b3               L65:
 988  01b3 97            	ld	xl,a
 989  01b4 89            	pushw	x
 990  01b5 ae0000        	ldw	x,#L522_editor
 991  01b8 8d910791      	callf	f_menu_digital_input_init
 993  01bc 5b06          	addw	sp,#6
 994                     ; 165         menu_show_alarm_item(&editor, 1, datetime_unit_map[st % 6]);
 996  01be c60002        	ld	a,L122_st
 997  01c1 5f            	clrw	x
 998  01c2 97            	ld	xl,a
 999  01c3 a606          	ld	a,#6
1000  01c5 8d000000      	callf	d_smodx
1002  01c9 d60000        	ld	a,(L3_datetime_unit_map,x)
1003  01cc 88            	push	a
1004  01cd 4b01          	push	#1
1005  01cf ae0000        	ldw	x,#L522_editor
1006  01d2 8d350735      	callf	f_menu_show_alarm_item
1008  01d6 725c0002      	inc	L122_st
1009  01da 85            	popw	x
1010                     ; 166         st++;
1012  01db               L332:
1013                     ; 167     case 1:
1013                     ; 168         menu_alarm_next_aux_cfg_date(msg, &st, &d->year, d->month, &editor, 12, 1);
1015  01db 4b01          	push	#1
1016  01dd 4b0c          	push	#12
1017  01df ae0000        	ldw	x,#L522_editor
1018  01e2 89            	pushw	x
1019  01e3 1e09          	ldw	x,(OFST+3,sp)
1020  01e5 e601          	ld	a,(1,x)
1021  01e7 88            	push	a
1022  01e8 89            	pushw	x
1023  01e9 ae0002        	ldw	x,#L122_st
1024  01ec 89            	pushw	x
1025  01ed 7b15          	ld	a,(OFST+15,sp)
1026  01ef 88            	push	a
1027  01f0 7b15          	ld	a,(OFST+15,sp)
1028  01f2 88            	push	a
1029  01f3 7b15          	ld	a,(OFST+15,sp)
1030  01f5 88            	push	a
1031  01f6 8dc106c1      	callf	f_menu_alarm_next_aux_cfg_date
1033  01fa 5b0c          	addw	sp,#12
1034                     ; 169         break;
1036  01fc acc304c3      	jra	L762
1037  0200               L532:
1038                     ; 170     case 2:
1038                     ; 171         menu_alarm_next_aux_cfg_date(msg, &st, &d->month, d->day, &editor, t_last_day_of_month(d->month, d->year), 1);
1040  0200 4b01          	push	#1
1041  0202 1e06          	ldw	x,(OFST+0,sp)
1042  0204 f6            	ld	a,(x)
1043  0205 1606          	ldw	y,(OFST+0,sp)
1044  0207 97            	ld	xl,a
1045  0208 90e601        	ld	a,(1,y)
1046  020b 95            	ld	xh,a
1047  020c 8d000000      	callf	f_t_last_day_of_month
1049  0210 88            	push	a
1050  0211 ae0000        	ldw	x,#L522_editor
1051  0214 89            	pushw	x
1052  0215 1e09          	ldw	x,(OFST+3,sp)
1053  0217 e602          	ld	a,(2,x)
1054  0219 88            	push	a
1055  021a 5c            	incw	x
1056  021b 89            	pushw	x
1057  021c ae0002        	ldw	x,#L122_st
1058  021f 89            	pushw	x
1059  0220 7b15          	ld	a,(OFST+15,sp)
1060  0222 88            	push	a
1061  0223 7b15          	ld	a,(OFST+15,sp)
1062  0225 88            	push	a
1063  0226 7b15          	ld	a,(OFST+15,sp)
1064  0228 88            	push	a
1065  0229 8dc106c1      	callf	f_menu_alarm_next_aux_cfg_date
1067  022d 5b0c          	addw	sp,#12
1068                     ; 172         break;
1070  022f acc304c3      	jra	L762
1071  0233               L732:
1072                     ; 173     case 3:
1072                     ; 174         menu_alarm_next_aux_cfg_date(msg, &st, &d->day, t->hour, &editor, 23, 0);
1074  0233 4b00          	push	#0
1075  0235 4b17          	push	#23
1076  0237 ae0000        	ldw	x,#L522_editor
1077  023a 89            	pushw	x
1078  023b 1e07          	ldw	x,(OFST+1,sp)
1079  023d f6            	ld	a,(x)
1080  023e 88            	push	a
1081  023f 1e0a          	ldw	x,(OFST+4,sp)
1082  0241 1c0002        	addw	x,#2
1083  0244 89            	pushw	x
1084  0245 ae0002        	ldw	x,#L122_st
1085  0248 89            	pushw	x
1086  0249 7b15          	ld	a,(OFST+15,sp)
1087  024b 88            	push	a
1088  024c 7b15          	ld	a,(OFST+15,sp)
1089  024e 88            	push	a
1090  024f 7b15          	ld	a,(OFST+15,sp)
1091  0251 88            	push	a
1092  0252 8dc106c1      	callf	f_menu_alarm_next_aux_cfg_date
1094  0256 5b0c          	addw	sp,#12
1095                     ; 175         break;
1097  0258 acc304c3      	jra	L762
1098  025c               L142:
1099                     ; 176     case 4:
1099                     ; 177         menu_alarm_next_aux_cfg_date(msg, &st, &t->hour, t->minute, &editor, 59, 0);
1101  025c 4b00          	push	#0
1102  025e 4b3b          	push	#59
1103  0260 ae0000        	ldw	x,#L522_editor
1104  0263 89            	pushw	x
1105  0264 1e07          	ldw	x,(OFST+1,sp)
1106  0266 e601          	ld	a,(1,x)
1107  0268 88            	push	a
1108  0269 89            	pushw	x
1109  026a ae0002        	ldw	x,#L122_st
1110  026d 89            	pushw	x
1111  026e 7b15          	ld	a,(OFST+15,sp)
1112  0270 88            	push	a
1113  0271 7b15          	ld	a,(OFST+15,sp)
1114  0273 88            	push	a
1115  0274 7b15          	ld	a,(OFST+15,sp)
1116  0276 88            	push	a
1117  0277 8dc106c1      	callf	f_menu_alarm_next_aux_cfg_date
1119  027b 5b0c          	addw	sp,#12
1120                     ; 178         break;
1122  027d acc304c3      	jra	L762
1123  0281               L342:
1124                     ; 179     case 5:
1124                     ; 180         menu_alarm_next_aux_cfg_date(msg, &st, &t->minute, t->second, &editor, 59, 0);
1126  0281 4b00          	push	#0
1127  0283 4b3b          	push	#59
1128  0285 ae0000        	ldw	x,#L522_editor
1129  0288 89            	pushw	x
1130  0289 1e07          	ldw	x,(OFST+1,sp)
1131  028b e602          	ld	a,(2,x)
1132  028d 88            	push	a
1133  028e 5c            	incw	x
1134  028f 89            	pushw	x
1135  0290 ae0002        	ldw	x,#L122_st
1136  0293 89            	pushw	x
1137  0294 7b15          	ld	a,(OFST+15,sp)
1138  0296 88            	push	a
1139  0297 7b15          	ld	a,(OFST+15,sp)
1140  0299 88            	push	a
1141  029a 7b15          	ld	a,(OFST+15,sp)
1142  029c 88            	push	a
1143  029d 8dc106c1      	callf	f_menu_alarm_next_aux_cfg_date
1145  02a1 5b0c          	addw	sp,#12
1146                     ; 181         break;
1148  02a3 acc304c3      	jra	L762
1149  02a7               L542:
1150                     ; 182     case 6:
1150                     ; 183         if (msg.evt == BUTTON_SHT_PRESSED || msg.evt == BUTTON_NOT_RELEASED) {
1152  02a7 7b0c          	ld	a,(OFST+6,sp)
1153  02a9 a101          	cp	a,#1
1154  02ab 2704          	jreq	L754
1156  02ad a103          	cp	a,#3
1157  02af 260c          	jrne	L554
1158  02b1               L754:
1159                     ; 184             menu_digital_input_inc(&editor);
1161  02b1 8deb04eb      	callf	LC006
1162  02b5 8dc704c7      	callf	LC004
1163                     ; 185             menu_show_alarm_item(&editor, 1, datetime_unit_map[(st - 1) % 6]);
1164  02b9 ac4b034b      	jra	L742
1165  02bd               L554:
1166                     ; 187         else if (msg.evt == BUTTON_LNG_PRESSED) {
1168  02bd a102          	cp	a,#2
1169  02bf 26f8          	jrne	L742
1170                     ; 188             t->second = editor.val;
1172  02c1 1e03          	ldw	x,(OFST-3,sp)
1173  02c3 c60001        	ld	a,L522_editor+1
1174  02c6 e702          	ld	(2,x),a
1175                     ; 189             memcpy(&cfg.curr_dt, &alarm.alarm_datetime, sizeof(datetime_t));
1177  02c8 ae0006        	ldw	x,#6
1178  02cb 89            	pushw	x
1179  02cc ae0008        	ldw	x,#L322_alarm+1
1180  02cf 89            	pushw	x
1181  02d0 ae0001        	ldw	x,#_cfg+1
1182  02d3 8d000000      	callf	f_memcpy
1184  02d7 5b04          	addw	sp,#4
1185                     ; 193             memcpy(&alarm, &cfg.alarm, sizeof(alarm_t));
1187  02d9 ae0016        	ldw	x,#22
1188  02dc 89            	pushw	x
1189  02dd ae0007        	ldw	x,#_cfg+7
1190  02e0 89            	pushw	x
1191  02e1 ae0007        	ldw	x,#L322_alarm
1192  02e4 8d000000      	callf	f_memcpy
1194  02e8 5b04          	addw	sp,#4
1195                     ; 194             memcpy(&alarm.alarm_datetime.date, &cfg.curr_dt.date, sizeof(date_t));
1197  02ea ae0003        	ldw	x,#3
1198  02ed 8ddc04dc      	callf	LC005
1199                     ; 195             Drv7SegSetDigit(&cfg.disp, 25, 3);
1201  02f1 4b03          	push	#3
1202  02f3 4b19          	push	#25
1203  02f5 ae0034        	ldw	x,#_cfg+52
1204  02f8 8d000000      	callf	f_Drv7SegSetDigit
1206  02fc 85            	popw	x
1207                     ; 196             Drv7SegSetDigit(&cfg.disp, 26, 2);
1209  02fd 4b02          	push	#2
1210  02ff 4b1a          	push	#26
1211  0301 ae0034        	ldw	x,#_cfg+52
1212  0304 8d000000      	callf	f_Drv7SegSetDigit
1214  0308 85            	popw	x
1215                     ; 197             Drv7SegSetDigit(&cfg.disp, 25, 1);
1217  0309 4b01          	push	#1
1218  030b 4b19          	push	#25
1219  030d ae0034        	ldw	x,#_cfg+52
1220  0310 8d000000      	callf	f_Drv7SegSetDigit
1222  0314 85            	popw	x
1223                     ; 198             Drv7SegSetDigit(&cfg.disp, 12, 0);
1225  0315 4b00          	push	#0
1226  0317 4b0c          	push	#12
1227  0319 ae0034        	ldw	x,#_cfg+52
1228  031c 8d000000      	callf	f_Drv7SegSetDigit
1230  0320 85            	popw	x
1231                     ; 200             menu_digital_input_init(&editor, d->year, 99, 26);
1233  0321 ae001a        	ldw	x,#26
1234  0324 89            	pushw	x
1235  0325 ae0063        	ldw	x,#99
1236  0328 89            	pushw	x
1237  0329 1e09          	ldw	x,(OFST+3,sp)
1238  032b f6            	ld	a,(x)
1239  032c 5f            	clrw	x
1240  032d 4d            	tnz	a
1241  032e 2a01          	jrpl	L221
1242  0330 53            	cplw	x
1243  0331               L221:
1244  0331 97            	ld	xl,a
1245  0332 89            	pushw	x
1246  0333 ae0000        	ldw	x,#L522_editor
1247  0336 8d910791      	callf	f_menu_digital_input_init
1249  033a 5b06          	addw	sp,#6
1250                     ; 201             menu_show_alarm_item(&editor, 1, datetime_unit_map[st % 6]);
1252  033c c60002        	ld	a,L122_st
1253  033f 5f            	clrw	x
1254  0340 97            	ld	xl,a
1255  0341 8dc704c7      	callf	LC004
1256                     ; 202             msg.evt = BUTTON_NOT_PRESSED;
1258  0345 0f0c          	clr	(OFST+6,sp)
1259                     ; 203             st++;
1261  0347 725c0002      	inc	L122_st
1262  034b               L742:
1263                     ; 205     case 7:
1263                     ; 206         menu_alarm_next_aux_cfg_date(msg, &st, &d->year, d->month, &editor, 12, 1);
1265  034b 4b01          	push	#1
1266  034d 4b0c          	push	#12
1267  034f ae0000        	ldw	x,#L522_editor
1268  0352 89            	pushw	x
1269  0353 1e09          	ldw	x,(OFST+3,sp)
1270  0355 e601          	ld	a,(1,x)
1271  0357 88            	push	a
1272  0358 89            	pushw	x
1273  0359 ae0002        	ldw	x,#L122_st
1274  035c 89            	pushw	x
1275  035d 7b15          	ld	a,(OFST+15,sp)
1276  035f 88            	push	a
1277  0360 7b15          	ld	a,(OFST+15,sp)
1278  0362 88            	push	a
1279  0363 7b15          	ld	a,(OFST+15,sp)
1280  0365 88            	push	a
1281  0366 8dc106c1      	callf	f_menu_alarm_next_aux_cfg_date
1283  036a 5b0c          	addw	sp,#12
1284                     ; 207         break;
1286  036c acc304c3      	jra	L762
1287  0370               L152:
1288                     ; 208     case 8:
1288                     ; 209         menu_alarm_next_aux_cfg_date(msg, &st, &d->month, d->day, &editor, t_last_day_of_month(d->month, d->year), 1);
1290  0370 4b01          	push	#1
1291  0372 1e06          	ldw	x,(OFST+0,sp)
1292  0374 f6            	ld	a,(x)
1293  0375 1606          	ldw	y,(OFST+0,sp)
1294  0377 97            	ld	xl,a
1295  0378 90e601        	ld	a,(1,y)
1296  037b 95            	ld	xh,a
1297  037c 8d000000      	callf	f_t_last_day_of_month
1299  0380 88            	push	a
1300  0381 ae0000        	ldw	x,#L522_editor
1301  0384 89            	pushw	x
1302  0385 1e09          	ldw	x,(OFST+3,sp)
1303  0387 e602          	ld	a,(2,x)
1304  0389 88            	push	a
1305  038a 5c            	incw	x
1306  038b 89            	pushw	x
1307  038c ae0002        	ldw	x,#L122_st
1308  038f 89            	pushw	x
1309  0390 7b15          	ld	a,(OFST+15,sp)
1310  0392 88            	push	a
1311  0393 7b15          	ld	a,(OFST+15,sp)
1312  0395 88            	push	a
1313  0396 7b15          	ld	a,(OFST+15,sp)
1314  0398 88            	push	a
1315  0399 8dc106c1      	callf	f_menu_alarm_next_aux_cfg_date
1317  039d 5b0c          	addw	sp,#12
1318                     ; 210         break;
1320  039f acc304c3      	jra	L762
1321  03a3               L352:
1322                     ; 211     case 9:
1322                     ; 212         menu_alarm_next_aux_cfg_date(msg, &st, &d->day, t->hour, &editor, 23, 0);
1324  03a3 4b00          	push	#0
1325  03a5 4b17          	push	#23
1326  03a7 ae0000        	ldw	x,#L522_editor
1327  03aa 89            	pushw	x
1328  03ab 1e07          	ldw	x,(OFST+1,sp)
1329  03ad f6            	ld	a,(x)
1330  03ae 88            	push	a
1331  03af 1e0a          	ldw	x,(OFST+4,sp)
1332  03b1 1c0002        	addw	x,#2
1333  03b4 89            	pushw	x
1334  03b5 ae0002        	ldw	x,#L122_st
1335  03b8 89            	pushw	x
1336  03b9 7b15          	ld	a,(OFST+15,sp)
1337  03bb 88            	push	a
1338  03bc 7b15          	ld	a,(OFST+15,sp)
1339  03be 88            	push	a
1340  03bf 7b15          	ld	a,(OFST+15,sp)
1341  03c1 88            	push	a
1342  03c2 8dc106c1      	callf	f_menu_alarm_next_aux_cfg_date
1344  03c6 5b0c          	addw	sp,#12
1345                     ; 213         break;
1347  03c8 acc304c3      	jra	L762
1348  03cc               L552:
1349                     ; 214     case 10:
1349                     ; 215         menu_alarm_next_aux_cfg_date(msg, &st, &t->hour, t->minute, &editor, 59, 0);
1351  03cc 4b00          	push	#0
1352  03ce 4b3b          	push	#59
1353  03d0 ae0000        	ldw	x,#L522_editor
1354  03d3 89            	pushw	x
1355  03d4 1e07          	ldw	x,(OFST+1,sp)
1356  03d6 e601          	ld	a,(1,x)
1357  03d8 88            	push	a
1358  03d9 89            	pushw	x
1359  03da ae0002        	ldw	x,#L122_st
1360  03dd 89            	pushw	x
1361  03de 7b15          	ld	a,(OFST+15,sp)
1362  03e0 88            	push	a
1363  03e1 7b15          	ld	a,(OFST+15,sp)
1364  03e3 88            	push	a
1365  03e4 7b15          	ld	a,(OFST+15,sp)
1366  03e6 88            	push	a
1367  03e7 8dc106c1      	callf	f_menu_alarm_next_aux_cfg_date
1369  03eb 5b0c          	addw	sp,#12
1370                     ; 216         break;
1372  03ed acc304c3      	jra	L762
1373  03f1               L752:
1374                     ; 217     case 11:
1374                     ; 218         menu_alarm_next_aux_cfg_date(msg, &st, &t->minute, t->second, &editor, 59, 0);
1376  03f1 4b00          	push	#0
1377  03f3 4b3b          	push	#59
1378  03f5 ae0000        	ldw	x,#L522_editor
1379  03f8 89            	pushw	x
1380  03f9 1e07          	ldw	x,(OFST+1,sp)
1381  03fb e602          	ld	a,(2,x)
1382  03fd 88            	push	a
1383  03fe 5c            	incw	x
1384  03ff 89            	pushw	x
1385  0400 ae0002        	ldw	x,#L122_st
1386  0403 89            	pushw	x
1387  0404 7b15          	ld	a,(OFST+15,sp)
1388  0406 88            	push	a
1389  0407 7b15          	ld	a,(OFST+15,sp)
1390  0409 88            	push	a
1391  040a 7b15          	ld	a,(OFST+15,sp)
1392  040c 88            	push	a
1393  040d 8dc106c1      	callf	f_menu_alarm_next_aux_cfg_date
1395  0411 5b0c          	addw	sp,#12
1396                     ; 219         break;
1398  0413 acc304c3      	jra	L762
1399  0417               L162:
1400                     ; 220     case 12:
1400                     ; 221         if (msg.evt == BUTTON_SHT_PRESSED || msg.evt == BUTTON_NOT_RELEASED) {
1402  0417 7b0c          	ld	a,(OFST+6,sp)
1403  0419 a101          	cp	a,#1
1404  041b 2704          	jreq	L764
1406  041d a103          	cp	a,#3
1407  041f 260c          	jrne	L564
1408  0421               L764:
1409                     ; 222             menu_digital_input_inc(&editor);
1411  0421 8deb04eb      	callf	LC006
1412  0425 8dc704c7      	callf	LC004
1413                     ; 223             menu_show_alarm_item(&editor, 1, datetime_unit_map[(st - 1) % 6]);
1414  0429 acc304c3      	jra	L762
1415  042d               L564:
1416                     ; 225         else if (msg.evt == BUTTON_LNG_PRESSED) {
1418  042d a102          	cp	a,#2
1419  042f 26f8          	jrne	L762
1420                     ; 226             st++;
1422  0431 725c0002      	inc	L122_st
1423                     ; 227             t->second = editor.val;
1425  0435 1e03          	ldw	x,(OFST-3,sp)
1426  0437 c60001        	ld	a,L522_editor+1
1427  043a e702          	ld	(2,x),a
1428                     ; 228             mark = ((*p) & 1) ? 1 : 0;
1430  043c 1e01          	ldw	x,(OFST-5,sp)
1431  043e f6            	ld	a,(x)
1432  043f a501          	bcp	a,#1
1433  0441 2704          	jreq	L641
1434  0443 a601          	ld	a,#1
1435  0445 2001          	jra	L051
1436  0447               L641:
1437  0447 4f            	clr	a
1438  0448               L051:
1439  0448 c70003        	ld	L722_mark,a
1440                     ; 229             menu_show_repeate_item(0, mark);
1442  044b 5f            	clrw	x
1443  044c               LC003:
1444  044c 97            	ld	xl,a
1445  044d 8d550755      	callf	f_menu_show_repeate_item
1447  0451 2070          	jra	L762
1448  0453               L362:
1449                     ; 232     case 13:
1449                     ; 233     case 14:
1449                     ; 234     case 15:
1449                     ; 235     case 16:
1449                     ; 236     case 17:
1449                     ; 237     case 18:
1449                     ; 238         menu_alarm_next_aux_cfg_repeate_pattern(msg, &st, st - 13, &mark, p);
1451  0453 1e01          	ldw	x,(OFST-5,sp)
1452  0455 89            	pushw	x
1453  0456 ae0003        	ldw	x,#L722_mark
1454  0459 89            	pushw	x
1455  045a c60002        	ld	a,L122_st
1456  045d a00d          	sub	a,#13
1457  045f 88            	push	a
1458  0460 ae0002        	ldw	x,#L122_st
1459  0463 89            	pushw	x
1460  0464 7b13          	ld	a,(OFST+13,sp)
1461  0466 88            	push	a
1462  0467 7b13          	ld	a,(OFST+13,sp)
1463  0469 88            	push	a
1464  046a 7b13          	ld	a,(OFST+13,sp)
1465  046c 88            	push	a
1466  046d 8d410641      	callf	f_menu_alarm_next_aux_cfg_repeate_pattern
1468  0471 5b0a          	addw	sp,#10
1469                     ; 239         break;
1471  0473 204e          	jra	L762
1472  0475               L562:
1473                     ; 240     case 19:
1473                     ; 241         if (msg.evt == BUTTON_SHT_PRESSED) {
1475  0475 7b0c          	ld	a,(OFST+6,sp)
1476  0477 a101          	cp	a,#1
1477  0479 2611          	jrne	L574
1478                     ; 242             mark = !mark;
1480  047b c60003        	ld	a,L722_mark
1481  047e 2603          	jrne	L651
1482  0480 4c            	inc	a
1483  0481 2001          	jra	L061
1484  0483               L651:
1485  0483 4f            	clr	a
1486  0484               L061:
1487  0484 c70003        	ld	L722_mark,a
1488                     ; 243             menu_show_repeate_item(6, mark);
1490  0487 ae0600        	ldw	x,#1536
1493  048a 20c0          	jpf	LC003
1494  048c               L574:
1495                     ; 245         else if (msg.evt == BUTTON_LNG_PRESSED) {
1497  048c a102          	cp	a,#2
1498  048e 2633          	jrne	L762
1499                     ; 246             st = 0;
1501  0490 725f0002      	clr	L122_st
1502                     ; 247             if (mark) *p |= (1 << 6);
1504  0494 c60003        	ld	a,L722_mark
1505  0497 2707          	jreq	L305
1508  0499 1e01          	ldw	x,(OFST-5,sp)
1509  049b f6            	ld	a,(x)
1510  049c aa40          	or	a,#64
1512  049e 2005          	jra	L505
1513  04a0               L305:
1514                     ; 248             else *p &= (~(1 << 6));
1516  04a0 1e01          	ldw	x,(OFST-5,sp)
1517  04a2 f6            	ld	a,(x)
1518  04a3 a4bf          	and	a,#191
1519  04a5               L505:
1520  04a5 f7            	ld	(x),a
1521                     ; 249             mark = false;
1523  04a6 725f0003      	clr	L722_mark
1524                     ; 250             memcpy(&cfg.alarm, &alarm, sizeof(alarm_t));
1526  04aa ae0016        	ldw	x,#22
1527  04ad 89            	pushw	x
1528  04ae ae0007        	ldw	x,#L322_alarm
1529  04b1 89            	pushw	x
1530  04b2 ae0007        	ldw	x,#_cfg+7
1531  04b5 8d000000      	callf	f_memcpy
1533  04b9 5b04          	addw	sp,#4
1534                     ; 254             alarm.mark = false;
1536  04bb 72110007      	bres	L322_alarm,#0
1537                     ; 255             return true;
1539  04bf a601          	ld	a,#1
1541  04c1 2001          	jra	L271
1542  04c3               L762:
1543                     ; 257     default:
1543                     ; 258         return false;
1546  04c3 4f            	clr	a
1548  04c4               L271:
1550  04c4 5b06          	addw	sp,#6
1551  04c6 87            	retf	
1552                     ; 260     return false;
1554  04c7               LC004:
1555  04c7 a606          	ld	a,#6
1556  04c9 8d000000      	callf	d_smodx
1558  04cd d60000        	ld	a,(L3_datetime_unit_map,x)
1559  04d0 88            	push	a
1560  04d1 4b01          	push	#1
1561  04d3 ae0000        	ldw	x,#L522_editor
1562  04d6 8d350735      	callf	f_menu_show_alarm_item
1564  04da 85            	popw	x
1565  04db 87            	retf	
1566  04dc               LC005:
1567  04dc 89            	pushw	x
1568  04dd ae0001        	ldw	x,#_cfg+1
1569  04e0 89            	pushw	x
1570  04e1 ae0008        	ldw	x,#L322_alarm+1
1571  04e4 8d000000      	callf	f_memcpy
1573  04e8 5b04          	addw	sp,#4
1574  04ea 87            	retf	
1575  04eb               LC006:
1576  04eb ae0000        	ldw	x,#L522_editor
1577  04ee 8daf07af      	callf	f_menu_digital_input_inc
1579                     ; 185             menu_show_alarm_item(&editor, 1, datetime_unit_map[(st - 1) % 6]);
1581  04f2 c60002        	ld	a,L122_st
1582  04f5 5f            	clrw	x
1583  04f6 97            	ld	xl,a
1584  04f7 5a            	decw	x
1585  04f8 87            	retf	
1587                     	switch	.data
1588  0004               L705_st:
1589  0004 00            	dc.b	0
1590  0005               L315_t:
1591  0005 00            	dc.b	0
1592  0006 00            	dc.b	0
1593  0007 00            	dc.b	0
1594                     	switch	.bss
1595  001d               L115_editor:
1596  001d 000000000000  	ds.b	7
1665                     ; 263 uint8_t menu_regressive_next(but_msg_t msg)
1665                     ; 264 {
1666                     	switch	.text
1667  04f9               f_menu_regressive_next:
1669  04f9 5204          	subw	sp,#4
1670       00000004      OFST:	set	4
1673                     ; 269     switch (st)
1675  04fb c60004        	ld	a,L705_st
1677                     ; 300     default:
1677                     ; 301         return false;
1678  04fe 271a          	jreq	L515
1679  0500 a004          	sub	a,#4
1680  0502 2604ac8a058a  	jreq	L715
1681  0508 4a            	dec	a
1682  0509 2604ac9a059a  	jreq	L125
1683  050f 4a            	dec	a
1684  0510 2604acc005c0  	jreq	L325
1685  0516 ac3e063e      	jra	L165
1686  051a               L515:
1687                     ; 271     case 0:
1687                     ; 272         t_convert_sec_to_time(cfg.rc.delay_in_sec, &t);
1689  051a ae0005        	ldw	x,#L315_t
1690  051d 89            	pushw	x
1691  051e ce0020        	ldw	x,_cfg+32
1692  0521 89            	pushw	x
1693  0522 ce001e        	ldw	x,_cfg+30
1694  0525 89            	pushw	x
1695  0526 8d000000      	callf	f_t_convert_sec_to_time
1697  052a 5b06          	addw	sp,#6
1698                     ; 273         msg.evt = BUTTON_NOT_PRESSED;
1700  052c 0f0a          	clr	(OFST+6,sp)
1701                     ; 274         Drv7SegSetDigit(&cfg.disp, 12, 3);
1703  052e 4b03          	push	#3
1704  0530 4b0c          	push	#12
1705  0532 ae0034        	ldw	x,#_cfg+52
1706  0535 8d000000      	callf	f_Drv7SegSetDigit
1708  0539 85            	popw	x
1709                     ; 275         Drv7SegSetDigit(&cfg.disp, 12, 2);
1711  053a 4b02          	push	#2
1712  053c 4b0c          	push	#12
1713  053e ae0034        	ldw	x,#_cfg+52
1714  0541 8d000000      	callf	f_Drv7SegSetDigit
1716  0545 85            	popw	x
1717                     ; 276         Drv7SegSetDigit(&cfg.disp, 27, 1);
1719  0546 4b01          	push	#1
1720  0548 4b1b          	push	#27
1721  054a ae0034        	ldw	x,#_cfg+52
1722  054d 8d000000      	callf	f_Drv7SegSetDigit
1724  0551 85            	popw	x
1725                     ; 277         Drv7SegSetDigit(&cfg.disp, 24, 0);
1727  0552 4b00          	push	#0
1728  0554 4b18          	push	#24
1729  0556 ae0034        	ldw	x,#_cfg+52
1730  0559 8d000000      	callf	f_Drv7SegSetDigit
1732  055d 85            	popw	x
1733                     ; 279         menu_digital_input_init(&editor, t.hour, 23, 0);
1735  055e 5f            	clrw	x
1736  055f 89            	pushw	x
1737  0560 ae0017        	ldw	x,#23
1738  0563 89            	pushw	x
1739  0564 5f            	clrw	x
1740  0565 c60005        	ld	a,L315_t
1741  0568 2a01          	jrpl	L212
1742  056a 53            	cplw	x
1743  056b               L212:
1744  056b 97            	ld	xl,a
1745  056c 89            	pushw	x
1746  056d ae001d        	ldw	x,#L115_editor
1747  0570 8d910791      	callf	f_menu_digital_input_init
1749  0574 5b06          	addw	sp,#6
1750                     ; 280         menu_show_alarm_item(&editor, 1, datetime_unit_map[3]);
1752  0576 4b0d          	push	#13
1753  0578 4b01          	push	#1
1754  057a ae001d        	ldw	x,#L115_editor
1755  057d 8d350735      	callf	f_menu_show_alarm_item
1757  0581 c60004        	ld	a,L705_st
1758  0584 ab04          	add	a,#4
1759  0586 c70004        	ld	L705_st,a
1760  0589 85            	popw	x
1761                     ; 281         st += 4;
1763  058a               L715:
1764                     ; 282     case 4:
1764                     ; 283         menu_alarm_next_aux_cfg_date(msg, &st, &t.hour, t.minute, &editor, 59, 0);
1766  058a 4b00          	push	#0
1767  058c 4b3b          	push	#59
1768  058e ae001d        	ldw	x,#L115_editor
1769  0591 89            	pushw	x
1770  0592 3b0006        	push	L315_t+1
1771  0595 ae0005        	ldw	x,#L315_t
1773                     ; 284         break;
1775  0598 200e          	jpf	LC008
1776  059a               L125:
1777                     ; 285     case 5:
1777                     ; 286         menu_alarm_next_aux_cfg_date(msg, &st, &t.minute, t.second, &editor, 59, 0);
1779  059a 4b00          	push	#0
1780  059c 4b3b          	push	#59
1781  059e ae001d        	ldw	x,#L115_editor
1782  05a1 89            	pushw	x
1783  05a2 3b0007        	push	L315_t+2
1784  05a5 ae0006        	ldw	x,#L315_t+1
1786  05a8               LC008:
1787  05a8 89            	pushw	x
1788  05a9 ae0004        	ldw	x,#L705_st
1789  05ac 89            	pushw	x
1790  05ad 7b13          	ld	a,(OFST+15,sp)
1791  05af 88            	push	a
1792  05b0 7b13          	ld	a,(OFST+15,sp)
1793  05b2 88            	push	a
1794  05b3 7b13          	ld	a,(OFST+15,sp)
1795  05b5 88            	push	a
1796  05b6 8dc106c1      	callf	f_menu_alarm_next_aux_cfg_date
1797  05ba 5b0c          	addw	sp,#12
1798                     ; 287         break;
1800  05bc ac3e063e      	jra	L165
1801  05c0               L325:
1802                     ; 288     case 6:
1802                     ; 289         if (msg.evt == BUTTON_SHT_PRESSED || msg.evt == BUTTON_NOT_RELEASED) {
1804  05c0 7b0a          	ld	a,(OFST+6,sp)
1805  05c2 a101          	cp	a,#1
1806  05c4 2704          	jreq	L565
1808  05c6 a103          	cp	a,#3
1809  05c8 2623          	jrne	L365
1810  05ca               L565:
1811                     ; 290             menu_digital_input_inc(&editor);
1813  05ca ae001d        	ldw	x,#L115_editor
1814  05cd 8daf07af      	callf	f_menu_digital_input_inc
1816                     ; 291             menu_show_alarm_item(&editor, 1, datetime_unit_map[(st - 1) % 6]);
1818  05d1 c60004        	ld	a,L705_st
1819  05d4 5f            	clrw	x
1820  05d5 97            	ld	xl,a
1821  05d6 5a            	decw	x
1822  05d7 a606          	ld	a,#6
1823  05d9 8d000000      	callf	d_smodx
1825  05dd d60000        	ld	a,(L3_datetime_unit_map,x)
1826  05e0 88            	push	a
1827  05e1 4b01          	push	#1
1828  05e3 ae001d        	ldw	x,#L115_editor
1829  05e6 8d350735      	callf	f_menu_show_alarm_item
1831  05ea 85            	popw	x
1833                     ; 300     default:
1833                     ; 301         return false;
1835  05eb 2051          	jpf	L165
1836  05ed               L365:
1837                     ; 293         else if (msg.evt == BUTTON_LNG_PRESSED) {
1839  05ed a102          	cp	a,#2
1840  05ef 264d          	jrne	L165
1841                     ; 294             t.second = editor.val;
1843  05f1 55001e0007    	mov	L315_t+2,L115_editor+1
1844                     ; 295             cfg.rc.delay_in_sec = t.hour * 3600 + t.minute * 60 + t.second;
1846  05f6 5f            	clrw	x
1847  05f7 c60007        	ld	a,L315_t+2
1848  05fa 2a01          	jrpl	L622
1849  05fc 53            	cplw	x
1850  05fd               L622:
1851  05fd 97            	ld	xl,a
1852  05fe 1f03          	ldw	(OFST-1,sp),x
1854  0600 5f            	clrw	x
1855  0601 c60006        	ld	a,L315_t+1
1856  0604 2a01          	jrpl	L032
1857  0606 53            	cplw	x
1858  0607               L032:
1859  0607 97            	ld	xl,a
1860  0608 a63c          	ld	a,#60
1861  060a 8d000000      	callf	d_bmulx
1863  060e 1f01          	ldw	(OFST-3,sp),x
1865  0610 5f            	clrw	x
1866  0611 c60005        	ld	a,L315_t
1867  0614 2a01          	jrpl	L232
1868  0616 53            	cplw	x
1869  0617               L232:
1870  0617 97            	ld	xl,a
1871  0618 90ae0e10      	ldw	y,#3600
1872  061c 8d000000      	callf	d_imul
1874  0620 72fb01        	addw	x,(OFST-3,sp)
1875  0623 72fb03        	addw	x,(OFST-1,sp)
1876  0626 8d000000      	callf	d_itolx
1878  062a ae001e        	ldw	x,#_cfg+30
1879  062d 8d000000      	callf	d_rtol
1881                     ; 296             cfg.rc.mode = INITIAL;
1883  0631 725f001d      	clr	_cfg+29
1884                     ; 297             st = 0;
1886  0635 725f0004      	clr	L705_st
1887                     ; 298             return true;
1889  0639 a601          	ld	a,#1
1891  063b               L432:
1893  063b 5b04          	addw	sp,#4
1894  063d 87            	retf	
1895  063e               L165:
1896                     ; 303     return false;
1899  063e 4f            	clr	a
1901  063f 20fa          	jra	L432
1975                     ; 307 void menu_alarm_next_aux_cfg_repeate_pattern(but_msg_t msg, uint8_t* pst, uint8_t id, uint8_t* pmark, uint8_t* ppattern)
1975                     ; 308 {
1976                     	switch	.text
1977  0641               f_menu_alarm_next_aux_cfg_repeate_pattern:
1979  0641 89            	pushw	x
1980       00000002      OFST:	set	2
1983                     ; 309     if (msg.evt == BUTTON_SHT_PRESSED) {
1985  0642 7b08          	ld	a,(OFST+6,sp)
1986  0644 a101          	cp	a,#1
1987  0646 2614          	jrne	L726
1988                     ; 310         *pmark = !*pmark;
1990  0648 1e0c          	ldw	x,(OFST+10,sp)
1991  064a f6            	ld	a,(x)
1992  064b 2603          	jrne	L042
1993  064d 4c            	inc	a
1994  064e 2001          	jra	L242
1995  0650               L042:
1996  0650 4f            	clr	a
1997  0651               L242:
1998  0651 f7            	ld	(x),a
1999                     ; 311         menu_show_repeate_item(id, *pmark);
2001  0652 97            	ld	xl,a
2002  0653 7b0b          	ld	a,(OFST+9,sp)
2003  0655 95            	ld	xh,a
2004  0656 8d550755      	callf	f_menu_show_repeate_item
2007  065a 2063          	jra	L136
2008  065c               L726:
2009                     ; 313     else if (msg.evt == BUTTON_LNG_PRESSED) {
2011  065c a102          	cp	a,#2
2012  065e 265f          	jrne	L136
2013                     ; 314         if (*pmark) *ppattern |= (1 << id);
2015  0660 1e0c          	ldw	x,(OFST+10,sp)
2016  0662 f6            	ld	a,(x)
2017  0663 2716          	jreq	L536
2020  0665 1e0e          	ldw	x,(OFST+12,sp)
2021  0667 7b0b          	ld	a,(OFST+9,sp)
2022  0669 905f          	clrw	y
2023  066b 9097          	ld	yl,a
2024  066d a601          	ld	a,#1
2025  066f 905d          	tnzw	y
2026  0671 2705          	jreq	L642
2027  0673               L052:
2028  0673 48            	sll	a
2029  0674 905a          	decw	y
2030  0676 26fb          	jrne	L052
2031  0678               L642:
2032  0678 fa            	or	a,(x)
2034  0679 2015          	jra	L736
2035  067b               L536:
2036                     ; 315         else *ppattern &= (~(1 << id));
2038  067b 1e0e          	ldw	x,(OFST+12,sp)
2039  067d 7b0b          	ld	a,(OFST+9,sp)
2040  067f 905f          	clrw	y
2041  0681 9097          	ld	yl,a
2042  0683 a601          	ld	a,#1
2043  0685 905d          	tnzw	y
2044  0687 2705          	jreq	L252
2045  0689               L452:
2046  0689 48            	sll	a
2047  068a 905a          	decw	y
2048  068c 26fb          	jrne	L452
2049  068e               L252:
2050  068e 43            	cpl	a
2051  068f f4            	and	a,(x)
2052  0690               L736:
2053  0690 f7            	ld	(x),a
2054                     ; 316         *pmark = (*ppattern & (1 << (id + 1))) ? 1 : 0;
2056  0691 5f            	clrw	x
2057  0692 97            	ld	xl,a
2058  0693 1f01          	ldw	(OFST-1,sp),x
2060  0695 ae0001        	ldw	x,#1
2061  0698 7b0b          	ld	a,(OFST+9,sp)
2062  069a 4c            	inc	a
2063  069b 2704          	jreq	L062
2064  069d               L262:
2065  069d 58            	sllw	x
2066  069e 4a            	dec	a
2067  069f 26fc          	jrne	L262
2068  06a1               L062:
2069  06a1 01            	rrwa	x,a
2070  06a2 1402          	and	a,(OFST+0,sp)
2071  06a4 01            	rrwa	x,a
2072  06a5 1401          	and	a,(OFST-1,sp)
2073  06a7 01            	rrwa	x,a
2074  06a8 5d            	tnzw	x
2075  06a9 2704          	jreq	L652
2076  06ab a601          	ld	a,#1
2077  06ad 2001          	jra	L462
2078  06af               L652:
2079  06af 4f            	clr	a
2080  06b0               L462:
2081  06b0 1e0c          	ldw	x,(OFST+10,sp)
2082  06b2 f7            	ld	(x),a
2083                     ; 317         menu_show_repeate_item(id + 1, *pmark);
2085  06b3 97            	ld	xl,a
2086  06b4 7b0b          	ld	a,(OFST+9,sp)
2087  06b6 4c            	inc	a
2088  06b7 95            	ld	xh,a
2089  06b8 8d550755      	callf	f_menu_show_repeate_item
2091                     ; 318         (*pst)++;
2093  06bc 1e09          	ldw	x,(OFST+7,sp)
2094  06be 7c            	inc	(x)
2095  06bf               L136:
2096                     ; 320 }
2099  06bf 85            	popw	x
2100  06c0 87            	retf	
2192                     ; 323 void menu_alarm_next_aux_cfg_date(but_msg_t msg,
2192                     ; 324     uint8_t* pst,
2192                     ; 325     int8_t* pval,
2192                     ; 326     int8_t val,
2192                     ; 327     menu_digital_input_t* ed,
2192                     ; 328     int8_t max,
2192                     ; 329     int8_t min)
2192                     ; 330 {
2193                     	switch	.text
2194  06c1               f_menu_alarm_next_aux_cfg_date:
2196       00000000      OFST:	set	0
2199                     ; 331     if (msg.evt == BUTTON_SHT_PRESSED || msg.evt == BUTTON_NOT_RELEASED) {
2201  06c1 7b06          	ld	a,(OFST+6,sp)
2202  06c3 a101          	cp	a,#1
2203  06c5 2704          	jreq	L507
2205  06c7 a103          	cp	a,#3
2206  06c9 2620          	jrne	L307
2207  06cb               L507:
2208                     ; 332         menu_digital_input_inc(ed);
2210  06cb 1e0c          	ldw	x,(OFST+12,sp)
2211  06cd 8daf07af      	callf	f_menu_digital_input_inc
2213                     ; 333         menu_show_alarm_item(ed, 1, datetime_unit_map[(*pst - 1) % 6]);
2215  06d1 1e07          	ldw	x,(OFST+7,sp)
2216  06d3 f6            	ld	a,(x)
2217  06d4 5f            	clrw	x
2218  06d5 97            	ld	xl,a
2219  06d6 5a            	decw	x
2220  06d7 a606          	ld	a,#6
2221  06d9 8d000000      	callf	d_smodx
2223  06dd d60000        	ld	a,(L3_datetime_unit_map,x)
2224  06e0 88            	push	a
2225  06e1 4b01          	push	#1
2226  06e3 1e0e          	ldw	x,(OFST+14,sp)
2227  06e5 8d350735      	callf	f_menu_show_alarm_item
2229  06e9 85            	popw	x
2231  06ea               L707:
2232                     ; 341 }
2235  06ea 87            	retf	
2236  06eb               L307:
2237                     ; 335     else if (msg.evt == BUTTON_LNG_PRESSED) {
2239  06eb a102          	cp	a,#2
2240  06ed 26fb          	jrne	L707
2241                     ; 336         *pval = ed->val;
2243  06ef 1e0c          	ldw	x,(OFST+12,sp)
2244  06f1 e601          	ld	a,(1,x)
2245  06f3 1e09          	ldw	x,(OFST+9,sp)
2246  06f5 f7            	ld	(x),a
2247                     ; 337         menu_digital_input_init(ed, val, max, min);
2249  06f6 5f            	clrw	x
2250  06f7 7b0f          	ld	a,(OFST+15,sp)
2251  06f9 4d            	tnz	a
2252  06fa 2a01          	jrpl	L003
2253  06fc 53            	cplw	x
2254  06fd               L003:
2255  06fd 97            	ld	xl,a
2256  06fe 89            	pushw	x
2257  06ff 7b10          	ld	a,(OFST+16,sp)
2258  0701 5f            	clrw	x
2259  0702 4d            	tnz	a
2260  0703 2a01          	jrpl	L203
2261  0705 53            	cplw	x
2262  0706               L203:
2263  0706 97            	ld	xl,a
2264  0707 89            	pushw	x
2265  0708 7b0f          	ld	a,(OFST+15,sp)
2266  070a 5f            	clrw	x
2267  070b 4d            	tnz	a
2268  070c 2a01          	jrpl	L403
2269  070e 53            	cplw	x
2270  070f               L403:
2271  070f 97            	ld	xl,a
2272  0710 89            	pushw	x
2273  0711 1e12          	ldw	x,(OFST+18,sp)
2274  0713 8d910791      	callf	f_menu_digital_input_init
2276  0717 5b06          	addw	sp,#6
2277                     ; 338         menu_show_alarm_item(ed, 1, datetime_unit_map[*pst % 6]);
2279  0719 1e07          	ldw	x,(OFST+7,sp)
2280  071b f6            	ld	a,(x)
2281  071c 5f            	clrw	x
2282  071d 97            	ld	xl,a
2283  071e a606          	ld	a,#6
2284  0720 8d000000      	callf	d_smodx
2286  0724 d60000        	ld	a,(L3_datetime_unit_map,x)
2287  0727 88            	push	a
2288  0728 4b01          	push	#1
2289  072a 1e0e          	ldw	x,(OFST+14,sp)
2290  072c 8d350735      	callf	f_menu_show_alarm_item
2292  0730 85            	popw	x
2293                     ; 339         (*pst)++;
2295  0731 1e07          	ldw	x,(OFST+7,sp)
2296  0733 7c            	inc	(x)
2298  0734 87            	retf	
2345                     ; 343 void menu_show_alarm_item(menu_digital_input_t* ed, uint8_t idx, uint8_t unit)
2345                     ; 344 {
2346                     	switch	.text
2347  0735               f_menu_show_alarm_item:
2349  0735 89            	pushw	x
2350       00000000      OFST:	set	0
2353                     ; 345     menu_show_digital_input(ed);
2355  0736 8dce07ce      	callf	f_menu_show_digital_input
2357                     ; 346     Drv7SegSetDigit(&cfg.disp, unit, 0);
2359  073a 4b00          	push	#0
2360  073c 7b08          	ld	a,(OFST+8,sp)
2361  073e 88            	push	a
2362  073f ae0034        	ldw	x,#_cfg+52
2363  0742 8d000000      	callf	f_Drv7SegSetDigit
2365  0746 85            	popw	x
2366                     ; 347     Drv7SegSetDigit(&cfg.disp, 11, 1);
2368  0747 4b01          	push	#1
2369  0749 4b0b          	push	#11
2370  074b ae0034        	ldw	x,#_cfg+52
2371  074e 8d000000      	callf	f_Drv7SegSetDigit
2373                     ; 348 }
2376  0752 5b04          	addw	sp,#4
2377  0754 87            	retf	
2418                     ; 350 void menu_show_repeate_item(uint8_t day, uint8_t ismarked)
2418                     ; 351 {
2419                     	switch	.text
2420  0755               f_menu_show_repeate_item:
2422  0755 89            	pushw	x
2423       00000000      OFST:	set	0
2426                     ; 352     Drv7SegSetDigit(&cfg.disp, day, 2);
2428  0756 4b02          	push	#2
2429  0758 9e            	ld	a,xh
2430  0759 88            	push	a
2431  075a ae0034        	ldw	x,#_cfg+52
2432  075d 8d000000      	callf	f_Drv7SegSetDigit
2434  0761 85            	popw	x
2435                     ; 353     Drv7SegSetDigit(&cfg.disp, 18, 0);
2437  0762 4b00          	push	#0
2438  0764 4b12          	push	#18
2439  0766 ae0034        	ldw	x,#_cfg+52
2440  0769 8d000000      	callf	f_Drv7SegSetDigit
2442  076d 85            	popw	x
2443                     ; 354     Drv7SegSetDigit(&cfg.disp, 11, 1);
2445  076e 4b01          	push	#1
2446  0770 4b0b          	push	#11
2447  0772 ae0034        	ldw	x,#_cfg+52
2448  0775 8d000000      	callf	f_Drv7SegSetDigit
2450  0779 85            	popw	x
2451                     ; 355     Drv7SegSetDigit(&cfg.disp, ismarked ? 17 : 15, 3);
2453  077a 4b03          	push	#3
2454  077c 7b03          	ld	a,(OFST+3,sp)
2455  077e 2704          	jreq	L233
2456  0780 a611          	ld	a,#17
2457  0782 2002          	jra	L433
2458  0784               L233:
2459  0784 a60f          	ld	a,#15
2460  0786               L433:
2461  0786 88            	push	a
2462  0787 ae0034        	ldw	x,#_cfg+52
2463  078a 8d000000      	callf	f_Drv7SegSetDigit
2465                     ; 356 }
2468  078e 5b04          	addw	sp,#4
2469  0790 87            	retf	
2527                     ; 358 void menu_digital_input_init(menu_digital_input_t* t, uint16_t def_val, uint16_t max, uint16_t min)
2527                     ; 359 {
2528                     	switch	.text
2529  0791               f_menu_digital_input_init:
2531  0791 89            	pushw	x
2532       00000000      OFST:	set	0
2535                     ; 360     t->val = def_val;
2537  0792 1606          	ldw	y,(OFST+6,sp)
2538  0794 ff            	ldw	(x),y
2539                     ; 361     if (max < min) { max = min; };
2541  0795 1e08          	ldw	x,(OFST+8,sp)
2542  0797 130a          	cpw	x,(OFST+10,sp)
2543  0799 2404          	jruge	L1001
2546  079b 1e0a          	ldw	x,(OFST+10,sp)
2547  079d 1f08          	ldw	(OFST+8,sp),x
2548  079f               L1001:
2549                     ; 362     t->maxval = max;
2552  079f 1e01          	ldw	x,(OFST+1,sp)
2553  07a1 1608          	ldw	y,(OFST+8,sp)
2554  07a3 ef02          	ldw	(2,x),y
2555                     ; 363     t->minval = min;
2557  07a5 160a          	ldw	y,(OFST+10,sp)
2558  07a7 ef04          	ldw	(4,x),y
2559                     ; 364     t->step = 1;
2561  07a9 a601          	ld	a,#1
2562  07ab e706          	ld	(6,x),a
2563                     ; 365 }
2566  07ad 85            	popw	x
2567  07ae 87            	retf	
2604                     ; 367 void menu_digital_input_inc(menu_digital_input_t* t)
2604                     ; 368 {
2605                     	switch	.text
2606  07af               f_menu_digital_input_inc:
2608       00000000      OFST:	set	0
2611                     ; 369     t->val += t->step;
2613  07af 9093          	ldw	y,x
2614  07b1 89            	pushw	x
2615  07b2 90e606        	ld	a,(6,y)
2616  07b5 eb01          	add	a,(1,x)
2617  07b7 e701          	ld	(1,x),a
2618  07b9 2401          	jrnc	L243
2619  07bb 7c            	inc	(x)
2620  07bc               L243:
2621                     ; 370     if (t->val > t->maxval) {
2623  07bc 9093          	ldw	y,x
2624  07be fe            	ldw	x,(x)
2625  07bf 90e302        	cpw	x,(2,y)
2626  07c2 2308          	jrule	L3201
2627                     ; 372         t->val = t->minval;
2629  07c4 1e01          	ldw	x,(OFST+1,sp)
2630  07c6 9093          	ldw	y,x
2631  07c8 90ee04        	ldw	y,(4,y)
2632  07cb ff            	ldw	(x),y
2633  07cc               L3201:
2634                     ; 374 }
2637  07cc 85            	popw	x
2638  07cd 87            	retf	
2677                     ; 376 void menu_show_digital_input(menu_digital_input_t* t)
2677                     ; 377 {
2678                     	switch	.text
2679  07ce               f_menu_show_digital_input:
2683                     ; 378     Drv7SegSetNum(&cfg.disp, t->val);
2685  07ce fe            	ldw	x,(x)
2686  07cf 89            	pushw	x
2687  07d0 ae0034        	ldw	x,#_cfg+52
2688  07d3 8d000000      	callf	f_Drv7SegSetNum
2690  07d7 85            	popw	x
2691                     ; 379 }
2694  07d8 87            	retf	
2718                     	xref	_cfg
2719                     	xdef	f_menu_regressive_next
2720                     	xdef	f_menu_show_digital_input
2721                     	xdef	f_menu_digital_input_inc
2722                     	xdef	f_menu_digital_input_init
2723                     	xdef	f_menu_show_repeate_item
2724                     	xdef	f_menu_show_alarm_item
2725                     	xdef	f_menu_alarm_next_aux_cfg_date
2726                     	xdef	f_menu_alarm_next_aux_cfg_repeate_pattern
2727                     	xdef	f_menu_alarm_next
2728                     	xdef	f_menu_select_sm_next
2729                     	xdef	f_menu_show
2730                     	xdef	f_menu_init
2731                     	xref	f_t_convert_sec_to_time
2732                     	xref	f_t_last_day_of_month
2733                     	xref	f_Drv7SegSetNum
2734                     	xref	f_Drv7SegSetDigit
2735                     	xref	f_memcpy
2736                     	xref.b	c_x
2755                     	xref	d_rtol
2756                     	xref	d_itolx
2757                     	xref	d_bmulx
2758                     	xref	d_bmuly
2759                     	xref	d_imul
2760                     	xref	d_jctab
2761                     	xref	d_smodx
2762                     	end
