
_interrupt:
	MOVWF      R15+0
	SWAPF      STATUS+0, 0
	CLRF       STATUS+0
	MOVWF      ___saveSTATUS+0
	MOVF       PCLATH+0, 0
	MOVWF      ___savePCLATH+0
	CLRF       PCLATH+0

;flasher.c,6 :: 		void interrupt(){
;flasher.c,8 :: 		if( intf_bit==1 ){
	BTFSS      INTF_bit+0, BitPos(INTF_bit+0)
	GOTO       L_interrupt0
;flasher.c,9 :: 		intf_bit=0;
	BCF        INTF_bit+0, BitPos(INTF_bit+0)
;flasher.c,10 :: 		count++;
	INCF       _count+0, 1
;flasher.c,12 :: 		}
L_interrupt0:
;flasher.c,14 :: 		}
L_end_interrupt:
L__interrupt39:
	MOVF       ___savePCLATH+0, 0
	MOVWF      PCLATH+0
	SWAPF      ___saveSTATUS+0, 0
	MOVWF      STATUS+0
	SWAPF      R15+0, 1
	SWAPF      R15+0, 0
	RETFIE
; end of _interrupt

_main:

;flasher.c,15 :: 		void main() {
;flasher.c,16 :: 		trisc=0;trisd=0;trisa=0;trisb=1;trise=0;
	CLRF       TRISC+0
	CLRF       TRISD+0
	CLRF       TRISA+0
	MOVLW      1
	MOVWF      TRISB+0
	CLRF       TRISE+0
;flasher.c,17 :: 		adcon1=7;
	MOVLW      7
	MOVWF      ADCON1+0
;flasher.c,18 :: 		gie_bit=1;      //global enable
	BSF        GIE_bit+0, BitPos(GIE_bit+0)
;flasher.c,19 :: 		inte_bit=1;     //enable
	BSF        INTE_bit+0, BitPos(INTE_bit+0)
;flasher.c,20 :: 		intedg_bit=0;   //falling edge
	BCF        INTEDG_bit+0, BitPos(INTEDG_bit+0)
;flasher.c,21 :: 		for(;;){
L_main1:
;flasher.c,22 :: 		portc=0;portd=0;porta=0;portb=0;porte=0;
	CLRF       PORTC+0
	CLRF       PORTD+0
	CLRF       PORTA+0
	CLRF       PORTB+0
	CLRF       PORTE+0
;flasher.c,24 :: 		while(portb.B1==0){
L_main4:
	BTFSC      PORTB+0, 1
	GOTO       L_main5
;flasher.c,25 :: 		for(i=0;i<=23;i++)
	CLRF       _i+0
L_main6:
	MOVF       _i+0, 0
	SUBLW      23
	BTFSS      STATUS+0, 0
	GOTO       L_main7
;flasher.c,26 :: 		{ if(portb.b1==1) break;
	BTFSS      PORTB+0, 1
	GOTO       L_main9
	GOTO       L_main7
L_main9:
;flasher.c,27 :: 		portc=arr1[i];
	MOVF       _i+0, 0
	ADDLW      _arr1+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      PORTC+0
;flasher.c,28 :: 		portd=arr1[i+3];
	MOVLW      3
	ADDWF      _i+0, 0
	MOVWF      R0+0
	CLRF       R0+1
	BTFSC      STATUS+0, 0
	INCF       R0+1, 1
	MOVF       R0+0, 0
	ADDLW      _arr1+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      PORTD+0
;flasher.c,29 :: 		porta=0b001001;
	MOVLW      9
	MOVWF      PORTA+0
;flasher.c,30 :: 		porte=0b100;
	MOVLW      4
	MOVWF      PORTE+0
;flasher.c,31 :: 		delay_ms(500);
	MOVLW      6
	MOVWF      R11+0
	MOVLW      19
	MOVWF      R12+0
	MOVLW      173
	MOVWF      R13+0
L_main10:
	DECFSZ     R13+0, 1
	GOTO       L_main10
	DECFSZ     R12+0, 1
	GOTO       L_main10
	DECFSZ     R11+0, 1
	GOTO       L_main10
	NOP
	NOP
;flasher.c,32 :: 		if(portd==0b00000000){
	MOVF       PORTD+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_main11
;flasher.c,33 :: 		while(i<=23){
L_main12:
	MOVF       _i+0, 0
	SUBLW      23
	BTFSS      STATUS+0, 0
	GOTO       L_main13
;flasher.c,34 :: 		portc=arr1[i];
	MOVF       _i+0, 0
	ADDLW      _arr1+0
	MOVWF      R0+0
	MOVF       R0+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      PORTC+0
;flasher.c,35 :: 		portd=arr1[i];
	MOVF       R0+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      PORTD+0
;flasher.c,36 :: 		porta=0b001001;
	MOVLW      9
	MOVWF      PORTA+0
;flasher.c,37 :: 		porte=0b010;
	MOVLW      2
	MOVWF      PORTE+0
;flasher.c,38 :: 		delay_ms(500);
	MOVLW      6
	MOVWF      R11+0
	MOVLW      19
	MOVWF      R12+0
	MOVLW      173
	MOVWF      R13+0
L_main14:
	DECFSZ     R13+0, 1
	GOTO       L_main14
	DECFSZ     R12+0, 1
	GOTO       L_main14
	DECFSZ     R11+0, 1
	GOTO       L_main14
	NOP
	NOP
;flasher.c,39 :: 		i++;
	INCF       _i+0, 1
;flasher.c,40 :: 		}
	GOTO       L_main12
L_main13:
;flasher.c,41 :: 		}
L_main11:
;flasher.c,25 :: 		for(i=0;i<=23;i++)
	INCF       _i+0, 1
;flasher.c,43 :: 		}
	GOTO       L_main6
L_main7:
;flasher.c,44 :: 		for(j=0;j<=15;j++)
	CLRF       _j+0
L_main15:
	MOVF       _j+0, 0
	SUBLW      15
	BTFSS      STATUS+0, 0
	GOTO       L_main16
;flasher.c,45 :: 		{   if(portb.b1==1) break;
	BTFSS      PORTB+0, 1
	GOTO       L_main18
	GOTO       L_main16
L_main18:
;flasher.c,46 :: 		portc=arr2[j+3];
	MOVLW      3
	ADDWF      _j+0, 0
	MOVWF      R0+0
	CLRF       R0+1
	BTFSC      STATUS+0, 0
	INCF       R0+1, 1
	MOVF       R0+0, 0
	ADDLW      _arr2+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      PORTC+0
;flasher.c,47 :: 		portd=arr2[j];
	MOVF       _j+0, 0
	ADDLW      _arr2+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      PORTD+0
;flasher.c,48 :: 		porta=0b001100;
	MOVLW      12
	MOVWF      PORTA+0
;flasher.c,49 :: 		porte=0b001;
	MOVLW      1
	MOVWF      PORTE+0
;flasher.c,50 :: 		delay_ms(500);
	MOVLW      6
	MOVWF      R11+0
	MOVLW      19
	MOVWF      R12+0
	MOVLW      173
	MOVWF      R13+0
L_main19:
	DECFSZ     R13+0, 1
	GOTO       L_main19
	DECFSZ     R12+0, 1
	GOTO       L_main19
	DECFSZ     R11+0, 1
	GOTO       L_main19
	NOP
	NOP
;flasher.c,51 :: 		if(portc==0b00000000){
	MOVF       PORTC+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_main20
;flasher.c,52 :: 		while(j<=15){
L_main21:
	MOVF       _j+0, 0
	SUBLW      15
	BTFSS      STATUS+0, 0
	GOTO       L_main22
;flasher.c,53 :: 		portc=arr2[j];
	MOVF       _j+0, 0
	ADDLW      _arr2+0
	MOVWF      R0+0
	MOVF       R0+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      PORTC+0
;flasher.c,54 :: 		portd=arr2[j];
	MOVF       R0+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      PORTD+0
;flasher.c,55 :: 		porta=0b001010;
	MOVLW      10
	MOVWF      PORTA+0
;flasher.c,56 :: 		porte=0b001;
	MOVLW      1
	MOVWF      PORTE+0
;flasher.c,57 :: 		delay_ms(500);
	MOVLW      6
	MOVWF      R11+0
	MOVLW      19
	MOVWF      R12+0
	MOVLW      173
	MOVWF      R13+0
L_main23:
	DECFSZ     R13+0, 1
	GOTO       L_main23
	DECFSZ     R12+0, 1
	GOTO       L_main23
	DECFSZ     R11+0, 1
	GOTO       L_main23
	NOP
	NOP
;flasher.c,58 :: 		j++;
	INCF       _j+0, 1
;flasher.c,59 :: 		}
	GOTO       L_main21
L_main22:
;flasher.c,60 :: 		}
L_main20:
;flasher.c,44 :: 		for(j=0;j<=15;j++)
	INCF       _j+0, 1
;flasher.c,62 :: 		}
	GOTO       L_main15
L_main16:
;flasher.c,63 :: 		}
	GOTO       L_main4
L_main5:
;flasher.c,65 :: 		while(portb.b1==1){
L_main24:
	BTFSS      PORTB+0, 1
	GOTO       L_main25
;flasher.c,66 :: 		if(count==1){
	MOVF       _count+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_main26
;flasher.c,67 :: 		porta=0b001001;
	MOVLW      9
	MOVWF      PORTA+0
;flasher.c,68 :: 		porte=0b100;}
	MOVLW      4
	MOVWF      PORTE+0
L_main26:
;flasher.c,70 :: 		if(count==2){
	MOVF       _count+0, 0
	XORLW      2
	BTFSS      STATUS+0, 2
	GOTO       L_main27
;flasher.c,72 :: 		while(k>=0){
L_main28:
	MOVLW      0
	SUBWF      _k+0, 0
	BTFSS      STATUS+0, 0
	GOTO       L_main29
;flasher.c,73 :: 		if(k==0) {k=3;
	MOVF       _k+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_main30
	MOVLW      3
	MOVWF      _k+0
;flasher.c,74 :: 		count=3;
	MOVLW      3
	MOVWF      _count+0
;flasher.c,75 :: 		break;}
	GOTO       L_main29
L_main30:
;flasher.c,76 :: 		porta=0b001001;
	MOVLW      9
	MOVWF      PORTA+0
;flasher.c,77 :: 		porte=0b010;
	MOVLW      2
	MOVWF      PORTE+0
;flasher.c,78 :: 		portd=k;
	MOVF       _k+0, 0
	MOVWF      PORTD+0
;flasher.c,79 :: 		delay_ms(500);
	MOVLW      6
	MOVWF      R11+0
	MOVLW      19
	MOVWF      R12+0
	MOVLW      173
	MOVWF      R13+0
L_main31:
	DECFSZ     R13+0, 1
	GOTO       L_main31
	DECFSZ     R12+0, 1
	GOTO       L_main31
	DECFSZ     R11+0, 1
	GOTO       L_main31
	NOP
	NOP
;flasher.c,80 :: 		k--;
	DECF       _k+0, 1
;flasher.c,81 :: 		}
	GOTO       L_main28
L_main29:
;flasher.c,82 :: 		}
L_main27:
;flasher.c,84 :: 		if(count==3){
	MOVF       _count+0, 0
	XORLW      3
	BTFSS      STATUS+0, 2
	GOTO       L_main32
;flasher.c,85 :: 		porta=0b001100;
	MOVLW      12
	MOVWF      PORTA+0
;flasher.c,86 :: 		porte=0b001;
	MOVLW      1
	MOVWF      PORTE+0
;flasher.c,87 :: 		}
L_main32:
;flasher.c,88 :: 		if(count==4){
	MOVF       _count+0, 0
	XORLW      4
	BTFSS      STATUS+0, 2
	GOTO       L_main33
;flasher.c,89 :: 		while(m>=0 ){
L_main34:
	MOVLW      0
	SUBWF      _m+0, 0
	BTFSS      STATUS+0, 0
	GOTO       L_main35
;flasher.c,90 :: 		if (m== 0){m=3;break;}
	MOVF       _m+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_main36
	MOVLW      3
	MOVWF      _m+0
	GOTO       L_main35
L_main36:
;flasher.c,91 :: 		porta=0b001010;
	MOVLW      10
	MOVWF      PORTA+0
;flasher.c,92 :: 		porte=0b001;
	MOVLW      1
	MOVWF      PORTE+0
;flasher.c,93 :: 		portc=m;
	MOVF       _m+0, 0
	MOVWF      PORTC+0
;flasher.c,94 :: 		delay_ms(500);
	MOVLW      6
	MOVWF      R11+0
	MOVLW      19
	MOVWF      R12+0
	MOVLW      173
	MOVWF      R13+0
L_main37:
	DECFSZ     R13+0, 1
	GOTO       L_main37
	DECFSZ     R12+0, 1
	GOTO       L_main37
	DECFSZ     R11+0, 1
	GOTO       L_main37
	NOP
	NOP
;flasher.c,95 :: 		m--;
	DECF       _m+0, 1
;flasher.c,96 :: 		count=1;
	MOVLW      1
	MOVWF      _count+0
;flasher.c,97 :: 		}
	GOTO       L_main34
L_main35:
;flasher.c,98 :: 		}
L_main33:
;flasher.c,101 :: 		}
	GOTO       L_main24
L_main25:
;flasher.c,102 :: 		}
	GOTO       L_main1
;flasher.c,104 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
