/*****************************************************
CodeWizardAVR V1.24.5 Standard

Project : 10�/�
Version : 
Date    : 09.09.2008

Chip type           : ATmega128L
Program type        : Application
Clock frequency     : 8,000000 MHz
Memory model        : Small
External SRAM size  : 0
Data Stack size     : 1024
*****************************************************/
#include <mega128.h>
#include <delay.h>
#include <math.h>

#define TX_slave_on  PORTE=PORTE|0b00000100
#define TX_slave_off PORTE=PORTE&0b11111011
#define TX_master_on   PORTD.4=1;
#define TX_master_off  PORTD.4=0;

#define led_01_on  PORTC.1=1
#define led_01_off PORTC.1=0
#define led_02_on  PORTC.2=1
#define led_02_off PORTC.2=0
#define led_03_on  PORTC.3=1
#define led_03_off PORTC.3=0
#define led_04_on  PORTC.4=1
#define led_04_off PORTC.4=0
#define led_05_on  PORTC.7=1
#define led_05_off PORTC.7=0
#define led_06_on  PORTC.6=1
#define led_06_off PORTC.6=0
#define led_07_on  PORTA.7=1
#define led_07_off PORTA.7=0
#define led_08_on  PORTA.6=1
#define led_08_off PORTA.6=0
#define led_09_on  PORTA.5=1
#define led_09_off PORTA.5=0
#define led_10_on  PORTA.4=1
#define led_10_off PORTA.4=0
#define led_11_on  PORTA.3=1
#define led_11_off PORTA.3=0
#define led_12_on  PORTA.1=1
#define led_12_off PORTA.1=0
#define led_13_on  PORTA.0=1
#define led_13_off PORTA.0=0
#define led_14_on  PORTF=PORTF|0b10000000
#define led_14_off PORTF=PORTF&0b01111111
#define led_15_on  PORTF=PORTF|0b00100000
#define led_15_off PORTF=PORTF&0b11011111
#define led_16_on  PORTF=PORTF|0b00001000
#define led_16_off PORTF=PORTF&0b11110111
#define led_17_on  PORTF=PORTF|0b00000010
#define led_17_off PORTF=PORTF&0b11111101
#define led_18_on  PORTF=PORTF|0b01000000
#define led_18_off PORTF=PORTF&0b10111111
#define led_19_on  PORTF=PORTF|0b00000001
#define led_19_off PORTF=PORTF&0b11111110
#define led_20_on  PORTF=PORTF|0b00000100
#define led_20_off PORTF=PORTF&0b11111011
#define led_red_on  PORTA.2=1
#define led_red_off PORTA.2=0
#define led_green_on  PORTF=PORTF|0b00010000
#define led_green_off PORTF=PORTF&0b11101111
#define key PINC.5  
#define eeAddressSKZ1H 0x0400
#define eeAddressSKZ1L 0x0401
#define eeAddressSKZ2H 0x0402
#define eeAddressSKZ2L 0x0403
#define eeAddressSKZ1toSKZ2 0x0404
#define eeAdrSKZ1ar 0x0405
#define eeAdrSKZ2ar 0x042C
// //--------------------------------------//
// USART1 Receiver interrupt service routine
//--------------------------------------//
#define RX_BUFFER_SIZE 128
char rx_buffer_master[RX_BUFFER_SIZE];
unsigned char rx_wr_index_master,rx_counter_master,mod_time_master;
bit tx_en_master,rx_m_master,rx_c_master;
interrupt [USART1_RXC] void usart1_rx_isr(void)
	{
	char st,d;
	st=UCSR1A;d=UDR1;
	if ((tx_en_master==0)&&(rx_c_master==0))
		{
		if (mod_time_master==0){rx_m_master=1;rx_wr_index_master=0;}
		mod_time_master=200;
		rx_buffer_master[rx_wr_index_master]=d;
		if (++rx_wr_index_master >=RX_BUFFER_SIZE) rx_wr_index_master=0;
		if (++rx_counter_master >= RX_BUFFER_SIZE) rx_counter_master=0;
		}
	}
//--------------------------------------//
// USART0 Receiver interrupt service routine
//--------------------------------------//
char rx_buffer_slave[RX_BUFFER_SIZE];
unsigned char rx_wr_index_slave,rx_counter_slave,mod_time_slave;
bit tx_en_slave,rx_m_slave,rx_c_slave;
interrupt [USART0_RXC] void usart0_rx_isr(void)
	{
	char st,d;
	st=UCSR0A;d=UDR0;
	if ((tx_en_slave==0)&&(rx_c_slave==0))
		{
		if (mod_time_slave==0){rx_m_slave=1;rx_wr_index_slave=0;}
//		mod_time_slave=12;
		mod_time_slave=200;
		rx_buffer_slave[rx_wr_index_slave]=d;
		if (++rx_wr_index_slave >=RX_BUFFER_SIZE) rx_wr_index_slave=0;
		if (++rx_counter_slave >= RX_BUFFER_SIZE) rx_counter_slave=0;
		}
	}
//--------------------------------------//
// USART1 Transmitter interrupt service routine
//--------------------------------------//
#define TX_BUFFER_SIZE 128
char tx_buffer_master[TX_BUFFER_SIZE];
unsigned char tx_buffer_begin_master,tx_buffer_end_master;
interrupt [USART1_TXC] void usart1_tx_isr(void)
	{
	if (tx_en_master==1)
		{
		delay_us(100);
		if (++tx_buffer_begin_master>=TX_BUFFER_SIZE) tx_buffer_begin_master=0;
		if (tx_buffer_begin_master!=tx_buffer_end_master) {UDR1=tx_buffer_master[tx_buffer_begin_master];}
		else {tx_en_master=0;rx_m_master=0;TX_master_off;}
		}
	}
//--------------------------------------//
// USART0 Transmitter interrupt service routine
//--------------------------------------//
char tx_buffer_slave[TX_BUFFER_SIZE];
unsigned char tx_buffer_begin_slave,tx_buffer_end_slave;
interrupt [USART0_TXC] void usart0_tx_isr(void)
	{
	if (tx_en_slave==1)
		{
		if (++tx_buffer_begin_slave>=TX_BUFFER_SIZE) tx_buffer_begin_slave=0;
		if (tx_buffer_begin_slave!=tx_buffer_end_slave) {UDR0=tx_buffer_slave[tx_buffer_begin_slave];}
		else {tx_en_slave=0;rx_m_slave=0;TX_slave_off;}
		}
	}
//--------------------------------------//
// Timer 0 overflow interrupt service routine
//--------------------------------------//
interrupt [TIM0_OVF] void timer0_ovf_isr(void)
        {
        TCNT0=0x07;//250us
	#asm("wdr");
	if (mod_time_slave==0){if(rx_m_slave==1) rx_c_slave=1;}   else 	mod_time_slave--;
	if (mod_time_master==0){if(rx_m_master==1) rx_c_master=1;}else 	mod_time_master--;
        }
//--------------------------------------//     


//--------------------------------------//
// Timer 3 overflow interrupt 
//--------------------------------------//    
/*int warning_flag, blink_flag, red;
interrupt [TIM3_OVF] void timer3_overflow(void)
        {      TCNT3H=0x00;
               TCNT3L=0x00;
                if (red==1){
                        led_green_off;
                        if(PORTA.2==1)led_red_off;
                        else led_red_on;}
                else{if(warning_flag==1){
                                if(blink_flag==1){
                                if(PORTF==PORTF|0b00010000)led_green_off;
                                else led_green_on;}
                                else led_green_on;}
                                else led_green_off;}
       
        
        }  */
        
void EEPROM_write(unsigned int eeAddress, unsigned char eeData)
{
/* Wait for completion of previous write */
while(EECR&0x02)//  (1<<EEWE))
;
/* Set up address and data registers */
EEAR = eeAddress;
EEDR = eeData;
/* Write logical one to EEMWE */
EECR |= 0x04;//(1<<EEMWE);
/* Start eeprom write by setting EEWE */
EECR |= 0x02;//(1<<EEWE); 
 }

unsigned char EEPROM_read(unsigned int eeAddress)
{
/* Wait for completion of previous write */
while(EECR & 0x02)//(1<<EEWE))
;
/* Set up address register */
EEAR = eeAddress;
/* Start eeprom read by writing EERE */
EECR |= 0x01;//(1<<EERE);
/* Return data from data register */
return EEDR;
}                              


//--------------------------------------//     

char str[15];
unsigned char tx_buffer_counter_master,tx_buffer_counter_slave,adres;
unsigned char i,drebezg;
float data[4];
long int ii;
unsigned long adc_buf;
int crc_master,crc_slave;
bit press,first_press,second_press;
unsigned int reg[40];
eeprom float kv=100;
eeprom float kn=100;

#include <stdio.h>
unsigned char save_reg(unsigned int d,unsigned int a);
char check_cr_master();
char check_cr_slave();
void crc_rtu_master(char a);			//
void crc_rtu_slave(char a);			//
void crc_end_master();			//
void crc_end_slave();			//
void mov_buf_master(char a);
void mov_buf0(char a);			//
void mov_buf_slave(char a);
void mov_buf1(char a);			//
unsigned int valskz;
void response_m_err(char a);                     //
void response_m_aa4();                     //
void response_m_aa6();                     //
signed int rms;
unsigned int SKZ_1,SKZ_2,SKZ1toSKZ2,SKZ_read;
#define send_save_frq  {crc_master=0xFFFF;mov_buf_master(0x01);mov_buf_master(0x04);mov_buf_master(0x00);mov_buf_master(0x80);mov_buf_master(0x00);mov_buf_master(0x01);crc_end_master();}
#define send_test  {crc_master=0xFFFF;mov_buf_master(0x01);mov_buf_master(0x0C);mov_buf_master(0x01);mov_buf_master(0x02);mov_buf_master(0x03);mov_buf_master(0x04);crc_end_master();}
#define send_read_valskz  {crc_master=0xFFFF;mov_buf_master(0x01);mov_buf_master(0x04);mov_buf_master(0x00);mov_buf_master(0x85);mov_buf_master(0x00);mov_buf_master(0x01);crc_end_master();}
#define send_read_skz  {crc_master=0xFFFF;mov_buf_master(0x01);mov_buf_master(0x04);mov_buf_master(0x00);mov_buf_master(0x86);mov_buf_master(0x00);mov_buf_master(0x01);crc_end_master();}
#define send_read_skzrel  {crc_master=0xFFFF;mov_buf_master(0x01);mov_buf_master(0x04);mov_buf_master(0x00);mov_buf_master(0x87);mov_buf_master(0x00);mov_buf_master(0x01);crc_end_master();}
#define send_save_skz1 {crc_master=0xFFFF;mov_buf_master(0x01);mov_buf_master(0x06);mov_buf_master(0x00);mov_buf_master(0x81);mov_buf_master(0x00);mov_buf_master(0x01);crc_end_master();}
#define send_save_skz2 {crc_master=0xFFFF;mov_buf_master(0x01);mov_buf_master(0x06);mov_buf_master(0x00);mov_buf_master(0x82);mov_buf_master(0x00);mov_buf_master(0x01);crc_end_master();}
#define send_read_skz1 {crc_master=0xFFFF;mov_buf_master(0x01);mov_buf_master(0x04);mov_buf_master(0x00);mov_buf_master(0x83);mov_buf_master(0x00);mov_buf_master(0x01);crc_end_master();}
#define send_read_skz2 {crc_master=0xFFFF;mov_buf_master(0x01);mov_buf_master(0x04);mov_buf_master(0x00);mov_buf_master(0x84);mov_buf_master(0x00);mov_buf_master(0x01);crc_end_master();}
//#define send_read_skz1  {crc_slave=0xFFFF;mov_buf_slave(0x01);mov_buf_slave(0x04);mov_buf_slave(0x00);mov_buf_slave(0x86);mov_buf_slave(0x00);mov_buf_slave(0x01);crc_end_slave();}
#define whait_read {TCNT1=0x0000;TCCR1B=0x03;/*8000000/8==1us*65535=65ms*/while ((TIFR&0b00000100)==0);TCCR1B=0;TIFR=TIFR;#asm("wdr");}
void led(unsigned char a)
        {
        switch (a)
                {
                case 0: {
          led_20_off;led_19_off;led_18_off;led_17_off;led_16_off;led_15_off;led_14_off;led_13_off;led_12_off;led_11_off;
          led_10_off;led_09_off;led_08_off;led_07_off;led_06_off;led_05_off;led_04_off;led_03_on;led_02_on;led_01_on;break;}
                case 1: {
          led_20_off;led_19_off;led_18_off;led_17_off;led_16_off;led_15_off;led_14_off;led_13_off;led_12_off;led_11_off;
          led_10_off;led_09_off;led_08_off;led_07_off;led_06_off;led_05_off;led_04_off;led_03_on;led_02_on;led_01_on;break;}
                case 2: {
          led_20_off;led_19_off;led_18_off;led_17_off;led_16_off;led_15_off;led_14_off;led_13_off;led_12_off;led_11_off;
          led_10_off;led_09_off;led_08_off;led_07_off;led_06_off;led_05_off;led_04_off;led_03_on;led_02_on;led_01_off;break;}
                case 3: {
          led_20_off;led_19_off;led_18_off;led_17_off;led_16_off;led_15_off;led_14_off;led_13_off;led_12_off;led_11_off;
          led_10_off;led_09_off;led_08_off;led_07_off;led_06_off;led_05_off;led_04_off;led_03_on;led_02_off;led_01_off;break;}
                case 4: {
          led_20_off;led_19_off;led_18_off;led_17_off;led_16_off;led_15_off;led_14_off;led_13_off;led_12_off;led_11_off;
          led_10_off;led_09_off;led_08_off;led_07_off;led_06_off;led_05_off;led_04_on;led_03_off;led_02_off;led_01_off;break;}
                case 5: {
          led_20_off;led_19_off;led_18_off;led_17_off;led_16_off;led_15_off;led_14_off;led_13_off;led_12_off;led_11_off;
          led_10_off;led_09_off;led_08_off;led_07_off;led_06_off;led_05_on;led_04_on;led_03_off;led_02_off;led_01_off;break;}
                case 6: {
          led_20_off;led_19_off;led_18_off;led_17_off;led_16_off;led_15_off;led_14_off;led_13_off;led_12_off;led_11_off;
          led_10_off;led_09_off;led_08_off;led_07_off;led_06_on;led_05_on;led_04_on;led_03_off;led_02_off;led_01_off;break;}
                case 7: {
          led_20_off;led_19_off;led_18_off;led_17_off;led_16_off;led_15_off;led_14_off;led_13_off;led_12_off;led_11_off;
          led_10_off;led_09_off;led_08_off;led_07_on;led_06_on;led_05_on;led_04_on;led_03_off;led_02_off;led_01_off;break;}
                case 8: {
          led_20_off;led_19_off;led_18_off;led_17_off;led_16_off;led_15_off;led_14_off;led_13_off;led_12_off;led_11_off;
          led_10_off;led_09_off;led_08_on;led_07_on;led_06_on;led_05_on;led_04_on;led_03_off;led_02_off;led_01_off;break;}
                case 9: {
          led_20_off;led_19_off;led_18_off;led_17_off;led_16_off;led_15_off;led_14_off;led_13_off;led_12_off;led_11_off;
          led_10_off;led_09_on;led_08_on;led_07_on;led_06_on;led_05_on;led_04_on;led_03_off;led_02_off;led_01_off;break;}
                case 10: {
          led_20_off;led_19_off;led_18_off;led_17_off;led_16_off;led_15_off;led_14_off;led_13_off;led_12_off;led_11_off;
          led_10_on;led_09_on;led_08_on;led_07_on;led_06_on;led_05_on;led_04_on;led_03_off;led_02_off;led_01_off;break;}
                case 11: {
          led_20_off;led_19_off;led_18_off;led_17_off;led_16_off;led_15_off;led_14_off;led_13_off;led_12_off;led_11_on;
          led_10_on;led_09_on;led_08_on;led_07_on;led_06_on;led_05_on;led_04_on;led_03_off;led_02_off;led_01_off;break;}
                case 12: {
          led_20_off;led_19_off;led_18_off;led_17_off;led_16_off;led_15_off;led_14_off;led_13_off;led_12_on;led_11_on;
          led_10_on;led_09_on;led_08_on;led_07_on;led_06_on;led_05_on;led_04_on;led_03_off;led_02_off;led_01_off;break;}
                case 13: {
          led_20_off;led_19_off;led_18_off;led_17_off;led_16_off;led_15_off;led_14_off;led_13_on;led_12_on;led_11_on;
          led_10_on;led_09_on;led_08_on;led_07_on;led_06_on;led_05_on;led_04_on;led_03_off;led_02_off;led_01_off;break;}
                case 14: {
          led_20_off;led_19_off;led_18_off;led_17_off;led_16_off;led_15_off;led_14_on;led_13_on;led_12_on;led_11_on;
          led_10_on;led_09_on;led_08_on;led_07_on;led_06_on;led_05_on;led_04_on;led_03_off;led_02_off;led_01_off;break;}
                case 15: {
          led_20_off;led_19_off;led_18_off;led_17_off;led_16_off;led_15_on;led_14_on;led_13_on;led_12_on;led_11_on;
          led_10_on;led_09_on;led_08_on;led_07_on;led_06_on;led_05_on;led_04_on;led_03_off;led_02_off;led_01_off;break;}
                case 16: {
          led_20_off;led_19_off;led_18_off;led_17_off;led_16_on;led_15_on;led_14_on;led_13_on;led_12_on;led_11_on;
          led_10_on;led_09_on;led_08_on;led_07_on;led_06_on;led_05_on;led_04_on;led_03_off;led_02_off;led_01_off;break;}
                case 17: {
          led_20_off;led_19_off;led_18_off;led_17_on;led_16_on;led_15_on;led_14_on;led_13_on;led_12_on;led_11_on;
          led_10_on;led_09_on;led_08_on;led_07_on;led_06_on;led_05_on;led_04_on;led_03_off;led_02_off;led_01_off;break;}
                case 18: {
          led_20_off;led_19_off;led_18_on;led_17_on;led_16_on;led_15_on;led_14_on;led_13_on;led_12_on;led_11_on;
          led_10_on;led_09_on;led_08_on;led_07_on;led_06_on;led_05_on;led_04_on;led_03_off;led_02_off;led_01_off;break;}
                case 19: {
          led_20_off;led_19_on;led_18_on;led_17_on;led_16_on;led_15_on;led_14_on;led_13_on;led_12_on;led_11_on;
          led_10_on;led_09_on;led_08_on;led_07_on;led_06_on;led_05_on;led_04_on;led_03_off;led_02_off;led_01_off;break;}
                case 20: {
          led_20_on;led_19_on;led_18_on;led_17_on;led_16_on;led_15_on;led_14_on;led_13_on;led_12_on;led_11_on;
          led_10_on;led_09_on;led_08_on;led_07_on;led_06_on;led_05_on;led_04_on;led_03_off;led_02_off;led_01_off;break;}
                default: {
          led_20_on;led_19_on;led_18_on;led_17_on;led_16_on;led_15_on;led_14_on;led_13_on;led_12_on;led_11_on;
          led_10_on;led_09_on;led_08_on;led_07_on;led_06_on;led_05_on;led_04_on;led_03_off;led_02_off;led_01_off;break;}
              }
        }
void blink_display(int value) //����������� ���������� � ���������� ������ ������� 
        {
        char i;
        led_green_on;
        led_red_on;
        delay_ms(1000);
        led_green_off;
        led_red_off;
        delay_ms(1000);
        
        for(i=1;i<(value/10);i++)
        {led_green_on;
        delay_ms(200);
        led_green_off;
        delay_ms(200);}
        led_green_on;
        led_red_on;
        delay_ms(600);
        led_green_off;
        led_red_off;
        delay_ms(600);
        } 
//-------------------------------------------
// ������ �������� ����������
//-------------------------------------------
void current_out(unsigned int out)
        {
        char i;
        DDRB = DDRB|0b00110111;
        PORTB=PORTB|0b00110111;
        PORTB.0=0;//
        out=out<<4;
        for (i=0;i<12;i++)
                {
                if(out>=0x8000)PORTB.2=1;//
                else PORTB.2=0;//
                PORTB.1=0;PORTB.1=1;//
                out<<=1;
                }
        PORTB.0=1;PORTB.4=0;PORTB.4=1;
        }
//-------------------------------------------        
void send_skz()
{crc_master=0xFFFF;
mov_buf_master(0x01);
mov_buf_master(0x0c);
mov_buf_master(EEPROM_read(eeAddressSKZ1H));     //������� ���������� ����������� � ������ �������� ����� ���1 � ���2
mov_buf_master(EEPROM_read(eeAddressSKZ1L));     //��� ������ ������ �������
mov_buf_master(EEPROM_read(eeAddressSKZ2H));
mov_buf_master(EEPROM_read(eeAddressSKZ2L));
crc_end_master();}      

/*void req_recieve_skz_array()
{unsigned int m;
crc_master=0xFFFF;
mov_buf_master(0x01);
for(m=2;m<79;m++)mov_buf_master(0xcc); 
crc_end_master();}   */

void save_skz_arrays(unsigned int skz1or2)//������ ������� ���������� ���� �������� ������� Config.SKZ_1 u Config.SKZ_2
{unsigned int m;                          // � ����� ����� ��������� ��� � ������ eeprom ���
unsigned int val1, val2,addrval;  


if(skz1or2==1){val1=0;val2=19;addrval=0x20;}        //������ addrval ��������� ������ �� ������� ������ ������ ��� ������ ��������� ���� ��������
if(skz1or2==0){val1=19;val2=38;addrval=0x2D;}
for (m=val1;m<val2;m++){
led_red_on;
/*if(skz1or2==1)led_red_on;
else {led_red_off;        
     if(!warning_flag)led_green_off;
     else led_green_on;}*/
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

whait_read; 
 /*if((skz1or2==0)&&(blink_flag==1)&&(warning_flag==0)){
 led_red_off;
 led_green_off;
 delay_ms(300);} */


if (check_cr_master()==1)
              {SKZ_read=0;
              if(rx_counter_master==7)SKZ_read=((unsigned int)rx_buffer_master[3]<<8)+rx_buffer_master[4];}
              #asm(" sei") 
              EEPROM_write(0x0405+2*m, rx_buffer_master[3]);
              EEPROM_write(0x0405+2*m+1, rx_buffer_master[4] ); 
              #asm(" cli")
                 
//              blink_display (rx_buffer_master[3]);
//              blink_display (rx_buffer_master[4]);              
} }



/*void recieve_skz_array()
{unsigned int m;   
rx_c_master=0;rx_m_master=0;rx_wr_index_master=0;rx_counter_master=0;  
for(m=0;m<80;m++)rx_buffer_master[m]=0;   
if (check_cr_master()==1){
if(rx_counter_master==80){
for (m=0;m<38;m++)
{
 #asm(" sei")          
 EEPROM_write(eeAdrSKZ1ar+m, rx_buffer_master[m+2] );               //��������� ��� � ������     
 #asm(" cli")}                                      
 for (m=0;m<38;m++)
{
 #asm(" sei")          
 EEPROM_write(eeAdrSKZ2ar+m, rx_buffer_master[m+40] );               //��������� ��� � ������     
 #asm(" cli")}            } }                         
} */

void send_skz_array()              //������� ������������ �� ��� �������� �������� ���1 � ���2 ����������� � ������ ���
{unsigned int m;   
rx_c_master=0;rx_m_master=0;
rx_wr_index_master=0;rx_counter_master=0;
rx_c_slave=0;rx_m_slave=0;
rx_wr_index_slave=0;rx_counter_slave=0;
//for(m=0;m<80;m++)tx_buffer_master[m]=0;
crc_master=0xFFFF;
mov_buf_master(0x01);
mov_buf_master(0xcd); 
for (m=0;m<76;m++)
{
// #asm(" sei")          
 mov_buf_master(EEPROM_read(0x0405+m));    }           //������ ������ �� ������    
// #asm(" cli")}                                      
 crc_end_master();                                    
}
       
void main(void)
{ 
int no_press=1; 
signed int x1,x2;
//char n;
float y;
y=0;   
unsigned int tok;//,reg1,reg2,reg;
unsigned char flag_green_led=0;
unsigned char warning_flag=0,blink_flag=0,red=0;
PORTA=0b00000000;DDRA=0b11111111;
PORTB=0b00000000;DDRB=0b00001100;
PORTC=0b00100000;DDRC=0b11011111;
PORTD=0b10000000;DDRD=0b00011000;
PORTE=0b00000000;DDRE=0b00000110;
PORTF=0b00000000;DDRF=0b11111111;
PORTG=0b00000000;DDRG=0b00000000;

UCSR0A=0x00;UCSR0B=0xD8;UCSR0C=0x06;UBRR0H=0x00;UBRR0L=0x33;
UCSR1A=0x00;UCSR1B=0xD8;UCSR1C=0x06;UBRR1H=0x00;UBRR1L=0x33;

ACSR=0x80;SFIOR=0x00;ASSR=0x00;
TCCR0=0x02;TCNT0=0x00;OCR0=0x00;
 led_03_off;led_02_off;led_01_off;led_20_off;led_19_off;led_18_off;
/*
TIMSK=0x01;//ETIMSK=0x00;
//TCCR3B=0x04;ETIFR=0x04;ETIMSK=0x04;TCCR3A=0x00;
rx_c_master=0;rx_m_master=0;
rx_wr_index_master=0;rx_counter_master=0;
rx_c_slave=0;rx_m_slave=0;
rx_wr_index_slave=0;rx_counter_slave=0;
//        send_save_skz1;
//        whait_read;   
//        send_save_skz2;
//        whait_read;   

#asm("sei")
SKZ_1=0;SKZ_2=0;
SKZ_1 = ((unsigned int)EEPROM_read(eeAddressSKZ1H)<<8)+EEPROM_read(eeAddressSKZ1L);        //v
SKZ_2 = ((unsigned int)EEPROM_read(eeAddressSKZ2H)<<8)+EEPROM_read(eeAddressSKZ2L);        //v
SKZ1toSKZ2 =   EEPROM_read(eeAddressSKZ1toSKZ2);  
if(SKZ1toSKZ2!=0xff){
                                      if(SKZ1toSKZ2>=60){warning_flag=1;
                                      if(SKZ1toSKZ2>=80)blink_flag=1;
                                      else blink_flag=0;
                                      }
                                      else warning_flag=0; }       
                                   //    blink_display(SKZ_1);  blink_display(SKZ_2);
                                      delay_ms(300);  
                                      send_skz_array();
                                      whait_read;                                      */
                                  /*    if((SKZ_1==0xffff)&&(SKZ_2==0xffff))no_press=0;
                                      else{ send_save_frq;
                                            whait_read;
                                            send_skz();
                                            whait_read;}*/
while (1)
        {
         /*
if(red)led_red_on;
else {led_red_off;        
     if(!warning_flag)led_green_off;
     else led_green_on;}
 rx_c_master=0;rx_m_master=0;
 rx_wr_index_master=0;rx_counter_master=0;
// rx_c_slave=0;rx_m_slave=0;
// rx_wr_index_slave=0;rx_counter_slave=0;

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
/*if(no_press){ 

 	send_read_valskz;
        whait_read; 
        led_red_off; 
        led_green_off;
        
        if (check_cr_master()==1)
                {
                valskz=0; 
                rms=0;
                if(rx_counter_master==7) valskz=((unsigned int)rx_buffer_master[3]<<8)+rx_buffer_master[4];    //V
                rms = 100*((double)((valskz - SKZ_1)/(SKZ_2 - SKZ_1)));    
                // blink_display(valskz);          
                rms=0-rms;
                rms=(float)((float)0.065*rms+10.5);    
                  
                }  
        }
else{*/  
 	/*send_read_skz;
        whait_read; 
        led_red_off; 
        led_green_off;
        
        if (check_cr_master()==1)
                {
                rms=0;
                if(rx_counter_master==7) rms=((unsigned int)rx_buffer_master[3]<<8)+rx_buffer_master[4]; 
               //    blink_display(rms*100);    
                //if(rms>0x10000)
                //rms=0-rms;
                //rms=(float)((float)0.065*rms+10.5);
            //    }  
       // }        
       // y=(float)((float)0.5*rms+(float)0.5*y+0.5);     
                rms=(rms+100)/10;
                rms=20-rms;
                if(rms>20)rms=20;
                if(rms<0)rms=0;
                
                                               }  

        y=(float)((float)0.5*rms+(float)0.5*y+0.5);
       
       if (y>20) y=20;if (y<1) y=1;  
 
//        if(blink_flag==1) led_green_off;
//-------------------------------------------
// ������ �������� ����������
//-------------------------------------------
        tok=rms*100+225;  
//        tok=rms*125;  
//        tok=(float)((float)(tok*0.822707)+1.740841);
        current_out(tok);
//-------------------------------------------
        if((red==1)|(blink_flag==1)){
        delay_ms(300);}
        led(y);   */
       
/*        if (first_press==1){
        if (second_press==1)red=0;
        led_green_off;
         }*/

//        if (flag_green_led>0)led_green_on;
//        delay_ms(300);
//         if(blink_flag==1) led_green_off;
//        led_03_off;led_02_off;led_01_off;led_20_off;led_19_off;led_18_off;//led_red_off;
        
       // if (flag_green_led<2)led_green_off;
        //-------------------------------------------
        if((key==0)&&(press==0))
                { 
/*                
                warning_flag=0;  
                blink_flag=0;
                //TCNT3H=0;
                //TCNT3L=0;
                               */
                press=1;drebezg=0;
                if((first_press==0)&&(second_press==0))
                        {
/*                        no_press=0;
                        red = 1; 
                        led_green_off;  
                        
                        
                	send_save_skz1;         //��������� � ��� ���1
                        whait_read; 
                        save_skz_arrays(red);   
                 */     
                 first_press=1;
                 led_red_on;
                 led_green_on;
                 y=20;
                 led(y);
                        }
                else if((first_press==1)&&(second_press==0))
                        {  
                        
                       // red=0;
                        second_press=1;
                	led_red_off;
                        led_green_off;
                        y=0;
                        led(y);          
                        
led_03_off;led_02_off;led_01_off;led_20_off;led_19_off;led_18_off;
                	//send_save_skz2;
                       // whait_read; 
                        
/*
       	        rx_c_master=0;rx_m_master=0;rx_wr_index_master=0;rx_counter_master=0;       //�������� ����� ������� � ����� ��� �������� � ������ ���������                rx_buffer_master[0]=0;
                rx_buffer_master[1]=0;
                rx_buffer_master[2]=0;
                rx_buffer_master[3]=0;
                rx_buffer_master[4]=0;
                rx_buffer_master[5]=0;
                rx_buffer_master[6]=0;
                rx_buffer_master[7]=0;
                rx_buffer_master[8]=0;
                rx_buffer_master[9]=0;
                         send_read_skzrel;//������ �������� �������������� ��������� �������
                         whait_read;
                         if (check_cr_master()==1)
                                 {
                                 SKZ1toSKZ2=0;
                                 if(rx_counter_master==7)SKZ1toSKZ2=((unsigned int)rx_buffer_master[3]<<8)+rx_buffer_master[4];
                                 }
                         EEPROM_write(eeAddressSKZ1toSKZ2, SKZ1toSKZ2);
 //                               blink_display(SKZ1toSKZ2);     //��������������� ������� ��� ��������� ����������� ������ ������ �������
                                      if(SKZ1toSKZ2>=60){warning_flag=1;
                                      if(SKZ1toSKZ2>=80)blink_flag=1;
                                      else blink_flag=0;
                                                        }
                                      else warning_flag=0;  
save_skz_arrays(red);     */                                    
/*                rx_c_master=0;rx_m_master=0;rx_wr_index_master=0;rx_counter_master=0;       //�������� ����� ������� � ����� ��� �������� � ������ ���������                rx_buffer_master[0]=0;
                rx_buffer_master[1]=0;
                rx_buffer_master[2]=0;
                rx_buffer_master[3]=0;
                rx_buffer_master[4]=0;
                rx_buffer_master[5]=0;
                rx_buffer_master[6]=0;
                rx_buffer_master[7]=0;
                rx_buffer_master[8]=0;
                rx_buffer_master[9]=0;                        
                        send_read_skz1;
                        whait_read;//����� �� ��������� ���������, ����������� �� ���
                           if (check_cr_master()==1)
                                 {
                                 SKZ_1=0;
                                 if(rx_counter_master==7)SKZ_1=((unsigned int)rx_buffer_master[3]<<8)+rx_buffer_master[4];
                                 }   
                            
                        #asm(" sei")          
                        EEPROM_write(eeAddressSKZ1H, rx_buffer_master[3] );               //��������� ��� � ������     
                        EEPROM_write(eeAddressSKZ1L, rx_buffer_master[4] );     
                        #asm(" cli")                                        
       	        rx_c_master=0;rx_m_master=0;rx_wr_index_master=0;rx_counter_master=0;       //�������� ����� ������� � ����� ��� �������� � ������ ���������                rx_buffer_master[0]=0;
                rx_buffer_master[1]=0;
                rx_buffer_master[2]=0;
                rx_buffer_master[3]=0;
                rx_buffer_master[4]=0;
                rx_buffer_master[5]=0;
                rx_buffer_master[6]=0;
                rx_buffer_master[7]=0;
                rx_buffer_master[8]=0;
                rx_buffer_master[9]=0;                        
                        send_read_skz2;
                        whait_read;//����� �� ��������� ���������, ����������� �� ���
                           if (check_cr_master()==1)
                                 {
                                 SKZ_2=0;
                                 if(rx_counter_master==7)SKZ_2=((unsigned int)rx_buffer_master[3]<<8)+rx_buffer_master[4]; 
                                 }   
                                 //blink_display(SKZ_2);   
                                 #asm(" sei")           
                                 EEPROM_write(eeAddressSKZ2H, rx_buffer_master[3] );               //��������� ��� � ������     
                                 EEPROM_write(eeAddressSKZ2L, rx_buffer_master[4] );                 
                                 #asm(" cli")         */
                                 
//req_recieve_skz_array();                                
//recieve_skz_array();
                        }    
                                
                }   


        if(key==1)if(++drebezg>1){press=0;drebezg=0;
                        if ((first_press==1)&&(second_press==1)){first_press=0;second_press=0;//����� 2�� ������� �� ������, ���������� ����� ����������� �������
                         
  
                        
                        }}
        if (rx_c_slave==1)
                {
                if (check_cr_slave()==1)
                        {
        		crc_slave=0xffff;
        		switch (rx_buffer_slave[1])
                                {
        		        case 4:{if (rx_counter_slave==8)response_m_aa4();
        	          	     	else   response_m_err(1);
        	          	     	break;}
        		        case 6:{if (rx_counter_slave==8)response_m_aa6();
        	          	     	else   response_m_err(1);
        	          	     	break;}
        		        default:response_m_err(2);
        		        }
                        }
       	        rx_c_master=0;rx_m_master=0;rx_wr_index_master=0;rx_counter_master=0;
       	        rx_c_slave=0;rx_m_slave=0;rx_wr_index_slave=0;rx_counter_slave=0;
                }       
          //led_red_off; 
        }
}
//------�������� ����������� ����� master-------//
char check_cr_master()                          //
        {                                       //
        char error;                             //
	error=1;crc_master=0xFFFF;i=0;          //
	while (i<(rx_wr_index_master-1)){crc_rtu_master(rx_buffer_master[i]);i++;}
	if ((rx_buffer_master[rx_wr_index_master])!=(crc_master>>8)) error=0;
	if ((rx_buffer_master[rx_wr_index_master-1])!=(crc_master&0x00FF)) error=0;
	return error;                           //
        }                                       //
//------�������� ����������� ����� slave--------//
char check_cr_slave()                           //
        {                                       //
        char error;                             //
	error=1;crc_slave=0xFFFF;i=0;           //
	while (i<(rx_wr_index_slave-1)){crc_rtu_slave(rx_buffer_slave[i]);i++;}
	if ((rx_buffer_slave[rx_wr_index_slave])!=(crc_slave>>8)) error=0;
	if ((rx_buffer_slave[rx_wr_index_slave-1])!=(crc_slave&0x00FF)) error=0;
	return error;                           //
        }                                       //
//------������ ����������� ����� master---------//
void crc_rtu_master(char a)		        //
	{				        //
	char n;                                 //
	crc_master = a^crc_master;	        //
	for(n=0; n<8; n++)		        //
		{			        //
		if(crc_master & 0x0001 == 1)	//
			{		        //
			crc_master = crc_master>>1;//
			crc_master=crc_master&0x7fff;//
			crc_master = crc_master^0xA001;//
			}		        //
		else			        //
			{ 		        //
			crc_master = crc_master>>1;//
			crc_master=crc_master&0x7fff;//
			} 		        //
		}			        //
	}				        //
//------������ ����������� ����� slave----------//
void crc_rtu_slave(char a)		        //
	{				        //
	char n;                                 //
	crc_slave = a^crc_slave;	        //
	for(n=0; n<8; n++)		        //
		{			        //
		if(crc_slave & 0x0001 == 1)     //
			{		        //
			crc_slave =crc_slave>>1;//
			crc_slave=crc_slave&0x7fff;//
			crc_slave = crc_slave^0xA001;//
			}		        //
		else			        //
			{ 		        //
			crc_slave = crc_slave>>1;//
			crc_slave=crc_slave&0x7fff;//
			} 		        //
		}			        //
	}				        //
//------���� � ������ ����������� master--------//
void mov_buf_master(char a){crc_rtu_master(a);mov_buf0(a);}//
void mov_buf0(char a)			        //
	{				        //
	#asm("cli");    		        //
	tx_buffer_counter_master++;	        //
	tx_buffer_master[tx_buffer_end_master]=a;//
	if (++tx_buffer_end_master==TX_BUFFER_SIZE) tx_buffer_end_master=0;//
	#asm("sei");			        //
	}				        //
//------���� � ������ ����������� slave---------//
void mov_buf_slave(char a){crc_rtu_slave(a);mov_buf1(a);}//
void mov_buf1(char a)			        //
	{				        //
	#asm("cli");    		        //
	tx_buffer_counter_slave++;	        //
	tx_buffer_slave[tx_buffer_end_slave]=a; //
	if (++tx_buffer_end_slave==TX_BUFFER_SIZE) tx_buffer_end_slave=0;//
	#asm("sei");			        //
	}				        //
//------������� ����������� �����---------------//
//------������ �������� �� master---------------//
void crc_end_master()				//
	{				        //
	mov_buf0(crc_master);mov_buf0(crc_master>>8);//
	TX_master_on;                              //
       	UDR1=tx_buffer_master[tx_buffer_begin_master];//
	tx_en_master=1;crc_master=0xffff;       //
	}				        //
//------������� ����������� �����---------------//
//------������ �������� �� slave----------------//
void crc_end_slave()				//
	{				        //
	mov_buf1(crc_slave);mov_buf1(crc_slave>>8);//
	TX_slave_on;                            //
       	UDR0=tx_buffer_slave[tx_buffer_begin_slave];//
	tx_en_slave=1;crc_slave=0xffff;	        //
	}				        //
//------����� ������----------------------------//
void response_m_err(char a)                     //
        {                                       //
	mov_buf_slave(rx_buffer_slave[0]);      //
	mov_buf_slave(rx_buffer_slave[1]|128);  //
	mov_buf_slave(a);                       //
        crc_end_slave();                        //
        }                                       //
//----------------------------------------------//
unsigned char save_reg(unsigned int d,unsigned int a)
        {                                       //
        if      (a==0x01)               kn=d;   //
        else if (a==0x02)               kv=d;   //
        else                            return 0;//
        return 1;                               //
        }                                       //
//----------------------------------------------//
void response_m_aa4()                           //
        {                                       //
       	crc_master=0xFFFF;                      //
       	for (i=0;i<rx_counter_slave-2;i++){mov_buf_master(rx_buffer_slave[i]);}
        crc_end_master();crc_master=0xFFFF;     //
        TCNT1=0x0000;TCCR1B=0x03;//8000000/8==1us*65535=65ms
        while ((TIFR&0b00000100)==0);           //
        TCCR1B=0;TIFR=TIFR;                     //
       	crc_slave=0xFFFF;                       //
       	for (i=0;i<rx_counter_master-2;i++){mov_buf_slave(rx_buffer_master[i]);}
        crc_end_slave();                        //
        }                                       //
//----------------------------------------------//
void response_m_aa6()                           //
        {                                       //
        unsigned int d,a,i;                     //
        a=rx_buffer_slave[2];a=(a<<8)+rx_buffer_slave[3];d=rx_buffer_slave[4];d=(d<<8)+rx_buffer_slave[5];
	if (save_reg(d,a)==1){for (i=0;i<6;i++)mov_buf_slave(rx_buffer_slave[i]);crc_end_slave();}
	else                                    //
	        {                               //
               	crc_master=0xFFFF;              //
               	for (i=0;i<rx_counter_slave-2;i++)
               	        {mov_buf_master(rx_buffer_slave[i]);}
                crc_end_master();crc_master=0xFFFF;
                TCNT1=0x0000;TCCR1B=0x03;//8000000/8==1us*65535=65ms
                while ((TIFR&0b00000100)==0);  //
                TCCR1B=0;                      //
                TIFR=TIFR;                     //
               	crc_slave=0xFFFF;              //
               	for (i=0;i<rx_counter_master-2;i++){mov_buf_slave(rx_buffer_master[i]);}
                crc_end_slave();               //
	        }                              //
        }                                      //
//----------------------------------------------//