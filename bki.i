
#pragma used+
sfrb PINF=0;
sfrb PINE=1;
sfrb DDRE=2;
sfrb PORTE=3;
sfrb ADCL=4;
sfrb ADCH=5;
sfrw ADCW=4;      
sfrb ADCSRA=6;
sfrb ADMUX=7;
sfrb ACSR=8;
sfrb UBRR0L=9;
sfrb UCSR0B=0xa;
sfrb UCSR0A=0xb;
sfrb UDR0=0xc;
sfrb SPCR=0xd;
sfrb SPSR=0xe;
sfrb SPDR=0xf;
sfrb PIND=0x10;
sfrb DDRD=0x11;
sfrb PORTD=0x12;
sfrb PINC=0x13;
sfrb DDRC=0x14;
sfrb PORTC=0x15;
sfrb PINB=0x16;
sfrb DDRB=0x17;
sfrb PORTB=0x18;
sfrb PINA=0x19;
sfrb DDRA=0x1a;
sfrb PORTA=0x1b;
sfrb EECR=0x1c;
sfrb EEDR=0x1d;
sfrb EEARL=0x1e;
sfrb EEARH=0x1f;
sfrw EEAR=0x1e;   
sfrb SFIOR=0x20;
sfrb WDTCR=0x21;
sfrb OCDR=0x22;
sfrb OCR2=0x23;
sfrb TCNT2=0x24;
sfrb TCCR2=0x25;
sfrb ICR1L=0x26;
sfrb ICR1H=0x27;
sfrw ICR1=0x26;   
sfrb OCR1BL=0x28;
sfrb OCR1BH=0x29;
sfrw OCR1B=0x28;  
sfrb OCR1AL=0x2a;
sfrb OCR1AH=0x2b;
sfrw OCR1A=0x2a;  
sfrb TCNT1L=0x2c;
sfrb TCNT1H=0x2d;
sfrw TCNT1=0x2c;  
sfrb TCCR1B=0x2e;
sfrb TCCR1A=0x2f;
sfrb ASSR=0x30;
sfrb OCR0=0x31;
sfrb TCNT0=0x32;
sfrb TCCR0=0x33;
sfrb MCUCSR=0x34;
sfrb MCUCR=0x35;
sfrb TIFR=0x36;
sfrb TIMSK=0x37;
sfrb EIFR=0x38;
sfrb EIMSK=0x39;
sfrb EICRB=0x3a;
sfrb RAMPZ=0x3b;
sfrb XDIV=0x3c;
sfrb SPL=0x3d;
sfrb SPH=0x3e;
sfrb SREG=0x3f;
#pragma used-

#asm
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x20
	.EQU __sm_mask=0x1C
	.EQU __sm_powerdown=0x10
	.EQU __sm_powersave=0x18
	.EQU __sm_standby=0x14
	.EQU __sm_ext_standby=0x1C
	.EQU __sm_adc_noise_red=0x08
	.SET power_ctrl_reg=mcucr
	#endif
#endasm

#pragma used+

void delay_us(unsigned int n);
void delay_ms(unsigned int n);

#pragma used-

#pragma used+

signed char cmax(signed char a,signed char b);
int max(int a,int b);
long lmax(long a,long b);
float fmax(float a,float b);
signed char cmin(signed char a,signed char b);
int min(int a,int b);
long lmin(long a,long b);
float fmin(float a,float b);
signed char csign(signed char x);
signed char sign(int x);
signed char lsign(long x);
signed char fsign(float x);
unsigned char isqrt(unsigned int x);
unsigned int lsqrt(unsigned long x);
float sqrt(float x);
float floor(float x);
float ceil(float x);
float fmod(float x,float y);
float modf(float x,float *ipart);
float ldexp(float x,int expon);
float frexp(float x,int *expon);
float exp(float x);
float log(float x);
float log10(float x);
float pow(float x,float y);
float sin(float x);
float cos(float x);
float tan(float x);
float sinh(float x);
float cosh(float x);
float tanh(float x);
float asin(float x);
float acos(float x);
float atan(float x);
float atan2(float y,float x);

#pragma used-
#pragma library math.lib

typedef char *va_list;

#pragma used+

char getchar(void);
void putchar(char c);
void puts(char *str);
void putsf(char flash *str);

char *gets(char *str,unsigned int len);

void printf(char flash *fmtstr,...);
void sprintf(char *str, char flash *fmtstr,...);
void snprintf(char *str, unsigned int size, char flash *fmtstr,...);
void vprintf (char flash * fmtstr, va_list argptr);
void vsprintf (char *str, char flash * fmtstr, va_list argptr);
void vsnprintf (char *str, unsigned int size, char flash * fmtstr, va_list argptr);
signed char scanf(char flash *fmtstr,...);
signed char sscanf(char *str, char flash *fmtstr,...);

#pragma used-

#pragma library stdio.lib

signed int LedQ=0,rms=0;
unsigned int SKZ_1,SKZ_2,SKZ1toSKZ2,SKZ_read,intro_cntr=0,intro_enabled=1,true_skz=0;
int terminal_mode=0,BPS_absent=0,PC_absent=0,w=0,rms_read=0,bps_absent_ctr=0;
void mov_buf_slave(char a);
void crc_end_slave();	
void send_test();	
void eeprom_reset();
void EEPROM_write(unsigned int eeAddress, unsigned char eeData);
char rx_buffer_master[128],rd_counts=0, CalibrFlag=0, r=0,object_state=1,SPI_tEnd=1;
unsigned int ModBusAddress=1,minimal_SKZ_val=30, minimal_object_enabled_level=40;
unsigned char rx_wr_index_master,rx_counter_master,mod_time_master,CRCHigh,CRCLow,reg91_answer;
int crc_master,crc_slave,rd_counter=0,AverTime_Value=30,AvTimer=0,start_calibration=0,finish_calibration=0,calibration_counter=0, flash_erase_flag = 0, AverSKZ_Value = 0;
bit tx_en_master,rx_m_master,rx_c_master,new_message,BKI_state_sent=0,ProcessingEEPROM=0;
char str[15];
void GetCRC16(char len);	
void CRC_update(unsigned char d);
unsigned char tx_buffer_counter_master,tx_buffer_counter_slave,adres,FreqOrder_read;
unsigned char i,drebezg;
float data[4];
signed char RecievedData[5],RecievedData5[6],AverSKZprcnt=0;
unsigned int BlinkCounter_Calibration=0,tok;
int warning_flag=0, FrequencyQ=3, ModbusMessage=0;
int blink_flag=0,red=0,calibration_correct=1;
int warning_flag_=0;
float ii;
unsigned long adc_buf;
bit press,first_press,second_press,AverTime_Flag=0, SendSKZsave_req=0;
unsigned int reg[40];
signed long SKZread_counter=0;
static int DeviceID=0x3491;
static int crctable[256]= {
0x0000, 0xC1C0, 0x81C1, 0x4001, 0x01C3, 0xC003, 0x8002, 0x41C2, 0x01C6, 0xC006,
0x8007, 0x41C7, 0x0005, 0xC1C5, 0x81C4, 0x4004, 0x01CC, 0xC00C, 0x800D, 0x41CD,
0x000F, 0xC1CF, 0x81CE, 0x400E, 0x000A, 0xC1CA, 0x81CB, 0x400B, 0x01C9, 0xC009,
0x8008, 0x41C8, 0x01D8, 0xC018, 0x8019, 0x41D9, 0x001B, 0xC1DB, 0x81DA, 0x401A,
0x001E, 0xC1DE, 0x81DF, 0x401F, 0x01DD, 0xC01D, 0x801C, 0x41DC, 0x0014, 0xC1D4,
0x81D5, 0x4015, 0x01D7, 0xC017, 0x8016, 0x41D6, 0x01D2, 0xC012, 0x8013, 0x41D3,
0x0011, 0xC1D1, 0x81D0, 0x4010, 0x01F0, 0xC030, 0x8031, 0x41F1, 0x0033, 0xC1F3,
0x81F2, 0x4032, 0x0036, 0xC1F6, 0x81F7, 0x4037, 0x01F5, 0xC035, 0x8034, 0x41F4,
0x003C, 0xC1FC, 0x81FD, 0x403D, 0x01FF, 0xC03F, 0x803E, 0x41FE, 0x01FA, 0xC03A, 
0x803B, 0x41FB, 0x0039, 0xC1F9, 0x81F8, 0x4038, 0x0028, 0xC1E8, 0x81E9, 0x4029,
0x01EB, 0xC02B, 0x802A, 0x41EA, 0x01EE, 0xC02E, 0x802F, 0x41EF, 0x002D, 0xC1ED,
0x81EC, 0x402C, 0x01E4, 0xC024, 0x8025, 0x41E5, 0x0027, 0xC1E7, 0x81E6, 0x4026,
0x0022, 0xC1E2, 0x81E3, 0x4023, 0x01E1, 0xC021, 0x8020, 0x41E0, 0x01A0, 0xC060, 
0x8061, 0x41A1, 0x0063, 0xC1A3, 0x81A2, 0x4062, 0x0066, 0xC1A6, 0x81A7, 0x4067,
0x01A5, 0xC065, 0x8064, 0x41A4, 0x006C, 0xC1AC, 0x81AD, 0x406D, 0x01AF, 0xC06F,
0x806E, 0x41AE, 0x01AA, 0xC06A, 0x806B, 0x41AB, 0x0069, 0xC1A9, 0x81A8, 0x4068, 
0x0078, 0xC1B8, 0x81B9, 0x4079, 0x01BB, 0xC07B, 0x807A, 0x41BA, 0x01BE, 0xC07E,
0x807F, 0x41BF, 0x007D, 0xC1BD, 0x81BC, 0x407C, 0x01B4, 0xC074, 0x8075, 0x41B5, 
0x0077, 0xC1B7, 0x81B6, 0x4076, 0x0072, 0xC1B2, 0x81B3, 0x4073, 0x01B1, 0xC071,
0x8070, 0x41B0, 0x0050, 0xC190, 0x8191, 0x4051, 0x0193, 0xC053, 0x8052, 0x4192, 
0x0196, 0xC056, 0x8057, 0x4197, 0x0055, 0xC195, 0x8194, 0x4054, 0x019C, 0xC05C,
0x805D, 0x419D, 0x005F, 0xC19F, 0x819E, 0x405E, 0x005A, 0xC19A, 0x819B, 0x405B, 
0x0199, 0xC059, 0x8058, 0x4198, 0x0188, 0xC048, 0x8049, 0x4189, 0x004B, 0xC18B,
0x818A, 0x404A, 0x004E, 0xC18E, 0x818F, 0x404F, 0x018D, 0xC04D, 0x804C, 0x418C,
0x0044, 0xC184, 0x8185, 0x4045, 0x0187, 0xC047, 0x8046, 0x4186, 0x0182, 0xC042,
0x8043, 0x4183, 0x0041, 0xC181, 0x8180, 0x4040
}; 

interrupt [31] void usart1_rx_isr(void)
{
char st,d;
st=(*(unsigned char *) 0x9b);d=(*(unsigned char *) 0x9c);
if ((tx_en_master==0)&&(rx_c_master==0))
{
if (mod_time_master==0){rx_m_master=1;rx_wr_index_master=0;}
mod_time_master=200;
rx_buffer_master[rx_wr_index_master]=d;
if (++rx_wr_index_master >=128) rx_wr_index_master=0;
if (++rx_counter_master >= 128) rx_counter_master=0;
}

}

char rx_buffer_slave[128], RData;
unsigned char rx_wr_index_slave,rx_counter_slave,mod_time_slave;
bit tx_en_slave,rx_m_slave,rx_c_slave;
char tx_buffer_slave[128];
unsigned char tx_buffer_begin_slave,tx_buffer_end_slave;
interrupt [19] void usart0_rx_isr(void)
{
char st,d;
int ii = 0;

#asm ("cli")
st=UCSR0A;d=UDR0;
#asm ("sei")
if(rx_counter_slave==0)rd_counts=0;
UCSR0B=0x90;

if (tx_en_slave==0)
{
if (mod_time_slave==0){rx_m_slave=1;rx_wr_index_slave=0;rd_counts=0;} 
mod_time_slave=14;
rd_counts++;
rx_buffer_slave[rx_wr_index_slave]=d;

if (++rx_wr_index_slave >=128) rx_wr_index_slave=0;
if (++rx_counter_slave >= 128) rx_counter_slave=0;
}

BKI_state_sent=0; new_message=1;RData=d;
reg91_answer=(object_state|((!BPS_absent)<<5)|(red<<4)|((ProcessingEEPROM)<<3)|((red|ProcessingEEPROM)<<2)|((warning_flag&(!blink_flag)<<1))|(warning_flag&(!blink_flag)|blink_flag)); 
if(rd_counts==8){
if(rx_buffer_slave[rx_wr_index_slave-8]==ModBusAddress&(rx_buffer_slave[rx_wr_index_slave-7]==0x06|rx_buffer_slave[rx_wr_index_slave-7]==0x03)){rx_counter_slave=0;
if(rx_buffer_slave[rx_wr_index_slave-7]==0x06&rx_buffer_slave[rx_wr_index_slave-6]==0x00)
{
if(rx_buffer_slave[rx_wr_index_slave-5]==0x91){start_calibration=(rx_buffer_slave[rx_wr_index_slave-3]&0x10)>>4;}
if(rx_buffer_slave[rx_wr_index_slave-5]==0x92){AverTime_Value=rx_buffer_slave[rx_wr_index_slave-4]*30;if(AverTime_Value==0)AverTime_Value=2;FrequencyQ=rx_buffer_slave[rx_wr_index_slave-3];AverTime_Flag=1;AvTimer=0;{(*(unsigned char *) 0x8b)=0x00;(*(unsigned char *) 0x8a)=0x04;(*(unsigned char *) 0x89)=0x81;(*(unsigned char *) 0x88)=0x0B;(*(unsigned char *) 0x7d)=0x04;};SKZread_counter=0;ModbusMessage=62;}
if(rx_buffer_slave[rx_wr_index_slave-5]==0x93){ModBusAddress=rx_buffer_slave[rx_wr_index_slave-3];ModbusMessage=63;}
if(rx_buffer_slave[rx_wr_index_slave-5]==0x94){minimal_SKZ_val=(((unsigned int)rx_buffer_slave[rx_wr_index_slave-4])<<8)|(unsigned int)rx_buffer_slave[rx_wr_index_slave-3];ModbusMessage=64;}
if(rx_buffer_slave[rx_wr_index_slave-5]==0x95){minimal_object_enabled_level=0;minimal_object_enabled_level=(int)((((int)rx_buffer_slave[rx_wr_index_slave-4])<<8)|(int)rx_buffer_slave[rx_wr_index_slave-3]);ModbusMessage=65;}
if(rx_buffer_slave[rx_wr_index_slave-5]==0xAC)
{
flash_erase_flag = 1;

}
CRCHigh=0xff;
CRCLow=0xff;
for (r=0;r<6;r++)
{

CRC_update(rx_buffer_slave[r]);

tx_buffer_slave[tx_buffer_end_slave]=rx_buffer_slave[r]; 
if (++tx_buffer_end_slave==128) tx_buffer_end_slave=0;

}
crc_slave=((unsigned int)CRCLow<<8)|CRCHigh;

tx_buffer_slave[tx_buffer_end_slave]=crc_slave; 
if (++tx_buffer_end_slave==128) tx_buffer_end_slave=0;

tx_buffer_slave[tx_buffer_end_slave]=(crc_slave>>8); 
if (++tx_buffer_end_slave==128) tx_buffer_end_slave=0;
PORTE=PORTE|0b00000100;                            
tx_en_slave=1;crc_slave=0xffff;UCSR0B=0xD8;
#asm("cli"); 
UDR0=tx_buffer_slave[tx_buffer_begin_slave];
#asm("sei");     

}
if(rx_buffer_slave[rx_wr_index_slave-7]==0x03&rx_buffer_slave[rx_wr_index_slave-6]==0x00&rx_buffer_slave[rx_wr_index_slave-4]==0x00&rx_buffer_slave[rx_wr_index_slave-3]==0x01){
if(rx_buffer_slave[rx_wr_index_slave-5]==0x90){rx_buffer_slave[rx_wr_index_slave-6]=0x02;rx_buffer_slave[rx_wr_index_slave-5]=AverSKZprcnt;rx_buffer_slave[rx_wr_index_slave-4]=LedQ;}
if(rx_buffer_slave[rx_wr_index_slave-5]==0x91){rx_buffer_slave[rx_wr_index_slave-6]=0x02;rx_buffer_slave[rx_wr_index_slave-5]=blink_flag|((!warning_flag)<<1)|(!warning_flag);rx_buffer_slave[rx_wr_index_slave-4]=reg91_answer;BKI_state_sent=1;}
if(rx_buffer_slave[rx_wr_index_slave-5]==0x92){rx_buffer_slave[rx_wr_index_slave-6]=0x02;rx_buffer_slave[rx_wr_index_slave-5]=AverTime_Value/30;rx_buffer_slave[rx_wr_index_slave-4]=FrequencyQ;}
if(rx_buffer_slave[rx_wr_index_slave-5]==0x93){rx_buffer_slave[rx_wr_index_slave-6]=0x02;rx_buffer_slave[rx_wr_index_slave-5]=0;rx_buffer_slave[rx_wr_index_slave-4]=ModBusAddress;}
if(rx_buffer_slave[rx_wr_index_slave-5]==0x94){rx_buffer_slave[rx_wr_index_slave-6]=0x02;rx_buffer_slave[rx_wr_index_slave-5]=minimal_SKZ_val>>8;rx_buffer_slave[rx_wr_index_slave-4]=minimal_SKZ_val;}
if(rx_buffer_slave[rx_wr_index_slave-5]==0x95){rx_buffer_slave[rx_wr_index_slave-6]=0x02;rx_buffer_slave[rx_wr_index_slave-5]=minimal_object_enabled_level>>8;rx_buffer_slave[rx_wr_index_slave-4]=minimal_object_enabled_level;}
if(rx_buffer_slave[rx_wr_index_slave-5]==0x96){rx_buffer_slave[rx_wr_index_slave-6]=0x02;rx_buffer_slave[rx_wr_index_slave-5]=0x00;rx_buffer_slave[rx_wr_index_slave-4]=DeviceID;}
if(rx_buffer_slave[rx_wr_index_slave-5]==0x97){rx_buffer_slave[rx_wr_index_slave-6]=0x02;rx_buffer_slave[rx_wr_index_slave-5]=AverSKZ_Value>>8;rx_buffer_slave[rx_wr_index_slave-4]=AverSKZ_Value;}
if(rx_buffer_slave[rx_wr_index_slave-5]==0x98){rx_buffer_slave[rx_wr_index_slave-6]=0x02;rx_buffer_slave[rx_wr_index_slave-5]=true_skz>>8;rx_buffer_slave[rx_wr_index_slave-4]=true_skz;}
if(rx_buffer_slave[rx_wr_index_slave-5]==0x99){rx_buffer_slave[rx_wr_index_slave-6]=0x02;rx_buffer_slave[rx_wr_index_slave-5]=SKZ_1>>8;rx_buffer_slave[rx_wr_index_slave-4]=SKZ_1;}
if(rx_buffer_slave[rx_wr_index_slave-5]==0x9a){rx_buffer_slave[rx_wr_index_slave-6]=0x02;rx_buffer_slave[rx_wr_index_slave-5]=SKZ_2>>8;rx_buffer_slave[rx_wr_index_slave-4]=SKZ_2;}
CRCHigh=0xff;
CRCLow=0xff;
for (r=0;r<5;r++)
{

CRC_update(rx_buffer_slave[r]);

tx_buffer_slave[tx_buffer_end_slave]=rx_buffer_slave[r]; 
if (++tx_buffer_end_slave==128) tx_buffer_end_slave=0;

}

crc_slave=((unsigned int)CRCLow<<8)|CRCHigh;

tx_buffer_slave[tx_buffer_end_slave]=crc_slave; 
if (++tx_buffer_end_slave==128) tx_buffer_end_slave=0;

tx_buffer_slave[tx_buffer_end_slave]=(crc_slave>>8); 
if (++tx_buffer_end_slave==128) tx_buffer_end_slave=0;
PORTE=PORTE|0b00000100;                            
tx_en_slave=1;crc_slave=0xffff;UCSR0B=0xD8;
#asm("cli");     
UDR0=tx_buffer_slave[tx_buffer_begin_slave];
#asm("sei"); 

}

}
}
if(rx_c_slave==1&mod_time_slave==0){rx_c_slave=0;rx_m_slave=0;rx_wr_index_slave=0;rx_counter_slave=0;
}      
}

char tx_buffer_master[128];
unsigned char tx_buffer_begin_master,tx_buffer_end_master;
interrupt [33] void usart1_tx_isr(void)
{

if (tx_en_master==1)
{
delay_us(100);
if (++tx_buffer_begin_master>=128) tx_buffer_begin_master=0;
if (tx_buffer_begin_master!=tx_buffer_end_master) {(*(unsigned char *) 0x9c)=tx_buffer_master[tx_buffer_begin_master];}
else {tx_en_master=0;rx_m_master=0;PORTD.4=0;;}
}

}

interrupt [21] void usart0_tx_isr(void)
{
#asm("cli");

if (tx_en_slave==1)
{
if (++tx_buffer_begin_slave>=128) tx_buffer_begin_slave=0;
if (tx_buffer_begin_slave!=tx_buffer_end_slave) {UDR0=tx_buffer_slave[tx_buffer_begin_slave];}
else {tx_en_slave=0;rx_m_slave=0;PORTE=PORTE&0b11111011;tx_buffer_begin_slave=0;tx_buffer_end_slave=0;UCSR0B=0x00;UCSR0B=0x90;}
}

#asm("sei");
}

interrupt [17] void timer0_ovf_isr(void)
{
#asm ("cli")
TCNT0=0x07;

if (mod_time_slave==0){if(rx_m_slave==1) rx_c_slave=1;}   else 	mod_time_slave--;
if (mod_time_master==0){if(rx_m_master==1) rx_c_master=1;}else 	mod_time_master--;

#asm ("sei")
}

interrupt [18] void spi_isr(void)
{

if(SPI_tEnd==0){
SPDR=tok;
SPI_tEnd=1;
delay_us(200);
PORTB.4=0;
PORTB.0=1;
}  

else PORTB.0=1;

}   

void current_out(unsigned int out)
{

PORTB.4=0;
delay_us(200);
PORTB.4=1;PORTB.0=0;
delay_us(200);

if(SPI_tEnd==1)
{SPI_tEnd=0;

SPDR=out>>8;

}
}

void EEPROM_write(unsigned int eeAddress, unsigned char eeData)
{

while(EECR&0x02)
;

EEAR = eeAddress;
EEDR = eeData;

EECR |= 0x04;

EECR |= 0x02;
}

unsigned char EEPROM_read(unsigned int eeAddress)
{

while(EECR & 0x02)
;

EEAR = eeAddress;

EECR |= 0x01;

return EEDR;
}                              

void eeprom_reset()
{
int i;
for(i=0;i<0x1000;i++)
{
if(i==0x0600)i++;
EEPROM_write(i,0xff); 
}
} 

eeprom float kv=100;
eeprom float kn=100;

unsigned char save_reg(unsigned int d,unsigned int a);
char check_cr_master();
char check_cr_slave();
void crc_rtu_master(char a);			
void crc_rtu_slave(char a);			
void crc_end_master();			

void mov_buf_master(char a);
void mov_buf0(char a);			
void mov_buf_slave(char a);
void mov_buf1(char a);			
unsigned int valskz;
void response_m_err(char a);                     
void response_m_aa4();                     
void response_m_aa6();                     

void led(unsigned char a)
{
switch (a)
{
case 0: {
(*(unsigned char *) 0x62)=(*(unsigned char *) 0x62)&0b11111011;(*(unsigned char *) 0x62)=(*(unsigned char *) 0x62)&0b11111110;(*(unsigned char *) 0x62)=(*(unsigned char *) 0x62)&0b10111111;(*(unsigned char *) 0x62)=(*(unsigned char *) 0x62)&0b11111101;(*(unsigned char *) 0x62)=(*(unsigned char *) 0x62)&0b11110111;(*(unsigned char *) 0x62)=(*(unsigned char *) 0x62)&0b11011111;(*(unsigned char *) 0x62)=(*(unsigned char *) 0x62)&0b01111111;PORTA.0=0;PORTA.1=0;PORTA.3=0;
PORTA.4=0;PORTA.5=0;PORTA.6=0;PORTA.7=0;PORTC.6=0;PORTC.7=0;PORTC.4=0;PORTC.3=1;PORTC.2=1;PORTC.1=1;break;}
case 1: {
(*(unsigned char *) 0x62)=(*(unsigned char *) 0x62)&0b11111011;(*(unsigned char *) 0x62)=(*(unsigned char *) 0x62)&0b11111110;(*(unsigned char *) 0x62)=(*(unsigned char *) 0x62)&0b10111111;(*(unsigned char *) 0x62)=(*(unsigned char *) 0x62)&0b11111101;(*(unsigned char *) 0x62)=(*(unsigned char *) 0x62)&0b11110111;(*(unsigned char *) 0x62)=(*(unsigned char *) 0x62)&0b11011111;(*(unsigned char *) 0x62)=(*(unsigned char *) 0x62)&0b01111111;PORTA.0=0;PORTA.1=0;PORTA.3=0;
PORTA.4=0;PORTA.5=0;PORTA.6=0;PORTA.7=0;PORTC.6=0;PORTC.7=0;PORTC.4=0;PORTC.3=0;PORTC.2=0;PORTC.1=1;break;}
case 2: {
(*(unsigned char *) 0x62)=(*(unsigned char *) 0x62)&0b11111011;(*(unsigned char *) 0x62)=(*(unsigned char *) 0x62)&0b11111110;(*(unsigned char *) 0x62)=(*(unsigned char *) 0x62)&0b10111111;(*(unsigned char *) 0x62)=(*(unsigned char *) 0x62)&0b11111101;(*(unsigned char *) 0x62)=(*(unsigned char *) 0x62)&0b11110111;(*(unsigned char *) 0x62)=(*(unsigned char *) 0x62)&0b11011111;(*(unsigned char *) 0x62)=(*(unsigned char *) 0x62)&0b01111111;PORTA.0=0;PORTA.1=0;PORTA.3=0;
PORTA.4=0;PORTA.5=0;PORTA.6=0;PORTA.7=0;PORTC.6=0;PORTC.7=0;PORTC.4=0;PORTC.3=0;PORTC.2=1;PORTC.1=1;break;}
case 3: {
(*(unsigned char *) 0x62)=(*(unsigned char *) 0x62)&0b11111011;(*(unsigned char *) 0x62)=(*(unsigned char *) 0x62)&0b11111110;(*(unsigned char *) 0x62)=(*(unsigned char *) 0x62)&0b10111111;(*(unsigned char *) 0x62)=(*(unsigned char *) 0x62)&0b11111101;(*(unsigned char *) 0x62)=(*(unsigned char *) 0x62)&0b11110111;(*(unsigned char *) 0x62)=(*(unsigned char *) 0x62)&0b11011111;(*(unsigned char *) 0x62)=(*(unsigned char *) 0x62)&0b01111111;PORTA.0=0;PORTA.1=0;PORTA.3=0;
PORTA.4=0;PORTA.5=0;PORTA.6=0;PORTA.7=0;PORTC.6=0;PORTC.7=0;PORTC.4=0;PORTC.3=1;PORTC.2=1;PORTC.1=1;break;}
case 4: {
(*(unsigned char *) 0x62)=(*(unsigned char *) 0x62)&0b11111011;(*(unsigned char *) 0x62)=(*(unsigned char *) 0x62)&0b11111110;(*(unsigned char *) 0x62)=(*(unsigned char *) 0x62)&0b10111111;(*(unsigned char *) 0x62)=(*(unsigned char *) 0x62)&0b11111101;(*(unsigned char *) 0x62)=(*(unsigned char *) 0x62)&0b11110111;(*(unsigned char *) 0x62)=(*(unsigned char *) 0x62)&0b11011111;(*(unsigned char *) 0x62)=(*(unsigned char *) 0x62)&0b01111111;PORTA.0=0;PORTA.1=0;PORTA.3=0;
PORTA.4=0;PORTA.5=0;PORTA.6=0;PORTA.7=0;PORTC.6=0;PORTC.7=0;PORTC.4=1;PORTC.3=0;PORTC.2=0;PORTC.1=0;break;}
case 5: {
(*(unsigned char *) 0x62)=(*(unsigned char *) 0x62)&0b11111011;(*(unsigned char *) 0x62)=(*(unsigned char *) 0x62)&0b11111110;(*(unsigned char *) 0x62)=(*(unsigned char *) 0x62)&0b10111111;(*(unsigned char *) 0x62)=(*(unsigned char *) 0x62)&0b11111101;(*(unsigned char *) 0x62)=(*(unsigned char *) 0x62)&0b11110111;(*(unsigned char *) 0x62)=(*(unsigned char *) 0x62)&0b11011111;(*(unsigned char *) 0x62)=(*(unsigned char *) 0x62)&0b01111111;PORTA.0=0;PORTA.1=0;PORTA.3=0;
PORTA.4=0;PORTA.5=0;PORTA.6=0;PORTA.7=0;PORTC.6=0;PORTC.7=1;PORTC.4=1;PORTC.3=0;PORTC.2=0;PORTC.1=0;break;}
case 6: {
(*(unsigned char *) 0x62)=(*(unsigned char *) 0x62)&0b11111011;(*(unsigned char *) 0x62)=(*(unsigned char *) 0x62)&0b11111110;(*(unsigned char *) 0x62)=(*(unsigned char *) 0x62)&0b10111111;(*(unsigned char *) 0x62)=(*(unsigned char *) 0x62)&0b11111101;(*(unsigned char *) 0x62)=(*(unsigned char *) 0x62)&0b11110111;(*(unsigned char *) 0x62)=(*(unsigned char *) 0x62)&0b11011111;(*(unsigned char *) 0x62)=(*(unsigned char *) 0x62)&0b01111111;PORTA.0=0;PORTA.1=0;PORTA.3=0;
PORTA.4=0;PORTA.5=0;PORTA.6=0;PORTA.7=0;PORTC.6=1;PORTC.7=1;PORTC.4=1;PORTC.3=0;PORTC.2=0;PORTC.1=0;break;}
case 7: {
(*(unsigned char *) 0x62)=(*(unsigned char *) 0x62)&0b11111011;(*(unsigned char *) 0x62)=(*(unsigned char *) 0x62)&0b11111110;(*(unsigned char *) 0x62)=(*(unsigned char *) 0x62)&0b10111111;(*(unsigned char *) 0x62)=(*(unsigned char *) 0x62)&0b11111101;(*(unsigned char *) 0x62)=(*(unsigned char *) 0x62)&0b11110111;(*(unsigned char *) 0x62)=(*(unsigned char *) 0x62)&0b11011111;(*(unsigned char *) 0x62)=(*(unsigned char *) 0x62)&0b01111111;PORTA.0=0;PORTA.1=0;PORTA.3=0;
PORTA.4=0;PORTA.5=0;PORTA.6=0;PORTA.7=1;PORTC.6=1;PORTC.7=1;PORTC.4=1;PORTC.3=0;PORTC.2=0;PORTC.1=0;break;}
case 8: {
(*(unsigned char *) 0x62)=(*(unsigned char *) 0x62)&0b11111011;(*(unsigned char *) 0x62)=(*(unsigned char *) 0x62)&0b11111110;(*(unsigned char *) 0x62)=(*(unsigned char *) 0x62)&0b10111111;(*(unsigned char *) 0x62)=(*(unsigned char *) 0x62)&0b11111101;(*(unsigned char *) 0x62)=(*(unsigned char *) 0x62)&0b11110111;(*(unsigned char *) 0x62)=(*(unsigned char *) 0x62)&0b11011111;(*(unsigned char *) 0x62)=(*(unsigned char *) 0x62)&0b01111111;PORTA.0=0;PORTA.1=0;PORTA.3=0;
PORTA.4=0;PORTA.5=0;PORTA.6=1;PORTA.7=1;PORTC.6=1;PORTC.7=1;PORTC.4=1;PORTC.3=0;PORTC.2=0;PORTC.1=0;break;}
case 9: {
(*(unsigned char *) 0x62)=(*(unsigned char *) 0x62)&0b11111011;(*(unsigned char *) 0x62)=(*(unsigned char *) 0x62)&0b11111110;(*(unsigned char *) 0x62)=(*(unsigned char *) 0x62)&0b10111111;(*(unsigned char *) 0x62)=(*(unsigned char *) 0x62)&0b11111101;(*(unsigned char *) 0x62)=(*(unsigned char *) 0x62)&0b11110111;(*(unsigned char *) 0x62)=(*(unsigned char *) 0x62)&0b11011111;(*(unsigned char *) 0x62)=(*(unsigned char *) 0x62)&0b01111111;PORTA.0=0;PORTA.1=0;PORTA.3=0;
PORTA.4=0;PORTA.5=1;PORTA.6=1;PORTA.7=1;PORTC.6=1;PORTC.7=1;PORTC.4=1;PORTC.3=0;PORTC.2=0;PORTC.1=0;break;}
case 10: {
(*(unsigned char *) 0x62)=(*(unsigned char *) 0x62)&0b11111011;(*(unsigned char *) 0x62)=(*(unsigned char *) 0x62)&0b11111110;(*(unsigned char *) 0x62)=(*(unsigned char *) 0x62)&0b10111111;(*(unsigned char *) 0x62)=(*(unsigned char *) 0x62)&0b11111101;(*(unsigned char *) 0x62)=(*(unsigned char *) 0x62)&0b11110111;(*(unsigned char *) 0x62)=(*(unsigned char *) 0x62)&0b11011111;(*(unsigned char *) 0x62)=(*(unsigned char *) 0x62)&0b01111111;PORTA.0=0;PORTA.1=0;PORTA.3=0;
PORTA.4=1;PORTA.5=1;PORTA.6=1;PORTA.7=1;PORTC.6=1;PORTC.7=1;PORTC.4=1;PORTC.3=0;PORTC.2=0;PORTC.1=0;break;}
case 11: {
(*(unsigned char *) 0x62)=(*(unsigned char *) 0x62)&0b11111011;(*(unsigned char *) 0x62)=(*(unsigned char *) 0x62)&0b11111110;(*(unsigned char *) 0x62)=(*(unsigned char *) 0x62)&0b10111111;(*(unsigned char *) 0x62)=(*(unsigned char *) 0x62)&0b11111101;(*(unsigned char *) 0x62)=(*(unsigned char *) 0x62)&0b11110111;(*(unsigned char *) 0x62)=(*(unsigned char *) 0x62)&0b11011111;(*(unsigned char *) 0x62)=(*(unsigned char *) 0x62)&0b01111111;PORTA.0=0;PORTA.1=0;PORTA.3=1;
PORTA.4=1;PORTA.5=1;PORTA.6=1;PORTA.7=1;PORTC.6=1;PORTC.7=1;PORTC.4=1;PORTC.3=0;PORTC.2=0;PORTC.1=0;break;}
case 12: {
(*(unsigned char *) 0x62)=(*(unsigned char *) 0x62)&0b11111011;(*(unsigned char *) 0x62)=(*(unsigned char *) 0x62)&0b11111110;(*(unsigned char *) 0x62)=(*(unsigned char *) 0x62)&0b10111111;(*(unsigned char *) 0x62)=(*(unsigned char *) 0x62)&0b11111101;(*(unsigned char *) 0x62)=(*(unsigned char *) 0x62)&0b11110111;(*(unsigned char *) 0x62)=(*(unsigned char *) 0x62)&0b11011111;(*(unsigned char *) 0x62)=(*(unsigned char *) 0x62)&0b01111111;PORTA.0=0;PORTA.1=1;PORTA.3=1;
PORTA.4=1;PORTA.5=1;PORTA.6=1;PORTA.7=1;PORTC.6=1;PORTC.7=1;PORTC.4=1;PORTC.3=0;PORTC.2=0;PORTC.1=0;break;}
case 13: {
(*(unsigned char *) 0x62)=(*(unsigned char *) 0x62)&0b11111011;(*(unsigned char *) 0x62)=(*(unsigned char *) 0x62)&0b11111110;(*(unsigned char *) 0x62)=(*(unsigned char *) 0x62)&0b10111111;(*(unsigned char *) 0x62)=(*(unsigned char *) 0x62)&0b11111101;(*(unsigned char *) 0x62)=(*(unsigned char *) 0x62)&0b11110111;(*(unsigned char *) 0x62)=(*(unsigned char *) 0x62)&0b11011111;(*(unsigned char *) 0x62)=(*(unsigned char *) 0x62)&0b01111111;PORTA.0=1;PORTA.1=1;PORTA.3=1;
PORTA.4=1;PORTA.5=1;PORTA.6=1;PORTA.7=1;PORTC.6=1;PORTC.7=1;PORTC.4=1;PORTC.3=0;PORTC.2=0;PORTC.1=0;break;}
case 14: {
(*(unsigned char *) 0x62)=(*(unsigned char *) 0x62)&0b11111011;(*(unsigned char *) 0x62)=(*(unsigned char *) 0x62)&0b11111110;(*(unsigned char *) 0x62)=(*(unsigned char *) 0x62)&0b10111111;(*(unsigned char *) 0x62)=(*(unsigned char *) 0x62)&0b11111101;(*(unsigned char *) 0x62)=(*(unsigned char *) 0x62)&0b11110111;(*(unsigned char *) 0x62)=(*(unsigned char *) 0x62)&0b11011111;(*(unsigned char *) 0x62)=(*(unsigned char *) 0x62)|0b10000000;PORTA.0=1;PORTA.1=1;PORTA.3=1;
PORTA.4=1;PORTA.5=1;PORTA.6=1;PORTA.7=1;PORTC.6=1;PORTC.7=1;PORTC.4=1;PORTC.3=0;PORTC.2=0;PORTC.1=0;break;}
case 15: {
(*(unsigned char *) 0x62)=(*(unsigned char *) 0x62)&0b11111011;(*(unsigned char *) 0x62)=(*(unsigned char *) 0x62)&0b11111110;(*(unsigned char *) 0x62)=(*(unsigned char *) 0x62)&0b10111111;(*(unsigned char *) 0x62)=(*(unsigned char *) 0x62)&0b11111101;(*(unsigned char *) 0x62)=(*(unsigned char *) 0x62)&0b11110111;(*(unsigned char *) 0x62)=(*(unsigned char *) 0x62)|0b00100000;(*(unsigned char *) 0x62)=(*(unsigned char *) 0x62)|0b10000000;PORTA.0=1;PORTA.1=1;PORTA.3=1;
PORTA.4=1;PORTA.5=1;PORTA.6=1;PORTA.7=1;PORTC.6=1;PORTC.7=1;PORTC.4=1;PORTC.3=0;PORTC.2=0;PORTC.1=0;break;}
case 16: {
(*(unsigned char *) 0x62)=(*(unsigned char *) 0x62)&0b11111011;(*(unsigned char *) 0x62)=(*(unsigned char *) 0x62)&0b11111110;(*(unsigned char *) 0x62)=(*(unsigned char *) 0x62)&0b10111111;(*(unsigned char *) 0x62)=(*(unsigned char *) 0x62)&0b11111101;(*(unsigned char *) 0x62)=(*(unsigned char *) 0x62)|0b00001000;(*(unsigned char *) 0x62)=(*(unsigned char *) 0x62)|0b00100000;(*(unsigned char *) 0x62)=(*(unsigned char *) 0x62)|0b10000000;PORTA.0=1;PORTA.1=1;PORTA.3=1;
PORTA.4=1;PORTA.5=1;PORTA.6=1;PORTA.7=1;PORTC.6=1;PORTC.7=1;PORTC.4=1;PORTC.3=0;PORTC.2=0;PORTC.1=0;break;}
case 17: {
(*(unsigned char *) 0x62)=(*(unsigned char *) 0x62)&0b11111011;(*(unsigned char *) 0x62)=(*(unsigned char *) 0x62)&0b11111110;(*(unsigned char *) 0x62)=(*(unsigned char *) 0x62)&0b10111111;(*(unsigned char *) 0x62)=(*(unsigned char *) 0x62)|0b00000010;(*(unsigned char *) 0x62)=(*(unsigned char *) 0x62)|0b00001000;(*(unsigned char *) 0x62)=(*(unsigned char *) 0x62)|0b00100000;(*(unsigned char *) 0x62)=(*(unsigned char *) 0x62)|0b10000000;PORTA.0=1;PORTA.1=1;PORTA.3=1;
PORTA.4=1;PORTA.5=1;PORTA.6=1;PORTA.7=1;PORTC.6=1;PORTC.7=1;PORTC.4=1;PORTC.3=0;PORTC.2=0;PORTC.1=0;break;}
case 18: {
(*(unsigned char *) 0x62)=(*(unsigned char *) 0x62)&0b11111011;(*(unsigned char *) 0x62)=(*(unsigned char *) 0x62)&0b11111110;(*(unsigned char *) 0x62)=(*(unsigned char *) 0x62)|0b01000000;(*(unsigned char *) 0x62)=(*(unsigned char *) 0x62)|0b00000010;(*(unsigned char *) 0x62)=(*(unsigned char *) 0x62)|0b00001000;(*(unsigned char *) 0x62)=(*(unsigned char *) 0x62)|0b00100000;(*(unsigned char *) 0x62)=(*(unsigned char *) 0x62)|0b10000000;PORTA.0=1;PORTA.1=1;PORTA.3=1;
PORTA.4=1;PORTA.5=1;PORTA.6=1;PORTA.7=1;PORTC.6=1;PORTC.7=1;PORTC.4=1;PORTC.3=0;PORTC.2=0;PORTC.1=0;break;}
case 19: {
(*(unsigned char *) 0x62)=(*(unsigned char *) 0x62)&0b11111011;(*(unsigned char *) 0x62)=(*(unsigned char *) 0x62)|0b00000001;(*(unsigned char *) 0x62)=(*(unsigned char *) 0x62)|0b01000000;(*(unsigned char *) 0x62)=(*(unsigned char *) 0x62)|0b00000010;(*(unsigned char *) 0x62)=(*(unsigned char *) 0x62)|0b00001000;(*(unsigned char *) 0x62)=(*(unsigned char *) 0x62)|0b00100000;(*(unsigned char *) 0x62)=(*(unsigned char *) 0x62)|0b10000000;PORTA.0=1;PORTA.1=1;PORTA.3=1;
PORTA.4=1;PORTA.5=1;PORTA.6=1;PORTA.7=1;PORTC.6=1;PORTC.7=1;PORTC.4=1;PORTC.3=0;PORTC.2=0;PORTC.1=0;break;}
case 20: {
(*(unsigned char *) 0x62)=(*(unsigned char *) 0x62)|0b00000100;(*(unsigned char *) 0x62)=(*(unsigned char *) 0x62)|0b00000001;(*(unsigned char *) 0x62)=(*(unsigned char *) 0x62)|0b01000000;(*(unsigned char *) 0x62)=(*(unsigned char *) 0x62)|0b00000010;(*(unsigned char *) 0x62)=(*(unsigned char *) 0x62)|0b00001000;(*(unsigned char *) 0x62)=(*(unsigned char *) 0x62)|0b00100000;(*(unsigned char *) 0x62)=(*(unsigned char *) 0x62)|0b10000000;PORTA.0=1;PORTA.1=1;PORTA.3=1;
PORTA.4=1;PORTA.5=1;PORTA.6=1;PORTA.7=1;PORTC.6=1;PORTC.7=1;PORTC.4=1;PORTC.3=0;PORTC.2=0;PORTC.1=0;break;}
case 30: {
(*(unsigned char *) 0x62)=(*(unsigned char *) 0x62)&0b11111011;(*(unsigned char *) 0x62)=(*(unsigned char *) 0x62)&0b11111110;(*(unsigned char *) 0x62)=(*(unsigned char *) 0x62)&0b10111111;(*(unsigned char *) 0x62)=(*(unsigned char *) 0x62)&0b11111101;(*(unsigned char *) 0x62)=(*(unsigned char *) 0x62)&0b11110111;(*(unsigned char *) 0x62)=(*(unsigned char *) 0x62)&0b11011111;(*(unsigned char *) 0x62)=(*(unsigned char *) 0x62)&0b01111111;PORTA.0=0;PORTA.1=0;PORTA.3=0;
PORTA.4=0;PORTA.5=0;PORTA.6=0;PORTA.7=0;PORTC.6=0;PORTC.7=0;PORTC.4=0;PORTC.3=0;PORTC.2=0;PORTC.1=0;break;}
default: {
(*(unsigned char *) 0x62)=(*(unsigned char *) 0x62)|0b00000100;(*(unsigned char *) 0x62)=(*(unsigned char *) 0x62)|0b00000001;(*(unsigned char *) 0x62)=(*(unsigned char *) 0x62)|0b01000000;(*(unsigned char *) 0x62)=(*(unsigned char *) 0x62)|0b00000010;(*(unsigned char *) 0x62)=(*(unsigned char *) 0x62)|0b00001000;(*(unsigned char *) 0x62)=(*(unsigned char *) 0x62)|0b00100000;(*(unsigned char *) 0x62)=(*(unsigned char *) 0x62)|0b10000000;PORTA.0=1;PORTA.1=1;PORTA.3=1;
PORTA.4=1;PORTA.5=1;PORTA.6=1;PORTA.7=1;PORTC.6=1;PORTC.7=1;PORTC.4=1;PORTC.3=0;PORTC.2=0;PORTC.1=0;break;}
}
}

interrupt [30] void timer3_ovf_isr(void)
{

{(*(unsigned char *) 0x8b)=0x00;(*(unsigned char *) 0x8a)=0x04;(*(unsigned char *) 0x89)=0x81;(*(unsigned char *) 0x88)=0x0B;(*(unsigned char *) 0x7d)=0x04;};   

AvTimer++;                    

}

interrupt [11] void timer2_ovf_isr(void)
{
TCCR2=0x05;
TCNT2=0x00;
OCR2=0x00;
TIMSK=TIMSK|0x40;

BlinkCounter_Calibration++;
if(BlinkCounter_Calibration==17){BlinkCounter_Calibration=0;}  
(*(unsigned char *) 0x62)=(*(unsigned char *) 0x62)|0b00010000&warning_flag; 
if((BlinkCounter_Calibration>=9)&&(warning_flag==1)&&(blink_flag==1))(*(unsigned char *) 0x62)=(*(unsigned char *) 0x62)|0b00010000;
if((BlinkCounter_Calibration>=9)&&(red==1))PORTA.2=1;
if((BlinkCounter_Calibration<9)&&(red==1))PORTA.2=0;
if((BlinkCounter_Calibration<9)&&(warning_flag==1)&&(blink_flag==1))(*(unsigned char *) 0x62)=(*(unsigned char *) 0x62)&0b11101111;

}       
void blink_on()
{
TCCR2=0x05;
TCNT2=0x00;
OCR2=0x00;
TIMSK=TIMSK|0x40;}

void blink_off()
{
TCCR2=0x00;
TCNT2=0x00;
OCR2=0x00;
TIMSK=0x01;}

void send_skz()
{crc_master=0xFFFF;
mov_buf_master(0x01);
mov_buf_master(0x0c);
mov_buf_master(EEPROM_read(0x0400));     
mov_buf_master(EEPROM_read(0x0401));     
mov_buf_master(EEPROM_read(0x0402));
mov_buf_master(EEPROM_read(0x0403));
crc_end_master();}      

void save_skz_arrays(unsigned int skz1or2)
{unsigned int m;                          
unsigned int val1, val2,addrval;  

ProcessingEEPROM=1;
(*(unsigned char *) 0x62)=(*(unsigned char *) 0x62)&0b11101111;
PORTA.2=1;
blink_off();
reg91_answer=(object_state|(!BPS_absent)<<5)|(red<<4)|((ProcessingEEPROM)<<3)|((red|ProcessingEEPROM)<<2)|((warning_flag&(!blink_flag)<<1))|(warning_flag&(!blink_flag)|blink_flag); 
delay_ms(3200);

if(skz1or2==1){val1=0;val2=19;addrval=0x20;}        
if(skz1or2==0){val1=19;val2=38;addrval=0x2D;}
for (m=val1;m<val2;m++){

rx_c_master=0;rx_m_master=0;rx_wr_index_master=0;rx_counter_master=0;  
rx_buffer_master[0]=0;
rx_buffer_master[1]=0;
rx_buffer_master[2]=0;
rx_buffer_master[3]=0;
rx_buffer_master[4]=0;
rx_buffer_master[5]=0;
rx_buffer_master[6]=0;
rx_buffer_master[7]=0;
rx_buffer_master[8]=0;
rx_buffer_master[9]=0;
crc_master=0xFFFF;
mov_buf_master(0x01);
mov_buf_master(0x04);
mov_buf_master(0x00);
mov_buf_master(m+addrval);
mov_buf_master(0x00);
mov_buf_master(0x01);
crc_end_master(); 

{TCNT1=0x0000;TCCR1B=0x03;while ((TIFR&0b00000100)==0);TCCR1B=0;TIFR=TIFR;}; 

if (check_cr_master()==1)
{SKZ_read=0;
if(rx_counter_master==7){SKZ_read=((unsigned int)rx_buffer_master[3]<<8)+rx_buffer_master[4];BPS_absent=0;}}
else BPS_absent=1;
#asm(" sei") 
EEPROM_write(0x0405+2*m, rx_buffer_master[3]);
EEPROM_write(0x0405+2*m+1, rx_buffer_master[4] ); 
#asm(" cli")

}
ProcessingEEPROM=0;PORTA.2=0;if(warning_flag)(*(unsigned char *) 0x62)=(*(unsigned char *) 0x62)|0b00010000; blink_on(); }

void save_freq_order()
{unsigned int m;      
unsigned int val,addrval;  
val=0;addrval=0x60;ProcessingEEPROM=1;        
for (m=val;m<19;m++){
(*(unsigned char *) 0x62)=(*(unsigned char *) 0x62)&0b11101111;
PORTA.2=1;
blink_off();

rx_c_master=0;rx_m_master=0;rx_wr_index_master=0;rx_counter_master=0;{rx_buffer_master[0]=0;rx_buffer_master[1]=0;rx_buffer_master[2]=0;rx_buffer_master[3]=0;rx_buffer_master[4]=0;rx_buffer_master[5]=0;rx_buffer_master[6]=0;rx_buffer_master[7]=0;rx_buffer_master[8]=0;rx_buffer_master[9]=0;};  
crc_master=0xFFFF;
mov_buf_master(0x01);
mov_buf_master(0x04);
mov_buf_master(0x00);
mov_buf_master(m+addrval);
mov_buf_master(0x00);
mov_buf_master(0x01);
crc_end_master(); 

{TCNT1=0x0000;TCCR1B=0x03;while ((TIFR&0b00000100)==0);TCCR1B=0;TIFR=TIFR;}; 

if (check_cr_master()==1)
{SKZ_read=0;
if(rx_counter_master==7){FreqOrder_read=rx_buffer_master[3]|rx_buffer_master[4];BPS_absent=0;}}
else BPS_absent=1;
#asm(" sei") 
EEPROM_write(0x0605, FreqOrder_read);
#asm(" cli")

}ProcessingEEPROM=0;PORTA.2=0;if(warning_flag)(*(unsigned char *) 0x62)=(*(unsigned char *) 0x62)|0b00010000; blink_on(); }

void send_frequency_value()              
{unsigned int m;   
rx_c_master=0;rx_m_master=0;
rx_wr_index_master=0;rx_counter_master=0;
rx_c_slave=0;rx_m_slave=0;
rx_wr_index_slave=0;rx_counter_slave=0;

crc_master=0xFFFF;
mov_buf_master(0x01);
mov_buf_master(0xcc); 
mov_buf_master(FrequencyQ); 
mov_buf_master(FrequencyQ);                                   
crc_end_master();                                    
}

void send_SKZMIN_value()              
{unsigned int m;   
rx_c_master=0;rx_m_master=0;
rx_wr_index_master=0;rx_counter_master=0;
rx_c_slave=0;rx_m_slave=0;
rx_wr_index_slave=0;rx_counter_slave=0;

crc_master=0xFFFF;
mov_buf_master(0x01);
mov_buf_master(0xcb); 
mov_buf_master((char)(minimal_SKZ_val>>8)); 
mov_buf_master(minimal_SKZ_val);                                   
crc_end_master();    
{TCNT1=0x0000;TCCR1B=0x03;while ((TIFR&0b00000100)==0);TCCR1B=0;TIFR=TIFR;};                                
}
void send_minimal_operat_val()              
{unsigned int m;   
rx_c_master=0;rx_m_master=0;
rx_wr_index_master=0;rx_counter_master=0;
rx_c_slave=0;rx_m_slave=0;
rx_wr_index_slave=0;rx_counter_slave=0;

crc_master=0xFFFF;
mov_buf_master(0x01);
mov_buf_master(0xcf); 
mov_buf_master((int)(minimal_object_enabled_level>>8)); 
mov_buf_master(minimal_object_enabled_level);                                   
crc_end_master();
{TCNT1=0x0000;TCCR1B=0x03;while ((TIFR&0b00000100)==0);TCCR1B=0;TIFR=TIFR;};    

}
void send_skz_array()              
{unsigned int m;   
rx_c_master=0;rx_m_master=0;
rx_wr_index_master=0;rx_counter_master=0;
rx_c_slave=0;rx_m_slave=0;
rx_wr_index_slave=0;rx_counter_slave=0;

crc_master=0xFFFF;
mov_buf_master(0x01);
mov_buf_master(0xcd); 
for (m=0;m<76;m++)
{

mov_buf_master(EEPROM_read(0x0405+m));    }           

crc_end_master();                                    
}

void send_freq_order()              
{unsigned int m;   
rx_c_master=0;rx_m_master=0;
rx_wr_index_master=0;rx_counter_master=0;

crc_master=0xFFFF;
mov_buf_master(0x01);
mov_buf_master(0xce); 
for (m=0;m<19;m++)
{

mov_buf_master(EEPROM_read(0x0605+m));    }           

crc_end_master();                                    
}

void go_main_menu(){

PORTE=PORTE|0b00000100;
printf("\r\n if you want to set Modbus address please type 'a' letter \r\n");
printf("\r\n if you want to set Averaging out time value please type 'v' letter \r\n");
printf("\r\n if you want to set the number of working frequencies please type 'f' letter \r\n");
printf("\r\n if you want to set the minimal SKZ value in ADC units please type 'm' letter \r\n");
printf("\r\n if you want to overview the current configuration  please type 'o' letter \r\n");

PORTE=PORTE&0b11111011;
}

void echo_answer_0x03(){
crc_slave=0xFFFF;
mov_buf_slave(rx_buffer_slave[0]);
mov_buf_slave(rx_buffer_slave[1]);
mov_buf_slave(rx_buffer_slave[2]);
mov_buf_slave(rx_buffer_slave[3]);
mov_buf_slave(rx_buffer_slave[4]);
crc_end_slave(); 

}

void echo_answer_0x06(){
mov_buf_slave(rx_buffer_slave[0]);
mov_buf_slave(rx_buffer_slave[1]);
mov_buf_slave(rx_buffer_slave[2]);
mov_buf_slave(rx_buffer_slave[3]);
mov_buf_slave(rx_buffer_slave[4]);
mov_buf_slave(rx_buffer_slave[5]);
crc_end_slave(); 

}

int ind_select(signed int ind_val){
signed int out_val;
if(ind_val>=90)out_val=1;
if((ind_val>10)&(ind_val<90))out_val=(99-ind_val)/10+1;
if((ind_val<=10)&(ind_val>=0))out_val=10;
if((ind_val<0)&(ind_val>-90))out_val=(100-ind_val)/10+1;
if(ind_val<=-90)out_val=20;
return out_val;}

void print_int(unsigned int int_val){
unsigned char char_val[3], dig_counter=0;
char_val[0]=int_val/100+0x30;
int_val=int_val%100;
char_val[1]=int_val/10+0x30;
int_val=int_val%10;
char_val[2]=int_val+0x30;
for (dig_counter=0;dig_counter<3;dig_counter++)putchar(char_val[dig_counter]);}  

void print_int5(unsigned int int_val){
unsigned char char_val[5], dig_counter=0;
char_val[0]=int_val/10000+0x30;
int_val=int_val%10000;
char_val[1]=int_val/1000+0x30;
int_val=int_val%1000;
char_val[2]=int_val/100+0x30;
int_val=int_val%100;
char_val[3]=int_val/10+0x30;
int_val=int_val%10;
char_val[4]=int_val+0x30;
for (dig_counter=0;dig_counter<5;dig_counter++)putchar(char_val[dig_counter]);}   

void terminal_commander(unsigned char RData, int mode){

if(ModbusMessage==62){EEPROM_write(0x0601,AverTime_Value);EEPROM_write(0x0602,FrequencyQ);send_frequency_value();ModbusMessage=0;}
if(ModbusMessage==63){EEPROM_write(0x0600,ModBusAddress);ModbusMessage=0;}
if(ModbusMessage==64){EEPROM_write(0x0603,(unsigned char)(minimal_SKZ_val>>8));EEPROM_write(0x0604,(unsigned char)(minimal_SKZ_val));send_SKZMIN_value();ModbusMessage=0;}
if(ModbusMessage==65){EEPROM_write(0x0606,(unsigned char)(minimal_object_enabled_level>>8));EEPROM_write(0x0607,(unsigned char)(minimal_object_enabled_level));send_minimal_operat_val();ModbusMessage=0;}
new_message=0;
}

void main(void)
{ 

int k=0,no_press=1; 
signed int x1,x2;
char disabling_counter=0,object_state_tmp;

float y;   

DDRA=0b11111111; 
PORTA=0b00000000;

DDRC=0b11011111;PORTC=0b00100000;
DDRD=0b00011000;PORTD=0b10000000;

(*(unsigned char *) 0x61)=0b11111111;(*(unsigned char *) 0x62)=0b00000000;
(*(unsigned char *) 0x64)=0b00000000;(*(unsigned char *) 0x65)=0b00000000;
UCSR0A=0x00;UCSR0B=0xD8;(*(unsigned char *) 0x95)=0x06;(*(unsigned char *) 0x90)=0x00;UBRR0L=0x2F;
(*(unsigned char *) 0x9b)=0x00;(*(unsigned char *) 0x9a)=0xD8;(*(unsigned char *) 0x9d)=0x06;(*(unsigned char *) 0x98)=0x00;(*(unsigned char *) 0x99)=0x2F;
DDRC.0=1;
ACSR=0x80;SFIOR=0x00;ASSR=0x00;
TCCR0=0x02;TCNT0=0x00;OCR0=0x00;
DDRB=0x37;
PORTB=0x31;   

SPCR=0xDE;
SPSR=0x00;

#asm
    in   r30,spsr
    in   r30,spdr
#endasm

{rx_buffer_slave[0]=0;rx_buffer_slave[1]=0;rx_buffer_slave[2]=0;rx_buffer_slave[3]=0;rx_buffer_slave[4]=0;rx_buffer_slave[5]=0;rx_buffer_slave[6]=0;rx_buffer_slave[7]=0;rx_buffer_slave[8]=0;rx_buffer_slave[9]=0;rx_buffer_slave[10]=0;};

TIMSK=0x01;

rx_c_master=0;rx_m_master=0;
rx_wr_index_master=0;rx_counter_master=0;
rx_c_slave=0;rx_m_slave=0;
rx_wr_index_slave=0;rx_counter_slave=0;

{PORTA.4=1;PORTA.5=1;PORTA.6=1;PORTA.7=1;PORTC.6=1;PORTC.7=1;PORTC.4=1;PORTC.3=1;PORTC.2=1;PORTC.1=1;};
delay_ms(500);
{(*(unsigned char *) 0x62)=(*(unsigned char *) 0x62)|0b00010000;PORTA.2=1;(*(unsigned char *) 0x62)=(*(unsigned char *) 0x62)|0b00000100;(*(unsigned char *) 0x62)=(*(unsigned char *) 0x62)|0b00000001;(*(unsigned char *) 0x62)=(*(unsigned char *) 0x62)|0b01000000;(*(unsigned char *) 0x62)=(*(unsigned char *) 0x62)|0b00000010;(*(unsigned char *) 0x62)=(*(unsigned char *) 0x62)|0b00001000;(*(unsigned char *) 0x62)=(*(unsigned char *) 0x62)|0b00100000;(*(unsigned char *) 0x62)=(*(unsigned char *) 0x62)|0b10000000;PORTA.0=1;PORTA.1=1;PORTA.3=1;PORTA.4=0;PORTA.5=0;PORTA.6=0;PORTA.7=0;PORTC.6=0;PORTC.7=0;PORTC.4=0;PORTC.3=0;PORTC.2=0;PORTC.1=0;};
delay_ms(500);
{(*(unsigned char *) 0x62)=(*(unsigned char *) 0x62)&0b11101111;PORTA.2=0;(*(unsigned char *) 0x62)=(*(unsigned char *) 0x62)&0b11111011;(*(unsigned char *) 0x62)=(*(unsigned char *) 0x62)&0b11111110;(*(unsigned char *) 0x62)=(*(unsigned char *) 0x62)&0b10111111;(*(unsigned char *) 0x62)=(*(unsigned char *) 0x62)&0b11111101;(*(unsigned char *) 0x62)=(*(unsigned char *) 0x62)&0b11110111;(*(unsigned char *) 0x62)=(*(unsigned char *) 0x62)&0b11011111;(*(unsigned char *) 0x62)=(*(unsigned char *) 0x62)&0b01111111;PORTA.0=0;PORTA.1=0;PORTA.3=0;PORTA.4=0;PORTA.5=0;PORTA.6=0;PORTA.7=0;PORTC.6=0;PORTC.7=0;PORTC.4=0;PORTC.3=0;PORTC.2=0;PORTC.1=0;}          ;

#asm("sei")

CalibrFlag=EEPROM_read(0x04ff);
if(EEPROM_read(0x0601)!=0xff)AverTime_Value=EEPROM_read(0x0601);
if(EEPROM_read(0x0602)!=0xff)FrequencyQ=EEPROM_read(0x0602);
if(EEPROM_read(0x0600)!=0xff)ModBusAddress=EEPROM_read(0x0600);
if(EEPROM_read(0x0603)!=0xff&EEPROM_read(0x0604)!=0xff){minimal_SKZ_val=(unsigned int)(EEPROM_read(0x0603))<<8;minimal_SKZ_val+=(unsigned int)(EEPROM_read(0x0604));}
if(EEPROM_read(0x0606)!=0xff&EEPROM_read(0x0607)!=0xff){minimal_object_enabled_level=(unsigned int)(EEPROM_read(0x0606))<<8;minimal_object_enabled_level+=(unsigned int)(EEPROM_read(0x0607));}
if((AverTime_Value!=0)&(red==0)){(*(unsigned char *) 0x8b)=0x00;(*(unsigned char *) 0x8a)=0x04;(*(unsigned char *) 0x89)=0x81;(*(unsigned char *) 0x88)=0x0B;(*(unsigned char *) 0x7d)=0x04;};

send_frequency_value();
{TCNT1=0x0000;TCCR1B=0x03;while ((TIFR&0b00000100)==0);TCCR1B=0;TIFR=TIFR;};

rx_c_master=0;rx_m_master=0;
rx_wr_index_master=0;rx_counter_master=0;
{rx_buffer_master[0]=0;rx_buffer_master[1]=0;rx_buffer_master[2]=0;rx_buffer_master[3]=0;rx_buffer_master[4]=0;rx_buffer_master[5]=0;rx_buffer_master[6]=0;rx_buffer_master[7]=0;rx_buffer_master[8]=0;rx_buffer_master[9]=0;};                 
send_SKZMIN_value();
rx_c_master=0;rx_m_master=0;
rx_wr_index_master=0;rx_counter_master=0;
{rx_buffer_master[0]=0;rx_buffer_master[1]=0;rx_buffer_master[2]=0;rx_buffer_master[3]=0;rx_buffer_master[4]=0;rx_buffer_master[5]=0;rx_buffer_master[6]=0;rx_buffer_master[7]=0;rx_buffer_master[8]=0;rx_buffer_master[9]=0;};                 
{TCNT1=0x0000;TCCR1B=0x03;while ((TIFR&0b00000100)==0);TCCR1B=0;TIFR=TIFR;};
send_minimal_operat_val();
{TCNT1=0x0000;TCCR1B=0x03;while ((TIFR&0b00000100)==0);TCCR1B=0;TIFR=TIFR;};

SKZ_1=0;SKZ_2=0;
if(CalibrFlag==1){
if(EEPROM_read(0x0400)!=0xff&EEPROM_read(0x0401)!=0xff)
{            
SKZ_1 = ((unsigned int)EEPROM_read(0x0400)<<8)+EEPROM_read(0x0401);
}
if(EEPROM_read(0x0402)!=0xff&EEPROM_read(0x0403)!=0xff){
SKZ_2 = ((unsigned int)EEPROM_read(0x0402)<<8)+EEPROM_read(0x0403);}        
SKZ1toSKZ2 =   EEPROM_read(0x0404);  
if(SKZ1toSKZ2!=0xff){
if(SKZ1toSKZ2<=40){warning_flag=1;
if(SKZ1toSKZ2<=20){blink_flag=1;blink_on();}
else {(*(unsigned char *) 0x62)=(*(unsigned char *) 0x62)|0b00010000;blink_flag=0;blink_off();}
}
else {warning_flag=0;(*(unsigned char *) 0x62)=(*(unsigned char *) 0x62)&0b11101111;blink_off(); }}       

send_freq_order();
{TCNT1=0x0000;TCCR1B=0x03;while ((TIFR&0b00000100)==0);TCCR1B=0;TIFR=TIFR;};

send_skz_array();
{TCNT1=0x0000;TCCR1B=0x03;while ((TIFR&0b00000100)==0);TCCR1B=0;TIFR=TIFR;};

}

while (1)
{
if(flash_erase_flag ==1)
{

led(30);    
EEPROM_write(0,0xff);
EEPROM_write(1,0xff);

WDTCR=0x18;
WDTCR=0x08;
#asm("cli")
delay_ms(3000);
}        

reg91_answer=(object_state|(!BPS_absent)<<5)|(red<<4)|((ProcessingEEPROM)<<3)|((red|ProcessingEEPROM)<<2)|((warning_flag&(!blink_flag)<<1))|(warning_flag&(!blink_flag)|blink_flag);        

if((blink_flag)|(red))blink_on();
else blink_off();  
if(BPS_absent){PORTC.1=!PORTC.1;PORTC.2=!PORTC.2;PORTC.3=!PORTC.3;} 
else{PORTC.1=PORTC.1&1;PORTC.2=PORTC.2&1;PORTC.3=PORTC.3&1;} 
if((object_state==0)&(!BPS_absent))
{
if((*(unsigned char *) 0x62)&0x40==0x40)
{  
(*(unsigned char *) 0x62)=(*(unsigned char *) 0x62)&0b10111111;
(*(unsigned char *) 0x62)=(*(unsigned char *) 0x62)&0b11111110;
(*(unsigned char *) 0x62)=(*(unsigned char *) 0x62)&0b11111011;
PORTC.1=0;PORTC.2=0;PORTC.3=0;
}
else                
{      
(*(unsigned char *) 0x62)=(*(unsigned char *) 0x62)|0b01000000;
(*(unsigned char *) 0x62)=(*(unsigned char *) 0x62)|0b00000001;
(*(unsigned char *) 0x62)=(*(unsigned char *) 0x62)|0b00000100;
PORTC.1=1;PORTC.2=1;PORTC.3=1;
}
}
current_out(tok);
if(new_message)terminal_commander(RData, terminal_mode); 
rx_c_master=0;rx_m_master=0;
rx_wr_index_master=0;rx_counter_master=0;
current_out(tok);
{rx_buffer_master[0]=0;rx_buffer_master[1]=0;rx_buffer_master[2]=0;rx_buffer_master[3]=0;rx_buffer_master[4]=0;rx_buffer_master[5]=0;rx_buffer_master[6]=0;rx_buffer_master[7]=0;rx_buffer_master[8]=0;rx_buffer_master[9]=0;};
{crc_master=0xFFFF;mov_buf_master(0x01);mov_buf_master(0x04);mov_buf_master(0x00);mov_buf_master(0x86);mov_buf_master(0x00);mov_buf_master(0x01);crc_end_master();};
current_out(tok);
{TCNT1=0x0000;TCCR1B=0x03;while ((TIFR&0b00000100)==0);TCCR1B=0;TIFR=TIFR;};
current_out(tok);

if (check_cr_master()==1)
{
rms=0;
if(rx_counter_master==7) rms=((int)rx_buffer_master[3])<<8|(char)rx_buffer_master[4];

SKZread_counter++;
BPS_absent=0;
bps_absent_ctr=0;
AverSKZ_Value=(float)AverSKZ_Value*((float)((float)SKZread_counter-1)/(float)SKZread_counter)+(float)((float)rms/(float)SKZread_counter);

}
else 
{
bps_absent_ctr++;
if(bps_absent_ctr>=4)BPS_absent=1;
}
current_out(tok);
rx_c_master=0;rx_m_master=0;
rx_wr_index_master=0;rx_counter_master=0;
{rx_buffer_master[0]=0;rx_buffer_master[1]=0;rx_buffer_master[2]=0;rx_buffer_master[3]=0;rx_buffer_master[4]=0;rx_buffer_master[5]=0;rx_buffer_master[6]=0;rx_buffer_master[7]=0;rx_buffer_master[8]=0;rx_buffer_master[9]=0;};                 
{crc_master=0xFFFF;mov_buf_master(0x01);mov_buf_master(0x04);mov_buf_master(0x00);mov_buf_master(0x88);mov_buf_master(0x00);mov_buf_master(0x01);crc_end_master();};
current_out(tok);
{TCNT1=0x0000;TCCR1B=0x03;while ((TIFR&0b00000100)==0);TCCR1B=0;TIFR=TIFR;};
current_out(tok);    
if (check_cr_master()==1)
{

}           

if((AvTimer>=(AverTime_Value))&(AverTime_Value!=0)&(!BPS_absent))
{

true_skz=(float)SKZ_1-(float)(SKZ_1-SKZ_2)*AverSKZ_Value/100;
if(true_skz<minimal_object_enabled_level)object_state = 0;
else object_state=0x40;
AvTimer=0;
disabling_counter=0;

if(AverSKZ_Value==0)rms=0;

SKZread_counter=0;
if(rms>=127|rms<-127)
{
if(rms>=127)AverSKZprcnt=127;
if(rms<-127)AverSKZprcnt=-127;
}
else AverSKZprcnt=(char)rms;

led(30);
if(object_state==0)   
{
(*(unsigned char *) 0x62)=(*(unsigned char *) 0x62)|0b01000000;
(*(unsigned char *) 0x62)=(*(unsigned char *) 0x62)|0b00000001;
(*(unsigned char *) 0x62)=(*(unsigned char *) 0x62)|0b00000100;
LedQ=0;
AverSKZprcnt=100;

tok=0;
}
else 
{
(*(unsigned char *) 0x62)=(*(unsigned char *) 0x62)&0b10111111;
(*(unsigned char *) 0x62)=(*(unsigned char *) 0x62)&0b11111110;
(*(unsigned char *) 0x62)=(*(unsigned char *) 0x62)&0b11111011;
LedQ=ind_select(rms);
SPCR=0xDE;

led(LedQ);
if (AverSKZprcnt<-100)tok=2000;
else tok=8*(100-AverSKZprcnt)+400;
if (tok<400)tok=400;
current_out(tok);
}

AverSKZ_Value=0;}

if(start_calibration==1)
{
press=0;PINC.5  =0;
if ((first_press==1)&&(second_press==1))
{
first_press=0;second_press=0;
}
}

if(((PINC.5  ==0)&&(press==0))|start_calibration)
{ 

warning_flag=0;  
blink_flag=0;

press=1;drebezg=0;
if(((first_press==0)&&(second_press==0)))
{
start_calibration=0;
no_press=0;
red = 1; 

first_press=1;
{crc_master=0xFFFF;mov_buf_master(0x01);mov_buf_master(0x06);mov_buf_master(0x00);mov_buf_master(0x81);mov_buf_master(0x00);mov_buf_master(0x01);crc_end_master();};         
{TCNT1=0x0000;TCCR1B=0x03;while ((TIFR&0b00000100)==0);TCCR1B=0;TIFR=TIFR;};

save_skz_arrays(red);   
save_freq_order();
}
else if(((first_press==1)&&(second_press==0)))
{  
start_calibration=0;    
red=0;
second_press=1;
{crc_master=0xFFFF;mov_buf_master(0x01);mov_buf_master(0x06);mov_buf_master(0x00);mov_buf_master(0x82);mov_buf_master(0x00);mov_buf_master(0x01);crc_end_master();};
{TCNT1=0x0000;TCCR1B=0x03;while ((TIFR&0b00000100)==0);TCCR1B=0;TIFR=TIFR;};

rx_c_master=0;rx_m_master=0;rx_wr_index_master=0;rx_counter_master=0;       
rx_buffer_master[1]=0;
rx_buffer_master[2]=0;
rx_buffer_master[3]=0;
rx_buffer_master[4]=0;
rx_buffer_master[5]=0;
rx_buffer_master[6]=0;
rx_buffer_master[7]=0;
rx_buffer_master[8]=0;
rx_buffer_master[9]=0;
{crc_master=0xFFFF;mov_buf_master(0x01);mov_buf_master(0x04);mov_buf_master(0x00);mov_buf_master(0x87);mov_buf_master(0x00);mov_buf_master(0x01);crc_end_master();};
{TCNT1=0x0000;TCCR1B=0x03;while ((TIFR&0b00000100)==0);TCCR1B=0;TIFR=TIFR;};

if (check_cr_master()==1)
{
SKZ1toSKZ2=0;
if(rx_counter_master==7)SKZ1toSKZ2=((unsigned int)rx_buffer_master[3]<<8)+rx_buffer_master[4];BPS_absent=0;
}
else BPS_absent=1;
{
rx_c_master=0;rx_m_master=0;
rx_wr_index_master=0;rx_counter_master=0;
{rx_buffer_master[0]=0;rx_buffer_master[1]=0;rx_buffer_master[2]=0;rx_buffer_master[3]=0;rx_buffer_master[4]=0;rx_buffer_master[5]=0;rx_buffer_master[6]=0;rx_buffer_master[7]=0;rx_buffer_master[8]=0;rx_buffer_master[9]=0;};
{crc_master=0xFFFF;mov_buf_master(0x01);mov_buf_master(0x04);mov_buf_master(0x00);mov_buf_master(0x83);mov_buf_master(0x00);mov_buf_master(0x01);crc_end_master();}; 
{TCNT1=0x0000;TCCR1B=0x03;while ((TIFR&0b00000100)==0);TCCR1B=0;TIFR=TIFR;};
if (check_cr_master()==1)
{
if(rx_counter_master==7) SKZ_1=((int)rx_buffer_master[3])<<8|(char)rx_buffer_master[4];
}
rx_c_master=0;rx_m_master=0;
rx_wr_index_master=0;rx_counter_master=0;
{rx_buffer_master[0]=0;rx_buffer_master[1]=0;rx_buffer_master[2]=0;rx_buffer_master[3]=0;rx_buffer_master[4]=0;rx_buffer_master[5]=0;rx_buffer_master[6]=0;rx_buffer_master[7]=0;rx_buffer_master[8]=0;rx_buffer_master[9]=0;};
{crc_master=0xFFFF;mov_buf_master(0x01);mov_buf_master(0x04);mov_buf_master(0x00);mov_buf_master(0x84);mov_buf_master(0x00);mov_buf_master(0x01);crc_end_master();};
{TCNT1=0x0000;TCCR1B=0x03;while ((TIFR&0b00000100)==0);TCCR1B=0;TIFR=TIFR;};
if (check_cr_master()==1)
{
if(rx_counter_master==7) SKZ_2=((int)rx_buffer_master[3])<<8|(char)rx_buffer_master[4];
}
}   
EEPROM_write(0x0404, SKZ1toSKZ2);
EEPROM_write(0x0400, SKZ_1>>8);
EEPROM_write(0x0401, SKZ_1);
EEPROM_write(0x0402, SKZ_2>>8);
EEPROM_write(0x0403, SKZ_2);                         

if(SKZ1toSKZ2<=40)
{
warning_flag=1;
if(SKZ1toSKZ2<=20)blink_flag=1;
else blink_flag=0;
}
else warning_flag=0;
CalibrFlag=1;  
save_skz_arrays(red);save_freq_order();  
EEPROM_write(0x04ff, CalibrFlag);                                         

}    

}   

if(PINC.5  ==1)if(++drebezg>1)
{
press=0;drebezg=0;
if ((first_press==1)&&(second_press==1))
{
first_press=0;
second_press=0;
}
}

rx_c_master=0;rx_m_master=0;rx_wr_index_master=0;rx_counter_master=0;

}
}

char check_cr_master()                          
{                                       
char error;                             
error=1;crc_master=0xFFFF;i=0;          
while (i<(rx_wr_index_master-1)){crc_rtu_master(rx_buffer_master[i]);i++;}
if ((rx_buffer_master[rx_wr_index_master])!=(crc_master>>8)) error=0;
if ((rx_buffer_master[rx_wr_index_master-1])!=(crc_master&0x00FF)) error=0;
return error;                           
}                                       

char check_cr_slave()                           
{                                       
char error;                             
error=1;crc_slave=0xFFFF;i=0;           
while (i<(rx_wr_index_slave-1)){crc_rtu_slave(rx_buffer_slave[i]);i++;}
if ((rx_buffer_slave[rx_wr_index_slave])!=(crc_slave>>8)) error=0;
if ((rx_buffer_slave[rx_wr_index_slave-1])!=(crc_slave&0x00FF)) error=0;
return error;                           
}                                       

void crc_rtu_master(char a)		        
{				        
char n;                                 
crc_master = a^crc_master;	        
for(n=0; n<8; n++)		        
{			        
if(crc_master & 0x0001 == 1)	
{		        
crc_master = crc_master>>1;
crc_master=crc_master&0x7fff;
crc_master = crc_master^0xA001;
}		        
else			        
{ 		        
crc_master = crc_master>>1;
crc_master=crc_master&0x7fff;
} 		        
}			        
}	

void  CRC_update(unsigned char d){
unsigned char uindex;
uindex = CRCHigh^d;
CRCHigh=CRCLow^(crctable[uindex]>>8);
CRCLow=crctable[uindex];    

}			        

void crc_rtu_slave(char a)		        
{				        
char n;                                 
crc_slave = a^crc_slave;	        
for(n=0; n<8; n++)		        
{			        
if(crc_slave & 0x0001 == 1)     
{		        
crc_slave =crc_slave>>1;
crc_slave=crc_slave&0x7fff;
crc_slave = crc_slave^0xA001;
}		        
else			        
{ 		        
crc_slave = crc_slave>>1;
crc_slave=crc_slave&0x7fff;
} 		        
}			        
}

void mov_buf_master(char a){crc_rtu_master(a);mov_buf0(a);}
void mov_buf0(char a)			        
{				        
#asm("cli");    		        
tx_buffer_counter_master++;	        
tx_buffer_master[tx_buffer_end_master]=a;
if (++tx_buffer_end_master==128) tx_buffer_end_master=0;
#asm("sei");			        
}				        

void mov_buf_slave(char a){CRC_update(a);mov_buf1(a);}
void mov_buf1(char a)			        
{				        
#asm("cli");    		        
tx_buffer_counter_slave++;	        
tx_buffer_slave[tx_buffer_end_slave]=a; 
if (++tx_buffer_end_slave==128) tx_buffer_end_slave=0;
#asm("sei");			        
}				        

void crc_end_master()				
{				        
mov_buf0(crc_master);mov_buf0(crc_master>>8);
PORTD.4=1;;                              
(*(unsigned char *) 0x9c)=tx_buffer_master[tx_buffer_begin_master];
tx_en_master=1;crc_master=0xffff;       
}				        

void crc_end_slave()				
{				        
mov_buf1(crc_slave);mov_buf1(crc_slave>>8);
PORTE=PORTE|0b00000100;                            
UDR0=tx_buffer_slave[tx_buffer_begin_slave];
tx_en_slave=1;crc_slave=0xffff;	        
}				        
void send_test()				
{				        
PORTE=PORTE|0b00000100;                            
UDR0=tx_buffer_slave[tx_buffer_begin_slave];
tx_en_slave=1;
}				     

void response_m_err(char a)                     
{                                       
mov_buf_slave(rx_buffer_slave[0]);      
mov_buf_slave(rx_buffer_slave[1]|128);  
mov_buf_slave(a);                       
crc_end_slave();                        
}                                       

unsigned char save_reg(unsigned int d,unsigned int a)
{                                       
if      (a==0x01)               kn=d;   
else if (a==0x02)               kv=d;   
else                            return 0;
return 1;                               
}                                       

void response_m_aa4()                           
{                                       

}                                       

void response_m_aa6()                           
{                                       

}                                      

void GetCRC16(char len)
{int b;
crc_slave = 0xFFFF;
for(b=0;b<len;b++)
{
crc_slave = crctable[((crc_slave>>8)^rx_buffer_slave[b])&0xFF] ^ (crc_slave<<8);
}
crc_slave ^= 0xFFFF;

}

