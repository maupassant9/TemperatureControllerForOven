   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.13.3 - 22 May 2025
   3                     ; Generator (Limited) V4.6.6 - 07 Jan 2026
   4                     ; Optimizer V4.6.6 - 07 Jan 2026
  19                     .const:	section	.text
  20  0000               _codes_number:
  21  0000 03            	dc.b	3
  22  0001 9f            	dc.b	159
  23  0002 25            	dc.b	37
  24  0003 0d            	dc.b	13
  25  0004 99            	dc.b	153
  26  0005 49            	dc.b	73
  27  0006 41            	dc.b	65
  28  0007 1f            	dc.b	31
  29  0008 01            	dc.b	1
  30  0009 09            	dc.b	9
  31  000a fe            	dc.b	254
  32  000b fd            	dc.b	253
  33  000c ff            	dc.b	255
  34  000d d1            	dc.b	209
  35  000e 39            	dc.b	57
  36  000f d5            	dc.b	213
  37  0010 91            	dc.b	145
  38  0011 89            	dc.b	137
  39  0012 31            	dc.b	49
  40  0013 85            	dc.b	133
  41  0014 bf            	dc.b	191
  42  0015 bb            	dc.b	187
  43  0016 63            	dc.b	99
  44  0017 83            	dc.b	131
  45  0018 73            	dc.b	115
  46  0019 11            	dc.b	17
  47  001a e3            	dc.b	227
  48  001b 61            	dc.b	97
  49                     	switch	.data
  50  0000               _regNum:
  51  0000 00000000      	dc.l	0
  52  0004               L7_data:
  53  0004 ff            	dc.b	255
  54  0005 000000        	ds.b	3
  55  0008               L11_lock:
  56  0008 00            	dc.b	0
 118                     ; 138 void Drv7SegInit(hc595_handle_t *handle){
 119                     	switch	.text
 120  0000               f_Drv7SegInit:
 124                     ; 139     DrvHc595Init(handle);
 126  0000 8d000000      	callf	f_DrvHc595Init
 128                     ; 140     Drv7SegCtrInit();
 131                     ; 141 }
 134  0004 acd500d5      	jpf	L3f_Drv7SegCtrInit
 186                     ; 155 void Drv7SegSetDigit(hc595_handle_t *handle, 
 186                     ; 156 									uint8_t digit,
 186                     ; 157 									uint8_t devId){
 187                     	switch	.text
 188  0008               f_Drv7SegSetDigit:
 190       fffffffe      OFST: set -2
 193                     ; 158 		data[devId] = codes_number[digit];
 195  0008 7b05          	ld	a,(OFST+7,sp)
 196  000a 5f            	clrw	x
 197  000b 97            	ld	xl,a
 198  000c 7b04          	ld	a,(OFST+6,sp)
 199  000e 905f          	clrw	y
 200  0010 9097          	ld	yl,a
 201  0012 90d60000      	ld	a,(_codes_number,y)
 202  0016 d70004        	ld	(L7_data,x),a
 203                     ; 159 }
 206  0019 87            	retf	
 257                     ; 161 void Drv7SegSetRawCode(hc595_handle_t *handle, 
 257                     ; 162 									uint8_t code,
 257                     ; 163 									uint8_t devId){
 258                     	switch	.text
 259  001a               f_Drv7SegSetRawCode:
 261       fffffffe      OFST: set -2
 264                     ; 164 		data[devId] = code;
 266  001a 7b05          	ld	a,(OFST+7,sp)
 267  001c 5f            	clrw	x
 268  001d 97            	ld	xl,a
 269  001e 7b04          	ld	a,(OFST+6,sp)
 270  0020 d70004        	ld	(L7_data,x),a
 271                     ; 165 }
 274  0023 87            	retf	
 319                     ; 167 void Drv7SegSetDp(hc595_handle_t *handle,
 319                     ; 168 									uint8_t devId){
 320                     	switch	.text
 321  0024               f_Drv7SegSetDp:
 323       fffffffe      OFST: set -2
 326                     ; 170 		data[devId] = (uint8_t)(data[devId]&((uint8_t)codes_number[10]));
 328  0024 7b04          	ld	a,(OFST+6,sp)
 329  0026 5f            	clrw	x
 330  0027 97            	ld	xl,a
 331  0028 d60004        	ld	a,(L7_data,x)
 332  002b a4fe          	and	a,#254
 333  002d d70004        	ld	(L7_data,x),a
 334                     ; 171 }
 337  0030 87            	retf	
 402                     ; 174 void Drv7SegSetNum(hc595_handle_t * handle, int16_t num)
 402                     ; 175 {
 403                     	switch	.text
 404  0031               f_Drv7SegSetNum:
 406  0031 89            	pushw	x
 407  0032 5204          	subw	sp,#4
 408       00000004      OFST:	set	4
 411                     ; 176 	uint8_t residual, id = 0;
 413  0034 0f02          	clr	(OFST-2,sp)
 415                     ; 177   uint16_t divider = 1000;
 417  0036 ae03e8        	ldw	x,#1000
 418  0039 1f03          	ldw	(OFST-1,sp),x
 420                     ; 179 	if(num < 0) {
 422  003b 1e0a          	ldw	x,(OFST+6,sp)
 423  003d 2a45          	jrpl	L102
 424                     ; 180 		id = 1;
 426  003f a601          	ld	a,#1
 427  0041 6b02          	ld	(OFST-2,sp),a
 429                     ; 181 		num = (-1*num);
 431  0043 50            	negw	x
 432  0044 1f0a          	ldw	(OFST+6,sp),x
 433                     ; 182     divider = divider / 10;
 435  0046 ae0064        	ldw	x,#100
 436  0049 1f03          	ldw	(OFST-1,sp),x
 438                     ; 183     Drv7SegSetDigit(handle, 11, 0);
 440  004b 4b00          	push	#0
 441  004d 4b0b          	push	#11
 442  004f 1e07          	ldw	x,(OFST+3,sp)
 443  0051 8d080008      	callf	f_Drv7SegSetDigit
 445  0055 85            	popw	x
 446  0056 202c          	jra	L102
 447  0058               L571:
 448                     ; 187 		residual = (num/divider);
 450  0058 1e0a          	ldw	x,(OFST+6,sp)
 451  005a 1603          	ldw	y,(OFST-1,sp)
 452  005c 65            	divw	x,y
 453  005d 01            	rrwa	x,a
 454  005e 6b01          	ld	(OFST-3,sp),a
 456                     ; 188 		Drv7SegSetDigit(handle, residual, id);
 458  0060 7b02          	ld	a,(OFST-2,sp)
 459  0062 88            	push	a
 460  0063 7b02          	ld	a,(OFST-2,sp)
 461  0065 88            	push	a
 462  0066 1e07          	ldw	x,(OFST+3,sp)
 463  0068 8d080008      	callf	f_Drv7SegSetDigit
 465  006c 85            	popw	x
 466                     ; 189 		num -= (divider*residual);
 468  006d 1e03          	ldw	x,(OFST-1,sp)
 469  006f 7b01          	ld	a,(OFST-3,sp)
 470  0071 8d000000      	callf	d_bmulx
 472  0075 72f00a        	subw	x,(OFST+6,sp)
 473  0078 50            	negw	x
 474  0079 1f0a          	ldw	(OFST+6,sp),x
 475                     ; 190 		divider = (divider/10);
 477  007b a60a          	ld	a,#10
 478  007d 1e03          	ldw	x,(OFST-1,sp)
 479  007f 62            	div	x,a
 480  0080 1f03          	ldw	(OFST-1,sp),x
 482                     ; 185 	for(; id < DISP_DIGITAL_NO; id++)
 484  0082 0c02          	inc	(OFST-2,sp)
 486  0084               L102:
 489  0084 7b02          	ld	a,(OFST-2,sp)
 490  0086 a104          	cp	a,#4
 491  0088 25ce          	jrult	L571
 492                     ; 192 }
 495  008a 5b06          	addw	sp,#6
 496  008c 87            	retf	
 543                     ; 194 void Drv7SegShow(hc595_handle_t * handle,
 543                     ; 195 									uint8_t devId){
 544                     	switch	.text
 545  008d               f_Drv7SegShow:
 547  008d 89            	pushw	x
 548       00000000      OFST:	set	0
 551                     ; 196     Drv7SegCtrClearAll();
 553  008e 8d3a013a      	callf	L5f_Drv7SegCtrClearAll
 555                     ; 197     DrvHc595Write(handle, &data[devId]);
 557  0092 7b06          	ld	a,(OFST+6,sp)
 558  0094 5f            	clrw	x
 559  0095 97            	ld	xl,a
 560  0096 1c0004        	addw	x,#L7_data
 561  0099 89            	pushw	x
 562  009a 1e03          	ldw	x,(OFST+3,sp)
 563  009c 8d000000      	callf	f_DrvHc595Write
 565  00a0 85            	popw	x
 566                     ; 198     Drv7SegCtrSet(devId, TRUE);
 568  00a1 7b06          	ld	a,(OFST+6,sp)
 569  00a3 ae0001        	ldw	x,#1
 570  00a6 95            	ld	xh,a
 571  00a7 8df200f2      	callf	f_Drv7SegCtrSet
 573                     ; 199 }
 576  00ab 85            	popw	x
 577  00ac 87            	retf	
 610                     ; 201 uint8_t Drv7SegGetDisplayCode(uint8_t devId)
 610                     ; 202 {
 611                     	switch	.text
 612  00ad               f_Drv7SegGetDisplayCode:
 616                     ; 203   return data[devId];
 618  00ad 5f            	clrw	x
 619  00ae 97            	ld	xl,a
 620  00af d60004        	ld	a,(L7_data,x)
 623  00b2 87            	retf	
 668                     ; 215 void Drv7SegClear(hc595_handle_t *handle, uint8_t devId){
 669                     	switch	.text
 670  00b3               f_Drv7SegClear:
 672       fffffffe      OFST: set -2
 675                     ; 217 	data[devId] = codes_number[12];
 677  00b3 7b04          	ld	a,(OFST+6,sp)
 678  00b5 5f            	clrw	x
 679  00b6 97            	ld	xl,a
 680  00b7 a6ff          	ld	a,#255
 681  00b9 d70004        	ld	(L7_data,x),a
 682                     ; 218 }
 685  00bc 87            	retf	
 729                     ; 220 void Drv7SegClearAll(hc595_handle_t *handle)
 729                     ; 221 {
 730                     	switch	.text
 731  00bd               f_Drv7SegClearAll:
 733  00bd 89            	pushw	x
 734  00be 88            	push	a
 735       00000001      OFST:	set	1
 738                     ; 222     uint8_t i = 0;
 740                     ; 223     for(i = 0; i < DISP_DIGITAL_NO; i++) Drv7SegClear(handle, i);
 742  00bf 4f            	clr	a
 743  00c0 6b01          	ld	(OFST+0,sp),a
 745  00c2               L703:
 748  00c2 88            	push	a
 749  00c3 1e03          	ldw	x,(OFST+2,sp)
 750  00c5 8db300b3      	callf	f_Drv7SegClear
 752  00c9 84            	pop	a
 755  00ca 0c01          	inc	(OFST+0,sp)
 759  00cc 7b01          	ld	a,(OFST+0,sp)
 760  00ce a104          	cp	a,#4
 761  00d0 25f0          	jrult	L703
 762                     ; 224 }
 765  00d2 5b03          	addw	sp,#3
 766  00d4 87            	retf	
 788                     ; 226 static void Drv7SegCtrInit()
 788                     ; 227 {
 789                     	switch	.text
 790  00d5               L3f_Drv7SegCtrInit:
 794                     ; 228     DIG1_PORT->ODR &= ~DIG1_PIN;
 796  00d5 8de100e1      	callf	LC001
 797                     ; 233     DIG1_PORT->ODR &= ~DIG1_PIN;
 799  00d9 8de100e1      	callf	LC001
 800                     ; 238     DIG1_PORT->ODR &= ~DIG1_PIN;
 802  00dd 8de100e1      	callf	LC001
 803                     ; 243     DIG1_PORT->ODR &= ~DIG1_PIN;
 805                     ; 247 }
 808  00e1               LC001:
 809  00e1 721b500a      	bres	20490,#5
 810                     ; 229     DIG1_PORT->DDR |= DIG1_PIN;
 812  00e5 721a500c      	bset	20492,#5
 813                     ; 230     DIG1_PORT->CR1 |= DIG1_PIN;
 815  00e9 721a500d      	bset	20493,#5
 816                     ; 231     DIG1_PORT->CR2 |= DIG1_PIN;
 818  00ed 721a500e      	bset	20494,#5
 819  00f1 87            	retf	
1014                     ; 249 void Drv7SegCtrSet(uint8_t pinNum, uint8_t is_on)
1014                     ; 250 {
1015                     	switch	.text
1016  00f2               f_Drv7SegCtrSet:
1018  00f2 89            	pushw	x
1019  00f3 5203          	subw	sp,#3
1020       00000003      OFST:	set	3
1023                     ; 251     GPIO_Pin_TypeDef pinNo = -1;
1025  00f5 a6ff          	ld	a,#255
1026  00f7 6b03          	ld	(OFST+0,sp),a
1028                     ; 253     switch(pinNum)
1030  00f9 9e            	ld	a,xh
1032                     ; 271         default:
1032                     ; 272             break;
1033  00fa 4d            	tnz	a
1034  00fb 270b          	jreq	L523
1035  00fd 4a            	dec	a
1036  00fe 270c          	jreq	L723
1037  0100 4a            	dec	a
1038  0101 2712          	jreq	L133
1039  0103 4a            	dec	a
1040  0104 2713          	jreq	L333
1041  0106 201a          	jra	L354
1042  0108               L523:
1043                     ; 255         case 0: 
1043                     ; 256             pinNo = DIG1_PIN;
1045  0108 a620          	ld	a,#32
1046                     ; 257             pinPort = DIG1_PORT;
1047                     ; 258             break;
1049  010a 2002          	jpf	LC003
1050  010c               L723:
1051                     ; 259         case 1:
1051                     ; 260             pinNo = DIG2_PIN;
1053  010c a640          	ld	a,#64
1054                     ; 261             pinPort = DIG2_PORT;
1056  010e               LC003:
1057  010e 6b03          	ld	(OFST+0,sp),a
1061  0110 ae500a        	ldw	x,#20490
1062                     ; 262             break;
1064  0113 200b          	jpf	LC002
1065  0115               L133:
1066                     ; 263         case 2:
1066                     ; 264             pinNo = DIG3_PIN;
1068  0115 a680          	ld	a,#128
1069                     ; 265             pinPort = DIG3_PORT;
1070                     ; 266             break;
1072  0117 20f5          	jpf	LC003
1073  0119               L333:
1074                     ; 267         case 3:
1074                     ; 268             pinNo = DIG4_PIN;
1076  0119 a608          	ld	a,#8
1077  011b 6b03          	ld	(OFST+0,sp),a
1079                     ; 269             pinPort = DIG4_PORT;
1081  011d ae5000        	ldw	x,#20480
1082  0120               LC002:
1083  0120 1f01          	ldw	(OFST-2,sp),x
1085                     ; 270             break;
1087                     ; 271         default:
1087                     ; 272             break;
1089  0122               L354:
1090                     ; 278         if(!is_on)
1092  0122 7b05          	ld	a,(OFST+2,sp)
1093  0124 2608          	jrne	L554
1094                     ; 279             pinPort->DDR |= pinNo;
1096  0126 1e01          	ldw	x,(OFST-2,sp)
1097  0128 e602          	ld	a,(2,x)
1098  012a 1a03          	or	a,(OFST+0,sp)
1100  012c 2007          	jra	L754
1101  012e               L554:
1102                     ; 281            pinPort->DDR &= ~pinNo;
1104  012e 1e01          	ldw	x,(OFST-2,sp)
1105  0130 7b03          	ld	a,(OFST+0,sp)
1106  0132 43            	cpl	a
1107  0133 e402          	and	a,(2,x)
1108  0135               L754:
1109  0135 e702          	ld	(2,x),a
1110                     ; 283 }
1113  0137 5b05          	addw	sp,#5
1114  0139 87            	retf	
1136                     ; 285 static void Drv7SegCtrClearAll()
1136                     ; 286 {
1137                     	switch	.text
1138  013a               L5f_Drv7SegCtrClearAll:
1142                     ; 287     DIG1_PORT->DDR |= DIG1_PIN;
1144  013a 721a500c      	bset	20492,#5
1145                     ; 288     DIG2_PORT->DDR |= DIG2_PIN;
1147  013e 721c500c      	bset	20492,#6
1148                     ; 289     DIG3_PORT->DDR |= DIG3_PIN;
1150  0142 721e500c      	bset	20492,#7
1151                     ; 290     DIG4_PORT->DDR |= DIG4_PIN;
1153  0146 72165002      	bset	20482,#3
1154                     ; 291 }
1157  014a 87            	retf	
1207                     	xdef	_regNum
1208                     	xdef	_codes_number
1209                     	xdef	f_Drv7SegCtrSet
1210                     	xdef	f_Drv7SegGetDisplayCode
1211                     	xdef	f_Drv7SegClearAll
1212                     	xdef	f_Drv7SegClear
1213                     	xdef	f_Drv7SegShow
1214                     	xdef	f_Drv7SegSetDp
1215                     	xdef	f_Drv7SegSetNum
1216                     	xdef	f_Drv7SegSetRawCode
1217                     	xdef	f_Drv7SegSetDigit
1218                     	xdef	f_Drv7SegInit
1219                     	xref	f_DrvHc595Write
1220                     	xref	f_DrvHc595Init
1221                     	xref.b	c_x
1240                     	xref	d_bmulx
1241                     	end
