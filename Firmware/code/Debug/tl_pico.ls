   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.13.3 - 22 May 2025
   3                     ; Generator (Limited) V4.6.6 - 07 Jan 2026
   4                     ; Optimizer V4.6.6 - 07 Jan 2026
 226                     ; 87 void tl_init(tl_t tl, uint8_t max_sz, tl_task_t buf)
 226                     ; 88 {
 227                     	switch	.text
 228  0000               f_tl_init:
 230  0000 89            	pushw	x
 231  0001 89            	pushw	x
 232       00000002      OFST:	set	2
 235                     ; 89 	size_t sz = 0;
 237                     ; 90 	if(!CHK_TL(tl)) return;
 239  0002 5d            	tnzw	x
 240  0003 2704          	jreq	L01
 243                     ; 91 	if(buf == NULL) return;
 245  0005 1e09          	ldw	x,(OFST+7,sp)
 246  0007 2603          	jrne	L731
 248  0009               L01:
 251  0009 5b04          	addw	sp,#4
 252  000b 87            	retf	
 253  000c               L731:
 254                     ; 92     sz = sizeof(tl_ele_t)*max_sz;
 256  000c 7b08          	ld	a,(OFST+6,sp)
 257  000e 97            	ld	xl,a
 258  000f a610          	ld	a,#16
 259  0011 42            	mul	x,a
 260  0012 1f01          	ldw	(OFST-1,sp),x
 262                     ; 93     tl->tasks = buf;
 264  0014 1e03          	ldw	x,(OFST+1,sp)
 265  0016 1609          	ldw	y,(OFST+7,sp)
 266  0018 ff            	ldw	(x),y
 267                     ; 94     memset(tl->tasks, 0, sz);
 269  0019 1e01          	ldw	x,(OFST-1,sp)
 270  001b 89            	pushw	x
 271  001c 4b00          	push	#0
 272  001e 1e06          	ldw	x,(OFST+4,sp)
 273  0020 fe            	ldw	x,(x)
 274  0021 8d000000      	callf	f_memset
 276  0025 5b03          	addw	sp,#3
 277                     ; 95     tl->tick = 0;
 279  0027 1e03          	ldw	x,(OFST+1,sp)
 280  0029 4f            	clr	a
 281  002a e707          	ld	(7,x),a
 282  002c e706          	ld	(6,x),a
 283  002e e705          	ld	(5,x),a
 284  0030 e704          	ld	(4,x),a
 285                     ; 96     tl->task_sz = 0;
 287  0032 6f02          	clr	(2,x)
 288                     ; 97     tl->max_sz = max_sz;
 290  0034 7b08          	ld	a,(OFST+6,sp)
 291  0036 e703          	ld	(3,x),a
 292                     ; 98     tl->disable = 0;
 294  0038 6f08          	clr	(8,x)
 295                     ; 99 }
 297  003a 20cd          	jra	L01
 394                     ; 117 tl_task_t tl_add(tl_t tl, run_t run, uint32_t delay, uint32_t period, task_st_t st, tl_task_param_t param)
 394                     ; 118 {
 395                     	switch	.text
 396  003c               f_tl_add:
 398  003c 89            	pushw	x
 399  003d 89            	pushw	x
 400       00000002      OFST:	set	2
 403                     ; 119     tl_task_t tsk = NULL;
 405                     ; 120 	if(!CHK_TL(tl)) return NULL;
 407  003e 5d            	tnzw	x
 410  003f 2706          	jreq	LC001
 411                     ; 121     if(st == TL_DEAD) return NULL;
 413  0041 7b13          	ld	a,(OFST+17,sp)
 414  0043 a102          	cp	a,#2
 415  0045 2604          	jrne	L312
 418  0047               LC001:
 421  0047 5f            	clrw	x
 423  0048               L61:
 425  0048 5b04          	addw	sp,#4
 426  004a 87            	retf	
 427  004b               L312:
 428                     ; 122     tsk = tl_get_taskmem(tl);
 430  004b 8d540154      	callf	L3f_tl_get_taskmem
 432  004f 1f01          	ldw	(OFST-1,sp),x
 434                     ; 123     if(tsk == NULL) return NULL;
 438  0051 27f4          	jreq	LC001
 439                     ; 124     tsk->belong_to = tl;
 441  0053 1603          	ldw	y,(OFST+1,sp)
 442  0055 ef0e          	ldw	(14,x),y
 443                     ; 125     tsk->run = run;
 445  0057 7b08          	ld	a,(OFST+6,sp)
 446  0059 f7            	ld	(x),a
 447  005a 7b09          	ld	a,(OFST+7,sp)
 448  005c e701          	ld	(1,x),a
 449  005e 7b0a          	ld	a,(OFST+8,sp)
 450  0060 e702          	ld	(2,x),a
 451                     ; 126     tsk->period = period;
 453  0062 7b12          	ld	a,(OFST+16,sp)
 454  0064 e708          	ld	(8,x),a
 455  0066 7b11          	ld	a,(OFST+15,sp)
 456  0068 e707          	ld	(7,x),a
 457  006a 7b10          	ld	a,(OFST+14,sp)
 458  006c e706          	ld	(6,x),a
 459  006e 7b0f          	ld	a,(OFST+13,sp)
 460  0070 e705          	ld	(5,x),a
 461                     ; 127     tsk->next_exe_ts = tl->tick + delay + 1;
 463  0072 93            	ldw	x,y
 464  0073 1c0004        	addw	x,#4
 465  0076 8d000000      	callf	d_ltor
 467  007a 96            	ldw	x,sp
 468  007b 1c000b        	addw	x,#OFST+9
 469  007e 8d000000      	callf	d_ladd
 471  0082 a601          	ld	a,#1
 472  0084 8d000000      	callf	d_ladc
 474  0088 1e01          	ldw	x,(OFST-1,sp)
 475  008a 1c0009        	addw	x,#9
 476  008d 8d000000      	callf	d_rtol
 478                     ; 128     tsk->st = st;
 480  0091 1e01          	ldw	x,(OFST-1,sp)
 481  0093 7b13          	ld	a,(OFST+17,sp)
 482  0095 e70d          	ld	(13,x),a
 483                     ; 129     tsk->param = param;
 485  0097 1614          	ldw	y,(OFST+18,sp)
 486  0099 ef03          	ldw	(3,x),y
 487                     ; 131     tl->task_sz++;
 490  009b 1e03          	ldw	x,(OFST+1,sp)
 491  009d 6c02          	inc	(2,x)
 492                     ; 133     return tsk;
 495  009f 1e01          	ldw	x,(OFST-1,sp)
 497  00a1 20a5          	jra	L61
 595                     ; 151 tl_task_t tl_add_singleton(tl_t tl, run_t run, uint32_t delay, uint32_t period, task_st_t st, tl_task_param_t param){
 596                     	switch	.text
 597  00a3               f_tl_add_singleton:
 599  00a3 89            	pushw	x
 600  00a4 89            	pushw	x
 601       00000002      OFST:	set	2
 604                     ; 153     tl_task_t task = tl_find(tl, run);
 606  00a5 1e09          	ldw	x,(OFST+7,sp)
 607  00a7 89            	pushw	x
 608  00a8 7b0a          	ld	a,(OFST+8,sp)
 609  00aa 88            	push	a
 610  00ab 1e06          	ldw	x,(OFST+4,sp)
 611  00ad 8d160116      	callf	L5f_tl_find
 613  00b1 5b03          	addw	sp,#3
 614  00b3 1f01          	ldw	(OFST-1,sp),x
 616                     ; 155     if(task != NULL)
 618  00b5 273c          	jreq	L762
 619                     ; 157         task->next_exe_ts = tl->tick + delay + 1;
 621  00b7 1e03          	ldw	x,(OFST+1,sp)
 622  00b9 1c0004        	addw	x,#4
 623  00bc 8d000000      	callf	d_ltor
 625  00c0 96            	ldw	x,sp
 626  00c1 1c000b        	addw	x,#OFST+9
 627  00c4 8d000000      	callf	d_ladd
 629  00c8 a601          	ld	a,#1
 630  00ca 8d000000      	callf	d_ladc
 632  00ce 1e01          	ldw	x,(OFST-1,sp)
 633  00d0 1c0009        	addw	x,#9
 634  00d3 8d000000      	callf	d_rtol
 636                     ; 158         task->period = period;
 638  00d7 1e01          	ldw	x,(OFST-1,sp)
 639  00d9 7b12          	ld	a,(OFST+16,sp)
 640  00db e708          	ld	(8,x),a
 641  00dd 7b11          	ld	a,(OFST+15,sp)
 642  00df e707          	ld	(7,x),a
 643  00e1 7b10          	ld	a,(OFST+14,sp)
 644  00e3 e706          	ld	(6,x),a
 645  00e5 7b0f          	ld	a,(OFST+13,sp)
 646  00e7 e705          	ld	(5,x),a
 647                     ; 159         task->st = st;
 649  00e9 7b13          	ld	a,(OFST+17,sp)
 650  00eb e70d          	ld	(13,x),a
 651                     ; 160         task->param = param;
 653  00ed 1614          	ldw	y,(OFST+18,sp)
 654  00ef ef03          	ldw	(3,x),y
 656                     ; 164 }
 658  00f1 2020          	jra	L62
 659  00f3               L762:
 660                     ; 162         return tl_add(tl, run, delay, period, st, param);
 662  00f3 1e14          	ldw	x,(OFST+18,sp)
 663  00f5 89            	pushw	x
 664  00f6 7b15          	ld	a,(OFST+19,sp)
 665  00f8 88            	push	a
 666  00f9 1e14          	ldw	x,(OFST+18,sp)
 667  00fb 89            	pushw	x
 668  00fc 1e14          	ldw	x,(OFST+18,sp)
 669  00fe 89            	pushw	x
 670  00ff 1e14          	ldw	x,(OFST+18,sp)
 671  0101 89            	pushw	x
 672  0102 1e14          	ldw	x,(OFST+18,sp)
 673  0104 89            	pushw	x
 674  0105 1e14          	ldw	x,(OFST+18,sp)
 675  0107 89            	pushw	x
 676  0108 7b15          	ld	a,(OFST+19,sp)
 677  010a 88            	push	a
 678  010b 1e11          	ldw	x,(OFST+15,sp)
 679  010d 8d3c003c      	callf	f_tl_add
 681  0111 5b0e          	addw	sp,#14
 683  0113               L62:
 685  0113 5b04          	addw	sp,#4
 686  0115 87            	retf	
 755                     ; 175 static tl_task_t tl_find(tl_t tl, run_t run){
 756                     	switch	.text
 757  0116               L5f_tl_find:
 759  0116 89            	pushw	x
 760  0117 5203          	subw	sp,#3
 761       00000003      OFST:	set	3
 764                     ; 177     uint8_t i = 0;
 766                     ; 178     for(i = 0; i < tl->max_sz; i++){
 768  0119 0f01          	clr	(OFST-2,sp)
 771  011b 202b          	jra	L533
 772  011d               L133:
 773                     ; 179         task = &tl->tasks[i];
 775  011d 7b01          	ld	a,(OFST-2,sp)
 776  011f 97            	ld	xl,a
 777  0120 a610          	ld	a,#16
 778  0122 42            	mul	x,a
 779  0123 1604          	ldw	y,(OFST+1,sp)
 780  0125 01            	rrwa	x,a
 781  0126 90eb01        	add	a,(1,y)
 782  0129 01            	rrwa	x,a
 783  012a 90f9          	adc	a,(y)
 784  012c 01            	rrwa	x,a
 785  012d 1f02          	ldw	(OFST-1,sp),x
 787                     ; 180         if((task->run == run) && (task->st != TL_DEAD)) return task;
 789  012f e602          	ld	a,(2,x)
 790  0131 110b          	cp	a,(OFST+8,sp)
 791  0133 2611          	jrne	L143
 792  0135 e601          	ld	a,(1,x)
 793  0137 110a          	cp	a,(OFST+7,sp)
 794  0139 260b          	jrne	L143
 795  013b f6            	ld	a,(x)
 796  013c 1109          	cp	a,(OFST+6,sp)
 797  013e 2606          	jrne	L143
 799  0140 e60d          	ld	a,(13,x)
 800  0142 a102          	cp	a,#2
 804  0144 260b          	jrne	L43
 805  0146               L143:
 806                     ; 178     for(i = 0; i < tl->max_sz; i++){
 808  0146 0c01          	inc	(OFST-2,sp)
 810  0148               L533:
 813  0148 1e04          	ldw	x,(OFST+1,sp)
 814  014a e603          	ld	a,(3,x)
 815  014c 1101          	cp	a,(OFST-2,sp)
 816  014e 22cd          	jrugt	L133
 817                     ; 182     return NULL;
 819  0150 5f            	clrw	x
 821  0151               L43:
 823  0151 5b05          	addw	sp,#5
 824  0153 87            	retf	
 882                     ; 192 static tl_task_t tl_get_taskmem(tl_t tl)
 882                     ; 193 {
 883                     	switch	.text
 884  0154               L3f_tl_get_taskmem:
 886  0154 89            	pushw	x
 887  0155 5203          	subw	sp,#3
 888       00000003      OFST:	set	3
 891                     ; 194     tl_task_t task; uint8_t i = 0;
 893                     ; 195 	if(!CHK_TL(tl)) return NULL;
 895  0157 5d            	tnzw	x
 898  0158 2715          	jreq	LC002
 899                     ; 198 	if(tl->task_sz + 1 > tl->max_sz) return NULL;
 901  015a e602          	ld	a,(2,x)
 902  015c 5f            	clrw	x
 903  015d 97            	ld	xl,a
 904  015e 1604          	ldw	y,(OFST+1,sp)
 905  0160 5c            	incw	x
 906  0161 90e603        	ld	a,(3,y)
 907  0164 905f          	clrw	y
 908  0166 9097          	ld	yl,a
 909  0168 90bf00        	ldw	c_y,y
 910  016b b300          	cpw	x,c_y
 911  016d 2d04          	jrsle	L773
 914  016f               LC002:
 917  016f 5f            	clrw	x
 919  0170               L04:
 921  0170 5b05          	addw	sp,#5
 922  0172 87            	retf	
 923  0173               L773:
 924                     ; 200 	for(i = 0; i < tl->max_sz; i++)
 926  0173 0f01          	clr	(OFST-2,sp)
 929  0175 2026          	jra	L504
 930  0177               L104:
 931                     ; 202 		task = &tl->tasks[i];
 933  0177 7b01          	ld	a,(OFST-2,sp)
 934  0179 97            	ld	xl,a
 935  017a a610          	ld	a,#16
 936  017c 42            	mul	x,a
 937  017d 1604          	ldw	y,(OFST+1,sp)
 938  017f 01            	rrwa	x,a
 939  0180 90eb01        	add	a,(1,y)
 940  0183 01            	rrwa	x,a
 941  0184 90f9          	adc	a,(y)
 942  0186 01            	rrwa	x,a
 943  0187 1f02          	ldw	(OFST-1,sp),x
 945                     ; 203 	    if((task->belong_to != tl) || (task->st == TL_DEAD)){
 947  0189 ee0e          	ldw	x,(14,x)
 948  018b 1304          	cpw	x,(OFST+1,sp)
 949  018d 2608          	jrne	L314
 951  018f 1e02          	ldw	x,(OFST-1,sp)
 952  0191 e60d          	ld	a,(13,x)
 953  0193 a102          	cp	a,#2
 954  0195 2604          	jrne	L114
 955  0197               L314:
 956                     ; 204 	    	return task;
 958  0197 1e02          	ldw	x,(OFST-1,sp)
 960  0199 20d5          	jra	L04
 961  019b               L114:
 962                     ; 200 	for(i = 0; i < tl->max_sz; i++)
 964  019b 0c01          	inc	(OFST-2,sp)
 966  019d               L504:
 969  019d 1e04          	ldw	x,(OFST+1,sp)
 970  019f e603          	ld	a,(3,x)
 971  01a1 1101          	cp	a,(OFST-2,sp)
 972  01a3 22d2          	jrugt	L104
 973                     ; 207 	return NULL;
 975  01a5 20c8          	jpf	LC002
1023                     ; 221 void tl_remove(tl_t tl, tl_task_t task)
1023                     ; 222 {
1024                     	switch	.text
1025  01a7               f_tl_remove:
1027  01a7 89            	pushw	x
1028       00000000      OFST:	set	0
1031                     ; 223 	if(task == NULL) return;
1033  01a8 1e06          	ldw	x,(OFST+6,sp)
1034  01aa 2706          	jreq	L44
1037                     ; 225     if(task->belong_to != tl) return;
1039  01ac ee0e          	ldw	x,(14,x)
1040  01ae 1301          	cpw	x,(OFST+1,sp)
1041  01b0 2702          	jreq	L544
1043  01b2               L44:
1046  01b2 85            	popw	x
1047  01b3 87            	retf	
1048  01b4               L544:
1049                     ; 226     task->st = TL_DEAD;
1051  01b4 1e06          	ldw	x,(OFST+6,sp)
1052  01b6 a602          	ld	a,#2
1053  01b8 e70d          	ld	(13,x),a
1054                     ; 228     tl->task_sz--;
1057  01ba 1e01          	ldw	x,(OFST+1,sp)
1058  01bc 6a02          	dec	(2,x)
1059                     ; 230 }
1062  01be 20f2          	jra	L44
1110                     ; 243 void tl_pause(tl_t tl, tl_task_t task)
1110                     ; 244 {
1111                     	switch	.text
1112  01c0               f_tl_pause:
1114  01c0 89            	pushw	x
1115       00000000      OFST:	set	0
1118                     ; 245     if(task == NULL) return;
1120  01c1 1e06          	ldw	x,(OFST+6,sp)
1121  01c3 2706          	jreq	L05
1124                     ; 246     if(task->belong_to != tl) return;
1126  01c5 ee0e          	ldw	x,(14,x)
1127  01c7 1301          	cpw	x,(OFST+1,sp)
1128  01c9 2702          	jreq	L774
1130  01cb               L05:
1133  01cb 85            	popw	x
1134  01cc 87            	retf	
1135  01cd               L774:
1136                     ; 247 	if(task->st == TL_DEAD) return;
1138  01cd 1e06          	ldw	x,(OFST+6,sp)
1139  01cf e60d          	ld	a,(13,x)
1140  01d1 a102          	cp	a,#2
1141  01d3 27f6          	jreq	L05
1144                     ; 248     task->st = TL_PAUSED;
1146  01d5 a601          	ld	a,#1
1147  01d7 e70d          	ld	(13,x),a
1148                     ; 249 }
1150  01d9 20f0          	jra	L05
1186                     ; 262 void tl_pause_all(tl_t tl)
1186                     ; 263 {
1187                     	switch	.text
1188  01db               f_tl_pause_all:
1190       00000000      OFST:	set	0
1193                     ; 264     if(tl == NULL) return;
1195  01db 5d            	tnzw	x
1196  01dc 2704          	jreq	L45
1199                     ; 265     tl->disable = 1;
1201  01de a601          	ld	a,#1
1202  01e0 e708          	ld	(8,x),a
1203                     ; 266 }
1204  01e2               L45:
1207  01e2 87            	retf	
1243                     ; 280 void tl_resume_all(tl_t tl)
1243                     ; 281 {
1244                     	switch	.text
1245  01e3               f_tl_resume_all:
1247       00000000      OFST:	set	0
1250                     ; 282     if(tl == NULL) return;
1252  01e3 5d            	tnzw	x
1253  01e4 2702          	jreq	L06
1256                     ; 283     tl->disable = 0;
1258  01e6 6f08          	clr	(8,x)
1259                     ; 284 }
1260  01e8               L06:
1263  01e8 87            	retf	
1311                     ; 297 void tl_resume(tl_t tl, tl_task_t task)
1311                     ; 298 {
1312                     	switch	.text
1313  01e9               f_tl_resume:
1315  01e9 89            	pushw	x
1316       00000000      OFST:	set	0
1319                     ; 299 	if(task == NULL) return;
1321  01ea 1e06          	ldw	x,(OFST+6,sp)
1322  01ec 2706          	jreq	L46
1325                     ; 300 	if(tl != task->belong_to) return;
1327  01ee ee0e          	ldw	x,(14,x)
1328  01f0 1301          	cpw	x,(OFST+1,sp)
1329  01f2 2702          	jreq	L775
1331  01f4               L46:
1334  01f4 85            	popw	x
1335  01f5 87            	retf	
1336  01f6               L775:
1337                     ; 301     if(TL_DEAD == task->st) return;
1339  01f6 1e06          	ldw	x,(OFST+6,sp)
1340  01f8 e60d          	ld	a,(13,x)
1341  01fa a102          	cp	a,#2
1342  01fc 27f6          	jreq	L46
1345                     ; 302     task->st = TL_READY;
1347  01fe 6f0d          	clr	(13,x)
1348                     ; 304 }
1350  0200 20f2          	jra	L46
1405                     ; 320 void tl_update(tl_t tl)
1405                     ; 321 {
1406                     	switch	.text
1407  0202               f_tl_update:
1409  0202 89            	pushw	x
1410  0203 5203          	subw	sp,#3
1411       00000003      OFST:	set	3
1414                     ; 322     uint8_t i = 0;
1416                     ; 323     tl_ele_t * tlele = NULL;
1418                     ; 324 	if(tl == NULL) return;
1420  0205 5d            	tnzw	x
1421  0206 2704          	jreq	L27
1424                     ; 325 	if(tl->disable) return;
1426  0208 e608          	ld	a,(8,x)
1427  020a 2703          	jreq	L536
1429  020c               L27:
1432  020c 5b05          	addw	sp,#5
1433  020e 87            	retf	
1434  020f               L536:
1435                     ; 326     tl->tick++;
1437  020f 1c0004        	addw	x,#4
1438  0212 4c            	inc	a
1439  0213 8d000000      	callf	d_lgadc
1441                     ; 329     for(i = 0;i < tl->task_sz; i++)
1443  0217 0f01          	clr	(OFST-2,sp)
1446  0219 ac9e029e      	jra	L346
1447  021d               L736:
1448                     ; 332         tlele = &tl->tasks[i];
1450  021d 7b01          	ld	a,(OFST-2,sp)
1451  021f 97            	ld	xl,a
1452  0220 a610          	ld	a,#16
1453  0222 42            	mul	x,a
1454  0223 1604          	ldw	y,(OFST+1,sp)
1455  0225 01            	rrwa	x,a
1456  0226 90eb01        	add	a,(1,y)
1457  0229 01            	rrwa	x,a
1458  022a 90f9          	adc	a,(y)
1459  022c 01            	rrwa	x,a
1460  022d 1f02          	ldw	(OFST-1,sp),x
1462                     ; 333         if(tlele->st ==  TL_PAUSED)
1464  022f e60d          	ld	a,(13,x)
1465  0231 4a            	dec	a
1466  0232 260a          	jrne	L746
1467                     ; 335             tlele->next_exe_ts++;
1469  0234 1c0009        	addw	x,#9
1470  0237 4c            	inc	a
1471  0238 8d000000      	callf	d_lgadc
1474  023c 205e          	jra	L156
1475  023e               L746:
1476                     ; 336         } else if((tlele->st == TL_READY) && (tl->tick == tlele->next_exe_ts)) {
1478  023e e60d          	ld	a,(13,x)
1479  0240 265a          	jrne	L156
1481  0242 1e04          	ldw	x,(OFST+1,sp)
1482  0244 1c0004        	addw	x,#4
1483  0247 8d000000      	callf	d_ltor
1485  024b 1e02          	ldw	x,(OFST-1,sp)
1486  024d 1c0009        	addw	x,#9
1487  0250 8d000000      	callf	d_lcmp
1489  0254 2646          	jrne	L156
1490                     ; 337             tlele->run(tlele->param);
1492  0256 1e02          	ldw	x,(OFST-1,sp)
1493  0258 1602          	ldw	y,(OFST-1,sp)
1494  025a ee03          	ldw	x,(3,x)
1495  025c 90f6          	ld	a,(y)
1496  025e b700          	ld	c_y,a
1497  0260 90ee01        	ldw	y,(1,y)
1498  0263 90bf01        	ldw	c_y+1,y
1499  0266 928d0000      	callf	[c_y.e]
1501                     ; 338             if(tlele->period != 0)
1503  026a 1e02          	ldw	x,(OFST-1,sp)
1504  026c 1c0005        	addw	x,#5
1505  026f 8d000000      	callf	d_lzmp
1507  0273 271d          	jreq	L556
1508                     ; 340                 tlele->next_exe_ts = (tlele->period + tl->tick);
1510  0275 1e04          	ldw	x,(OFST+1,sp)
1511  0277 1c0004        	addw	x,#4
1512  027a 8d000000      	callf	d_ltor
1514  027e 1e02          	ldw	x,(OFST-1,sp)
1515  0280 1c0005        	addw	x,#5
1516  0283 8d000000      	callf	d_ladd
1518  0287 1e02          	ldw	x,(OFST-1,sp)
1519  0289 1c0009        	addw	x,#9
1520  028c 8d000000      	callf	d_rtol
1523  0290 200a          	jra	L156
1524  0292               L556:
1525                     ; 342                 tlele->st = TL_DEAD;
1527  0292 1e02          	ldw	x,(OFST-1,sp)
1528  0294 a602          	ld	a,#2
1529  0296 e70d          	ld	(13,x),a
1530                     ; 343                 tl->task_sz--;
1532  0298 1e04          	ldw	x,(OFST+1,sp)
1533  029a 6a02          	dec	(2,x)
1534  029c               L156:
1535                     ; 329     for(i = 0;i < tl->task_sz; i++)
1537  029c 0c01          	inc	(OFST-2,sp)
1539  029e               L346:
1542  029e 1e04          	ldw	x,(OFST+1,sp)
1543  02a0 e602          	ld	a,(2,x)
1544  02a2 1101          	cp	a,(OFST-2,sp)
1545  02a4 2304ac1d021d  	jrugt	L736
1546                     ; 347 }
1548  02aa ac0c020c      	jra	L27
1584                     ; 357 uint32_t tl_get_timestamp(tl_t tl)
1584                     ; 358 {
1585                     	switch	.text
1586  02ae               f_tl_get_timestamp:
1590                     ; 359     return tl->tick;
1592  02ae 1c0004        	addw	x,#4
1596  02b1 ac000000      	jpf	d_ltor
1608                     	xref	f_memset
1609                     	xdef	f_tl_get_timestamp
1610                     	xdef	f_tl_update
1611                     	xdef	f_tl_resume_all
1612                     	xdef	f_tl_resume
1613                     	xdef	f_tl_pause_all
1614                     	xdef	f_tl_pause
1615                     	xdef	f_tl_remove
1616                     	xdef	f_tl_add_singleton
1617                     	xdef	f_tl_add
1618                     	xdef	f_tl_init
1619                     	xref.b	c_y
1638                     	xref	d_lzmp
1639                     	xref	d_lcmp
1640                     	xref	d_lgadc
1641                     	xref	d_rtol
1642                     	xref	d_ladc
1643                     	xref	d_ladd
1644                     	xref	d_ltor
1645                     	end
