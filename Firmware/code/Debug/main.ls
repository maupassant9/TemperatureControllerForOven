   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.13.3 - 22 May 2025
   3                     ; Generator (Limited) V4.6.6 - 07 Jan 2026
   4                     ; Optimizer V4.6.6 - 07 Jan 2026
  19                     	switch	.data
  20  0000               L3_st:
  21  0000 00            	dc.b	0
 111                     ; 5 void main()
 111                     ; 6 {
 112                     	switch	.text
 113  0000               f_main:
 117                     ; 8   st = main_sm(st);
 119  0000 c60000        	ld	a,L3_st
 120  0003 8d000000      	callf	f_main_sm
 122  0007 c70000        	ld	L3_st,a
 123                     ; 9 }
 126  000a 87            	retf	
 138                     	xdef	f_main
 139                     	xref	f_main_sm
 158                     	end
