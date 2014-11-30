/*****************************************************
CodeWizardAVR V1.24.5 Standard

Project : 10ч/д
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
#include <stdio.h>

#define uart_slave_disable UCSR0B=0x00
#define transmitter_off UCSR0B=0x90
#define transmitter_on UCSR0B=0xD8
#define TX_slave_on  PORTE=PORTE|0b00000100
#define TX_slave_off PORTE=PORTE&0b11111011
#define TX_master_on   PORTD.4=1;
#define TX_master_off  PORTD.4=0;
#define testing_blink_on PORTC.0=1
#define testing_blink_off PORTC.0=0
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
#define led_calibration_on  PORTA.2=1
#define led_calibration_off PORTA.2=0
#define led_warning_on  PORTF=PORTF|0b00010000
#define led_warning_off PORTF=PORTF&0b11101111
#define key PINC.5  
#define eeAddressSKZ1H 0x0400
#define eeAddressSKZ1L 0x0401
#define eeAddressSKZ2H 0x0402
#define eeAddressSKZ2L 0x0403
#define eeAddressSKZ1toSKZ2 0x0404
#define eeAdrSKZ1ar 0x0405
#define eeAdrSKZ2ar 0x042C
#define eeAddrCalibrFlag 0x04ff
#define eeAddressModBusAddr 0x0600
#define eeAddressAverTimeV 0x0601
#define eeAddressFreqQ 0x0602
#define eeAddressMINSKZH 0x0603
#define eeAddressMINSKZL 0x0604
#define eeAddressFirstFreq 0x0605
#define eeAddressMINOPLH 0x0606
#define eeAddressMINOPLL 0x0607
#define AvTimer_on {TCCR3A=0x00;TCCR3B=0x04;TCNT3H=0x81;TCNT3L=0x0B;ETIMSK=0x04;}
#define AvTimer_off {TCCR3A=0x00;TCCR3B=0x00;TCNT3H=0x00;TCNT3L=0x00;ETIMSK=0x00;}
#define ClearBuf_slave {rx_buffer_slave[0]=0;rx_buffer_slave[1]=0;rx_buffer_slave[2]=0;rx_buffer_slave[3]=0;rx_buffer_slave[4]=0;rx_buffer_slave[5]=0;rx_buffer_slave[6]=0;rx_buffer_slave[7]=0;rx_buffer_slave[8]=0;rx_buffer_slave[9]=0;rx_buffer_slave[10]=0;}
#define ClearBuf_master{rx_buffer_master[0]=0;rx_buffer_master[1]=0;rx_buffer_master[2]=0;rx_buffer_master[3]=0;rx_buffer_master[4]=0;rx_buffer_master[5]=0;rx_buffer_master[6]=0;rx_buffer_master[7]=0;rx_buffer_master[8]=0;rx_buffer_master[9]=0;}
#define send_save_frq  {crc_master=0xFFFF;mov_buf_master(0x01);mov_buf_master(0x04);mov_buf_master(0x00);mov_buf_master(0x80);mov_buf_master(0x00);mov_buf_master(0x01);crc_end_master();}
//#define send_test  {crc_master=0xFFFF;mov_buf_master(0x01);mov_buf_master(0x0C);mov_buf_master(0x01);mov_buf_master(0x02);mov_buf_master(0x03);mov_buf_master(0x04);crc_end_master();}
#define send_read_valskz  {crc_master=0xFFFF;mov_buf_master(0x01);mov_buf_master(0x04);mov_buf_master(0x00);mov_buf_master(0x85);mov_buf_master(0x00);mov_buf_master(0x01);crc_end_master();}
#define send_read_skz  {crc_master=0xFFFF;mov_buf_master(0x01);mov_buf_master(0x04);mov_buf_master(0x00);mov_buf_master(0x86);mov_buf_master(0x00);mov_buf_master(0x01);crc_end_master();}
#define send_read_object_state  {crc_master=0xFFFF;mov_buf_master(0x01);mov_buf_master(0x04);mov_buf_master(0x00);mov_buf_master(0x88);mov_buf_master(0x00);mov_buf_master(0x01);crc_end_master();}
#define send_read_skzrel  {crc_master=0xFFFF;mov_buf_master(0x01);mov_buf_master(0x04);mov_buf_master(0x00);mov_buf_master(0x87);mov_buf_master(0x00);mov_buf_master(0x01);crc_end_master();}
#define send_save_skz1 {crc_master=0xFFFF;mov_buf_master(0x01);mov_buf_master(0x06);mov_buf_master(0x00);mov_buf_master(0x81);mov_buf_master(0x00);mov_buf_master(0x01);crc_end_master();}
#define send_save_skz2 {crc_master=0xFFFF;mov_buf_master(0x01);mov_buf_master(0x06);mov_buf_master(0x00);mov_buf_master(0x82);mov_buf_master(0x00);mov_buf_master(0x01);crc_end_master();}
#define send_read_skz1 {crc_master=0xFFFF;mov_buf_master(0x01);mov_buf_master(0x04);mov_buf_master(0x00);mov_buf_master(0x83);mov_buf_master(0x00);mov_buf_master(0x01);crc_end_master();}
#define send_read_skz2 {crc_master=0xFFFF;mov_buf_master(0x01);mov_buf_master(0x04);mov_buf_master(0x00);mov_buf_master(0x84);mov_buf_master(0x00);mov_buf_master(0x01);crc_end_master();}
//#define send_read_skz1  {crc_slave=0xFFFF;mov_buf_slave(0x01);mov_buf_slave(0x04);mov_buf_slave(0x00);mov_buf_slave(0x86);mov_buf_slave(0x00);mov_buf_slave(0x01);crc_end_slave();}
#define whait_read {/*delay_ms(65);*/TCNT1=0x0000;TCCR1B=0x03;/*8000000/8==1us*65535=65ms*/while ((TIFR&0b00000100)==0);TCCR1B=0;TIFR=TIFR;/*#asm("wdr");*/}
#define BPS_link_failed {led_20_on;led_19_on;led_18_on;}
#define Object_disabled {led_20_on;led_19_on;led_18_on;}
#define BPS_link_ok{led_20_off;led_19_off;led_18_off;}
#define Object_enabled {led_20_off;led_19_off;led_18_off;}
#define Led_Intro1_on {led_10_on;led_09_on;led_08_on;led_07_on;led_06_on;led_05_on;led_04_on;led_03_on;led_02_on;led_01_on;}
#define Led_Intro2_on {led_warning_on;led_calibration_on;led_20_on;led_19_on;led_18_on;led_17_on;led_16_on;led_15_on;led_14_on;led_13_on;led_12_on;led_11_on;led_10_off;led_09_off;led_08_off;led_07_off;led_06_off;led_05_off;led_04_off;led_03_off;led_02_off;led_01_off;}
#define Led_Intro2_off {led_warning_off;led_calibration_off;led_20_off;led_19_off;led_18_off;led_17_off;led_16_off;led_15_off;led_14_off;led_13_off;led_12_off;led_11_off;led_10_off;led_09_off;led_08_off;led_07_off;led_06_off;led_05_off;led_04_off;led_03_off;led_02_off;led_01_off;}          

//#define DeviceID1 0x9191
//#define DevID 0x9191

// //--------------------------------------//
// USART1 Receiver interrupt service routine
//--------------------------------------//
#define RX_BUFFER_SIZE 128
#define TX_BUFFER_SIZE 128
//flash unsigned char APP_READY                                  @0xEFF0;
signed int LedQ=0,rms=0;
unsigned int SKZ_1,SKZ_2,SKZ1toSKZ2,SKZ_read,intro_cntr=0,intro_enabled=1,true_skz=0;
int terminal_mode=0,BPS_absent=0,PC_absent=0,w=0,rms_read=0,bps_absent_ctr=0;
void mov_buf_slave(char a);
void crc_end_slave();	
void send_test();	
void eeprom_reset();
void EEPROM_write(unsigned int eeAddress, unsigned char eeData);
char rx_buffer_master[RX_BUFFER_SIZE],rd_counts=0, CalibrFlag=0, r=0,object_state=1,SPI_tEnd=1;
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
unsigned int /*ModBusAddress=1,*/BlinkCounter_Calibration=0,tok;
int warning_flag=0, FrequencyQ=3, ModbusMessage=0;
int blink_flag=0,red=0,calibration_correct=1;
int warning_flag_=0;
float ii;
unsigned long adc_buf;
bit press,first_press,second_press,AverTime_Flag=0, SendSKZsave_req=0;
unsigned int reg[40];
signed long SKZread_counter=0;
 static int DeviceID=0x3491;// ID устройства, адрес 0х96, возможно только чтение, хранится версия, тип прошивки, тип устройства 0b(A)(xx1)-тип(xxx1)-версия A=1=application
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
char rx_buffer_slave[RX_BUFFER_SIZE], RData;
unsigned char rx_wr_index_slave,rx_counter_slave,mod_time_slave;
bit tx_en_slave,rx_m_slave,rx_c_slave;
char tx_buffer_slave[TX_BUFFER_SIZE];
unsigned char tx_buffer_begin_slave,tx_buffer_end_slave;
interrupt [USART0_RXC] void usart0_rx_isr(void)
	{
        char st,d;
        int ii = 0;

        //int w=0;
     #asm ("cli")
	st=UCSR0A;d=UDR0;//TX_slave_off;
     #asm ("sei")
    if(rx_counter_slave==0)rd_counts=0;
	 transmitter_off;

	if (tx_en_slave==0)//&&(rx_c_slave==0))   //rx_c_slave- конец модбас сообщения
		{
		if (mod_time_slave==0){rx_m_slave=1;rx_wr_index_slave=0;rd_counts=0;} //rx_m_slave = идет процесс приема сообщения модбас ; вообще же здесь мы определяем, начало ли это сообщения 
		mod_time_slave=14;
        rd_counts++;
		rx_buffer_slave[rx_wr_index_slave]=d;

                if (++rx_wr_index_slave >=RX_BUFFER_SIZE) rx_wr_index_slave=0;
                if (++rx_counter_slave >= RX_BUFFER_SIZE) rx_counter_slave=0;
		}
                
BKI_state_sent=0; new_message=1;RData=d;
reg91_answer=(object_state|((!BPS_absent)<<5)|(red<<4)|((ProcessingEEPROM)<<3)|((red|ProcessingEEPROM)<<2)|((warning_flag&(!blink_flag)<<1))|(warning_flag&(!blink_flag)|blink_flag)); 
if(rd_counts==8){
if(rx_buffer_slave[rx_wr_index_slave-8]==ModBusAddress&(rx_buffer_slave[rx_wr_index_slave-7]==0x06|rx_buffer_slave[rx_wr_index_slave-7]==0x03)){rx_counter_slave=0;
if(rx_buffer_slave[rx_wr_index_slave-7]==0x06&rx_buffer_slave[rx_wr_index_slave-6]==0x00)
{
    if(rx_buffer_slave[rx_wr_index_slave-5]==0x91){start_calibration=(rx_buffer_slave[rx_wr_index_slave-3]&0x10)>>4;}
    if(rx_buffer_slave[rx_wr_index_slave-5]==0x92){AverTime_Value=rx_buffer_slave[rx_wr_index_slave-4]*30;if(AverTime_Value==0)AverTime_Value=2;FrequencyQ=rx_buffer_slave[rx_wr_index_slave-3];AverTime_Flag=1;AvTimer=0;AvTimer_on;SKZread_counter=0;ModbusMessage=62;}
    if(rx_buffer_slave[rx_wr_index_slave-5]==0x93){ModBusAddress=rx_buffer_slave[rx_wr_index_slave-3];ModbusMessage=63;}
    if(rx_buffer_slave[rx_wr_index_slave-5]==0x94){minimal_SKZ_val=(((unsigned int)rx_buffer_slave[rx_wr_index_slave-4])<<8)|(unsigned int)rx_buffer_slave[rx_wr_index_slave-3];ModbusMessage=64;}
    if(rx_buffer_slave[rx_wr_index_slave-5]==0x95){minimal_object_enabled_level=0;minimal_object_enabled_level=(int)((((int)rx_buffer_slave[rx_wr_index_slave-4])<<8)|(int)rx_buffer_slave[rx_wr_index_slave-3]);ModbusMessage=65;}//transmitter_on;TX_slave_on;printf("minimal_object_enabled_level=%d\r\n",minimal_object_enabled_level);TX_slave_off;transmitter_off;}
    if(rx_buffer_slave[rx_wr_index_slave-5]==0xAC)
    {
    flash_erase_flag = 1;
    //for(ii=0x0400;ii<0x0600;ii++)EEPROM_write(ii,0xff); 
    }
    CRCHigh=0xff;
    CRCLow=0xff;
    for (r=0;r<6;r++)
        {
        //#asm("cli");  
        CRC_update(rx_buffer_slave[r]);
        //tx_buffer_counter_slave++;	        //
        tx_buffer_slave[tx_buffer_end_slave]=rx_buffer_slave[r]; //
        if (++tx_buffer_end_slave==TX_BUFFER_SIZE) tx_buffer_end_slave=0;//
        //#asm("sei"); 
        }
    crc_slave=((unsigned int)CRCLow<<8)|CRCHigh;
         //   tx_buffer_counter_slave++;	  
        // #asm("cli");           //
        tx_buffer_slave[tx_buffer_end_slave]=crc_slave; //
        if (++tx_buffer_end_slave==TX_BUFFER_SIZE) tx_buffer_end_slave=0;
        //    tx_buffer_counter_slave++;	        //
        tx_buffer_slave[tx_buffer_end_slave]=(crc_slave>>8); //
        if (++tx_buffer_end_slave==TX_BUFFER_SIZE) tx_buffer_end_slave=0;
        TX_slave_on;                            //
        tx_en_slave=1;crc_slave=0xffff;transmitter_on;
        #asm("cli"); 
            UDR0=tx_buffer_slave[tx_buffer_begin_slave];
        #asm("sei");     
    //rx_c_slave=0;rx_m_slave=0;rx_wr_index_slave=0;rx_counter_slave=0;
}
if(rx_buffer_slave[rx_wr_index_slave-7]==0x03&rx_buffer_slave[rx_wr_index_slave-6]==0x00&rx_buffer_slave[rx_wr_index_slave-4]==0x00&rx_buffer_slave[rx_wr_index_slave-3]==0x01){
if(rx_buffer_slave[rx_wr_index_slave-5]==0x90){rx_buffer_slave[rx_wr_index_slave-6]=0x02;rx_buffer_slave[rx_wr_index_slave-5]=AverSKZprcnt;rx_buffer_slave[rx_wr_index_slave-4]=LedQ;}
if(rx_buffer_slave[rx_wr_index_slave-5]==0x91){rx_buffer_slave[rx_wr_index_slave-6]=0x02;rx_buffer_slave[rx_wr_index_slave-5]=blink_flag|((!warning_flag)<<1)|(!warning_flag);rx_buffer_slave[rx_wr_index_slave-4]=reg91_answer;BKI_state_sent=1;}
if(rx_buffer_slave[rx_wr_index_slave-5]==0x92){rx_buffer_slave[rx_wr_index_slave-6]=0x02;rx_buffer_slave[rx_wr_index_slave-5]=AverTime_Value/30;rx_buffer_slave[rx_wr_index_slave-4]=FrequencyQ;}
if(rx_buffer_slave[rx_wr_index_slave-5]==0x93){rx_buffer_slave[rx_wr_index_slave-6]=0x02;rx_buffer_slave[rx_wr_index_slave-5]=0;rx_buffer_slave[rx_wr_index_slave-4]=ModBusAddress;}
if(rx_buffer_slave[rx_wr_index_slave-5]==0x94){rx_buffer_slave[rx_wr_index_slave-6]=0x02;rx_buffer_slave[rx_wr_index_slave-5]=minimal_SKZ_val>>8;rx_buffer_slave[rx_wr_index_slave-4]=minimal_SKZ_val;}
if(rx_buffer_slave[rx_wr_index_slave-5]==0x95){rx_buffer_slave[rx_wr_index_slave-6]=0x02;rx_buffer_slave[rx_wr_index_slave-5]=minimal_object_enabled_level>>8;rx_buffer_slave[rx_wr_index_slave-4]=minimal_object_enabled_level;}
if(rx_buffer_slave[rx_wr_index_slave-5]==0x96){rx_buffer_slave[rx_wr_index_slave-6]=0x02;rx_buffer_slave[rx_wr_index_slave-5]=0x00;rx_buffer_slave[rx_wr_index_slave-4]=DeviceID;}
if(rx_buffer_slave[rx_wr_index_slave-5]==0x97){rx_buffer_slave[rx_wr_index_slave-6]=0x02;rx_buffer_slave[rx_wr_index_slave-5]=AverSKZ_Value>>8;rx_buffer_slave[rx_wr_index_slave-4]=AverSKZ_Value;}   //среднее значение СКЗ
if(rx_buffer_slave[rx_wr_index_slave-5]==0x98){rx_buffer_slave[rx_wr_index_slave-6]=0x02;rx_buffer_slave[rx_wr_index_slave-5]=true_skz>>8;rx_buffer_slave[rx_wr_index_slave-4]=true_skz;}             //текущее "реальное" значение СКЗ
if(rx_buffer_slave[rx_wr_index_slave-5]==0x99){rx_buffer_slave[rx_wr_index_slave-6]=0x02;rx_buffer_slave[rx_wr_index_slave-5]=SKZ_1>>8;rx_buffer_slave[rx_wr_index_slave-4]=SKZ_1;}                   //СКЗ1 
if(rx_buffer_slave[rx_wr_index_slave-5]==0x9a){rx_buffer_slave[rx_wr_index_slave-6]=0x02;rx_buffer_slave[rx_wr_index_slave-5]=SKZ_2>>8;rx_buffer_slave[rx_wr_index_slave-4]=SKZ_2;}                   //СКЗ2 - все 4 регистра нужны для отладки
CRCHigh=0xff;
CRCLow=0xff;
for (r=0;r<5;r++)
{
	//#asm("cli");    		        //
        CRC_update(rx_buffer_slave[r]);
//	tx_buffer_counter_slave++;	        //
	tx_buffer_slave[tx_buffer_end_slave]=rx_buffer_slave[r]; //
	if (++tx_buffer_end_slave==TX_BUFFER_SIZE) tx_buffer_end_slave=0;//
//	#asm("sei");
}

crc_slave=((unsigned int)CRCLow<<8)|CRCHigh;
   //     tx_buffer_counter_slave++;	
   //     #asm("cli");        //
	tx_buffer_slave[tx_buffer_end_slave]=crc_slave; //
	if (++tx_buffer_end_slave==TX_BUFFER_SIZE) tx_buffer_end_slave=0;
    //    tx_buffer_counter_slave++;	        //
	tx_buffer_slave[tx_buffer_end_slave]=(crc_slave>>8); //
	if (++tx_buffer_end_slave==TX_BUFFER_SIZE) tx_buffer_end_slave=0;
	TX_slave_on;                            //
    tx_en_slave=1;crc_slave=0xffff;transmitter_on;
    #asm("cli");     
    UDR0=tx_buffer_slave[tx_buffer_begin_slave];
    #asm("sei"); 
//rx_c_slave=0;rx_m_slave=0;rx_wr_index_slave=0;rx_counter_slave=0;
}//w=w+8;//TX_slave_on; 

}//rx_c_slave=0;rx_m_slave=0;rx_wr_index_slave=0;rx_counter_slave=0;
}
 if(rx_c_slave==1&mod_time_slave==0){rx_c_slave=0;rx_m_slave=0;rx_wr_index_slave=0;rx_counter_slave=0;//rd_counts=0;
 }      
	}
//--------------------------------------//
// USART1 Transmitter interrupt service routine
//--------------------------------------//

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

interrupt [USART0_TXC] void usart0_tx_isr(void)
	{
     #asm("cli");
       //#asm ("cli")  
	if (tx_en_slave==1)
		{
		if (++tx_buffer_begin_slave>=TX_BUFFER_SIZE) tx_buffer_begin_slave=0;
		if (tx_buffer_begin_slave!=tx_buffer_end_slave) {UDR0=tx_buffer_slave[tx_buffer_begin_slave];}
		else {tx_en_slave=0;rx_m_slave=0;TX_slave_off;tx_buffer_begin_slave=0;tx_buffer_end_slave=0;uart_slave_disable;transmitter_off;}
       	}
        //new_message=0;  
          //  #asm ("sei") 
        #asm("sei");
	}
//--------------------------------------//
// Timer 0 overflow interrupt service routine
//--------------------------------------//
interrupt [TIM0_OVF] void timer0_ovf_isr(void)
        {
        #asm ("cli")
        TCNT0=0x07;//250us
	//#asm("wdr");
	if (mod_time_slave==0){if(rx_m_slave==1) rx_c_slave=1;}   else 	mod_time_slave--;
	if (mod_time_master==0){if(rx_m_master==1) rx_c_master=1;}else 	mod_time_master--;

    #asm ("sei")
        }
//--------------------------------------//     
// SPI interrupt service routine
interrupt [SPI_STC] void spi_isr(void)
{
//unsigned char data;
//data=SPDR;
// Place your code here
if(SPI_tEnd==0){
SPDR=tok;
SPI_tEnd=1;
delay_us(200);
PORTB.4=0;
PORTB.0=1;
}  
//delay_us(2);
else PORTB.0=1;
//else PORTB.0=1;  
}   
//-------------------------------------------
// модуль токового интерфейса
//-------------------------------------------
void current_out(unsigned int out)
        {
//        char i;
//        DDRB = DDRB|0b00110111;
//        PORTB=PORTB|0b00110111;
//        PORTB.0=0;//
//        out=out<<4;
//        for (i=0;i<12;i++)
//                {
//                if(out>=0x8000)PORTB.2=1;//
//                else PORTB.2=0;//
//                PORTB.1=0;PORTB.1=1;//
//                out<<=1;
//                }
//        PORTB.0=1;PORTB.4=0;PORTB.4=1;
           PORTB.4=0;
           delay_us(200);
           PORTB.4=1;PORTB.0=0;
           delay_us(200);
//        PORTB.2=1;
//        PORTB.0=0;
        if(SPI_tEnd==1)
            {SPI_tEnd=0;
            
             SPDR=out>>8;
            // PORTB.2=0;
            // PORTB.4=0;
            }
        }

        
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

void eeprom_reset()
{
    int i;
    for(i=0;i<0x1000;i++)
    {
    if(i==eeAddressModBusAddr)i++;
    EEPROM_write(i,0xff); 
    }
} 

//--------------------------------------//     


eeprom float kv=100;
eeprom float kn=100;

unsigned char save_reg(unsigned int d,unsigned int a);
char check_cr_master();
char check_cr_slave();
void crc_rtu_master(char a);			//
void crc_rtu_slave(char a);			//
void crc_end_master();			//
	//
void mov_buf_master(char a);
void mov_buf0(char a);			//
void mov_buf_slave(char a);
void mov_buf1(char a);			//
unsigned int valskz;
void response_m_err(char a);                     //
void response_m_aa4();                     //
void response_m_aa6();                     //


void led(unsigned char a)
        {
        switch (a)
                {
                case 0: {
          led_20_off;led_19_off;led_18_off;led_17_off;led_16_off;led_15_off;led_14_off;led_13_off;led_12_off;led_11_off;
          led_10_off;led_09_off;led_08_off;led_07_off;led_06_off;led_05_off;led_04_off;led_03_on;led_02_on;led_01_on;break;}
                case 1: {
          led_20_off;led_19_off;led_18_off;led_17_off;led_16_off;led_15_off;led_14_off;led_13_off;led_12_off;led_11_off;
          led_10_off;led_09_off;led_08_off;led_07_off;led_06_off;led_05_off;led_04_off;led_03_off;led_02_off;led_01_on;break;}
                case 2: {
          led_20_off;led_19_off;led_18_off;led_17_off;led_16_off;led_15_off;led_14_off;led_13_off;led_12_off;led_11_off;
          led_10_off;led_09_off;led_08_off;led_07_off;led_06_off;led_05_off;led_04_off;led_03_off;led_02_on;led_01_on;break;}
                case 3: {
          led_20_off;led_19_off;led_18_off;led_17_off;led_16_off;led_15_off;led_14_off;led_13_off;led_12_off;led_11_off;
          led_10_off;led_09_off;led_08_off;led_07_off;led_06_off;led_05_off;led_04_off;led_03_on;led_02_on;led_01_on;break;}
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
                case 30: {
          led_20_off;led_19_off;led_18_off;led_17_off;led_16_off;led_15_off;led_14_off;led_13_off;led_12_off;led_11_off;
          led_10_off;led_09_off;led_08_off;led_07_off;led_06_off;led_05_off;led_04_off;led_03_off;led_02_off;led_01_off;break;}
                default: {
          led_20_on;led_19_on;led_18_on;led_17_on;led_16_on;led_15_on;led_14_on;led_13_on;led_12_on;led_11_on;
          led_10_on;led_09_on;led_08_on;led_07_on;led_06_on;led_05_on;led_04_on;led_03_off;led_02_off;led_01_off;break;}
              }
        }
        
        
interrupt [TIM3_OVF] void timer3_ovf_isr(void)
{
// Reinitialize Timer 3 value
//if(AvTimer%2==0)testing_blink_on;
//else testing_blink_off;
//#asm(" cli")
AvTimer_on;   
          // включаем таймер
// Place your code here
//SendSKZsave_req=1;   //этот флаг показывает, что нужно обратиться к БПС и сохранить значение СКЗ (в процентах)
AvTimer++;                    //наращиваем значение таймера
//#asm(" sei")
}
        
interrupt [TIM2_OVF] void timer2_ovf_isr(void)
{
TCCR2=0x05;
TCNT2=0x00;
OCR2=0x00;
TIMSK=TIMSK|0x40;

BlinkCounter_Calibration++;
if(BlinkCounter_Calibration==17){BlinkCounter_Calibration=0;}  
led_warning_on&warning_flag; 
if((BlinkCounter_Calibration>=9)&&(warning_flag==1)&&(blink_flag==1))led_warning_on;
if((BlinkCounter_Calibration>=9)&&(red==1))led_calibration_on;
if((BlinkCounter_Calibration<9)&&(red==1))led_calibration_off;
if((BlinkCounter_Calibration<9)&&(warning_flag==1)&&(blink_flag==1))led_warning_off;

//#asm("wdr");                                        

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
/*
void blink_display(int value) //отображение информации о содержимом буфера мастера 
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
        } */

//-------------------------------------------        
void send_skz()
{crc_master=0xFFFF;
mov_buf_master(0x01);
mov_buf_master(0x0c);
mov_buf_master(EEPROM_read(eeAddressSKZ1H));     //функция отправляет сохраненные в еепром значения точек СКЗ1 и СКЗ2
mov_buf_master(EEPROM_read(eeAddressSKZ1L));     //это псевдо модбас функция
mov_buf_master(EEPROM_read(eeAddressSKZ2H));
mov_buf_master(EEPROM_read(eeAddressSKZ2L));
crc_end_master();}      

/*void req_recieve_skz_array()
{unsigned int m;
crc_master=0xFFFF;
mov_buf_master(0x01);
for(m=2;m<79;m++)mov_buf_master(0xcc); 
crc_end_master();}   */

//void blink_intro()
//{
//led_20_on;led_19_on;led_18_on;led_17_on;led_16_on;led_15_on;led_14_on;led_13_on;led_12_on;led_11_on;led_10_on;led_09_on;led_08_on;led_07_on;led_06_on;led_05_on;led_04_on;led_03_on;led_02_on;led_01_on;
//led_20_off;led_19_off;led_18_off;led_17_off;led_16_off;led_15_off;led_14_off;led_13_off;led_12_off;led_11_off;led_10_off;led_09_off;led_08_off;led_07_off;led_06_off;led_05_off;led_04_off;led_03_off;led_02_off;led_01_off;          
//}
void save_skz_arrays(unsigned int skz1or2)//данная функция производит съем значений массива Config.SKZ_1 u Config.SKZ_2
{unsigned int m;                          // а также сразу сохраняет его в памяти eeprom БКИ
unsigned int val1, val2,addrval;  

 ProcessingEEPROM=1;
 led_warning_off;
led_calibration_on;
blink_off();
reg91_answer=(object_state|(!BPS_absent)<<5)|(red<<4)|((ProcessingEEPROM)<<3)|((red|ProcessingEEPROM)<<2)|((warning_flag&(!blink_flag)<<1))|(warning_flag&(!blink_flag)|blink_flag); 
 delay_ms(3200);
 
if(skz1or2==1){val1=0;val2=19;addrval=0x20;}        //адреса addrval подобраны исходя из адресов команд модбас для чтения указанных выше массивов
if(skz1or2==0){val1=19;val2=38;addrval=0x2D;}
for (m=val1;m<val2;m++){

//led_red_on;
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
//delay_ms(65);
 /*if((skz1or2==0)&&(blink_flag==1)&&(warning_flag==0)){
 led_red_off;
 led_green_off;
 delay_ms(300);} */

//if(BKI_state_sent==0){;}

if (check_cr_master()==1)
              {SKZ_read=0;
              if(rx_counter_master==7){SKZ_read=((unsigned int)rx_buffer_master[3]<<8)+rx_buffer_master[4];BPS_absent=0;}}
              else BPS_absent=1;
              #asm(" sei") 
              EEPROM_write(0x0405+2*m, rx_buffer_master[3]);
              EEPROM_write(0x0405+2*m+1, rx_buffer_master[4] ); 
              #asm(" cli")
                 
//              blink_display (rx_buffer_master[3]);
//              blink_display (rx_buffer_master[4]);              
}
 ProcessingEEPROM=0;led_calibration_off;if(warning_flag)led_warning_on; blink_on(); }


void save_freq_order()//функция читает порядок частот и сохраняет в БКИ
{unsigned int m;      // а также сразу сохраняет его в памяти eeprom БКИ
unsigned int val,addrval;  
val=0;addrval=0x60;ProcessingEEPROM=1;        //адреса addrval подобраны исходя из адресов команд модбас для чтения указанных выше массивов
for (m=val;m<19;m++){
led_warning_off;
led_calibration_on;
blink_off();
//led_red_on;
/*if(skz1or2==1)led_red_on;
else {led_red_off;        
     if(!warning_flag)led_green_off;
     else led_green_on;}*/
rx_c_master=0;rx_m_master=0;rx_wr_index_master=0;rx_counter_master=0;ClearBuf_master;  
crc_master=0xFFFF;
mov_buf_master(0x01);
mov_buf_master(0x04);
mov_buf_master(0x00);
mov_buf_master(m+addrval);
mov_buf_master(0x00);
mov_buf_master(0x01);
crc_end_master(); 

//delay_ms(65);
whait_read; 
 /*if((skz1or2==0)&&(blink_flag==1)&&(warning_flag==0)){
 led_red_off;
 led_green_off;
 delay_ms(300);} */

//delay_ms(15000);
if (check_cr_master()==1)
              {SKZ_read=0;
              if(rx_counter_master==7){FreqOrder_read=rx_buffer_master[3]|rx_buffer_master[4];BPS_absent=0;}}
              else BPS_absent=1;
              #asm(" sei") 
              EEPROM_write(eeAddressFirstFreq, FreqOrder_read);
              #asm(" cli")
                 
//              blink_display (rx_buffer_master[3]);
//              blink_display (rx_buffer_master[4]);              
}ProcessingEEPROM=0;led_calibration_off;if(warning_flag)led_warning_on; blink_on(); }

/*void recieve_skz_array()
{unsigned int m;   
rx_c_master=0;rx_m_master=0;rx_wr_index_master=0;rx_counter_master=0;  
for(m=0;m<80;m++)rx_buffer_master[m]=0;   
if (check_cr_master()==1){
if(rx_counter_master==80){
for (m=0;m<38;m++)
{
 //#asm(" sei")          
 EEPROM_write(eeAdrSKZ1ar+m, rx_buffer_master[m+2] );               //сохраняем его в еепром     
// #asm(" cli")}                                      
 for (m=0;m<38;m++)
{
// #asm(" sei")          
 EEPROM_write(eeAdrSKZ2ar+m, rx_buffer_master[m+40] );               //сохраняем его в еепром     
// #asm(" cli")}            } }                         
} */

void send_frequency_value()              //функция отправляющая на БПС значение величину количества рабочих частот, сохраненную в еепром БКИ
{unsigned int m;   
rx_c_master=0;rx_m_master=0;
rx_wr_index_master=0;rx_counter_master=0;
rx_c_slave=0;rx_m_slave=0;
rx_wr_index_slave=0;rx_counter_slave=0;
//for(m=0;m<80;m++)tx_buffer_master[m]=0;
crc_master=0xFFFF;
mov_buf_master(0x01);
mov_buf_master(0xcc); 
mov_buf_master(FrequencyQ); 
mov_buf_master(FrequencyQ);                                   
 crc_end_master();                                    
}

void send_SKZMIN_value()              //функция отправляющая на БПС величину минимального СКЗ сохраненные в еепром БКИ
{unsigned int m;   
rx_c_master=0;rx_m_master=0;
rx_wr_index_master=0;rx_counter_master=0;
rx_c_slave=0;rx_m_slave=0;
rx_wr_index_slave=0;rx_counter_slave=0;
//for(m=0;m<80;m++)tx_buffer_master[m]=0;
crc_master=0xFFFF;
mov_buf_master(0x01);
mov_buf_master(0xcb); 
mov_buf_master((char)(minimal_SKZ_val>>8)); 
mov_buf_master(minimal_SKZ_val);                                   
 crc_end_master();    
 whait_read;                                
}
void send_minimal_operat_val()              //функция отправляющая на БПС величину значения СКЗ, соответствующего уровню работы мельницы, сохраненные в еепром БКИ
{unsigned int m;   
rx_c_master=0;rx_m_master=0;
rx_wr_index_master=0;rx_counter_master=0;
rx_c_slave=0;rx_m_slave=0;
rx_wr_index_slave=0;rx_counter_slave=0;
//for(m=0;m<80;m++)tx_buffer_master[m]=0;
crc_master=0xFFFF;
mov_buf_master(0x01);
mov_buf_master(0xcf); 
mov_buf_master((int)(minimal_object_enabled_level>>8)); 
mov_buf_master(minimal_object_enabled_level);                                   
 crc_end_master();
 whait_read;    
//transmitter_on;TX_slave_on;printf("eval1=%d eval2=%d\r\n",(int)(minimal_object_enabled_level>>8),minimal_object_enabled_level);TX_slave_off;transmitter_off;                                 
}
void send_skz_array()              //функция отправляющая на БПС значение массивов СКЗ1 и СКЗ2 сохраненные в еепром БКИ
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
 mov_buf_master(EEPROM_read(0x0405+m));    }           //читаем массив из памяти    
// #asm(" cli")}                                      
 crc_end_master();                                    
}

void send_freq_order()              //функция отправляющая на БПС значение массивов СКЗ1 и СКЗ2 сохраненные в еепром БКИ
{unsigned int m;   
rx_c_master=0;rx_m_master=0;
rx_wr_index_master=0;rx_counter_master=0;
//for(m=0;m<80;m++)tx_buffer_master[m]=0;
crc_master=0xFFFF;
mov_buf_master(0x01);
mov_buf_master(0xce); 
for (m=0;m<19;m++)
{
// #asm(" sei")          
 mov_buf_master(EEPROM_read(eeAddressFirstFreq+m));    }           //читаем массив из памяти    
// #asm(" cli")}                                      
 crc_end_master();                                    
}

void go_main_menu(){
//TX_master_on;
TX_slave_on;
printf("\r\n if you want to set Modbus address please type 'a' letter \r\n");
printf("\r\n if you want to set Averaging out time value please type 'v' letter \r\n");
printf("\r\n if you want to set the number of working frequencies please type 'f' letter \r\n");
printf("\r\n if you want to set the minimal SKZ value in ADC units please type 'm' letter \r\n");
printf("\r\n if you want to overview the current configuration  please type 'o' letter \r\n");
//TX_master_off;
TX_slave_off;
}

void echo_answer_0x03(){
crc_slave=0xFFFF;
mov_buf_slave(rx_buffer_slave[0]);
mov_buf_slave(rx_buffer_slave[1]);
mov_buf_slave(rx_buffer_slave[2]);
mov_buf_slave(rx_buffer_slave[3]);
mov_buf_slave(rx_buffer_slave[4]);
crc_end_slave(); 
//whait_read;
}

void echo_answer_0x06(){
mov_buf_slave(rx_buffer_slave[0]);
mov_buf_slave(rx_buffer_slave[1]);
mov_buf_slave(rx_buffer_slave[2]);
mov_buf_slave(rx_buffer_slave[3]);
mov_buf_slave(rx_buffer_slave[4]);
mov_buf_slave(rx_buffer_slave[5]);
crc_end_slave(); 
//whait_read;
}

int ind_select(signed int ind_val){
signed int out_val;
if(ind_val>=90)out_val=1;
if((ind_val>10)&(ind_val<90))out_val=(99-ind_val)/10+1;
if((ind_val<=10)&(ind_val>=0))out_val=10;
if((ind_val<0)&(ind_val>-90))out_val=(100-ind_val)/10+1;
if(ind_val<=-90)out_val=20;
return out_val;}

//int ind_select(signed int ind_val){
//signed int out_val;
//if(ind_val<=-90)out_val=1;
//if((ind_val<-9)&(ind_val>-90))out_val=(ind_val+100)/10+1;
//if((ind_val>-9)&(ind_val<0))out_val=10;
//if((ind_val>=0)&(ind_val<90))out_val=(ind_val+100)/10+1;
//if(ind_val>=90)out_val=20;
//return out_val;}

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

if(ModbusMessage==62){EEPROM_write(eeAddressAverTimeV,AverTime_Value);EEPROM_write(eeAddressFreqQ,FrequencyQ);send_frequency_value();ModbusMessage=0;}
if(ModbusMessage==63){EEPROM_write(eeAddressModBusAddr,ModBusAddress);ModbusMessage=0;}
if(ModbusMessage==64){EEPROM_write(eeAddressMINSKZH,(unsigned char)(minimal_SKZ_val>>8));EEPROM_write(eeAddressMINSKZL,(unsigned char)(minimal_SKZ_val));send_SKZMIN_value();ModbusMessage=0;}
if(ModbusMessage==65){EEPROM_write(eeAddressMINOPLH,(unsigned char)(minimal_object_enabled_level>>8));EEPROM_write(eeAddressMINOPLL,(unsigned char)(minimal_object_enabled_level));send_minimal_operat_val();ModbusMessage=0;}
new_message=0;
}

//{crc_master=0xFFFF;mov_buf_master(0x01);mov_buf_master(0x06);mov_buf_master(0x00);mov_buf_master(0x82);mov_buf_master(0x00);mov_buf_master(0x01);crc_end_master();}
  

     
void main(void)
{ 
//signed int AverSKZ_Value=0;
int k=0,no_press=1; 
signed int x1,x2;
char disabling_counter=0,object_state_tmp;
//char n;
float y;   
//,reg1,reg2,reg;
DDRA=0b11111111; 
PORTA=0b00000000;
//DDRB=0b00001100;PORTB=0b00000000;
DDRC=0b11011111;PORTC=0b00100000;
DDRD=0b00011000;PORTD=0b10000000;
//PORTE=0b00000000;DDRE=0b00000110;
DDRF=0b11111111;PORTF=0b00000000;
DDRG=0b00000000;PORTG=0b00000000;
UCSR0A=0x00;UCSR0B=0xD8;UCSR0C=0x06;UBRR0H=0x00;UBRR0L=0x2F;
UCSR1A=0x00;UCSR1B=0xD8;UCSR1C=0x06;UBRR1H=0x00;UBRR1L=0x2F;
DDRC.0=1;
ACSR=0x80;SFIOR=0x00;ASSR=0x00;
TCCR0=0x02;TCNT0=0x00;OCR0=0x00;
DDRB=0x37;
PORTB=0x31;   //CS
//PORTB.5=1;   //CLR
// SPI initialization
// SPI Type: Master
// SPI Clock Rate: 62,500 kHz
// SPI Clock Phase: Cycle Start
// SPI Clock Polarity: High
// SPI Data Order: LSB First
SPCR=0xDE;
SPSR=0x00;
// Clear the SPI interrupt flag
#asm
    in   r30,spsr
    in   r30,spdr
#endasm
//led(0);
//delay_ms(100);
// led(21);
ClearBuf_slave;

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
Led_Intro1_on;
delay_ms(500);
Led_Intro2_on;
delay_ms(500);
Led_Intro2_off;
//delay_ms(200);

#asm("sei")
//delay_ms(200);

CalibrFlag=EEPROM_read(eeAddrCalibrFlag);
if(EEPROM_read(eeAddressAverTimeV)!=0xff)AverTime_Value=EEPROM_read(eeAddressAverTimeV);
if(EEPROM_read(eeAddressFreqQ)!=0xff)FrequencyQ=EEPROM_read(eeAddressFreqQ);
if(EEPROM_read(eeAddressModBusAddr)!=0xff)ModBusAddress=EEPROM_read(eeAddressModBusAddr);
if(EEPROM_read(eeAddressMINSKZH)!=0xff&EEPROM_read(eeAddressMINSKZL)!=0xff){minimal_SKZ_val=(unsigned int)(EEPROM_read(eeAddressMINSKZH))<<8;minimal_SKZ_val+=(unsigned int)(EEPROM_read(eeAddressMINSKZL));}
if(EEPROM_read(eeAddressMINOPLH)!=0xff&EEPROM_read(eeAddressMINOPLL)!=0xff){minimal_object_enabled_level=(unsigned int)(EEPROM_read(eeAddressMINOPLH))<<8;minimal_object_enabled_level+=(unsigned int)(EEPROM_read(eeAddressMINOPLL));}
if((AverTime_Value!=0)&(red==0))AvTimer_on;

//go_main_menu();
//TX_slave_on;printf("AverSKZ_Value=%d,skz_counter=%d testval=%e\r\n",AverSKZ_Value,SKZread_counter,testval);TX_slave_off;
//led(0);
send_frequency_value();
 whait_read;
 
 //delay_ms(65);
 rx_c_master=0;rx_m_master=0;
 rx_wr_index_master=0;rx_counter_master=0;
ClearBuf_master;                 
 send_SKZMIN_value();
rx_c_master=0;rx_m_master=0;
 rx_wr_index_master=0;rx_counter_master=0;
ClearBuf_master;                 
 whait_read;
send_minimal_operat_val();
 whait_read;
 //delay_ms(65);  
SKZ_1=0;SKZ_2=0;
if(CalibrFlag==1){
if(EEPROM_read(eeAddressSKZ1H)!=0xff&EEPROM_read(eeAddressSKZ1L)!=0xff)
    {            //        загружаем СКЗ1 и СКЗ2 из еепром
    SKZ_1 = ((unsigned int)EEPROM_read(eeAddressSKZ1H)<<8)+EEPROM_read(eeAddressSKZ1L);
    }
if(EEPROM_read(eeAddressSKZ2H)!=0xff&EEPROM_read(eeAddressSKZ2L)!=0xff){
SKZ_2 = ((unsigned int)EEPROM_read(eeAddressSKZ2H)<<8)+EEPROM_read(eeAddressSKZ2L);}        //v
SKZ1toSKZ2 =   EEPROM_read(eeAddressSKZ1toSKZ2);  
if(SKZ1toSKZ2!=0xff){
                                      if(SKZ1toSKZ2<=40){warning_flag=1;
                                      if(SKZ1toSKZ2<=20){blink_flag=1;blink_on();}
                                      else {led_warning_on;blink_flag=0;blink_off();}
                                      }
                                      else {warning_flag=0;led_warning_off;blink_off(); }}       
                                   //    blink_display(SKZ_1);  blink_display(SKZ_2);
                                      //delay_ms(300);
                                      send_freq_order();
                                      whait_read;
                                      //delay_ms(65); 
                                      send_skz_array();
                                      whait_read;
                                      //delay_ms(65);
                                        }
                                       
                                       
                                  /*    if((SKZ_1==0xffff)&&(SKZ_2==0xffff))no_press=0;
                                      else{ send_save_frq;
                                            whait_read;
                                            send_skz();
                                            whait_read;}*/
                                     
while (1)
        {
if(flash_erase_flag ==1)
    {
        //eeprom_reset(); 
    led(30);    
    EEPROM_write(0,0xff);
    EEPROM_write(1,0xff);
   // #asm("JMP 0")
    WDTCR=0x18;
    WDTCR=0x08;
    #asm("cli")
    delay_ms(3000);
    }        
      //  if(k==0) {blink_intro();k=1;}
reg91_answer=(object_state|(!BPS_absent)<<5)|(red<<4)|((ProcessingEEPROM)<<3)|((red|ProcessingEEPROM)<<2)|((warning_flag&(!blink_flag)<<1))|(warning_flag&(!blink_flag)|blink_flag);        
      
 if((blink_flag)|(red))blink_on();
 else blink_off();  
 if(BPS_absent){PORTC.1=!PORTC.1;PORTC.2=!PORTC.2;PORTC.3=!PORTC.3;} 
 else{PORTC.1=PORTC.1&1;PORTC.2=PORTC.2&1;PORTC.3=PORTC.3&1;} 
 if((object_state==0)&(!BPS_absent))
 {
        if(PORTF&0x40==0x40)
        {  
                    PORTF=PORTF&0b10111111;
                    PORTF=PORTF&0b11111110;
                    PORTF=PORTF&0b11111011;
                    PORTC.1=0;PORTC.2=0;PORTC.3=0;
        }
        else                
        {      
                    PORTF=PORTF|0b01000000;
                    PORTF=PORTF|0b00000001;
                    PORTF=PORTF|0b00000100;
                    PORTC.1=1;PORTC.2=1;PORTC.3=1;
        }
 }
current_out(tok);
if(new_message)
{      
    if(ModbusMessage==62)
        send_frequency_value();    
    terminal_commander(RData, terminal_mode);

} 
rx_c_master=0;rx_m_master=0;
rx_wr_index_master=0;rx_counter_master=0;
current_out(tok);
ClearBuf_master;
send_read_skz;
current_out(tok);
whait_read;
current_out(tok);
        //delay_ms(65); 
           if (check_cr_master()==1)
                {
                rms=0;
                if(rx_counter_master==7) rms=((int)rx_buffer_master[3])<<8|(char)rx_buffer_master[4];
               
                SKZread_counter++;
                BPS_absent=0;
                bps_absent_ctr=0;
                AverSKZ_Value=(float)AverSKZ_Value*((float)((float)SKZread_counter-1)/(float)SKZread_counter)+(float)((float)rms/(float)SKZread_counter);
              //  if(AverSKZ_Value<minimal_object_enabled_level)disabling_counter++;    (SKZ1-SKZ/SKZ1-SKZ2)    => SKZ = SKZ1-(SKZ1-SKZ2)*AverSKZ_value;
                }
                else 
                {
                bps_absent_ctr++;
                if(bps_absent_ctr>=4)BPS_absent=1;
                }
current_out(tok);
rx_c_master=0;rx_m_master=0;
rx_wr_index_master=0;rx_counter_master=0;
ClearBuf_master;                 
    send_read_object_state;
    current_out(tok);
    whait_read;
    current_out(tok);    
     if (check_cr_master()==1)
     {
     //   object_state_tmp=0;
     //   if(rx_counter_master==7)object_state_tmp=((int)rx_buffer_master[3])<<8|(char)rx_buffer_master[4];
     //   if(object_state_tmp==0)disabling_counter++;
     
    //transmitter_on;TX_slave_on;printf("AverSKZ_Value=%d,skz_counter=%d,enabled:%d\r\n",AverSKZ_Value,SKZread_counter,object_state_tmp);TX_slave_off;transmitter_off;
     }           
               // if(BPS_absent)BPS_link_failed; 
               //    blink_display(rms*100);    
                //if(rms>0x10000)
                //rms=0-rms;
                //rms=(float)((float)0.065*rms+10.5);
            //    }  
       // }        
       // y=(float)((float)0.5*rms+(float)0.5*y+0.5);
            
                 if((AvTimer>=(AverTime_Value))&(AverTime_Value!=0)&(!BPS_absent))
                 {
                   // if(disabling_counter>=(AverTime_Value*2))object_state=0;
                    true_skz=(float)SKZ_1-(float)(SKZ_1-SKZ_2)*AverSKZ_Value/100;
                    if(true_skz<minimal_object_enabled_level)object_state = 0;
                    else object_state=0x40;
                    AvTimer=0;
                    disabling_counter=0;
                    //  if(SKZread_counter==0)SKZread_counter=1;
                    //  AverSKZ_Value=(int)AverSKZ_Value/SKZread_counter;
                    //if(AverSKZ_Value<0)rms=(int)AverSKZ_Value;
                    //if(AverSKZ_Value>0)rms=(int)AverSKZ_Value;
                    if(AverSKZ_Value==0)rms=0;
                    // transmitter_on;TX_slave_on;printf("rms=%d object_state:%d\r\n",rms,object_state);TX_slave_off;transmitter_off;
                    //  TX_slave_on;printf("AverSKZ_Value=%d rms=%d \r\n",AverSKZ_Value,rms);TX_slave_off;
                    SKZread_counter=0;
                    if(rms>=127|rms<-127)
                    {
                        if(rms>=127)AverSKZprcnt=127;
                        if(rms<-127)AverSKZprcnt=-127;
                    }
                    else AverSKZprcnt=(char)rms;
                
                    //  transmitter_on;TX_slave_on;printf("rms=%d, AverSKZprcn%d object_state:%d\r\n",rms,AverSKZprcnt,object_state);TX_slave_off;transmitter_off;
                    // TX_slave_on;printf("AverSKZprcnt=%d\r\n",AverSKZprcnt);TX_slave_off;   
 
                    led(30);
                    if(object_state==0)   //в случае, если треть пришедших сообщений сигнализируют выключенное состояние объекта
                    {
                    PORTF=PORTF|0b01000000;
                    PORTF=PORTF|0b00000001;
                    PORTF=PORTF|0b00000100;
                    LedQ=0;
                    AverSKZprcnt=100;
                    //SPCR=0x00;
                    tok=0;
                    }
                else 
                    {
                    PORTF=PORTF&0b10111111;
                    PORTF=PORTF&0b11111110;
                    PORTF=PORTF&0b11111011;
                    LedQ=ind_select(rms);
                    SPCR=0xDE;
                    //transmitter_on;TX_slave_on;printf("LedQ=%d\r\n",LedQ);TX_slave_off;transmitter_off;
                    led(LedQ);
                    if (AverSKZprcnt<-100)tok=2000;
                    else tok=8*(100-AverSKZprcnt)+400;
                    if (tok<400)tok=400;
                    current_out(tok);
                    }
                //transmitter_on;TX_slave_on;printf("rms=%d\r\n",rms);TX_slave_off;transmitter_off;
                //current interface module with SPI                

//end of module        
                AverSKZ_Value=0;}
                
//if(BPS_absent){PORTC.1=!PORTC.1;PORTC.2=!PORTC.2;PORTC.3=!PORTC.3;}                                                 

      //  y=(float)((float)0.5*rms+(float)0.5*y+0.5);
       
      // if (y>20) y=20;if (y<1) y=1;  
      //}  */
//        if(blink_flag==1) led_green_off;
//-------------------------------------------
// модуль токового интерфейса
//-------------------------------------------

/*******************************************************/
     
        if(start_calibration==1)
        {
        press=0;key=0;
        if ((first_press==1)&&(second_press==1))
            {
            first_press=0;second_press=0;
            }
        }
        //if(finish_calibration==1){key=1;drebezg=2;}
        if(((key==0)&&(press==0))|start_calibration)
                { 
                
                warning_flag=0;  
                blink_flag=0;
                //TCNT3H=0;
                //TCNT3L=0;
                               
                press=1;drebezg=0;
                if(((first_press==0)&&(second_press==0)))
                        {
                        start_calibration=0;
                        no_press=0;
                        red = 1; 
//                        led_green_off;  
                        
                        first_press=1;
                     	send_save_skz1;         //сохраняем в БПС скз1
                        whait_read;
                        //delay_ms(65); 
                        save_skz_arrays(red);   
                          save_freq_order();
                        }
                else if(((first_press==1)&&(second_press==0)))
                        {  
                        start_calibration=0;    
                        red=0;
                        second_press=1;
                	    send_save_skz2;
                        whait_read;
                        //delay_ms(65); 
                 // if(finish_calibration){key=1;drebezg=2;finish_calibration=0;}         
               	        rx_c_master=0;rx_m_master=0;rx_wr_index_master=0;rx_counter_master=0;       //обнуляем буфер мастера а также все счетчики и прочие перменные                rx_buffer_master[0]=0;
                        rx_buffer_master[1]=0;
                        rx_buffer_master[2]=0;
                        rx_buffer_master[3]=0;
                        rx_buffer_master[4]=0;
                        rx_buffer_master[5]=0;
                        rx_buffer_master[6]=0;
                        rx_buffer_master[7]=0;
                        rx_buffer_master[8]=0;
                        rx_buffer_master[9]=0;
                        send_read_skzrel;//читаем значение относительного изменения сигнала
                        whait_read;
                         //delay_ms(65);
                        if (check_cr_master()==1)
                                 {
                                 SKZ1toSKZ2=0;
                                 if(rx_counter_master==7)SKZ1toSKZ2=((unsigned int)rx_buffer_master[3]<<8)+rx_buffer_master[4];BPS_absent=0;
                                 }
                         else BPS_absent=1;
                             {
                                rx_c_master=0;rx_m_master=0;
                                rx_wr_index_master=0;rx_counter_master=0;
                                ClearBuf_master;
                                send_read_skz1; 
                                whait_read;
                                if (check_cr_master()==1)
                                {
                                if(rx_counter_master==7) SKZ_1=((int)rx_buffer_master[3])<<8|(char)rx_buffer_master[4];
                                }
                                rx_c_master=0;rx_m_master=0;
                                rx_wr_index_master=0;rx_counter_master=0;
                                ClearBuf_master;
                                send_read_skz2;
                                whait_read;
                                if (check_cr_master()==1)
                                {
                                if(rx_counter_master==7) SKZ_2=((int)rx_buffer_master[3])<<8|(char)rx_buffer_master[4];
                                }
                            }   
                         EEPROM_write(eeAddressSKZ1toSKZ2, SKZ1toSKZ2);
                         EEPROM_write(eeAddressSKZ1H, SKZ_1>>8);
                         EEPROM_write(eeAddressSKZ1L, SKZ_1);
                         EEPROM_write(eeAddressSKZ2H, SKZ_2>>8);
                         EEPROM_write(eeAddressSKZ2L, SKZ_2);                         
 //                               blink_display(SKZ1toSKZ2);     //вспомогательная функция для просмотра содержимого буфера приема мастера
                                      if(SKZ1toSKZ2<=40)
                                      {
                                        warning_flag=1;
                                        if(SKZ1toSKZ2<=20)blink_flag=1;
                                        else blink_flag=0;
                                      }
                                      else warning_flag=0;
                                      CalibrFlag=1;  
save_skz_arrays(red);save_freq_order(); 
send_frequency_value();    
EEPROM_write(eeAddrCalibrFlag, CalibrFlag);                                         
        
                        }    
                              
                }   

         
        if(key==1)if(++drebezg>1)
            {
            press=0;drebezg=0;
            if ((first_press==1)&&(second_press==1))
               {
               first_press=0;
               second_press=0;//после 2го нажатия на кнопку, сбрасываем флаги сработавших нажатий
               }
            }
/*        if (rx_c_slave==1)
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
                }    */   
                rx_c_master=0;rx_m_master=0;rx_wr_index_master=0;rx_counter_master=0;
       	     //   rx_c_slave=0;rx_m_slave=0;rx_wr_index_slave=0;rx_counter_slave=0;                
          //led_red_off; 
        }
}
//------проверка контрольной суммы master-------//
char check_cr_master()                          //
        {                                       //
        char error;                             //
	error=1;crc_master=0xFFFF;i=0;          //
	while (i<(rx_wr_index_master-1)){crc_rtu_master(rx_buffer_master[i]);i++;}
	if ((rx_buffer_master[rx_wr_index_master])!=(crc_master>>8)) error=0;
	if ((rx_buffer_master[rx_wr_index_master-1])!=(crc_master&0x00FF)) error=0;
	return error;                           //
        }                                       //
//------проверка контрольной суммы slave--------//
char check_cr_slave()                           //
        {                                       //
        char error;                             //
	error=1;crc_slave=0xFFFF;i=0;           //
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
	}	
    
void  CRC_update(unsigned char d){
  unsigned char uindex;
  uindex = CRCHigh^d;
  CRCHigh=CRCLow^(crctable[uindex]>>8);
  CRCLow=crctable[uindex];    
  
}			        //
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
	}
       //
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
void mov_buf_slave(char a){CRC_update(a);mov_buf1(a);}//
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
       	UDR1=tx_buffer_master[tx_buffer_begin_master];//
	tx_en_master=1;crc_master=0xffff;       //
	}				        //
//------посылка контрольной суммы---------------//
//------начало передачи по slave----------------//
void crc_end_slave()				//
	{				        //
	mov_buf1(crc_slave);mov_buf1(crc_slave>>8);//
	TX_slave_on;                            //
       	UDR0=tx_buffer_slave[tx_buffer_begin_slave];//
	tx_en_slave=1;crc_slave=0xffff;	        //
	}				        //
void send_test()				//
	{				        //
	TX_slave_on;                            //
       	UDR0=tx_buffer_slave[tx_buffer_begin_slave];//
	tx_en_slave=1;
	}				     
//------ответ ошибка----------------------------//
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
//       	crc_master=0xFFFF;                      //
//       	for (i=0;i<rx_counter_slave-2;i++){mov_buf_master(rx_buffer_slave[i]);}
//        crc_end_master();crc_master=0xFFFF;     //
//        TCNT1=0x0000;TCCR1B=0x03;//8000000/8==1us*65535=65ms
//        while ((TIFR&0b00000100)==0);           //
//        TCCR1B=0;TIFR=TIFR;                     //
//       	crc_slave=0xFFFF;                       //
//       	for (i=0;i<rx_counter_master-2;i++){mov_buf_slave(rx_buffer_master[i]);}
//        crc_end_slave();                        //
        }                                       //
//----------------------------------------------//
void response_m_aa6()                           //
        {                                       //
//        unsigned int d,a,i;                     //
//        a=rx_buffer_slave[2];a=(a<<8)+rx_buffer_slave[3];d=rx_buffer_slave[4];d=(d<<8)+rx_buffer_slave[5];
//	if (save_reg(d,a)==1){for (i=0;i<6;i++)mov_buf_slave(rx_buffer_slave[i]);crc_end_slave();}
//	else                                    //
//	        {                               //
//               	crc_master=0xFFFF;              //
//               	for (i=0;i<rx_counter_slave-2;i++)
//               	        {mov_buf_master(rx_buffer_slave[i]);}
//                crc_end_master();crc_master=0xFFFF;
//                TCNT1=0x0000;TCCR1B=0x03;//8000000/8==1us*65535=65ms
//                while ((TIFR&0b00000100)==0);  //
//                TCCR1B=0;                      //
//                TIFR=TIFR;                     //
//               	crc_slave=0xFFFF;              //
//               	for (i=0;i<rx_counter_master-2;i++){mov_buf_slave(rx_buffer_master[i]);}
//                crc_end_slave();               //
//	        }                              //
        }                                      //
//----------------------------------------------//


    
void GetCRC16(char len)
{int b;
 crc_slave = 0xFFFF;
 for(b=0;b<len;b++)
  {
   crc_slave = crctable[((crc_slave>>8)^rx_buffer_slave[b])&0xFF] ^ (crc_slave<<8);
  }
 crc_slave ^= 0xFFFF;
 //return crc_slave;
}

