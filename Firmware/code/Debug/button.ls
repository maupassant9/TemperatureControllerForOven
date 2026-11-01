   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.13.3 - 22 May 2025
   3                     ; Generator (Limited) V4.6.6 - 07 Jan 2026
   4                     ; Optimizer V4.6.6 - 07 Jan 2026
 111                     ; 36 void bt_init(but_t *b, uint16_t id, int8_t (*get)(uint16_t))
 111                     ; 37 {
 112                     	switch	.text
 113  0000               f_bt_init:
 115       fffffffe      OFST: set -2
 118                     ; 38     b->get_val = get;
 120  0000 7b06          	ld	a,(OFST+8,sp)
 121  0002 e706          	ld	(6,x),a
 122  0004 7b07          	ld	a,(OFST+9,sp)
 123  0006 e707          	ld	(7,x),a
 124  0008 7b08          	ld	a,(OFST+10,sp)
 125  000a e708          	ld	(8,x),a
 126                     ; 39     b->id = id;
 128  000c 1604          	ldw	y,(OFST+6,sp)
 129  000e ff            	ldw	(x),y
 130                     ; 40     b->pressed_cnter = 0;
 132  000f 4f            	clr	a
 133  0010 e705          	ld	(5,x),a
 134  0012 e704          	ld	(4,x),a
 135  0014 e703          	ld	(3,x),a
 136  0016 e702          	ld	(2,x),a
 137                     ; 41 }
 140  0018 87            	retf	
 142                     .const:	section	.text
 143  0000               L35_msg:
 144  0000 0000          	ds.b	2
 145  0002 00            	dc.b	0
 324                     	switch	.const
 325  0003               L21:
 326  0003 00000064      	dc.l	100
 327  0007               L41:
 328  0007 0000000a      	dc.l	10
 329  000b               L02:
 330  000b 00000005      	dc.l	5
 331  000f               L22:
 332  000f 0000001e      	dc.l	30
 333                     ; 81 void bt_update(but_t *b, cb_t cb_but)
 333                     ; 82 {
 334                     	switch	.text
 335  0019               f_bt_update:
 337  0019 89            	pushw	x
 338  001a 5207          	subw	sp,#7
 339       00000007      OFST:	set	7
 342                     ; 83     uint32_t pressed_cnter_cp = 0;
 344                     ; 84     but_msg_t msg = {b->id, 0};
 346  001c 96            	ldw	x,sp
 347  001d 1c0005        	addw	x,#OFST-2
 348  0020 90ae0000      	ldw	y,#L35_msg
 349  0024 a603          	ld	a,#3
 350  0026 8d000000      	callf	d_xymov
 352  002a 1e08          	ldw	x,(OFST+1,sp)
 353  002c fe            	ldw	x,(x)
 354  002d 1f05          	ldw	(OFST-2,sp),x
 356                     ; 85     if(b->get_val(b->id)){
 358  002f 1e08          	ldw	x,(OFST+1,sp)
 359  0031 1608          	ldw	y,(OFST+1,sp)
 360  0033 fe            	ldw	x,(x)
 361  0034 90e606        	ld	a,(6,y)
 362  0037 b700          	ld	c_y,a
 363  0039 90ee07        	ldw	y,(7,y)
 364  003c 90bf01        	ldw	c_y+1,y
 365  003f 928d0000      	callf	[c_y.e]
 367  0043 4d            	tnz	a
 368  0044 273b          	jreq	L361
 369                     ; 87         b->pressed_cnter++;
 371  0046 1e08          	ldw	x,(OFST+1,sp)
 372  0048 1c0002        	addw	x,#2
 373  004b a601          	ld	a,#1
 374  004d 8d000000      	callf	d_lgadc
 376                     ; 88         if(b->pressed_cnter >= BUTTON_LNG_NOT_RELEASE_TIME){
 378  0051 1e08          	ldw	x,(OFST+1,sp)
 379  0053 8dcd00cd      	callf	LC002
 381  0057 2571          	jrult	L171
 382                     ; 89             if(0 == (b->pressed_cnter)%BUTTON_NOT_RELEASED_EVT_INTERVAL_IN_TICK){
 384  0059 1e08          	ldw	x,(OFST+1,sp)
 385  005b 1c0002        	addw	x,#2
 386  005e 8d000000      	callf	d_ltor
 388  0062 ae0007        	ldw	x,#L41
 389  0065 8d000000      	callf	d_lumd
 391  0069 8d000000      	callf	d_lrzmp
 393  006d 265b          	jrne	L171
 394                     ; 91                 msg.evt = BUTTON_NOT_RELEASED;
 396  006f a603          	ld	a,#3
 397  0071 6b07          	ld	(OFST+0,sp),a
 399                     ; 92                 cirbuf_put(cb_but, (cb_ele_t)&msg);
 401  0073 96            	ldw	x,sp
 402  0074 1c0005        	addw	x,#OFST-2
 403  0077 89            	pushw	x
 404  0078 1e0f          	ldw	x,(OFST+8,sp)
 405  007a 8d000000      	callf	f_cirbuf_put
 407  007e 85            	popw	x
 408  007f 2049          	jra	L171
 409  0081               L361:
 410                     ; 97          if(b->pressed_cnter >= BUTTON_SHT_PRESSED_TIME_IN_TICK && b->pressed_cnter < BUTTON_LNG_PRESSED_TIME_IN_TICK){
 412  0081 1e08          	ldw	x,(OFST+1,sp)
 413  0083 1c0002        	addw	x,#2
 414  0086 8d000000      	callf	d_ltor
 416  008a ae000b        	ldw	x,#L02
 417  008d 8d000000      	callf	d_lcmp
 419  0091 250c          	jrult	L371
 421  0093 1e08          	ldw	x,(OFST+1,sp)
 422  0095 8ddb00db      	callf	LC003
 424  0099 2404          	jruge	L371
 425                     ; 98             msg.evt = BUTTON_SHT_PRESSED;
 427  009b a601          	ld	a,#1
 428                     ; 99             cirbuf_put(cb_but, (cb_ele_t)&msg);
 431  009d 2012          	jpf	LC001
 432  009f               L371:
 433                     ; 100         } else if(b->pressed_cnter >= BUTTON_LNG_PRESSED_TIME_IN_TICK && b->pressed_cnter < (BUTTON_LNG_NOT_RELEASE_TIME)){
 435  009f 1e08          	ldw	x,(OFST+1,sp)
 436  00a1 8ddb00db      	callf	LC003
 438  00a5 2518          	jrult	L571
 440  00a7 1e08          	ldw	x,(OFST+1,sp)
 441  00a9 8dcd00cd      	callf	LC002
 443  00ad 2410          	jruge	L571
 444                     ; 101             msg.evt = BUTTON_LNG_PRESSED;
 446  00af a602          	ld	a,#2
 447                     ; 102             cirbuf_put(cb_but, (cb_ele_t)&msg);
 450  00b1               LC001:
 451  00b1 6b07          	ld	(OFST+0,sp),a
 454  00b3 96            	ldw	x,sp
 455  00b4 1c0005        	addw	x,#OFST-2
 456  00b7 89            	pushw	x
 457  00b8 1e0f          	ldw	x,(OFST+8,sp)
 458  00ba 8d000000      	callf	f_cirbuf_put
 459  00be 85            	popw	x
 460  00bf               L571:
 461                     ; 105         b->pressed_cnter = 0;
 463  00bf 1e08          	ldw	x,(OFST+1,sp)
 464  00c1 4f            	clr	a
 465  00c2 e705          	ld	(5,x),a
 466  00c4 e704          	ld	(4,x),a
 467  00c6 e703          	ld	(3,x),a
 468  00c8 e702          	ld	(2,x),a
 469  00ca               L171:
 470                     ; 107 }
 473  00ca 5b09          	addw	sp,#9
 474  00cc 87            	retf	
 475  00cd               LC002:
 476  00cd 1c0002        	addw	x,#2
 477  00d0 8d000000      	callf	d_ltor
 479  00d4 ae0003        	ldw	x,#L21
 480  00d7 ac000000      	jpf	d_lcmp
 481  00db               LC003:
 482  00db 1c0002        	addw	x,#2
 483  00de 8d000000      	callf	d_ltor
 485  00e2 ae000f        	ldw	x,#L22
 486  00e5 ac000000      	jpf	d_lcmp
 498                     	xdef	f_bt_update
 499                     	xdef	f_bt_init
 500                     	xref	f_cirbuf_put
 501                     	xref.b	c_x
 502                     	xref.b	c_y
 521                     	xref	d_lrzmp
 522                     	xref	d_lumd
 523                     	xref	d_lcmp
 524                     	xref	d_ltor
 525                     	xref	d_lgadc
 526                     	xref	d_xymov
 527                     	end
