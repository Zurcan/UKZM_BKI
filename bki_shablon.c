/*
1-----A3--59-PF2
2-----A1--61-PF0
3-----A7--55-PF6
4-----A2--60-PF1
5-----A4--58-PF3
6-----A6--56-PF5
7-----A8--54-PF7
8-----A9--51-PA0
9-----A10-50-PA1
10----A12-48-PA3
11----A13-47-PA4
12----A14-46-PA5
13----A15-45-PA6
14----A16-44-PA7
15----A19-41-PC6
16----A20-42-PC7
17----A17-39-PC4
18----L1--38-PC3
19----L2--37-PC2
20----K1--36-PC1
green-A5--57-PF4
red---A11-49-PA2
key---A18-40-PC5

o(4)  o(2)
o(5)  o(1)
o(6)  o(red)
o(7)  o(3)
o(9)  o(8)
o(10) o(green)
o(12) o(11)
o(14) o(13)
o(15) o(16)
o(17) o(key)
o(18) o(gnd)
o(19) o(gnd)
o(20) o(gnd)



*/
/*****************************************************
CodeWizardAVR V1.24.5 Standard

Project : 10ч/д
Version : 
Date    : 27.06.2007

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

#define UPE 2
#define OVR 3
#define FE 4

#define FRAMING_ERROR (1<<FE)
#define PARITY_ERROR (1<<UPE)
#define DATA_OVERRUN (1<<OVR)

#define TX_slave_on  PORTE=PORTE|0b00000100
#define TX_slave_off PORTE=PORTE&0b11111011
#define TX_master_on   PORTD.4=1;
#define TX_master_off  PORTD.4=0;

//#define TX_master_on  PORTE=PORTE|0b00000100
//#define TX_master_off PORTE=PORTE&0b11111011
//#define TX_slave_on   PORTD.4=1;
//#define TX_slave_off  PORTD.4=0;

//#define TX_slave_on   PORTD.5=1;
//#define TX_slave_off  PORTD.5=0;

// #define led_20_on  PORTF=PORTF|0b00001000
// #define led_20_off PORTF=PORTF&0b11110111
// 
// #define led_19_on  PORTF=PORTF|0b00000100
// #define led_19_off PORTF=PORTF&0b11111011
// 
// #define led_18_on  PORTF=PORTF|0b00000010
// #define led_18_off PORTF=PORTF&0b11111101
// 
// #define led_17_on  PORTF=PORTF|0b00000001
// #define led_17_off PORTF=PORTF&0b11111110
// 
// #define led_16_on  PORTC.7=1
// #define led_16_off PORTC.7=0
// 
// #define led_15_on  PORTC.6=1
// #define led_15_off PORTC.6=0
// 
// #define led_14_on  PORTC.5=1
// #define led_14_off PORTC.5=0
// 
// #define led_13_on  PORTC.4=1
// #define led_13_off PORTC.4=0
// 
// #define led_12_on  PORTC.3=1
// #define led_12_off PORTC.3=0
// 
// #define led_11_on  PORTC.2=1
// #define led_11_off PORTC.2=0
// 
// 
// 
// #define led_10_on  PORTC.1=1
// #define led_10_off PORTC.1=0
// 
// #define led_09_on  PORTC.0=1
// #define led_09_off PORTC.0=0
// 
// #define led_08_on  PORTA.7=1
// #define led_08_off PORTA.7=0
// 
// #define led_07_on  PORTA.6=1
// #define led_07_off PORTA.6=0
// 
// #define led_06_on  PORTA.5=1
// #define led_06_off PORTA.5=0
// 
// #define led_05_on  PORTA.4=1
// #define led_05_off PORTA.4=0
// 
// #define led_04_on  PORTA.3=1
// #define led_04_off PORTA.3=0
// 
// #define led_03_on  PORTA.2=1
// #define led_03_off PORTA.2=0
// 
// #define led_02_on  PORTA.1=1
// #define led_02_off PORTA.1=0
// 
// #define led_01_on  PORTA.0=1
// #define led_01_off PORTA.0=0
// 
// #define led_red_on  PORTB.3=1
// #define led_red_off PORTB.3=0
// 
// #define led_green_on  PORTB.2=1
// #define led_green_off PORTB.2=0
// 
// #define key PIND.7
#define led_20_on  PORTC.1=1
#define led_20_off PORTC.1=0

#define led_19_on  PORTC.2=1
#define led_19_off PORTC.2=0

#define led_18_on  PORTC.3=1
#define led_18_off PORTC.3=0

#define led_17_on  PORTC.4=1
#define led_17_off PORTC.4=0

#define led_16_on  PORTC.7=1
#define led_16_off PORTC.7=0

#define led_15_on  PORTC.6=1
#define led_15_off PORTC.6=0

#define led_14_on  PORTA.7=1
#define led_14_off PORTA.7=0

#define led_13_on  PORTA.6=1
#define led_13_off PORTA.6=0

#define led_12_on  PORTA.5=1
#define led_12_off PORTA.5=0

#define led_11_on  PORTA.4=1
#define led_11_off PORTA.4=0

#define led_10_on  PORTA.3=1
#define led_10_off PORTA.3=0

#define led_09_on  PORTA.1=1
#define led_09_off PORTA.1=0

#define led_08_on  PORTA.0=1
#define led_08_off PORTA.0=0


#define led_07_on  PORTF=PORTF|0b10000000
#define led_07_off PORTF=PORTF&0b01111111

#define led_06_on  PORTF=PORTF|0b00100000
#define led_06_off PORTF=PORTF&0b11011111

#define led_05_on  PORTF=PORTF|0b00001000
#define led_05_off PORTF=PORTF&0b11110111

#define led_04_on  PORTF=PORTF|0b00000010
#define led_04_off PORTF=PORTF&0b11111101

#define led_03_on  PORTF=PORTF|0b01000000
#define led_03_off PORTF=PORTF&0b10111111

#define led_02_on  PORTF=PORTF|0b00000001
#define led_02_off PORTF=PORTF&0b11111110

#define led_01_on  PORTF=PORTF|0b00000100
#define led_01_off PORTF=PORTF&0b11111011

#define led_green_on  PORTA.2=1
#define led_green_off PORTA.2=0

#define led_red_on  PORTF=PORTF|0b00010000
#define led_red_off PORTF=PORTF&0b11101111

#define key PINC.5

// //--------------------------------------//
// USART1 Receiver interrupt service routine
//--------------------------------------//
#define RX_BUFFER_SIZE 24
char rx_buffer_master[RX_BUFFER_SIZE];
unsigned char rx_wr_index_master,rx_counter_master,mod_time_master;
bit tx_en_master,rx_m_master,rx_c_master;
interrupt [USART1_RXC] void usart0_rx_isr(void)
	{
	char st,d;
	st=UCSR1A;d=UDR1;
	if ((/*(st&(FRAMING_ERROR|PARITY_ERROR|DATA_OVERRUN))==0)&&(*/(tx_en_master==0)&&(rx_c_master==0)))
		{
		if (mod_time_master==0){rx_m_master=1;rx_wr_index_master=0;}
//		mod_time_master=12;
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
interrupt [USART0_RXC] void usart1_rx_isr(void)
	{
	char st,d;
	st=UCSR0A;d=UDR0;
	if ((/*(st&(FRAMING_ERROR|PARITY_ERROR|DATA_OVERRUN))==0)&&(*/(tx_en_slave==0)&&(rx_c_slave==0)))
		{
		if (mod_time_slave==0){rx_m_slave=1;rx_wr_index_slave=0;}
		mod_time_slave=12;
//		mod_time_master=200;
		rx_buffer_slave[rx_wr_index_slave]=d;
		if (++rx_wr_index_slave >=RX_BUFFER_SIZE) rx_wr_index_slave=0;
		if (++rx_counter_slave >= RX_BUFFER_SIZE) rx_counter_slave=0;
		}
	}
//--------------------------------------//
// USART1 Transmitter interrupt service routine
//--------------------------------------//
#define TX_BUFFER_SIZE 64
char tx_buffer_master[TX_BUFFER_SIZE];
unsigned char tx_buffer_begin_master,tx_buffer_end_master;
interrupt [USART1_TXC] void usart0_tx_isr(void)
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
interrupt [USART0_TXC] void usart1_tx_isr(void)
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
	if (mod_time_slave==0){if(rx_m_slave==1) rx_c_slave=1;}
	else 	mod_time_slave--;
	if (mod_time_master==0){if(rx_m_master==1) rx_c_master=1;}
	else 	mod_time_master--;
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
//eeprom unsigned int reg_tun[17]={1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17};
eeprom float kv=100;
eeprom float kn=100;
//eeprom unsigned int kv=100;
//eeprom unsigned int kn=100;
#include <stdio.h>
//unsigned int find_reg(unsigned int a);
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

void response_m_err(char a);                     //
void response_m_aa4();                     //
void response_m_aa6();                     //
signed int rms;
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

void main(void)
{
// Declare your local variables here
float y;
//char n;

// DDRC=0b11011110;PORTC.5=1;
// DDRA=0b11111111;
// DDRF=0b11111111;
// while (1)
//         {
//         while(key==1);
//         led_01_on;delay_ms(100);
//         led_02_on;delay_ms(100);
//         led_03_on;delay_ms(100);
//         led_04_on;delay_ms(100);
//         led_05_on;delay_ms(100);
//         led_06_on;delay_ms(100);
//         led_07_on;delay_ms(100);
//         led_08_on;delay_ms(100);
//         led_09_on;delay_ms(100);
//         led_10_on;delay_ms(100);
//         led_11_on;delay_ms(100);
//         led_12_on;delay_ms(100);
//         led_13_on;delay_ms(100);
//         led_14_on;delay_ms(100);
//         led_15_on;delay_ms(100);
//         led_16_on;delay_ms(100);
//         led_17_on;delay_ms(100);
//         led_18_on;delay_ms(100);
//         led_19_on;delay_ms(100);
//         led_20_on;delay_ms(100);
// 
//         led_red_on;delay_ms(100);
//         led_green_on;delay_ms(100);
// 
// 
//         while(key==1);
//         led_01_off;delay_ms(100);
//         led_02_off;delay_ms(100);
//         led_03_off;delay_ms(100);
//         led_04_off;delay_ms(100);
//         led_05_off;delay_ms(100);
//         led_06_off;delay_ms(100);
//         led_07_off;delay_ms(100);
//         led_08_off;delay_ms(100);
//         led_09_off;delay_ms(100);
//         led_10_off;delay_ms(100);
//         led_11_off;delay_ms(100);
//         led_12_off;delay_ms(100);
//         led_13_off;delay_ms(100);
//         led_14_off;delay_ms(100);
//         led_15_off;delay_ms(100);
//         led_16_off;delay_ms(100);
//         led_17_off;delay_ms(100);
//         led_18_off;delay_ms(100);
//         led_19_off;delay_ms(100);
//         led_20_off;delay_ms(100);
// 
//         led_red_off;delay_ms(100);
//         led_green_off;delay_ms(100);
//         }





// rms=0;kn=100;kv=100;
// if (rms>0)
//         {
//         rms=10-rms*7/kn;
//         y=rms;
//         }
// else if (rms<0)
//         {
//         rms=10-rms*7/kv;
//         y=rms;
//         }
// else y=10;
// 
// rms=20;kn=100;kv=100;
// if (rms>0)
//         {
//         rms=10-rms*7/kn;
//         y=rms;
//         }
// else if (rms<0)
//         {
//         rms=10-rms*7/kv;
//         y=rms;
//         }
// else y=10;
// 
// rms=30;kn=100;kv=100;
// if (rms>0)
//         {
//         rms=10-rms*7/kn;
//         y=rms;
//         }
// else if (rms<0)
//         {
//         rms=10-rms*7/kv;
//         y=rms;
//         }
// else y=10;
// 
// rms=70;kn=100;kv=100;
// if (rms>0) y=10-((rms/kn)*7);
// else if (rms<0) y=10-((rms/kv)*7);
// else y=10;
// 
// 
// rms=100;kn=100;kv=100;
// if (rms>0) y=10-((rms/kn)*7);
// else if (rms<0) y=10-((rms/kv)*7);
// else y=10;
// 
// 
// rms=-100;kn=100;kv=100;
// if (rms>0) y=10-((rms/kn)*7);
// else if (rms<0) y=10-((rms/kv)*7);
// else y=10;
// 
// rms=-70;kn=100;kv=100;
// if (rms>0) y=10-((rms/kn)*7);
// else if (rms<0) y=10-((rms/kv)*7);
// else y=10;
// 
// rms=-20;kn=100;kv=100;
// if (rms>0) y=10-((rms/kn)*7);
// else if (rms<0) y=10-((rms/kv)*7);
// else y=10;

PORTA=0x00;DDRA=0xFF;
PORTB=0x00;DDRB=0x0C;
PORTC=0b00000010;DDRC=0b11111101;
PORTD=0x80;DDRD=0b00011000;
PORTE=0x00;DDRE=0x04;
PORTF=0x00;DDRF=0xFF;
PORTG=0x00;DDRG=0x00;

UCSR0A=0x00;UCSR0B=0xD8;UCSR0C=0x06;
UBRR0H=0x00;UBRR0L=0x33;

UCSR1A=0x00;UCSR1B=0xD8;UCSR1C=0x06;
UBRR1H=0x00;UBRR1L=0x33;
//UCSR1A=0x00;UCSR1B=0x00;UCSR1C=0x06;
//UBRR1H=0x00;UBRR1L=0x33;

ACSR=0x80;SFIOR=0x00;
ASSR=0x00;
TCCR0=0x02;
TCNT0=0x00;
OCR0=0x00;

TIMSK=0x01;
ETIMSK=0x00;

// Global enable interrupts





#asm("sei")
while (1)
        {
//         led_03_on;delay_ms(20);
//  	crc_slave=0xFFFF;
//         mov_buf_slave(0x01);
//         mov_buf_slave(0x04);
//         mov_buf_slave(0x00);
//         mov_buf_slave(0x86);
//         mov_buf_slave(0x00);
//         mov_buf_slave(0x01);
//         crc_end_slave();
//         led_03_off;
// 	crc_slave=0xFFFF;



//        led_01_on;delay_ms(20);
 	crc_master=0xFFFF;
        mov_buf_master(0x01);
        mov_buf_master(0x04);
        mov_buf_master(0x00);
        mov_buf_master(0x86);
        mov_buf_master(0x00);
        mov_buf_master(0x01);
        crc_end_master();
//        led_01_off;
	crc_master=0xFFFF;
	TCNT1=0x0000;			
        TCCR1B=0x03;//8000000/8==1us*65535=65ms
//        led_02_on;
        while ((TIFR&0b00000100)==0);
//        led_02_off;
        TCCR1B=0;                       //
        TIFR=TIFR;                //
        #asm("wdr");
        if (check_cr_master()==1)
                {
                rms=0;
                if(rx_counter_master==7)rms=((unsigned int)rx_buffer_master[3]<<8)+rx_buffer_master[4];
       	        rx_c_master=0;rx_m_master=0;
               	rx_wr_index_master=0;rx_counter_master=0;
                }
        if (rms>0)// скз по частотам в %
                {
                rms=10-(rms*7/kn);
                if (rms<1)rms=1;
                y=rms;
                }
        else if (rms<0)
                {
                rms=10-(rms*7/kv);
                if (rms>20)rms=20;
                y=rms;
                }
        else {y=10;rms=10;}

//        if (rms>100) rms=100;
//        if (rms<-100) rms=-100;
        led_green_on;
            
        led(y);
        delay_ms(300);
        led_03_off;led_02_off;led_01_off;
        led_20_off;led_19_off;led_18_off;


        if((key==0)&&(press==0))
                {
                press=1;
                drebezg=0;
                if((first_press==0)&&(second_press==0))
                        {
                        led_red_on;
                        first_press=1;
                	crc_master=0xFFFF;
                        mov_buf_master(0x01);
                        mov_buf_master(0x06);
                        mov_buf_master(0x00);
                        mov_buf_master(0x81);
                        mov_buf_master(0x00);
                        mov_buf_master(0x01);
                        crc_end_master();
                	crc_master=0xFFFF;
                	TCNT1=0x0000;			
                        TCCR1B=0x03;//8000000/8==1us*65535=65ms
                        while ((TIFR&0b00000100)==0);
                        TCCR1B=0;                       //
                        TIFR=TIFR;                //
       	        rx_c_master=0;rx_m_master=0;
               	rx_wr_index_master=0;rx_counter_master=0;
                        }
                else if((first_press==1)&&(second_press==0))
                        {
                        led_red_off;
                        second_press=1;
                	crc_master=0xFFFF;
                        mov_buf_master(0x01);
                        mov_buf_master(0x06);
                        mov_buf_master(0x00);
                        mov_buf_master(0x82);
                        mov_buf_master(0x00);
                        mov_buf_master(0x01);
                        crc_end_master();
                	crc_master=0xFFFF;
                	TCNT1=0x0000;			
                        TCCR1B=0x03;//8000000/8==1us*65535=65ms
                        while ((TIFR&0b00000100)==0);
                        TCCR1B=0;                       //
                        TIFR=TIFR;                //
       	        rx_c_master=0;rx_m_master=0;
               	rx_wr_index_master=0;rx_counter_master=0;
                        }
                }
        if(key==1)if(++drebezg>1){press=0;drebezg=0;
                        if ((first_press==1)&&(second_press==1)){first_press=0;second_press=0;}}
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
       	        rx_c_master=0;rx_m_master=0;
               	rx_wr_index_master=0;rx_counter_master=0;
       	        rx_c_slave=0;rx_m_slave=0;
               	rx_wr_index_slave=0;rx_counter_slave=0;
                }
        }
}
//------проверка контрольной суммы master-------//
char check_cr_master()                          //
        {                                       //
        char error;                             //
	error=1;                                //
	crc_master=0xFFFF;i=0;                  //
	while (i<(rx_wr_index_master-1)){crc_rtu_master(rx_buffer_master[i]);i++;}
	if ((rx_buffer_master[rx_wr_index_master])!=(crc_master>>8)) error=0;
	if ((rx_buffer_master[rx_wr_index_master-1])!=(crc_master&0x00FF)) error=0;
	return error;                           //
        }                                       //
//------проверка контрольной суммы slave--------//
char check_cr_slave()                           //
        {                                       //
        char error;                             //
	error=1;                                //
	crc_slave=0xFFFF;i=0;                   //
	while (i<(rx_wr_index_slave-1)){crc_rtu_slave(rx_buffer_slave[i]);i++;}
	if ((rx_buffer_slave[rx_wr_index_slave])!=(crc_slave>>8)) error=0;
	if ((rx_buffer_slave[rx_wr_index_slave-1])!=(crc_slave&0x00FF)) error=0;
	return error;                           //
        }                                       //
//------расчет контрольной суммы master---------//
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
//------расчет контрольной суммы slave----------//
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
//------байт в буффер передатчика master--------//
void mov_buf_master(char a){crc_rtu_master(a);mov_buf0(a);}//
void mov_buf0(char a)			        //
	{				        //
	#asm("cli");    		        //
	tx_buffer_counter_master++;	        //
	tx_buffer_master[tx_buffer_end_master]=a;//
	if (++tx_buffer_end_master==TX_BUFFER_SIZE) tx_buffer_end_master=0;//
	#asm("sei");			        //
	}				        //
//------байт в буффер передатчика slave---------//
void mov_buf_slave(char a){crc_rtu_slave(a);mov_buf1(a);}//
void mov_buf1(char a)			        //
	{				        //
	#asm("cli");    		        //
	tx_buffer_counter_slave++;	        //
	tx_buffer_slave[tx_buffer_end_slave]=a; //
	if (++tx_buffer_end_slave==TX_BUFFER_SIZE) tx_buffer_end_slave=0;//
	#asm("sei");			        //
	}				        //
//------посылка контрольной суммы---------------//
//------начало передачи по master---------------//
void crc_end_master()				//
	{				        //
	mov_buf0(crc_master);mov_buf0(crc_master>>8);//
	TX_master_on;                              //
       	UDR0=tx_buffer_master[tx_buffer_begin_master];//
	tx_en_master=1;crc_master=0xffff;       //
	}				        //
//------посылка контрольной суммы---------------//
//------начало передачи по slave----------------//
void crc_end_slave()				//
	{				        //
	mov_buf1(crc_slave);mov_buf1(crc_slave>>8);//
	TX_slave_on;                            //
       	UDR1=tx_buffer_slave[tx_buffer_begin_slave];//
	tx_en_slave=1;crc_slave=0xffff;	        //
	}				        //
//------ответ ошибка----------------------------//
void response_m_err(char a)                     //
        {                                       //
	mov_buf_slave(rx_buffer_slave[0]);      //
	mov_buf_slave(rx_buffer_slave[1]|128);  //
	mov_buf_slave(a);                       //
        crc_end_slave();                        //
        }                                       //
//----------------------------------------------//
//unsigned int find_reg(unsigned int a)
//        {
//        unsigned int d;
//        if      ((a>=0x00)&&(a<=0x20))  d=reg[a];
//        else if (a==0x86)                d=rms;
//        else                             d=0;
//        return d;
//        }
unsigned char save_reg(unsigned int d,unsigned int a)
        {
        if      (a==0x01)               kn=d;
        else if (a==0x02)               kv=d;
        else                            return 0;
        return 1;
        }

void response_m_aa4()
        {
//        unsigned int a;
//  	mov_buf_slave(rx_buffer_slave[0]);
//  	mov_buf_slave(rx_buffer_slave[1]); 
//  	mov_buf_slave(rx_buffer_slave[5]*2);
//         i=rx_buffer_slave[5];                         //
//         a=rx_buffer_slave[2];
//         a=(a<<8)+rx_buffer_slave[3];         //
//         while (i>0)
//                 {
// 		mov_buf_slave(find_reg(a)>>8);
// 		mov_buf_slave(find_reg(a));
// 		a++;i--;                        //
// 		}                               //
//         crc_end_slave(); 
       	crc_master=0xFFFF;
       	for (i=0;i<rx_counter_slave-2;i++)
       	        {
                mov_buf_master(rx_buffer_slave[i]);
                }
        crc_end_master();
        crc_master=0xFFFF;
        TCNT1=0x0000;			
        TCCR1B=0x03;//8000000/8==1us*65535=65ms
        while ((TIFR&0b00000100)==0);
        TCCR1B=0;                       //
        TIFR=TIFR;                //
       	crc_slave=0xFFFF;
       	for (i=0;i<rx_counter_master-2;i++)
       	        {
                mov_buf_slave(rx_buffer_master[i]);
                }
        crc_end_slave();
        }

void response_m_aa6()
        {
        unsigned int d,a,i;
        a=rx_buffer_slave[2];
        a=(a<<8)+rx_buffer_slave[3];
        d=rx_buffer_slave[4];
        d=(d<<8)+rx_buffer_slave[5];
	if (save_reg(d,a)==1){for (i=0;i<6;i++)mov_buf_slave(rx_buffer_slave[i]);crc_end_slave();}
	else 
	        {
               	crc_master=0xFFFF;
               	for (i=0;i<rx_counter_slave-2;i++)
               	        {
                        mov_buf_master(rx_buffer_slave[i]);
                        }
                crc_end_master();
                crc_master=0xFFFF;
                TCNT1=0x0000;			
                TCCR1B=0x03;//8000000/8==1us*65535=65ms
                while ((TIFR&0b00000100)==0);
                TCCR1B=0;                       //
                TIFR=TIFR;                //
               	crc_slave=0xFFFF;
               	for (i=0;i<rx_counter_master-2;i++)
               	        {
                        mov_buf_slave(rx_buffer_master[i]);
                        }
                crc_end_slave();
	        }
//	else response_m_err(2);                     //
        }
