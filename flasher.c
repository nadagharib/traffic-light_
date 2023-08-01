 char arr1[]={0b00100011,0b00100010,0b00100001,0b00100000,0b00011001,0b00011000,0b00010111,0b00010110,0b00010101,0b00010100,0b00010011,0b00010010,0b00010001,0b00010000,0b00001001,0b00001000,0b00000111,0b00000110,0b00000101,0b00000100,0b00000011,0b00000010,0b00000001,0b00000000};
char arr2[]={0b00010101,0b00010100,0b00010011,0b00010010,0b00010001,0b00010000,0b00001001,0b00001000,0b00000111,0b00000110,0b00000101,0b00000100,0b00000011,0b00000010,0b00000001,0b00000000};
 char i=0;
 char j=0;
 char k=3,m=3; char count=0;
void interrupt(){

  if( intf_bit==1 ){
    intf_bit=0;
    count++;

    }

}
void main() {
trisc=0;trisd=0;trisa=0;trisb=1;trise=0;
  adcon1=7;
  gie_bit=1;      //global enable
  inte_bit=1;     //enable
  intedg_bit=0;   //falling edge
  for(;;){
  portc=0;portd=0;porta=0;portb=0;porte=0;
   // auto
   while(portb.B1==0){
    for(i=0;i<=23;i++)
    { if(portb.b1==1) break;
      portc=arr1[i];
      portd=arr1[i+3];
      porta=0b001001;
      porte=0b100;
      delay_ms(500);
      if(portd==0b00000000){
        while(i<=23){
        portc=arr1[i];
        portd=arr1[i];
         porta=0b001001;
         porte=0b010;
         delay_ms(500);
         i++;
        }
       }

     }
     for(j=0;j<=15;j++)
    {   if(portb.b1==1) break;
      portc=arr2[j+3];
      portd=arr2[j];
      porta=0b001100;
      porte=0b001;
      delay_ms(500);
      if(portc==0b00000000){
        while(j<=15){
        portc=arr2[j];
        portd=arr2[j];
        porta=0b001010;
        porte=0b001;
         delay_ms(500);
         j++;
        }
       }

     }      
     }
       //manual
   while(portb.b1==1){
      if(count==1){
    porta=0b001001;
    porte=0b100;}

    if(count==2){

     while(k>=0){
     if(k==0) {k=3; 
    count=3;
      break;}
      porta=0b001001;
      porte=0b010;
      portd=k;
     delay_ms(500);
      k--;
     }
   }

    if(count==3){
    porta=0b001100;
    porte=0b001;
    }
     if(count==4){
     while(m>=0 ){
     if (m== 0){m=3;break;}
     porta=0b001010;
     porte=0b001;
     portc=m;
      delay_ms(500);
      m--;
      count=1;
     }
    }


   }
  }

}