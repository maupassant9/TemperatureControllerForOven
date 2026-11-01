   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.13.3 - 22 May 2025
   3                     ; Generator (Limited) V4.6.6 - 07 Jan 2026
   4                     ; Optimizer V4.6.6 - 07 Jan 2026
 150                     ; 55 void cirbuf_init(cb_t pcb, uint16_t ele_no, uint16_t ele_sz, uint8_t *buf, bool allow_overf)
 150                     ; 56 {
 151                     	switch	.text
 152  0000               f_cirbuf_init:
 154  0000 89            	pushw	x
 155       00000000      OFST:	set	0
 158  0001               L37:
 159                     ; 57     ASSERT(NULL == pcb);
 161  0001 1e01          	ldw	x,(OFST+1,sp)
 162  0003 27fc          	jreq	L37
 164  0005               L101:
 165                     ; 58     ASSERT(NULL == buf);
 167  0005 1e0a          	ldw	x,(OFST+10,sp)
 168  0007 27fc          	jreq	L101
 170  0009               L701:
 171                     ; 59     ASSERT(((ele_no & (ele_no - 1)) != 0));
 173  0009 1e06          	ldw	x,(OFST+6,sp)
 174  000b 5a            	decw	x
 175  000c 01            	rrwa	x,a
 176  000d 1407          	and	a,(OFST+7,sp)
 177  000f 01            	rrwa	x,a
 178  0010 1406          	and	a,(OFST+6,sp)
 179  0012 01            	rrwa	x,a
 180  0013 5d            	tnzw	x
 181  0014 26f3          	jrne	L701
 182                     ; 60     pcb->head = 0;
 184  0016 1e01          	ldw	x,(OFST+1,sp)
 185  0018 905f          	clrw	y
 186  001a ff            	ldw	(x),y
 187                     ; 61     pcb->tail = 0;
 189  001b ef02          	ldw	(2,x),y
 190                     ; 62     pcb->mem = buf;
 192  001d 160a          	ldw	y,(OFST+10,sp)
 193  001f ef04          	ldw	(4,x),y
 194                     ; 63     pcb->ele_sz = ele_sz;
 196  0021 1608          	ldw	y,(OFST+8,sp)
 197  0023 ef06          	ldw	(6,x),y
 198                     ; 64     pcb->ele_no = ele_no;
 200  0025 1606          	ldw	y,(OFST+6,sp)
 201  0027 ef08          	ldw	(8,x),y
 202                     ; 65     pcb->allow_of = allow_overf;
 204  0029 7b0c          	ld	a,(OFST+12,sp)
 205  002b e80a          	xor	a,(10,x)
 206  002d a401          	and	a,#1
 207  002f e80a          	xor	a,(10,x)
 208  0031 e70a          	ld	(10,x),a
 209                     ; 67 }
 212  0033 85            	popw	x
 213  0034 87            	retf	
 260                     ; 81 int8_t cirbuf_put(cb_t pcb, cb_ele_t ele)
 260                     ; 82 {
 261                     	switch	.text
 262  0035               f_cirbuf_put:
 264  0035 89            	pushw	x
 265  0036 89            	pushw	x
 266       00000002      OFST:	set	2
 269                     ; 83   if (CB_ISFULL(pcb))
 271  0037 9093          	ldw	y,x
 272  0039 fe            	ldw	x,(x)
 273  003a 90e302        	cpw	x,(2,y)
 274  003d 2306          	jrule	L01
 275  003f 1e03          	ldw	x,(OFST+1,sp)
 276  0041 ee02          	ldw	x,(2,x)
 277  0043 2003          	jra	L21
 278  0045               L01:
 279  0045 1e03          	ldw	x,(OFST+1,sp)
 280  0047 fe            	ldw	x,(x)
 281  0048               L21:
 282  0048 1f01          	ldw	(OFST-1,sp),x
 284  004a 1e03          	ldw	x,(OFST+1,sp)
 285  004c 9093          	ldw	y,x
 286  004e fe            	ldw	x,(x)
 287  004f 90e302        	cpw	x,(2,y)
 288  0052 2305          	jrule	L41
 289  0054 1e03          	ldw	x,(OFST+1,sp)
 290  0056 fe            	ldw	x,(x)
 291  0057 2004          	jra	L61
 292  0059               L41:
 293  0059 1e03          	ldw	x,(OFST+1,sp)
 294  005b ee02          	ldw	x,(2,x)
 295  005d               L61:
 296  005d 72f001        	subw	x,(OFST-1,sp)
 297  0060 90e308        	cpw	x,(8,y)
 298  0063 2621          	jrne	L731
 299                     ; 85      if(!CB_ALLOW_OVERFLOW(pcb)) return -1;
 301  0065 1e03          	ldw	x,(OFST+1,sp)
 302  0067 e60a          	ld	a,(10,x)
 303  0069 a501          	bcp	a,#1
 304  006b 2604          	jrne	L141
 307  006d a6ff          	ld	a,#255
 309  006f 2063          	jra	L22
 310  0071               L141:
 311                     ; 86      CB_CIR_INC(pcb->head, pcb->ele_no);
 313  0071 ee08          	ldw	x,(8,x)
 314  0073 58            	sllw	x
 315  0074 5a            	decw	x
 316  0075 1f01          	ldw	(OFST-1,sp),x
 318  0077 1e03          	ldw	x,(OFST+1,sp)
 319  0079 fe            	ldw	x,(x)
 320  007a 5c            	incw	x
 321  007b 01            	rrwa	x,a
 322  007c 1402          	and	a,(OFST+0,sp)
 323  007e 01            	rrwa	x,a
 324  007f 1401          	and	a,(OFST-1,sp)
 325  0081 1603          	ldw	y,(OFST+1,sp)
 326  0083 01            	rrwa	x,a
 327  0084 90ff          	ldw	(y),x
 328  0086               L731:
 329                     ; 88   CB_COPY_ELEMENT(CB_ADDR_ELEMENT(pcb,CB_INDEX(pcb,pcb->tail)), ele);
 331  0086 1e03          	ldw	x,(OFST+1,sp)
 332  0088 ee06          	ldw	x,(6,x)
 333  008a 89            	pushw	x
 334  008b 1e0a          	ldw	x,(OFST+8,sp)
 335  008d 89            	pushw	x
 336  008e 1e07          	ldw	x,(OFST+5,sp)
 337  0090 ee08          	ldw	x,(8,x)
 338  0092 5a            	decw	x
 339  0093 1607          	ldw	y,(OFST+5,sp)
 340  0095 01            	rrwa	x,a
 341  0096 90e403        	and	a,(3,y)
 342  0099 01            	rrwa	x,a
 343  009a 90e402        	and	a,(2,y)
 344  009d 01            	rrwa	x,a
 345  009e 90ee06        	ldw	y,(6,y)
 346  00a1 8d000000      	callf	d_imul
 348  00a5 9093          	ldw	y,x
 349  00a7 1e07          	ldw	x,(OFST+5,sp)
 350  00a9 9001          	rrwa	y,a
 351  00ab eb05          	add	a,(5,x)
 352  00ad 9001          	rrwa	y,a
 353  00af e904          	adc	a,(4,x)
 354  00b1 9001          	rrwa	y,a
 355  00b3 93            	ldw	x,y
 356  00b4 8d000000      	callf	f_memcpy
 358  00b8 5b04          	addw	sp,#4
 359                     ; 89   CB_CIR_INC(pcb->tail, pcb->ele_no);
 361  00ba 1e03          	ldw	x,(OFST+1,sp)
 362  00bc ee08          	ldw	x,(8,x)
 363  00be 58            	sllw	x
 364  00bf 5a            	decw	x
 365  00c0 1f01          	ldw	(OFST-1,sp),x
 367  00c2 1e03          	ldw	x,(OFST+1,sp)
 368  00c4 ee02          	ldw	x,(2,x)
 369  00c6 5c            	incw	x
 370  00c7 01            	rrwa	x,a
 371  00c8 1402          	and	a,(OFST+0,sp)
 372  00ca 01            	rrwa	x,a
 373  00cb 1401          	and	a,(OFST-1,sp)
 374  00cd 1603          	ldw	y,(OFST+1,sp)
 375  00cf 01            	rrwa	x,a
 376  00d0 90ef02        	ldw	(2,y),x
 377                     ; 90   return 0;
 379  00d3 4f            	clr	a
 381  00d4               L22:
 383  00d4 5b04          	addw	sp,#4
 384  00d6 87            	retf	
 431                     ; 105 int8_t cirbuf_get(cb_t pcb, cb_ele_t ele)
 431                     ; 106 {
 432                     	switch	.text
 433  00d7               f_cirbuf_get:
 435  00d7 89            	pushw	x
 436  00d8 89            	pushw	x
 437       00000002      OFST:	set	2
 440                     ; 107   if (CB_ISEMPTY(pcb)) return -1;
 442  00d9 9093          	ldw	y,x
 443  00db fe            	ldw	x,(x)
 444  00dc 90e302        	cpw	x,(2,y)
 445  00df 2604          	jrne	L761
 448  00e1 a6ff          	ld	a,#255
 450  00e3 204b          	jra	L03
 451  00e5               L761:
 452                     ; 109   CB_COPY_ELEMENT(ele, CB_ADDR_ELEMENT(pcb, CB_INDEX(pcb,pcb->head)));
 454  00e5 1e03          	ldw	x,(OFST+1,sp)
 455  00e7 ee06          	ldw	x,(6,x)
 456  00e9 89            	pushw	x
 457  00ea 1e05          	ldw	x,(OFST+3,sp)
 458  00ec ee08          	ldw	x,(8,x)
 459  00ee 5a            	decw	x
 460  00ef 1605          	ldw	y,(OFST+3,sp)
 461  00f1 01            	rrwa	x,a
 462  00f2 90e401        	and	a,(1,y)
 463  00f5 01            	rrwa	x,a
 464  00f6 90f4          	and	a,(y)
 465  00f8 01            	rrwa	x,a
 466  00f9 90ee06        	ldw	y,(6,y)
 467  00fc 8d000000      	callf	d_imul
 469  0100 9093          	ldw	y,x
 470  0102 1e05          	ldw	x,(OFST+3,sp)
 471  0104 9001          	rrwa	y,a
 472  0106 eb05          	add	a,(5,x)
 473  0108 9001          	rrwa	y,a
 474  010a e904          	adc	a,(4,x)
 475  010c 9001          	rrwa	y,a
 476  010e 9089          	pushw	y
 477  0110 1e0c          	ldw	x,(OFST+10,sp)
 478  0112 8d000000      	callf	f_memcpy
 480  0116 5b04          	addw	sp,#4
 481                     ; 110   CB_CIR_INC(pcb->head, pcb->ele_no);
 483  0118 1e03          	ldw	x,(OFST+1,sp)
 484  011a ee08          	ldw	x,(8,x)
 485  011c 58            	sllw	x
 486  011d 5a            	decw	x
 487  011e 1f01          	ldw	(OFST-1,sp),x
 489  0120 1e03          	ldw	x,(OFST+1,sp)
 490  0122 fe            	ldw	x,(x)
 491  0123 5c            	incw	x
 492  0124 01            	rrwa	x,a
 493  0125 1402          	and	a,(OFST+0,sp)
 494  0127 01            	rrwa	x,a
 495  0128 1401          	and	a,(OFST-1,sp)
 496  012a 1603          	ldw	y,(OFST+1,sp)
 497  012c 01            	rrwa	x,a
 498  012d 90ff          	ldw	(y),x
 499                     ; 111   return 0;
 501  012f 4f            	clr	a
 503  0130               L03:
 505  0130 5b04          	addw	sp,#4
 506  0132 87            	retf	
 518                     	xdef	f_cirbuf_get
 519                     	xdef	f_cirbuf_put
 520                     	xdef	f_cirbuf_init
 521                     	xref	f_memcpy
 522                     	xref.b	c_x
 541                     	xref	d_imul
 542                     	end
