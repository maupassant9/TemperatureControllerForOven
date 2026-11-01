   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.13.3 - 22 May 2025
   3                     ; Generator (Limited) V4.6.6 - 07 Jan 2026
   4                     ; Optimizer V4.6.6 - 07 Jan 2026
  19                     	switch	.data
  20  0000               _gpioPort:
  21  0000 0000          	dc.w	0
  22  0002 500f          	dc.w	20495
  23  0004 500f          	dc.w	20495
  24  0006 500f          	dc.w	20495
  25  0008 500f          	dc.w	20495
  26  000a               _gpioPin:
  27  000a 00            	dc.b	0
  28  000b 04            	dc.b	4
  29  000c 10            	dc.b	16
  30  000d 20            	dc.b	32
  31  000e 08            	dc.b	8
 101                     ; 55 void DrvHc595Init(hc595_handle_t *handle)
 101                     ; 56 {
 102                     	switch	.text
 103  0000               f_DrvHc595Init:
 105  0000 89            	pushw	x
 106  0001 88            	push	a
 107       00000001      OFST:	set	1
 110                     ; 57     unsigned char cnt, ser = DEFAULT_VALUE;
 112  0002 a601          	ld	a,#1
 113  0004 6b01          	ld	(OFST+0,sp),a
 115                     ; 59     handle->pins_number[0] = SER_PIN;
 117  0006 f7            	ld	(x),a
 118                     ; 60     handle->pins_number[1] = SRCLK_PIN;
 120  0007 4c            	inc	a
 121  0008 e701          	ld	(1,x),a
 122                     ; 61     handle->pins_number[2] = RCLK_PIN;
 124  000a 48            	sll	a
 125  000b e702          	ld	(2,x),a
 126                     ; 62     handle->pins_number[3] = SRCLR_PIN;
 128  000d a603          	ld	a,#3
 129  000f e703          	ld	(3,x),a
 130                     ; 63     handle->pins_number[4] = OE_PIN;
 132  0011 6f04          	clr	(4,x)
 133                     ; 65     gpioPinsInit();
 135  0013 8d4e014e      	callf	L31f_gpioPinsInit
 137                     ; 67     Hc595GpiosWriteAll(handle,(uint8_t)(0x18|ser));
 139  0017 7b01          	ld	a,(OFST+0,sp)
 140  0019 aa18          	or	a,#24
 141  001b 88            	push	a
 142  001c 1e03          	ldw	x,(OFST+2,sp)
 143  001e 8d500050      	callf	L5f_Hc595GpiosWriteAll
 145  0022 84            	pop	a
 146                     ; 68     Hc595GpiosWriteAll(handle,(uint8_t)(0x18|ser));
 148  0023 7b01          	ld	a,(OFST+0,sp)
 149  0025 aa18          	or	a,#24
 150  0027 88            	push	a
 151  0028 1e03          	ldw	x,(OFST+2,sp)
 152  002a 8d500050      	callf	L5f_Hc595GpiosWriteAll
 154  002e 84            	pop	a
 155                     ; 69     Hc595GpiosWriteAll(handle,(uint8_t)(0x10|ser));
 157  002f 7b01          	ld	a,(OFST+0,sp)
 158  0031 aa10          	or	a,#16
 159  0033 88            	push	a
 160  0034 1e03          	ldw	x,(OFST+2,sp)
 161  0036 8d500050      	callf	L5f_Hc595GpiosWriteAll
 163  003a 84            	pop	a
 164                     ; 70     Hc595GpiosWriteAll(handle,(uint8_t)(0x0c|ser));
 166  003b 7b01          	ld	a,(OFST+0,sp)
 167  003d aa0c          	or	a,#12
 168  003f 88            	push	a
 169  0040 1e03          	ldw	x,(OFST+2,sp)
 170  0042 8d500050      	callf	L5f_Hc595GpiosWriteAll
 172  0046 84            	pop	a
 173                     ; 71     DrvHc595Clear(handle);
 175  0047 1e02          	ldw	x,(OFST+1,sp)
 176  0049 8ddc00dc      	callf	f_DrvHc595Clear
 178                     ; 72 }
 181  004d 5b03          	addw	sp,#3
 182  004f 87            	retf	
 233                     ; 89 static void Hc595GpiosWriteAll(hc595_handle_t * handle, uint8_t val)
 233                     ; 90 {
 234                     	switch	.text
 235  0050               L5f_Hc595GpiosWriteAll:
 237  0050 89            	pushw	x
 238  0051 88            	push	a
 239       00000001      OFST:	set	1
 242                     ; 91     unsigned char cnt = 0;
 244  0052 0f01          	clr	(OFST+0,sp)
 247  0054 2019          	jra	L501
 248  0056               L101:
 249                     ; 93         Hc595GpioWrite(handle->pins_number[cnt], (uint8_t)(val&0x01));
 251  0056 7b07          	ld	a,(OFST+6,sp)
 252  0058 a401          	and	a,#1
 253  005a 97            	ld	xl,a
 254  005b 7b01          	ld	a,(OFST+0,sp)
 255  005d 905f          	clrw	y
 256  005f 9097          	ld	yl,a
 257  0061 72f902        	addw	y,(OFST+1,sp)
 258  0064 90f6          	ld	a,(y)
 259  0066 95            	ld	xh,a
 260  0067 8d780078      	callf	L3f_Hc595GpioWrite
 262                     ; 94         val = (uint8_t)(val >> 1);
 264  006b 0407          	srl	(OFST+6,sp)
 265                     ; 92     for(;cnt < 5; cnt++){
 267  006d 0c01          	inc	(OFST+0,sp)
 269  006f               L501:
 272  006f 7b01          	ld	a,(OFST+0,sp)
 273  0071 a105          	cp	a,#5
 274  0073 25e1          	jrult	L101
 275                     ; 98 }
 278  0075 5b03          	addw	sp,#3
 279  0077 87            	retf	
 318                     ; 112 static void Hc595GpioWrite(int8_t pin_number,
 318                     ; 113                         unsigned char val)
 318                     ; 114 {
 319                     	switch	.text
 320  0078               L3f_Hc595GpioWrite:
 322  0078 89            	pushw	x
 323       00000000      OFST:	set	0
 326                     ; 115     if(val == 1){
 328  0079 9f            	ld	a,xl
 329  007a 4a            	dec	a
 330  007b 2606          	jrne	L721
 331                     ; 116         digitalPut(pin_number, HIGH_VOLT);
 333  007d 9e            	ld	a,xh
 334  007e ae0001        	ldw	x,#1
 337  0081 2003          	jra	L131
 338  0083               L721:
 339                     ; 118         digitalPut(pin_number,LOW_VOLT);
 341  0083 7b01          	ld	a,(OFST+1,sp)
 342  0085 5f            	clrw	x
 344  0086               L131:
 345  0086 95            	ld	xh,a
 346  0087 8dfe00fe      	callf	L11f_digitalPut
 347                     ; 120 }
 350  008b 85            	popw	x
 351  008c 87            	retf	
 426                     ; 140 void DrvHc595Write(hc595_handle_t * handle,
 426                     ; 141 														uint8_t * pval)
 426                     ; 142 {
 427                     	switch	.text
 428  008d               f_DrvHc595Write:
 430  008d 89            	pushw	x
 431  008e 5204          	subw	sp,#4
 432       00000004      OFST:	set	4
 435                     ; 144 		for(devNo = 0; devNo < DEV_NO; devNo++)
 437  0090 0f01          	clr	(OFST-3,sp)
 439  0092               L761:
 440                     ; 146       val = pval[devNo];
 442  0092 7b01          	ld	a,(OFST-3,sp)
 443  0094 5f            	clrw	x
 444  0095 97            	ld	xl,a
 445  0096 72fb0a        	addw	x,(OFST+6,sp)
 446  0099 f6            	ld	a,(x)
 447  009a 6b04          	ld	(OFST+0,sp),a
 449                     ; 147 			for(cnt = 0; cnt < 8; cnt++){
 451  009c 0f02          	clr	(OFST-2,sp)
 453  009e               L571:
 454                     ; 148 				ser = (uint8_t)(val&0x01);
 456  009e 7b04          	ld	a,(OFST+0,sp)
 457  00a0 a401          	and	a,#1
 458  00a2 6b03          	ld	(OFST-1,sp),a
 460                     ; 149 				Hc595GpiosWriteAll(handle,(uint8_t)(0x08|ser));
 462  00a4 aa08          	or	a,#8
 463  00a6 88            	push	a
 464  00a7 1e06          	ldw	x,(OFST+2,sp)
 465  00a9 8d500050      	callf	L5f_Hc595GpiosWriteAll
 467  00ad 84            	pop	a
 468                     ; 150 				Hc595GpiosWriteAll(handle,(uint8_t)(0x0a|ser));
 470  00ae 7b03          	ld	a,(OFST-1,sp)
 471  00b0 aa0a          	or	a,#10
 472  00b2 88            	push	a
 473  00b3 1e06          	ldw	x,(OFST+2,sp)
 474  00b5 8d500050      	callf	L5f_Hc595GpiosWriteAll
 476  00b9 84            	pop	a
 477                     ; 151 				val = (uint8_t)(val >> 1);
 479  00ba 0404          	srl	(OFST+0,sp)
 481                     ; 147 			for(cnt = 0; cnt < 8; cnt++){
 483  00bc 0c02          	inc	(OFST-2,sp)
 487  00be 7b02          	ld	a,(OFST-2,sp)
 488  00c0 a108          	cp	a,#8
 489  00c2 25da          	jrult	L571
 490                     ; 144 		for(devNo = 0; devNo < DEV_NO; devNo++)
 492  00c4 0c01          	inc	(OFST-3,sp)
 496  00c6 27ca          	jreq	L761
 497                     ; 154     Hc595GpiosWriteAll(handle,0x0c);
 499  00c8 4b0c          	push	#12
 500  00ca 1e06          	ldw	x,(OFST+2,sp)
 501  00cc 8d500050      	callf	L5f_Hc595GpiosWriteAll
 503  00d0 84            	pop	a
 504                     ; 155     Hc595GpiosWriteAll(handle,0x08);        
 506  00d1 4b08          	push	#8
 507  00d3 1e06          	ldw	x,(OFST+2,sp)
 508  00d5 8d500050      	callf	L5f_Hc595GpiosWriteAll
 510  00d9 5b07          	addw	sp,#7
 511                     ; 156 }   
 514  00db 87            	retf	
 568                     ; 168 void DrvHc595Clear(hc595_handle_t * handle){
 569                     	switch	.text
 570  00dc               f_DrvHc595Clear:
 572  00dc 89            	pushw	x
 573  00dd 89            	pushw	x
 574       00000002      OFST:	set	2
 577                     ; 172 	for(cnt = 0; cnt < DEV_NO; cnt++)
 579  00de 0f02          	clr	(OFST+0,sp)
 581  00e0               L132:
 582                     ; 175 		data[cnt] = 0xff;
 584  00e0 96            	ldw	x,sp
 585  00e1 5c            	incw	x
 586  00e2 9f            	ld	a,xl
 587  00e3 5e            	swapw	x
 588  00e4 1b02          	add	a,(OFST+0,sp)
 589  00e6 2401          	jrnc	L05
 590  00e8 5c            	incw	x
 591  00e9               L05:
 592  00e9 02            	rlwa	x,a
 593  00ea a6ff          	ld	a,#255
 594  00ec f7            	ld	(x),a
 595                     ; 172 	for(cnt = 0; cnt < DEV_NO; cnt++)
 597  00ed 0c02          	inc	(OFST+0,sp)
 601  00ef 27ef          	jreq	L132
 602                     ; 180 	DrvHc595Write(handle,data);
 604  00f1 96            	ldw	x,sp
 605  00f2 5c            	incw	x
 606  00f3 89            	pushw	x
 607  00f4 1e05          	ldw	x,(OFST+3,sp)
 608  00f6 8d8d008d      	callf	f_DrvHc595Write
 610  00fa 5b06          	addw	sp,#6
 611                     ; 181 }
 614  00fc 87            	retf	
 645                     ; 195 static void Hc595Wait(unsigned char mini_seg)
 645                     ; 196 {
 646                     	switch	.text
 647  00fd               L7f_Hc595Wait:
 651                     ; 198 }
 654  00fd 87            	retf	
 694                     ; 213 static void digitalPut(int8_t pinNum, uint8_t value)
 694                     ; 214 {
 695                     	switch	.text
 696  00fe               L11f_digitalPut:
 698  00fe 89            	pushw	x
 699       00000000      OFST:	set	0
 702                     ; 215     if(gpioPort[pinNum] != 0)
 704  00ff 9e            	ld	a,xh
 705  0100 5f            	clrw	x
 706  0101 4d            	tnz	a
 707  0102 2a01          	jrpl	L06
 708  0104 53            	cplw	x
 709  0105               L06:
 710  0105 97            	ld	xl,a
 711  0106 58            	sllw	x
 712  0107 d60001        	ld	a,(_gpioPort+1,x)
 713  010a da0000        	or	a,(_gpioPort,x)
 714  010d 273d          	jreq	L172
 715                     ; 217         if(value == HIGH_VOLT){
 717  010f 7b02          	ld	a,(OFST+2,sp)
 718  0111 4a            	dec	a
 719  0112 261c          	jrne	L372
 720                     ; 218             gpioPort[pinNum]->ODR |= gpioPin[pinNum];
 722  0114 7b01          	ld	a,(OFST+1,sp)
 723  0116 5f            	clrw	x
 724  0117 4d            	tnz	a
 725  0118 2a01          	jrpl	L26
 726  011a 53            	cplw	x
 727  011b               L26:
 728  011b 97            	ld	xl,a
 729  011c 58            	sllw	x
 730  011d 905f          	clrw	y
 731  011f de0000        	ldw	x,(_gpioPort,x)
 732  0122 4d            	tnz	a
 733  0123 2a02          	jrpl	L46
 734  0125 9053          	cplw	y
 735  0127               L46:
 736  0127 9097          	ld	yl,a
 737  0129 f6            	ld	a,(x)
 738  012a 90da000a      	or	a,(_gpioPin,y)
 740  012e 201b          	jpf	LC001
 741  0130               L372:
 742                     ; 220             gpioPort[pinNum]->ODR &= ~gpioPin[pinNum];
 744  0130 7b01          	ld	a,(OFST+1,sp)
 745  0132 5f            	clrw	x
 746  0133 4d            	tnz	a
 747  0134 2a01          	jrpl	L66
 748  0136 53            	cplw	x
 749  0137               L66:
 750  0137 97            	ld	xl,a
 751  0138 58            	sllw	x
 752  0139 905f          	clrw	y
 753  013b de0000        	ldw	x,(_gpioPort,x)
 754  013e 4d            	tnz	a
 755  013f 2a02          	jrpl	L07
 756  0141 9053          	cplw	y
 757  0143               L07:
 758  0143 9097          	ld	yl,a
 759  0145 90d6000a      	ld	a,(_gpioPin,y)
 760  0149 43            	cpl	a
 761  014a f4            	and	a,(x)
 762  014b               LC001:
 763  014b f7            	ld	(x),a
 764  014c               L172:
 765                     ; 223 }
 768  014c 85            	popw	x
 769  014d 87            	retf	
 802                     ; 236 static void gpioPinsInit()
 802                     ; 237 {
 803                     	switch	.text
 804  014e               L31f_gpioPinsInit:
 806  014e 88            	push	a
 807       00000001      OFST:	set	1
 810                     ; 240 	for(cnt = 0; cnt < 5; cnt++){
 812  014f 4f            	clr	a
 813  0150 6b01          	ld	(OFST+0,sp),a
 815  0152               L313:
 816                     ; 241         if(gpioPort[cnt] != 0)
 818  0152 5f            	clrw	x
 819  0153 97            	ld	xl,a
 820  0154 58            	sllw	x
 821  0155 d60001        	ld	a,(_gpioPort+1,x)
 822  0158 da0000        	or	a,(_gpioPort,x)
 823  015b 273a          	jreq	L123
 824                     ; 243             gpioPort[cnt]->ODR &= ~gpioPin[cnt];
 826  015d de0000        	ldw	x,(_gpioPort,x)
 827  0160 7b01          	ld	a,(OFST+0,sp)
 828  0162 905f          	clrw	y
 829  0164 9097          	ld	yl,a
 830  0166 90d6000a      	ld	a,(_gpioPin,y)
 831  016a 43            	cpl	a
 832  016b f4            	and	a,(x)
 833  016c f7            	ld	(x),a
 834                     ; 244             gpioPort[cnt]->DDR |= gpioPin[cnt];
 836  016d 7b01          	ld	a,(OFST+0,sp)
 837  016f 8da101a1      	callf	LC002
 838  0173 e602          	ld	a,(2,x)
 839  0175 90da000a      	or	a,(_gpioPin,y)
 840  0179 e702          	ld	(2,x),a
 841                     ; 246             gpioPort[cnt]->CR1 |= gpioPin[cnt];
 843  017b 7b01          	ld	a,(OFST+0,sp)
 844  017d 8da101a1      	callf	LC002
 845  0181 e603          	ld	a,(3,x)
 846  0183 90da000a      	or	a,(_gpioPin,y)
 847  0187 e703          	ld	(3,x),a
 848                     ; 247             gpioPort[cnt]->CR2 |= gpioPin[cnt];
 850  0189 7b01          	ld	a,(OFST+0,sp)
 851  018b 8da101a1      	callf	LC002
 852  018f e604          	ld	a,(4,x)
 853  0191 90da000a      	or	a,(_gpioPin,y)
 854  0195 e704          	ld	(4,x),a
 855  0197               L123:
 856                     ; 240 	for(cnt = 0; cnt < 5; cnt++){
 858  0197 0c01          	inc	(OFST+0,sp)
 862  0199 7b01          	ld	a,(OFST+0,sp)
 863  019b a105          	cp	a,#5
 864  019d 25b3          	jrult	L313
 865                     ; 250 }
 868  019f 84            	pop	a
 869  01a0 87            	retf	
 870  01a1               LC002:
 871  01a1 5f            	clrw	x
 872  01a2 97            	ld	xl,a
 873  01a3 58            	sllw	x
 874  01a4 905f          	clrw	y
 875  01a6 de0000        	ldw	x,(_gpioPort,x)
 876  01a9 9097          	ld	yl,a
 877  01ab 87            	retf	
1051                     	xdef	_gpioPin
1052                     	xdef	_gpioPort
1053                     	xdef	f_DrvHc595Clear
1054                     	xdef	f_DrvHc595Write
1055                     	xdef	f_DrvHc595Init
1074                     	end
