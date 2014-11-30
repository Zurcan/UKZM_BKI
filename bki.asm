
;CodeVisionAVR C Compiler V3.10 Advanced
;(C) Copyright 1998-2014 Pavel Haiduc, HP InfoTech s.r.l.
;http://www.hpinfotech.com

;Build configuration    : Release
;Chip type              : ATmega128
;Program type           : Application
;Clock frequency        : 8,000000 MHz
;Memory model           : Small
;Optimize for           : Speed
;(s)printf features     : int, width
;(s)scanf features      : int, width
;External RAM size      : 0
;Data Stack size        : 1024 byte(s)
;Heap size              : 0 byte(s)
;Promote 'char' to 'int': Yes
;'char' is unsigned     : Yes
;8 bit enums            : Yes
;Global 'const' stored in FLASH: No
;Enhanced function parameter passing: Yes
;Enhanced core instructions: On
;Automatic register allocation for global variables: On
;Smart register allocation: On

	#define _MODEL_SMALL_

	#pragma AVRPART ADMIN PART_NAME ATmega128
	#pragma AVRPART MEMORY PROG_FLASH 131072
	#pragma AVRPART MEMORY EEPROM 4096
	#pragma AVRPART MEMORY INT_SRAM SIZE 4096
	#pragma AVRPART MEMORY INT_SRAM START_ADDR 0x100

	#define CALL_SUPPORTED 1

	.LISTMAC
	.EQU UDRE=0x5
	.EQU RXC=0x7
	.EQU USR=0xB
	.EQU UDR=0xC
	.EQU SPSR=0xE
	.EQU SPDR=0xF
	.EQU EERE=0x0
	.EQU EEWE=0x1
	.EQU EEMWE=0x2
	.EQU EECR=0x1C
	.EQU EEDR=0x1D
	.EQU EEARL=0x1E
	.EQU EEARH=0x1F
	.EQU WDTCR=0x21
	.EQU MCUCR=0x35
	.EQU RAMPZ=0x3B
	.EQU SPL=0x3D
	.EQU SPH=0x3E
	.EQU SREG=0x3F
	.EQU XMCRA=0x6D
	.EQU XMCRB=0x6C

	.DEF R0X0=R0
	.DEF R0X1=R1
	.DEF R0X2=R2
	.DEF R0X3=R3
	.DEF R0X4=R4
	.DEF R0X5=R5
	.DEF R0X6=R6
	.DEF R0X7=R7
	.DEF R0X8=R8
	.DEF R0X9=R9
	.DEF R0XA=R10
	.DEF R0XB=R11
	.DEF R0XC=R12
	.DEF R0XD=R13
	.DEF R0XE=R14
	.DEF R0XF=R15
	.DEF R0X10=R16
	.DEF R0X11=R17
	.DEF R0X12=R18
	.DEF R0X13=R19
	.DEF R0X14=R20
	.DEF R0X15=R21
	.DEF R0X16=R22
	.DEF R0X17=R23
	.DEF R0X18=R24
	.DEF R0X19=R25
	.DEF R0X1A=R26
	.DEF R0X1B=R27
	.DEF R0X1C=R28
	.DEF R0X1D=R29
	.DEF R0X1E=R30
	.DEF R0X1F=R31

	.EQU __SRAM_START=0x0100
	.EQU __SRAM_END=0x10FF
	.EQU __DSTACK_SIZE=0x0400
	.EQU __HEAP_SIZE=0x0000
	.EQU __CLEAR_SRAM_SIZE=__SRAM_END-__SRAM_START+1

	.MACRO __CPD1N
	CPI  R30,LOW(@0)
	LDI  R26,HIGH(@0)
	CPC  R31,R26
	LDI  R26,BYTE3(@0)
	CPC  R22,R26
	LDI  R26,BYTE4(@0)
	CPC  R23,R26
	.ENDM

	.MACRO __CPD2N
	CPI  R26,LOW(@0)
	LDI  R30,HIGH(@0)
	CPC  R27,R30
	LDI  R30,BYTE3(@0)
	CPC  R24,R30
	LDI  R30,BYTE4(@0)
	CPC  R25,R30
	.ENDM

	.MACRO __CPWRR
	CP   R@0,R@2
	CPC  R@1,R@3
	.ENDM

	.MACRO __CPWRN
	CPI  R@0,LOW(@2)
	LDI  R30,HIGH(@2)
	CPC  R@1,R30
	.ENDM

	.MACRO __ADDB1MN
	SUBI R30,LOW(-@0-(@1))
	.ENDM

	.MACRO __ADDB2MN
	SUBI R26,LOW(-@0-(@1))
	.ENDM

	.MACRO __ADDW1MN
	SUBI R30,LOW(-@0-(@1))
	SBCI R31,HIGH(-@0-(@1))
	.ENDM

	.MACRO __ADDW2MN
	SUBI R26,LOW(-@0-(@1))
	SBCI R27,HIGH(-@0-(@1))
	.ENDM

	.MACRO __ADDW1FN
	SUBI R30,LOW(-2*@0-(@1))
	SBCI R31,HIGH(-2*@0-(@1))
	.ENDM

	.MACRO __ADDD1FN
	SUBI R30,LOW(-2*@0-(@1))
	SBCI R31,HIGH(-2*@0-(@1))
	SBCI R22,BYTE3(-2*@0-(@1))
	.ENDM

	.MACRO __ADDD1N
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	SBCI R22,BYTE3(-@0)
	SBCI R23,BYTE4(-@0)
	.ENDM

	.MACRO __ADDD2N
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	SBCI R24,BYTE3(-@0)
	SBCI R25,BYTE4(-@0)
	.ENDM

	.MACRO __SUBD1N
	SUBI R30,LOW(@0)
	SBCI R31,HIGH(@0)
	SBCI R22,BYTE3(@0)
	SBCI R23,BYTE4(@0)
	.ENDM

	.MACRO __SUBD2N
	SUBI R26,LOW(@0)
	SBCI R27,HIGH(@0)
	SBCI R24,BYTE3(@0)
	SBCI R25,BYTE4(@0)
	.ENDM

	.MACRO __ANDBMNN
	LDS  R30,@0+(@1)
	ANDI R30,LOW(@2)
	STS  @0+(@1),R30
	.ENDM

	.MACRO __ANDWMNN
	LDS  R30,@0+(@1)
	ANDI R30,LOW(@2)
	STS  @0+(@1),R30
	LDS  R30,@0+(@1)+1
	ANDI R30,HIGH(@2)
	STS  @0+(@1)+1,R30
	.ENDM

	.MACRO __ANDD1N
	ANDI R30,LOW(@0)
	ANDI R31,HIGH(@0)
	ANDI R22,BYTE3(@0)
	ANDI R23,BYTE4(@0)
	.ENDM

	.MACRO __ANDD2N
	ANDI R26,LOW(@0)
	ANDI R27,HIGH(@0)
	ANDI R24,BYTE3(@0)
	ANDI R25,BYTE4(@0)
	.ENDM

	.MACRO __ORBMNN
	LDS  R30,@0+(@1)
	ORI  R30,LOW(@2)
	STS  @0+(@1),R30
	.ENDM

	.MACRO __ORWMNN
	LDS  R30,@0+(@1)
	ORI  R30,LOW(@2)
	STS  @0+(@1),R30
	LDS  R30,@0+(@1)+1
	ORI  R30,HIGH(@2)
	STS  @0+(@1)+1,R30
	.ENDM

	.MACRO __ORD1N
	ORI  R30,LOW(@0)
	ORI  R31,HIGH(@0)
	ORI  R22,BYTE3(@0)
	ORI  R23,BYTE4(@0)
	.ENDM

	.MACRO __ORD2N
	ORI  R26,LOW(@0)
	ORI  R27,HIGH(@0)
	ORI  R24,BYTE3(@0)
	ORI  R25,BYTE4(@0)
	.ENDM

	.MACRO __DELAY_USB
	LDI  R24,LOW(@0)
__DELAY_USB_LOOP:
	DEC  R24
	BRNE __DELAY_USB_LOOP
	.ENDM

	.MACRO __DELAY_USW
	LDI  R24,LOW(@0)
	LDI  R25,HIGH(@0)
__DELAY_USW_LOOP:
	SBIW R24,1
	BRNE __DELAY_USW_LOOP
	.ENDM

	.MACRO __GETD1S
	LDD  R30,Y+@0
	LDD  R31,Y+@0+1
	LDD  R22,Y+@0+2
	LDD  R23,Y+@0+3
	.ENDM

	.MACRO __GETD2S
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	LDD  R24,Y+@0+2
	LDD  R25,Y+@0+3
	.ENDM

	.MACRO __PUTD1S
	STD  Y+@0,R30
	STD  Y+@0+1,R31
	STD  Y+@0+2,R22
	STD  Y+@0+3,R23
	.ENDM

	.MACRO __PUTD2S
	STD  Y+@0,R26
	STD  Y+@0+1,R27
	STD  Y+@0+2,R24
	STD  Y+@0+3,R25
	.ENDM

	.MACRO __PUTDZ2
	STD  Z+@0,R26
	STD  Z+@0+1,R27
	STD  Z+@0+2,R24
	STD  Z+@0+3,R25
	.ENDM

	.MACRO __CLRD1S
	STD  Y+@0,R30
	STD  Y+@0+1,R30
	STD  Y+@0+2,R30
	STD  Y+@0+3,R30
	.ENDM

	.MACRO __POINTB1MN
	LDI  R30,LOW(@0+(@1))
	.ENDM

	.MACRO __POINTW1MN
	LDI  R30,LOW(@0+(@1))
	LDI  R31,HIGH(@0+(@1))
	.ENDM

	.MACRO __POINTD1M
	LDI  R30,LOW(@0)
	LDI  R31,HIGH(@0)
	LDI  R22,BYTE3(@0)
	LDI  R23,BYTE4(@0)
	.ENDM

	.MACRO __POINTW1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	.ENDM

	.MACRO __POINTD1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	LDI  R22,BYTE3(2*@0+(@1))
	LDI  R23,BYTE4(2*@0+(@1))
	.ENDM

	.MACRO __POINTB2MN
	LDI  R26,LOW(@0+(@1))
	.ENDM

	.MACRO __POINTW2MN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	.ENDM

	.MACRO __POINTW2FN
	LDI  R26,LOW(2*@0+(@1))
	LDI  R27,HIGH(2*@0+(@1))
	.ENDM

	.MACRO __POINTD2FN
	LDI  R26,LOW(2*@0+(@1))
	LDI  R27,HIGH(2*@0+(@1))
	LDI  R24,BYTE3(2*@0+(@1))
	LDI  R25,BYTE4(2*@0+(@1))
	.ENDM

	.MACRO __POINTBRM
	LDI  R@0,LOW(@1)
	.ENDM

	.MACRO __POINTWRM
	LDI  R@0,LOW(@2)
	LDI  R@1,HIGH(@2)
	.ENDM

	.MACRO __POINTBRMN
	LDI  R@0,LOW(@1+(@2))
	.ENDM

	.MACRO __POINTWRMN
	LDI  R@0,LOW(@2+(@3))
	LDI  R@1,HIGH(@2+(@3))
	.ENDM

	.MACRO __POINTWRFN
	LDI  R@0,LOW(@2*2+(@3))
	LDI  R@1,HIGH(@2*2+(@3))
	.ENDM

	.MACRO __GETD1N
	LDI  R30,LOW(@0)
	LDI  R31,HIGH(@0)
	LDI  R22,BYTE3(@0)
	LDI  R23,BYTE4(@0)
	.ENDM

	.MACRO __GETD2N
	LDI  R26,LOW(@0)
	LDI  R27,HIGH(@0)
	LDI  R24,BYTE3(@0)
	LDI  R25,BYTE4(@0)
	.ENDM

	.MACRO __GETB1MN
	LDS  R30,@0+(@1)
	.ENDM

	.MACRO __GETB1HMN
	LDS  R31,@0+(@1)
	.ENDM

	.MACRO __GETW1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	.ENDM

	.MACRO __GETD1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	LDS  R22,@0+(@1)+2
	LDS  R23,@0+(@1)+3
	.ENDM

	.MACRO __GETBRMN
	LDS  R@0,@1+(@2)
	.ENDM

	.MACRO __GETWRMN
	LDS  R@0,@2+(@3)
	LDS  R@1,@2+(@3)+1
	.ENDM

	.MACRO __GETWRZ
	LDD  R@0,Z+@2
	LDD  R@1,Z+@2+1
	.ENDM

	.MACRO __GETD2Z
	LDD  R26,Z+@0
	LDD  R27,Z+@0+1
	LDD  R24,Z+@0+2
	LDD  R25,Z+@0+3
	.ENDM

	.MACRO __GETB2MN
	LDS  R26,@0+(@1)
	.ENDM

	.MACRO __GETW2MN
	LDS  R26,@0+(@1)
	LDS  R27,@0+(@1)+1
	.ENDM

	.MACRO __GETD2MN
	LDS  R26,@0+(@1)
	LDS  R27,@0+(@1)+1
	LDS  R24,@0+(@1)+2
	LDS  R25,@0+(@1)+3
	.ENDM

	.MACRO __PUTB1MN
	STS  @0+(@1),R30
	.ENDM

	.MACRO __PUTW1MN
	STS  @0+(@1),R30
	STS  @0+(@1)+1,R31
	.ENDM

	.MACRO __PUTD1MN
	STS  @0+(@1),R30
	STS  @0+(@1)+1,R31
	STS  @0+(@1)+2,R22
	STS  @0+(@1)+3,R23
	.ENDM

	.MACRO __PUTB1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMWRB
	.ENDM

	.MACRO __PUTW1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMWRW
	.ENDM

	.MACRO __PUTD1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMWRD
	.ENDM

	.MACRO __PUTBR0MN
	STS  @0+(@1),R0
	.ENDM

	.MACRO __PUTBMRN
	STS  @0+(@1),R@2
	.ENDM

	.MACRO __PUTWMRN
	STS  @0+(@1),R@2
	STS  @0+(@1)+1,R@3
	.ENDM

	.MACRO __PUTBZR
	STD  Z+@1,R@0
	.ENDM

	.MACRO __PUTWZR
	STD  Z+@2,R@0
	STD  Z+@2+1,R@1
	.ENDM

	.MACRO __GETW1R
	MOV  R30,R@0
	MOV  R31,R@1
	.ENDM

	.MACRO __GETW2R
	MOV  R26,R@0
	MOV  R27,R@1
	.ENDM

	.MACRO __GETWRN
	LDI  R@0,LOW(@2)
	LDI  R@1,HIGH(@2)
	.ENDM

	.MACRO __PUTW1R
	MOV  R@0,R30
	MOV  R@1,R31
	.ENDM

	.MACRO __PUTW2R
	MOV  R@0,R26
	MOV  R@1,R27
	.ENDM

	.MACRO __ADDWRN
	SUBI R@0,LOW(-@2)
	SBCI R@1,HIGH(-@2)
	.ENDM

	.MACRO __ADDWRR
	ADD  R@0,R@2
	ADC  R@1,R@3
	.ENDM

	.MACRO __SUBWRN
	SUBI R@0,LOW(@2)
	SBCI R@1,HIGH(@2)
	.ENDM

	.MACRO __SUBWRR
	SUB  R@0,R@2
	SBC  R@1,R@3
	.ENDM

	.MACRO __ANDWRN
	ANDI R@0,LOW(@2)
	ANDI R@1,HIGH(@2)
	.ENDM

	.MACRO __ANDWRR
	AND  R@0,R@2
	AND  R@1,R@3
	.ENDM

	.MACRO __ORWRN
	ORI  R@0,LOW(@2)
	ORI  R@1,HIGH(@2)
	.ENDM

	.MACRO __ORWRR
	OR   R@0,R@2
	OR   R@1,R@3
	.ENDM

	.MACRO __EORWRR
	EOR  R@0,R@2
	EOR  R@1,R@3
	.ENDM

	.MACRO __GETWRS
	LDD  R@0,Y+@2
	LDD  R@1,Y+@2+1
	.ENDM

	.MACRO __PUTBSR
	STD  Y+@1,R@0
	.ENDM

	.MACRO __PUTWSR
	STD  Y+@2,R@0
	STD  Y+@2+1,R@1
	.ENDM

	.MACRO __MOVEWRR
	MOV  R@0,R@2
	MOV  R@1,R@3
	.ENDM

	.MACRO __INWR
	IN   R@0,@2
	IN   R@1,@2+1
	.ENDM

	.MACRO __OUTWR
	OUT  @2+1,R@1
	OUT  @2,R@0
	.ENDM

	.MACRO __CALL1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	ICALL
	.ENDM

	.MACRO __CALL1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	CALL __GETW1PF
	ICALL
	.ENDM

	.MACRO __CALL2EN
	PUSH R26
	PUSH R27
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMRDW
	POP  R27
	POP  R26
	ICALL
	.ENDM

	.MACRO __CALL2EX
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	CALL __EEPROMRDD
	ICALL
	.ENDM

	.MACRO __GETW1STACK
	IN   R30,SPL
	IN   R31,SPH
	ADIW R30,@0+1
	LD   R0,Z+
	LD   R31,Z
	MOV  R30,R0
	.ENDM

	.MACRO __GETD1STACK
	IN   R30,SPL
	IN   R31,SPH
	ADIW R30,@0+1
	LD   R0,Z+
	LD   R1,Z+
	LD   R22,Z
	MOVW R30,R0
	.ENDM

	.MACRO __NBST
	BST  R@0,@1
	IN   R30,SREG
	LDI  R31,0x40
	EOR  R30,R31
	OUT  SREG,R30
	.ENDM


	.MACRO __PUTB1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RNS
	MOVW R26,R@0
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RNS
	MOVW R26,R@0
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RNS
	MOVW R26,R@0
	ADIW R26,@1
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	CALL __PUTDP1
	.ENDM


	.MACRO __GETB1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R30,Z
	.ENDM

	.MACRO __GETB1HSX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R31,Z
	.ENDM

	.MACRO __GETW1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R0,Z+
	LD   R31,Z
	MOV  R30,R0
	.ENDM

	.MACRO __GETD1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R0,Z+
	LD   R1,Z+
	LD   R22,Z+
	LD   R23,Z
	MOVW R30,R0
	.ENDM

	.MACRO __GETB2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R26,X
	.ENDM

	.MACRO __GETW2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	.ENDM

	.MACRO __GETD2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R1,X+
	LD   R24,X+
	LD   R25,X
	MOVW R26,R0
	.ENDM

	.MACRO __GETBRSX
	MOVW R30,R28
	SUBI R30,LOW(-@1)
	SBCI R31,HIGH(-@1)
	LD   R@0,Z
	.ENDM

	.MACRO __GETWRSX
	MOVW R30,R28
	SUBI R30,LOW(-@2)
	SBCI R31,HIGH(-@2)
	LD   R@0,Z+
	LD   R@1,Z
	.ENDM

	.MACRO __GETBRSX2
	MOVW R26,R28
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	LD   R@0,X
	.ENDM

	.MACRO __GETWRSX2
	MOVW R26,R28
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	LD   R@0,X+
	LD   R@1,X
	.ENDM

	.MACRO __LSLW8SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R31,Z
	CLR  R30
	.ENDM

	.MACRO __PUTB1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __CLRW1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X,R30
	.ENDM

	.MACRO __CLRD1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X+,R30
	ST   X+,R30
	ST   X,R30
	.ENDM

	.MACRO __PUTB2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z,R26
	.ENDM

	.MACRO __PUTW2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z+,R26
	ST   Z,R27
	.ENDM

	.MACRO __PUTD2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z+,R26
	ST   Z+,R27
	ST   Z+,R24
	ST   Z,R25
	.ENDM

	.MACRO __PUTBSRX
	MOVW R30,R28
	SUBI R30,LOW(-@1)
	SBCI R31,HIGH(-@1)
	ST   Z,R@0
	.ENDM

	.MACRO __PUTWSRX
	MOVW R30,R28
	SUBI R30,LOW(-@2)
	SBCI R31,HIGH(-@2)
	ST   Z+,R@0
	ST   Z,R@1
	.ENDM

	.MACRO __PUTB1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __MULBRR
	MULS R@0,R@1
	MOVW R30,R0
	.ENDM

	.MACRO __MULBRRU
	MUL  R@0,R@1
	MOVW R30,R0
	.ENDM

	.MACRO __MULBRR0
	MULS R@0,R@1
	.ENDM

	.MACRO __MULBRRU0
	MUL  R@0,R@1
	.ENDM

	.MACRO __MULBNWRU
	LDI  R26,@2
	MUL  R26,R@0
	MOVW R30,R0
	MUL  R26,R@1
	ADD  R31,R0
	.ENDM

;NAME DEFINITIONS FOR GLOBAL VARIABLES ALLOCATED TO REGISTERS
	.DEF _LedQ=R4
	.DEF _LedQ_msb=R5
	.DEF _rms=R6
	.DEF _rms_msb=R7
	.DEF _SKZ_1=R8
	.DEF _SKZ_1_msb=R9
	.DEF _SKZ_2=R10
	.DEF _SKZ_2_msb=R11
	.DEF _SKZ1toSKZ2=R12
	.DEF _SKZ1toSKZ2_msb=R13

	.CSEG
	.ORG 0x00

;START OF CODE MARKER
__START_OF_CODE:

;INTERRUPT VECTORS
	JMP  __RESET
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  _timer2_ovf_isr
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  _timer0_ovf_isr
	JMP  _spi_isr
	JMP  _usart0_rx_isr
	JMP  0x00
	JMP  _usart0_tx_isr
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  _timer3_ovf_isr
	JMP  _usart1_rx_isr
	JMP  0x00
	JMP  _usart1_tx_isr
	JMP  0x00
	JMP  0x00

_tbl10_G101:
	.DB  0x10,0x27,0xE8,0x3,0x64,0x0,0xA,0x0
	.DB  0x1,0x0
_tbl16_G101:
	.DB  0x0,0x10,0x0,0x1,0x10,0x0,0x1,0x0

;REGISTER BIT VARIABLES INITIALIZATION
__REG_BIT_VARS:
	.DW  0x0000

;GLOBAL REGISTER VARIABLES INITIALIZATION
__REG_VARS:
	.DB  0x0,0x0,0x0,0x0

_0x3:
	.DB  0x1
_0x4:
	.DB  0x1
_0x5:
	.DB  0x1
_0x6:
	.DB  0x1
_0x7:
	.DB  0x1E
_0x8:
	.DB  0x28
_0x9:
	.DB  0x1E
_0xA:
	.DB  0x3
_0xB:
	.DB  0x1
_0xC:
	.DB  0x91,0x34
_0xD:
	.DB  0x0,0x0,0xC0,0xC1,0xC1,0x81,0x1,0x40
	.DB  0xC3,0x1,0x3,0xC0,0x2,0x80,0xC2,0x41
	.DB  0xC6,0x1,0x6,0xC0,0x7,0x80,0xC7,0x41
	.DB  0x5,0x0,0xC5,0xC1,0xC4,0x81,0x4,0x40
	.DB  0xCC,0x1,0xC,0xC0,0xD,0x80,0xCD,0x41
	.DB  0xF,0x0,0xCF,0xC1,0xCE,0x81,0xE,0x40
	.DB  0xA,0x0,0xCA,0xC1,0xCB,0x81,0xB,0x40
	.DB  0xC9,0x1,0x9,0xC0,0x8,0x80,0xC8,0x41
	.DB  0xD8,0x1,0x18,0xC0,0x19,0x80,0xD9,0x41
	.DB  0x1B,0x0,0xDB,0xC1,0xDA,0x81,0x1A,0x40
	.DB  0x1E,0x0,0xDE,0xC1,0xDF,0x81,0x1F,0x40
	.DB  0xDD,0x1,0x1D,0xC0,0x1C,0x80,0xDC,0x41
	.DB  0x14,0x0,0xD4,0xC1,0xD5,0x81,0x15,0x40
	.DB  0xD7,0x1,0x17,0xC0,0x16,0x80,0xD6,0x41
	.DB  0xD2,0x1,0x12,0xC0,0x13,0x80,0xD3,0x41
	.DB  0x11,0x0,0xD1,0xC1,0xD0,0x81,0x10,0x40
	.DB  0xF0,0x1,0x30,0xC0,0x31,0x80,0xF1,0x41
	.DB  0x33,0x0,0xF3,0xC1,0xF2,0x81,0x32,0x40
	.DB  0x36,0x0,0xF6,0xC1,0xF7,0x81,0x37,0x40
	.DB  0xF5,0x1,0x35,0xC0,0x34,0x80,0xF4,0x41
	.DB  0x3C,0x0,0xFC,0xC1,0xFD,0x81,0x3D,0x40
	.DB  0xFF,0x1,0x3F,0xC0,0x3E,0x80,0xFE,0x41
	.DB  0xFA,0x1,0x3A,0xC0,0x3B,0x80,0xFB,0x41
	.DB  0x39,0x0,0xF9,0xC1,0xF8,0x81,0x38,0x40
	.DB  0x28,0x0,0xE8,0xC1,0xE9,0x81,0x29,0x40
	.DB  0xEB,0x1,0x2B,0xC0,0x2A,0x80,0xEA,0x41
	.DB  0xEE,0x1,0x2E,0xC0,0x2F,0x80,0xEF,0x41
	.DB  0x2D,0x0,0xED,0xC1,0xEC,0x81,0x2C,0x40
	.DB  0xE4,0x1,0x24,0xC0,0x25,0x80,0xE5,0x41
	.DB  0x27,0x0,0xE7,0xC1,0xE6,0x81,0x26,0x40
	.DB  0x22,0x0,0xE2,0xC1,0xE3,0x81,0x23,0x40
	.DB  0xE1,0x1,0x21,0xC0,0x20,0x80,0xE0,0x41
	.DB  0xA0,0x1,0x60,0xC0,0x61,0x80,0xA1,0x41
	.DB  0x63,0x0,0xA3,0xC1,0xA2,0x81,0x62,0x40
	.DB  0x66,0x0,0xA6,0xC1,0xA7,0x81,0x67,0x40
	.DB  0xA5,0x1,0x65,0xC0,0x64,0x80,0xA4,0x41
	.DB  0x6C,0x0,0xAC,0xC1,0xAD,0x81,0x6D,0x40
	.DB  0xAF,0x1,0x6F,0xC0,0x6E,0x80,0xAE,0x41
	.DB  0xAA,0x1,0x6A,0xC0,0x6B,0x80,0xAB,0x41
	.DB  0x69,0x0,0xA9,0xC1,0xA8,0x81,0x68,0x40
	.DB  0x78,0x0,0xB8,0xC1,0xB9,0x81,0x79,0x40
	.DB  0xBB,0x1,0x7B,0xC0,0x7A,0x80,0xBA,0x41
	.DB  0xBE,0x1,0x7E,0xC0,0x7F,0x80,0xBF,0x41
	.DB  0x7D,0x0,0xBD,0xC1,0xBC,0x81,0x7C,0x40
	.DB  0xB4,0x1,0x74,0xC0,0x75,0x80,0xB5,0x41
	.DB  0x77,0x0,0xB7,0xC1,0xB6,0x81,0x76,0x40
	.DB  0x72,0x0,0xB2,0xC1,0xB3,0x81,0x73,0x40
	.DB  0xB1,0x1,0x71,0xC0,0x70,0x80,0xB0,0x41
	.DB  0x50,0x0,0x90,0xC1,0x91,0x81,0x51,0x40
	.DB  0x93,0x1,0x53,0xC0,0x52,0x80,0x92,0x41
	.DB  0x96,0x1,0x56,0xC0,0x57,0x80,0x97,0x41
	.DB  0x55,0x0,0x95,0xC1,0x94,0x81,0x54,0x40
	.DB  0x9C,0x1,0x5C,0xC0,0x5D,0x80,0x9D,0x41
	.DB  0x5F,0x0,0x9F,0xC1,0x9E,0x81,0x5E,0x40
	.DB  0x5A,0x0,0x9A,0xC1,0x9B,0x81,0x5B,0x40
	.DB  0x99,0x1,0x59,0xC0,0x58,0x80,0x98,0x41
	.DB  0x88,0x1,0x48,0xC0,0x49,0x80,0x89,0x41
	.DB  0x4B,0x0,0x8B,0xC1,0x8A,0x81,0x4A,0x40
	.DB  0x4E,0x0,0x8E,0xC1,0x8F,0x81,0x4F,0x40
	.DB  0x8D,0x1,0x4D,0xC0,0x4C,0x80,0x8C,0x41
	.DB  0x44,0x0,0x84,0xC1,0x85,0x81,0x45,0x40
	.DB  0x87,0x1,0x47,0xC0,0x46,0x80,0x86,0x41
	.DB  0x82,0x1,0x42,0xC0,0x43,0x80,0x83,0x41
	.DB  0x41,0x0,0x81,0xC1,0x80,0x81,0x40,0x40
_0x0:
	.DB  0xD,0xA,0x20,0x69,0x66,0x20,0x79,0x6F
	.DB  0x75,0x20,0x77,0x61,0x6E,0x74,0x20,0x74
	.DB  0x6F,0x20,0x73,0x65,0x74,0x20,0x4D,0x6F
	.DB  0x64,0x62,0x75,0x73,0x20,0x61,0x64,0x64
	.DB  0x72,0x65,0x73,0x73,0x20,0x70,0x6C,0x65
	.DB  0x61,0x73,0x65,0x20,0x74,0x79,0x70,0x65
	.DB  0x20,0x27,0x61,0x27,0x20,0x6C,0x65,0x74
	.DB  0x74,0x65,0x72,0x20,0xD,0xA,0x0,0xD
	.DB  0xA,0x20,0x69,0x66,0x20,0x79,0x6F,0x75
	.DB  0x20,0x77,0x61,0x6E,0x74,0x20,0x74,0x6F
	.DB  0x20,0x73,0x65,0x74,0x20,0x41,0x76,0x65
	.DB  0x72,0x61,0x67,0x69,0x6E,0x67,0x20,0x6F
	.DB  0x75,0x74,0x20,0x74,0x69,0x6D,0x65,0x20
	.DB  0x76,0x61,0x6C,0x75,0x65,0x20,0x70,0x6C
	.DB  0x65,0x61,0x73,0x65,0x20,0x74,0x79,0x70
	.DB  0x65,0x20,0x27,0x76,0x27,0x20,0x6C,0x65
	.DB  0x74,0x74,0x65,0x72,0x20,0xD,0xA,0x0
	.DB  0xD,0xA,0x20,0x69,0x66,0x20,0x79,0x6F
	.DB  0x75,0x20,0x77,0x61,0x6E,0x74,0x20,0x74
	.DB  0x6F,0x20,0x73,0x65,0x74,0x20,0x74,0x68
	.DB  0x65,0x20,0x6E,0x75,0x6D,0x62,0x65,0x72
	.DB  0x20,0x6F,0x66,0x20,0x77,0x6F,0x72,0x6B
	.DB  0x69,0x6E,0x67,0x20,0x66,0x72,0x65,0x71
	.DB  0x75,0x65,0x6E,0x63,0x69,0x65,0x73,0x20
	.DB  0x70,0x6C,0x65,0x61,0x73,0x65,0x20,0x74
	.DB  0x79,0x70,0x65,0x20,0x27,0x66,0x27,0x20
	.DB  0x6C,0x65,0x74,0x74,0x65,0x72,0x20,0xD
	.DB  0xA,0x0,0xD,0xA,0x20,0x69,0x66,0x20
	.DB  0x79,0x6F,0x75,0x20,0x77,0x61,0x6E,0x74
	.DB  0x20,0x74,0x6F,0x20,0x73,0x65,0x74,0x20
	.DB  0x74,0x68,0x65,0x20,0x6D,0x69,0x6E,0x69
	.DB  0x6D,0x61,0x6C,0x20,0x53,0x4B,0x5A,0x20
	.DB  0x76,0x61,0x6C,0x75,0x65,0x20,0x69,0x6E
	.DB  0x20,0x41,0x44,0x43,0x20,0x75,0x6E,0x69
	.DB  0x74,0x73,0x20,0x70,0x6C,0x65,0x61,0x73
	.DB  0x65,0x20,0x74,0x79,0x70,0x65,0x20,0x27
	.DB  0x6D,0x27,0x20,0x6C,0x65,0x74,0x74,0x65
	.DB  0x72,0x20,0xD,0xA,0x0,0xD,0xA,0x20
	.DB  0x69,0x66,0x20,0x79,0x6F,0x75,0x20,0x77
	.DB  0x61,0x6E,0x74,0x20,0x74,0x6F,0x20,0x6F
	.DB  0x76,0x65,0x72,0x76,0x69,0x65,0x77,0x20
	.DB  0x74,0x68,0x65,0x20,0x63,0x75,0x72,0x72
	.DB  0x65,0x6E,0x74,0x20,0x63,0x6F,0x6E,0x66
	.DB  0x69,0x67,0x75,0x72,0x61,0x74,0x69,0x6F
	.DB  0x6E,0x20,0x20,0x70,0x6C,0x65,0x61,0x73
	.DB  0x65,0x20,0x74,0x79,0x70,0x65,0x20,0x27
	.DB  0x6F,0x27,0x20,0x6C,0x65,0x74,0x74,0x65
	.DB  0x72,0x20,0xD,0xA,0x0
_0x2040060:
	.DB  0x1
_0x2040000:
	.DB  0x2D,0x4E,0x41,0x4E,0x0,0x49,0x4E,0x46
	.DB  0x0

__GLOBAL_INI_TBL:
	.DW  0x02
	.DW  0x02
	.DW  __REG_BIT_VARS*2

	.DW  0x04
	.DW  0x04
	.DW  __REG_VARS*2

	.DW  0x01
	.DW  _object_state
	.DW  _0x4*2

	.DW  0x01
	.DW  _SPI_tEnd
	.DW  _0x5*2

	.DW  0x01
	.DW  _ModBusAddress
	.DW  _0x6*2

	.DW  0x01
	.DW  _minimal_SKZ_val
	.DW  _0x7*2

	.DW  0x01
	.DW  _minimal_object_enabled_level
	.DW  _0x8*2

	.DW  0x01
	.DW  _AverTime_Value
	.DW  _0x9*2

	.DW  0x01
	.DW  _FrequencyQ
	.DW  _0xA*2

	.DW  0x02
	.DW  _DeviceID_G000
	.DW  _0xC*2

	.DW  0x200
	.DW  _crctable_G000
	.DW  _0xD*2

	.DW  0x01
	.DW  __seed_G102
	.DW  _0x2040060*2

_0xFFFFFFFF:
	.DW  0

#define __GLOBAL_INI_TBL_PRESENT 1

__RESET:
	CLI
	CLR  R30
	OUT  EECR,R30

;INTERRUPT VECTORS ARE PLACED
;AT THE START OF FLASH
	LDI  R31,1
	OUT  MCUCR,R31
	OUT  MCUCR,R30
	STS  XMCRB,R30

;DISABLE WATCHDOG
	LDI  R31,0x18
	OUT  WDTCR,R31
	OUT  WDTCR,R30

;CLEAR R2-R14
	LDI  R24,(14-2)+1
	LDI  R26,2
	CLR  R27
__CLEAR_REG:
	ST   X+,R30
	DEC  R24
	BRNE __CLEAR_REG

;CLEAR SRAM
	LDI  R24,LOW(__CLEAR_SRAM_SIZE)
	LDI  R25,HIGH(__CLEAR_SRAM_SIZE)
	LDI  R26,LOW(__SRAM_START)
	LDI  R27,HIGH(__SRAM_START)
__CLEAR_SRAM:
	ST   X+,R30
	SBIW R24,1
	BRNE __CLEAR_SRAM

;GLOBAL VARIABLES INITIALIZATION
	LDI  R30,LOW(__GLOBAL_INI_TBL*2)
	LDI  R31,HIGH(__GLOBAL_INI_TBL*2)
__GLOBAL_INI_NEXT:
	LPM  R24,Z+
	LPM  R25,Z+
	SBIW R24,0
	BREQ __GLOBAL_INI_END
	LPM  R26,Z+
	LPM  R27,Z+
	LPM  R0,Z+
	LPM  R1,Z+
	MOVW R22,R30
	MOVW R30,R0
__GLOBAL_INI_LOOP:
	LPM  R0,Z+
	ST   X+,R0
	SBIW R24,1
	BRNE __GLOBAL_INI_LOOP
	MOVW R30,R22
	RJMP __GLOBAL_INI_NEXT
__GLOBAL_INI_END:

	OUT  RAMPZ,R24

;HARDWARE STACK POINTER INITIALIZATION
	LDI  R30,LOW(__SRAM_END-__HEAP_SIZE)
	OUT  SPL,R30
	LDI  R30,HIGH(__SRAM_END-__HEAP_SIZE)
	OUT  SPH,R30

;DATA STACK POINTER INITIALIZATION
	LDI  R28,LOW(__SRAM_START+__DSTACK_SIZE)
	LDI  R29,HIGH(__SRAM_START+__DSTACK_SIZE)

	JMP  _main

	.ESEG
	.ORG 0

	.DSEG
	.ORG 0x500

	.CSEG
;/*****************************************************
;CodeWizardAVR V1.24.5 Standard
;
;Project : 10ч/д
;Version :
;Date    : 09.09.2008
;
;Chip type           : ATmega128L
;Program type        : Application
;Clock frequency     : 8,000000 MHz
;Memory model        : Small
;External SRAM size  : 0
;Data Stack size     : 1024
;*****************************************************/
;#include <mega128.h>
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
;#include <delay.h>
;#include <math.h>
;#include <stdio.h>
;
;#define uart_slave_disable UCSR0B=0x00
;#define transmitter_off UCSR0B=0x90
;#define transmitter_on UCSR0B=0xD8
;#define TX_slave_on  PORTE=PORTE|0b00000100
;#define TX_slave_off PORTE=PORTE&0b11111011
;#define TX_master_on   PORTD.4=1;
;#define TX_master_off  PORTD.4=0;
;#define testing_blink_on PORTC.0=1
;#define testing_blink_off PORTC.0=0
;#define led_01_on  PORTC.1=1
;#define led_01_off PORTC.1=0
;#define led_02_on  PORTC.2=1
;#define led_02_off PORTC.2=0
;#define led_03_on  PORTC.3=1
;#define led_03_off PORTC.3=0
;#define led_04_on  PORTC.4=1
;#define led_04_off PORTC.4=0
;#define led_05_on  PORTC.7=1
;#define led_05_off PORTC.7=0
;#define led_06_on  PORTC.6=1
;#define led_06_off PORTC.6=0
;#define led_07_on  PORTA.7=1
;#define led_07_off PORTA.7=0
;#define led_08_on  PORTA.6=1
;#define led_08_off PORTA.6=0
;#define led_09_on  PORTA.5=1
;#define led_09_off PORTA.5=0
;#define led_10_on  PORTA.4=1
;#define led_10_off PORTA.4=0
;#define led_11_on  PORTA.3=1
;#define led_11_off PORTA.3=0
;#define led_12_on  PORTA.1=1
;#define led_12_off PORTA.1=0
;#define led_13_on  PORTA.0=1
;#define led_13_off PORTA.0=0
;#define led_14_on  PORTF=PORTF|0b10000000
;#define led_14_off PORTF=PORTF&0b01111111
;#define led_15_on  PORTF=PORTF|0b00100000
;#define led_15_off PORTF=PORTF&0b11011111
;#define led_16_on  PORTF=PORTF|0b00001000
;#define led_16_off PORTF=PORTF&0b11110111
;#define led_17_on  PORTF=PORTF|0b00000010
;#define led_17_off PORTF=PORTF&0b11111101
;#define led_18_on  PORTF=PORTF|0b01000000
;#define led_18_off PORTF=PORTF&0b10111111
;#define led_19_on  PORTF=PORTF|0b00000001
;#define led_19_off PORTF=PORTF&0b11111110
;#define led_20_on  PORTF=PORTF|0b00000100
;#define led_20_off PORTF=PORTF&0b11111011
;#define led_calibration_on  PORTA.2=1
;#define led_calibration_off PORTA.2=0
;#define led_warning_on  PORTF=PORTF|0b00010000
;#define led_warning_off PORTF=PORTF&0b11101111
;#define key PINC.5
;#define eeAddressSKZ1H 0x0400
;#define eeAddressSKZ1L 0x0401
;#define eeAddressSKZ2H 0x0402
;#define eeAddressSKZ2L 0x0403
;#define eeAddressSKZ1toSKZ2 0x0404
;#define eeAdrSKZ1ar 0x0405
;#define eeAdrSKZ2ar 0x042C
;#define eeAddrCalibrFlag 0x04ff
;#define eeAddressModBusAddr 0x0600
;#define eeAddressAverTimeV 0x0601
;#define eeAddressFreqQ 0x0602
;#define eeAddressMINSKZH 0x0603
;#define eeAddressMINSKZL 0x0604
;#define eeAddressFirstFreq 0x0605
;#define eeAddressMINOPLH 0x0606
;#define eeAddressMINOPLL 0x0607
;#define AvTimer_on {TCCR3A=0x00;TCCR3B=0x04;TCNT3H=0x81;TCNT3L=0x0B;ETIMSK=0x04;}
;#define AvTimer_off {TCCR3A=0x00;TCCR3B=0x00;TCNT3H=0x00;TCNT3L=0x00;ETIMSK=0x00;}
;#define ClearBuf_slave {rx_buffer_slave[0]=0;rx_buffer_slave[1]=0;rx_buffer_slave[2]=0;rx_buffer_slave[3]=0;rx_buffer_sl ...
;#define ClearBuf_master{rx_buffer_master[0]=0;rx_buffer_master[1]=0;rx_buffer_master[2]=0;rx_buffer_master[3]=0;rx_buffe ...
;#define send_save_frq  {crc_master=0xFFFF;mov_buf_master(0x01);mov_buf_master(0x04);mov_buf_master(0x00);mov_buf_master( ...
;//#define send_test  {crc_master=0xFFFF;mov_buf_master(0x01);mov_buf_master(0x0C);mov_buf_master(0x01);mov_buf_master(0x ...
;#define send_read_valskz  {crc_master=0xFFFF;mov_buf_master(0x01);mov_buf_master(0x04);mov_buf_master(0x00);mov_buf_mast ...
;#define send_read_skz  {crc_master=0xFFFF;mov_buf_master(0x01);mov_buf_master(0x04);mov_buf_master(0x00);mov_buf_master( ...
;#define send_read_object_state  {crc_master=0xFFFF;mov_buf_master(0x01);mov_buf_master(0x04);mov_buf_master(0x00);mov_bu ...
;#define send_read_skzrel  {crc_master=0xFFFF;mov_buf_master(0x01);mov_buf_master(0x04);mov_buf_master(0x00);mov_buf_mast ...
;#define send_save_skz1 {crc_master=0xFFFF;mov_buf_master(0x01);mov_buf_master(0x06);mov_buf_master(0x00);mov_buf_master( ...
;#define send_save_skz2 {crc_master=0xFFFF;mov_buf_master(0x01);mov_buf_master(0x06);mov_buf_master(0x00);mov_buf_master( ...
;#define send_read_skz1 {crc_master=0xFFFF;mov_buf_master(0x01);mov_buf_master(0x04);mov_buf_master(0x00);mov_buf_master( ...
;#define send_read_skz2 {crc_master=0xFFFF;mov_buf_master(0x01);mov_buf_master(0x04);mov_buf_master(0x00);mov_buf_master( ...
;//#define send_read_skz1  {crc_slave=0xFFFF;mov_buf_slave(0x01);mov_buf_slave(0x04);mov_buf_slave(0x00);mov_buf_slave(0x ...
;#define whait_read {/*delay_ms(65);*/TCNT1=0x0000;TCCR1B=0x03;/*8000000/8==1us*65535=65ms*/while ((TIFR&0b00000100)==0); ...
;#define BPS_link_failed {led_20_on;led_19_on;led_18_on;}
;#define Object_disabled {led_20_on;led_19_on;led_18_on;}
;#define BPS_link_ok{led_20_off;led_19_off;led_18_off;}
;#define Object_enabled {led_20_off;led_19_off;led_18_off;}
;#define Led_Intro1_on {led_10_on;led_09_on;led_08_on;led_07_on;led_06_on;led_05_on;led_04_on;led_03_on;led_02_on;led_01_ ...
;#define Led_Intro2_on {led_warning_on;led_calibration_on;led_20_on;led_19_on;led_18_on;led_17_on;led_16_on;led_15_on;led ...
;#define Led_Intro2_off {led_warning_off;led_calibration_off;led_20_off;led_19_off;led_18_off;led_17_off;led_16_off;led_1 ...
;
;//#define DeviceID1 0x9191
;//#define DevID 0x9191
;
;// //--------------------------------------//
;// USART1 Receiver interrupt service routine
;//--------------------------------------//
;#define RX_BUFFER_SIZE 128
;#define TX_BUFFER_SIZE 128
;//flash unsigned char APP_READY                                  @0xEFF0;
;signed int LedQ=0,rms=0;
;unsigned int SKZ_1,SKZ_2,SKZ1toSKZ2,SKZ_read,intro_cntr=0,intro_enabled=1,true_skz=0;

	.DSEG
;int terminal_mode=0,BPS_absent=0,PC_absent=0,w=0,rms_read=0,bps_absent_ctr=0;
;void mov_buf_slave(char a);
;void crc_end_slave();
;void send_test();
;void eeprom_reset();
;void EEPROM_write(unsigned int eeAddress, unsigned char eeData);
;char rx_buffer_master[RX_BUFFER_SIZE],rd_counts=0, CalibrFlag=0, r=0,object_state=1,SPI_tEnd=1;
;unsigned int ModBusAddress=1,minimal_SKZ_val=30, minimal_object_enabled_level=40;
;unsigned char rx_wr_index_master,rx_counter_master,mod_time_master,CRCHigh,CRCLow,reg91_answer;
;int crc_master,crc_slave,rd_counter=0,AverTime_Value=30,AvTimer=0,start_calibration=0,finish_calibration=0,calibration_c ...
;bit tx_en_master,rx_m_master,rx_c_master,new_message,BKI_state_sent=0,ProcessingEEPROM=0;
;char str[15];
;void GetCRC16(char len);
;void CRC_update(unsigned char d);
;unsigned char tx_buffer_counter_master,tx_buffer_counter_slave,adres,FreqOrder_read;
;unsigned char i,drebezg;
;float data[4];
;signed char RecievedData[5],RecievedData5[6],AverSKZprcnt=0;
;unsigned int /*ModBusAddress=1,*/BlinkCounter_Calibration=0,tok;
;int warning_flag=0, FrequencyQ=3, ModbusMessage=0;
;int blink_flag=0,red=0,calibration_correct=1;
;int warning_flag_=0;
;float ii;
;unsigned long adc_buf;
;bit press,first_press,second_press,AverTime_Flag=0, SendSKZsave_req=0;
;unsigned int reg[40];
;signed long SKZread_counter=0;
; static int DeviceID=0x3491;// ID устройства, адрес 0х96, возможно только чтение, хранится версия, тип прошивки, тип уст ...
;static int crctable[256]= {
;	0x0000, 0xC1C0, 0x81C1, 0x4001, 0x01C3, 0xC003, 0x8002, 0x41C2, 0x01C6, 0xC006,
;	0x8007, 0x41C7, 0x0005, 0xC1C5, 0x81C4, 0x4004, 0x01CC, 0xC00C, 0x800D, 0x41CD,
;	0x000F, 0xC1CF, 0x81CE, 0x400E, 0x000A, 0xC1CA, 0x81CB, 0x400B, 0x01C9, 0xC009,
;	0x8008, 0x41C8, 0x01D8, 0xC018, 0x8019, 0x41D9, 0x001B, 0xC1DB, 0x81DA, 0x401A,
;	0x001E, 0xC1DE, 0x81DF, 0x401F, 0x01DD, 0xC01D, 0x801C, 0x41DC, 0x0014, 0xC1D4,
;	0x81D5, 0x4015, 0x01D7, 0xC017, 0x8016, 0x41D6, 0x01D2, 0xC012, 0x8013, 0x41D3,
;	0x0011, 0xC1D1, 0x81D0, 0x4010, 0x01F0, 0xC030, 0x8031, 0x41F1, 0x0033, 0xC1F3,
;	0x81F2, 0x4032, 0x0036, 0xC1F6, 0x81F7, 0x4037, 0x01F5, 0xC035, 0x8034, 0x41F4,
;	0x003C, 0xC1FC, 0x81FD, 0x403D, 0x01FF, 0xC03F, 0x803E, 0x41FE, 0x01FA, 0xC03A,
;	0x803B, 0x41FB, 0x0039, 0xC1F9, 0x81F8, 0x4038, 0x0028, 0xC1E8, 0x81E9, 0x4029,
;	0x01EB, 0xC02B, 0x802A, 0x41EA, 0x01EE, 0xC02E, 0x802F, 0x41EF, 0x002D, 0xC1ED,
;	0x81EC, 0x402C, 0x01E4, 0xC024, 0x8025, 0x41E5, 0x0027, 0xC1E7, 0x81E6, 0x4026,
;	0x0022, 0xC1E2, 0x81E3, 0x4023, 0x01E1, 0xC021, 0x8020, 0x41E0, 0x01A0, 0xC060,
;	0x8061, 0x41A1, 0x0063, 0xC1A3, 0x81A2, 0x4062, 0x0066, 0xC1A6, 0x81A7, 0x4067,
;	0x01A5, 0xC065, 0x8064, 0x41A4, 0x006C, 0xC1AC, 0x81AD, 0x406D, 0x01AF, 0xC06F,
;	0x806E, 0x41AE, 0x01AA, 0xC06A, 0x806B, 0x41AB, 0x0069, 0xC1A9, 0x81A8, 0x4068,
;	0x0078, 0xC1B8, 0x81B9, 0x4079, 0x01BB, 0xC07B, 0x807A, 0x41BA, 0x01BE, 0xC07E,
;	0x807F, 0x41BF, 0x007D, 0xC1BD, 0x81BC, 0x407C, 0x01B4, 0xC074, 0x8075, 0x41B5,
;	0x0077, 0xC1B7, 0x81B6, 0x4076, 0x0072, 0xC1B2, 0x81B3, 0x4073, 0x01B1, 0xC071,
;	0x8070, 0x41B0, 0x0050, 0xC190, 0x8191, 0x4051, 0x0193, 0xC053, 0x8052, 0x4192,
;	0x0196, 0xC056, 0x8057, 0x4197, 0x0055, 0xC195, 0x8194, 0x4054, 0x019C, 0xC05C,
;	0x805D, 0x419D, 0x005F, 0xC19F, 0x819E, 0x405E, 0x005A, 0xC19A, 0x819B, 0x405B,
;	0x0199, 0xC059, 0x8058, 0x4198, 0x0188, 0xC048, 0x8049, 0x4189, 0x004B, 0xC18B,
;	0x818A, 0x404A, 0x004E, 0xC18E, 0x818F, 0x404F, 0x018D, 0xC04D, 0x804C, 0x418C,
;	0x0044, 0xC184, 0x8185, 0x4045, 0x0187, 0xC047, 0x8046, 0x4186, 0x0182, 0xC042,
;	0x8043, 0x4183, 0x0041, 0xC181, 0x8180, 0x4040
;};
;
;
;
;interrupt [USART1_RXC] void usart1_rx_isr(void)
; 0000 00B9 	{

	.CSEG
_usart1_rx_isr:
; .FSTART _usart1_rx_isr
	ST   -Y,R26
	ST   -Y,R30
	ST   -Y,R31
	IN   R30,SREG
	ST   -Y,R30
; 0000 00BA 	char st,d;
; 0000 00BB 	st=UCSR1A;d=UDR1;
	ST   -Y,R17
	ST   -Y,R16
;	st -> R17
;	d -> R16
	LDS  R17,155
	LDS  R16,156
; 0000 00BC 	if ((tx_en_master==0)&&(rx_c_master==0))
	SBRC R2,0
	RJMP _0xF
	SBRS R2,2
	RJMP _0x10
_0xF:
	RJMP _0xE
_0x10:
; 0000 00BD 		{
; 0000 00BE 		if (mod_time_master==0){rx_m_master=1;rx_wr_index_master=0;}
	LDS  R30,_mod_time_master
	CPI  R30,0
	BRNE _0x11
	SET
	BLD  R2,1
	LDI  R30,LOW(0)
	STS  _rx_wr_index_master,R30
; 0000 00BF 		mod_time_master=200;
_0x11:
	LDI  R30,LOW(200)
	STS  _mod_time_master,R30
; 0000 00C0 		rx_buffer_master[rx_wr_index_master]=d;
	LDS  R30,_rx_wr_index_master
	LDI  R31,0
	SUBI R30,LOW(-_rx_buffer_master)
	SBCI R31,HIGH(-_rx_buffer_master)
	ST   Z,R16
; 0000 00C1 		if (++rx_wr_index_master >=RX_BUFFER_SIZE) rx_wr_index_master=0;
	LDS  R26,_rx_wr_index_master
	SUBI R26,-LOW(1)
	STS  _rx_wr_index_master,R26
	CPI  R26,LOW(0x80)
	BRLO _0x12
	LDI  R30,LOW(0)
	STS  _rx_wr_index_master,R30
; 0000 00C2 		if (++rx_counter_master >= RX_BUFFER_SIZE) rx_counter_master=0;
_0x12:
	LDS  R26,_rx_counter_master
	SUBI R26,-LOW(1)
	STS  _rx_counter_master,R26
	CPI  R26,LOW(0x80)
	BRLO _0x13
	LDI  R30,LOW(0)
	STS  _rx_counter_master,R30
; 0000 00C3 		}
_0x13:
; 0000 00C4 
; 0000 00C5 	}
_0xE:
	LD   R16,Y+
	LD   R17,Y+
	LD   R30,Y+
	OUT  SREG,R30
	LD   R31,Y+
	LD   R30,Y+
	LD   R26,Y+
	RETI
; .FEND
;//--------------------------------------//
;// USART0 Receiver interrupt service routine
;//--------------------------------------//
;char rx_buffer_slave[RX_BUFFER_SIZE], RData;
;unsigned char rx_wr_index_slave,rx_counter_slave,mod_time_slave;
;bit tx_en_slave,rx_m_slave,rx_c_slave;
;char tx_buffer_slave[TX_BUFFER_SIZE];
;unsigned char tx_buffer_begin_slave,tx_buffer_end_slave;
;interrupt [USART0_RXC] void usart0_rx_isr(void)
; 0000 00CF 	{
_usart0_rx_isr:
; .FSTART _usart0_rx_isr
	ST   -Y,R0
	ST   -Y,R1
	ST   -Y,R15
	ST   -Y,R22
	ST   -Y,R23
	ST   -Y,R24
	ST   -Y,R25
	ST   -Y,R26
	ST   -Y,R27
	ST   -Y,R30
	ST   -Y,R31
	IN   R30,SREG
	ST   -Y,R30
; 0000 00D0         char st,d;
; 0000 00D1         int ii = 0;
; 0000 00D2 
; 0000 00D3         //int w=0;
; 0000 00D4      #asm ("cli")
	CALL __SAVELOCR4
;	st -> R17
;	d -> R16
;	ii -> R18,R19
	__GETWRN 18,19,0
	cli
; 0000 00D5 	st=UCSR0A;d=UDR0;//TX_slave_off;
	IN   R17,11
	IN   R16,12
; 0000 00D6      #asm ("sei")
	sei
; 0000 00D7     if(rx_counter_slave==0)rd_counts=0;
	LDS  R30,_rx_counter_slave
	CPI  R30,0
	BRNE _0x14
	LDI  R30,LOW(0)
	STS  _rd_counts,R30
; 0000 00D8 	 transmitter_off;
_0x14:
	LDI  R30,LOW(144)
	OUT  0xA,R30
; 0000 00D9 
; 0000 00DA 	if (tx_en_slave==0)//&&(rx_c_slave==0))   //rx_c_slave- конец модбас сообщения
	SBRC R3,3
	RJMP _0x15
; 0000 00DB 		{
; 0000 00DC 		if (mod_time_slave==0){rx_m_slave=1;rx_wr_index_slave=0;rd_counts=0;} //rx_m_slave = идет процесс приема сообщения мод ...
	LDS  R30,_mod_time_slave
	CPI  R30,0
	BRNE _0x16
	SET
	BLD  R3,4
	LDI  R30,LOW(0)
	STS  _rx_wr_index_slave,R30
	STS  _rd_counts,R30
; 0000 00DD 		mod_time_slave=14;
_0x16:
	LDI  R30,LOW(14)
	STS  _mod_time_slave,R30
; 0000 00DE         rd_counts++;
	LDS  R30,_rd_counts
	SUBI R30,-LOW(1)
	STS  _rd_counts,R30
; 0000 00DF 		rx_buffer_slave[rx_wr_index_slave]=d;
	LDS  R30,_rx_wr_index_slave
	LDI  R31,0
	SUBI R30,LOW(-_rx_buffer_slave)
	SBCI R31,HIGH(-_rx_buffer_slave)
	ST   Z,R16
; 0000 00E0 
; 0000 00E1                 if (++rx_wr_index_slave >=RX_BUFFER_SIZE) rx_wr_index_slave=0;
	LDS  R26,_rx_wr_index_slave
	SUBI R26,-LOW(1)
	STS  _rx_wr_index_slave,R26
	CPI  R26,LOW(0x80)
	BRLO _0x17
	LDI  R30,LOW(0)
	STS  _rx_wr_index_slave,R30
; 0000 00E2                 if (++rx_counter_slave >= RX_BUFFER_SIZE) rx_counter_slave=0;
_0x17:
	LDS  R26,_rx_counter_slave
	SUBI R26,-LOW(1)
	STS  _rx_counter_slave,R26
	CPI  R26,LOW(0x80)
	BRLO _0x18
	LDI  R30,LOW(0)
	STS  _rx_counter_slave,R30
; 0000 00E3 		}
_0x18:
; 0000 00E4 
; 0000 00E5 BKI_state_sent=0; new_message=1;RData=d;
_0x15:
	CLT
	BLD  R2,4
	SET
	BLD  R2,3
	STS  _RData,R16
; 0000 00E6 reg91_answer=(object_state|((!BPS_absent)<<5)|(red<<4)|((ProcessingEEPROM)<<3)|((red|ProcessingEEPROM)<<2)|((warning_fla ...
	LDS  R30,_BPS_absent
	LDS  R31,_BPS_absent+1
	CALL __LNEGW1
	SWAP R30
	ANDI R30,0xF0
	LSL  R30
	LDS  R26,_object_state
	OR   R30,R26
	MOV  R26,R30
	LDS  R30,_red
	SWAP R30
	ANDI R30,0xF0
	OR   R30,R26
	MOV  R0,R30
	LDI  R26,0
	SBRC R2,5
	LDI  R26,1
	MOV  R30,R26
	LSL  R30
	LSL  R30
	LSL  R30
	OR   R0,R30
	LDI  R30,0
	SBRC R2,5
	LDI  R30,1
	LDS  R26,_red
	OR   R30,R26
	LSL  R30
	LSL  R30
	OR   R0,R30
	LDS  R30,_blink_flag
	LDS  R31,_blink_flag+1
	CALL __LNEGW1
	LSL  R30
	LDS  R26,_warning_flag
	AND  R30,R26
	OR   R0,R30
	LDS  R30,_blink_flag
	LDS  R31,_blink_flag+1
	CALL __LNEGW1
	AND  R30,R26
	LDS  R26,_blink_flag
	OR   R30,R26
	OR   R30,R0
	STS  _reg91_answer,R30
; 0000 00E7 if(rd_counts==8){
	LDS  R26,_rd_counts
	CPI  R26,LOW(0x8)
	BREQ PC+2
	RJMP _0x19
; 0000 00E8 if(rx_buffer_slave[rx_wr_index_slave-8]==ModBusAddress&(rx_buffer_slave[rx_wr_index_slave-7]==0x06|rx_buffer_slave[rx_wr ...
	LDS  R30,_rx_wr_index_slave
	LDI  R31,0
	MOVW R22,R30
	SBIW R30,8
	SUBI R30,LOW(-_rx_buffer_slave)
	SBCI R31,HIGH(-_rx_buffer_slave)
	LD   R26,Z
	LDS  R30,_ModBusAddress
	LDS  R31,_ModBusAddress+1
	LDI  R27,0
	CALL __EQW12
	MOV  R1,R30
	MOVW R30,R22
	SBIW R30,7
	SUBI R30,LOW(-_rx_buffer_slave)
	SBCI R31,HIGH(-_rx_buffer_slave)
	LD   R26,Z
	LDI  R30,LOW(6)
	CALL __EQB12
	MOV  R0,R30
	MOVW R30,R22
	SBIW R30,7
	SUBI R30,LOW(-_rx_buffer_slave)
	SBCI R31,HIGH(-_rx_buffer_slave)
	LD   R26,Z
	LDI  R30,LOW(3)
	CALL __EQB12
	OR   R30,R0
	AND  R30,R1
	BRNE PC+2
	RJMP _0x1A
	LDI  R30,LOW(0)
	STS  _rx_counter_slave,R30
; 0000 00E9 if(rx_buffer_slave[rx_wr_index_slave-7]==0x06&rx_buffer_slave[rx_wr_index_slave-6]==0x00)
	LDS  R30,_rx_wr_index_slave
	LDI  R31,0
	MOVW R22,R30
	SBIW R30,7
	SUBI R30,LOW(-_rx_buffer_slave)
	SBCI R31,HIGH(-_rx_buffer_slave)
	LD   R26,Z
	LDI  R30,LOW(6)
	CALL __EQB12
	MOV  R0,R30
	MOVW R30,R22
	SBIW R30,6
	SUBI R30,LOW(-_rx_buffer_slave)
	SBCI R31,HIGH(-_rx_buffer_slave)
	LD   R26,Z
	LDI  R30,LOW(0)
	CALL __EQB12
	AND  R30,R0
	BRNE PC+2
	RJMP _0x1B
; 0000 00EA {
; 0000 00EB     if(rx_buffer_slave[rx_wr_index_slave-5]==0x91){start_calibration=(rx_buffer_slave[rx_wr_index_slave-3]&0x10)>>4;}
	LDS  R30,_rx_wr_index_slave
	LDI  R31,0
	SBIW R30,5
	SUBI R30,LOW(-_rx_buffer_slave)
	SBCI R31,HIGH(-_rx_buffer_slave)
	LD   R26,Z
	CPI  R26,LOW(0x91)
	BRNE _0x1C
	LDS  R30,_rx_wr_index_slave
	LDI  R31,0
	SBIW R30,3
	SUBI R30,LOW(-_rx_buffer_slave)
	SBCI R31,HIGH(-_rx_buffer_slave)
	LD   R30,Z
	LDI  R31,0
	ANDI R30,LOW(0x10)
	ANDI R31,HIGH(0x10)
	CALL __ASRW4
	STS  _start_calibration,R30
	STS  _start_calibration+1,R31
; 0000 00EC     if(rx_buffer_slave[rx_wr_index_slave-5]==0x92){AverTime_Value=rx_buffer_slave[rx_wr_index_slave-4]*30;if(AverTime_Va ...
_0x1C:
	LDS  R30,_rx_wr_index_slave
	LDI  R31,0
	SBIW R30,5
	SUBI R30,LOW(-_rx_buffer_slave)
	SBCI R31,HIGH(-_rx_buffer_slave)
	LD   R26,Z
	CPI  R26,LOW(0x92)
	BREQ PC+2
	RJMP _0x1D
	LDS  R30,_rx_wr_index_slave
	LDI  R31,0
	SBIW R30,4
	SUBI R30,LOW(-_rx_buffer_slave)
	SBCI R31,HIGH(-_rx_buffer_slave)
	LD   R26,Z
	LDI  R30,LOW(30)
	MUL  R30,R26
	MOVW R30,R0
	STS  _AverTime_Value,R30
	STS  _AverTime_Value+1,R31
	SBIW R30,0
	BRNE _0x1E
	LDI  R30,LOW(2)
	LDI  R31,HIGH(2)
	STS  _AverTime_Value,R30
	STS  _AverTime_Value+1,R31
_0x1E:
	LDS  R30,_rx_wr_index_slave
	LDI  R31,0
	SBIW R30,3
	SUBI R30,LOW(-_rx_buffer_slave)
	SBCI R31,HIGH(-_rx_buffer_slave)
	LD   R30,Z
	LDI  R31,0
	STS  _FrequencyQ,R30
	STS  _FrequencyQ+1,R31
	SET
	BLD  R3,1
	LDI  R30,LOW(0)
	STS  _AvTimer,R30
	STS  _AvTimer+1,R30
	STS  139,R30
	LDI  R30,LOW(4)
	STS  138,R30
	LDI  R30,LOW(129)
	STS  137,R30
	LDI  R30,LOW(11)
	STS  136,R30
	LDI  R30,LOW(4)
	STS  125,R30
	LDI  R30,LOW(0)
	STS  _SKZread_counter,R30
	STS  _SKZread_counter+1,R30
	STS  _SKZread_counter+2,R30
	STS  _SKZread_counter+3,R30
	LDI  R30,LOW(62)
	LDI  R31,HIGH(62)
	STS  _ModbusMessage,R30
	STS  _ModbusMessage+1,R31
; 0000 00ED     if(rx_buffer_slave[rx_wr_index_slave-5]==0x93){ModBusAddress=rx_buffer_slave[rx_wr_index_slave-3];ModbusMessage=63;}
_0x1D:
	LDS  R30,_rx_wr_index_slave
	LDI  R31,0
	SBIW R30,5
	SUBI R30,LOW(-_rx_buffer_slave)
	SBCI R31,HIGH(-_rx_buffer_slave)
	LD   R26,Z
	CPI  R26,LOW(0x93)
	BRNE _0x1F
	LDS  R30,_rx_wr_index_slave
	LDI  R31,0
	SBIW R30,3
	SUBI R30,LOW(-_rx_buffer_slave)
	SBCI R31,HIGH(-_rx_buffer_slave)
	LD   R30,Z
	LDI  R31,0
	STS  _ModBusAddress,R30
	STS  _ModBusAddress+1,R31
	LDI  R30,LOW(63)
	LDI  R31,HIGH(63)
	STS  _ModbusMessage,R30
	STS  _ModbusMessage+1,R31
; 0000 00EE     if(rx_buffer_slave[rx_wr_index_slave-5]==0x94){minimal_SKZ_val=(((unsigned int)rx_buffer_slave[rx_wr_index_slave-4]) ...
_0x1F:
	LDS  R30,_rx_wr_index_slave
	LDI  R31,0
	SBIW R30,5
	SUBI R30,LOW(-_rx_buffer_slave)
	SBCI R31,HIGH(-_rx_buffer_slave)
	LD   R26,Z
	CPI  R26,LOW(0x94)
	BRNE _0x20
	LDS  R30,_rx_wr_index_slave
	LDI  R31,0
	MOVW R0,R30
	SBIW R30,4
	SUBI R30,LOW(-_rx_buffer_slave)
	SBCI R31,HIGH(-_rx_buffer_slave)
	LD   R31,Z
	LDI  R30,LOW(0)
	MOVW R26,R30
	MOVW R30,R0
	SBIW R30,3
	SUBI R30,LOW(-_rx_buffer_slave)
	SBCI R31,HIGH(-_rx_buffer_slave)
	LD   R30,Z
	LDI  R31,0
	OR   R30,R26
	OR   R31,R27
	STS  _minimal_SKZ_val,R30
	STS  _minimal_SKZ_val+1,R31
	LDI  R30,LOW(64)
	LDI  R31,HIGH(64)
	STS  _ModbusMessage,R30
	STS  _ModbusMessage+1,R31
; 0000 00EF     if(rx_buffer_slave[rx_wr_index_slave-5]==0x95){minimal_object_enabled_level=0;minimal_object_enabled_level=(int)(((( ...
_0x20:
	LDS  R30,_rx_wr_index_slave
	LDI  R31,0
	SBIW R30,5
	SUBI R30,LOW(-_rx_buffer_slave)
	SBCI R31,HIGH(-_rx_buffer_slave)
	LD   R26,Z
	CPI  R26,LOW(0x95)
	BRNE _0x21
	LDI  R30,LOW(0)
	STS  _minimal_object_enabled_level,R30
	STS  _minimal_object_enabled_level+1,R30
	LDS  R30,_rx_wr_index_slave
	LDI  R31,0
	MOVW R0,R30
	SBIW R30,4
	SUBI R30,LOW(-_rx_buffer_slave)
	SBCI R31,HIGH(-_rx_buffer_slave)
	LD   R31,Z
	LDI  R30,LOW(0)
	MOVW R26,R30
	MOVW R30,R0
	SBIW R30,3
	SUBI R30,LOW(-_rx_buffer_slave)
	SBCI R31,HIGH(-_rx_buffer_slave)
	LD   R30,Z
	LDI  R31,0
	OR   R30,R26
	OR   R31,R27
	STS  _minimal_object_enabled_level,R30
	STS  _minimal_object_enabled_level+1,R31
	LDI  R30,LOW(65)
	LDI  R31,HIGH(65)
	STS  _ModbusMessage,R30
	STS  _ModbusMessage+1,R31
; 0000 00F0     if(rx_buffer_slave[rx_wr_index_slave-5]==0xAC)
_0x21:
	LDS  R30,_rx_wr_index_slave
	LDI  R31,0
	SBIW R30,5
	SUBI R30,LOW(-_rx_buffer_slave)
	SBCI R31,HIGH(-_rx_buffer_slave)
	LD   R26,Z
	CPI  R26,LOW(0xAC)
	BRNE _0x22
; 0000 00F1     {
; 0000 00F2     flash_erase_flag = 1;
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	STS  _flash_erase_flag,R30
	STS  _flash_erase_flag+1,R31
; 0000 00F3     //for(ii=0x0400;ii<0x0600;ii++)EEPROM_write(ii,0xff);
; 0000 00F4     }
; 0000 00F5     CRCHigh=0xff;
_0x22:
	LDI  R30,LOW(255)
	STS  _CRCHigh,R30
; 0000 00F6     CRCLow=0xff;
	STS  _CRCLow,R30
; 0000 00F7     for (r=0;r<6;r++)
	LDI  R30,LOW(0)
	STS  _r,R30
_0x24:
	LDS  R26,_r
	CPI  R26,LOW(0x6)
	BRSH _0x25
; 0000 00F8         {
; 0000 00F9         //#asm("cli");
; 0000 00FA         CRC_update(rx_buffer_slave[r]);
	LDS  R30,_r
	LDI  R31,0
	SUBI R30,LOW(-_rx_buffer_slave)
	SBCI R31,HIGH(-_rx_buffer_slave)
	LD   R26,Z
	CALL _CRC_update
; 0000 00FB         //tx_buffer_counter_slave++;	        //
; 0000 00FC         tx_buffer_slave[tx_buffer_end_slave]=rx_buffer_slave[r]; //
	LDS  R26,_tx_buffer_end_slave
	LDI  R27,0
	SUBI R26,LOW(-_tx_buffer_slave)
	SBCI R27,HIGH(-_tx_buffer_slave)
	LDS  R30,_r
	LDI  R31,0
	SUBI R30,LOW(-_rx_buffer_slave)
	SBCI R31,HIGH(-_rx_buffer_slave)
	LD   R30,Z
	ST   X,R30
; 0000 00FD         if (++tx_buffer_end_slave==TX_BUFFER_SIZE) tx_buffer_end_slave=0;//
	LDS  R26,_tx_buffer_end_slave
	SUBI R26,-LOW(1)
	STS  _tx_buffer_end_slave,R26
	CPI  R26,LOW(0x80)
	BRNE _0x26
	LDI  R30,LOW(0)
	STS  _tx_buffer_end_slave,R30
; 0000 00FE         //#asm("sei");
; 0000 00FF         }
_0x26:
	LDS  R30,_r
	SUBI R30,-LOW(1)
	STS  _r,R30
	RJMP _0x24
_0x25:
; 0000 0100     crc_slave=((unsigned int)CRCLow<<8)|CRCHigh;
	LDS  R27,_CRCLow
	LDI  R26,LOW(0)
	LDS  R30,_CRCHigh
	LDI  R31,0
	OR   R30,R26
	OR   R31,R27
	STS  _crc_slave,R30
	STS  _crc_slave+1,R31
; 0000 0101          //   tx_buffer_counter_slave++;
; 0000 0102         // #asm("cli");           //
; 0000 0103         tx_buffer_slave[tx_buffer_end_slave]=crc_slave; //
	LDS  R30,_tx_buffer_end_slave
	LDI  R31,0
	SUBI R30,LOW(-_tx_buffer_slave)
	SBCI R31,HIGH(-_tx_buffer_slave)
	LDS  R26,_crc_slave
	STD  Z+0,R26
; 0000 0104         if (++tx_buffer_end_slave==TX_BUFFER_SIZE) tx_buffer_end_slave=0;
	LDS  R26,_tx_buffer_end_slave
	SUBI R26,-LOW(1)
	STS  _tx_buffer_end_slave,R26
	CPI  R26,LOW(0x80)
	BRNE _0x27
	LDI  R30,LOW(0)
	STS  _tx_buffer_end_slave,R30
; 0000 0105         //    tx_buffer_counter_slave++;	        //
; 0000 0106         tx_buffer_slave[tx_buffer_end_slave]=(crc_slave>>8); //
_0x27:
	LDS  R26,_tx_buffer_end_slave
	LDI  R27,0
	SUBI R26,LOW(-_tx_buffer_slave)
	SBCI R27,HIGH(-_tx_buffer_slave)
	LDS  R30,_crc_slave
	LDS  R31,_crc_slave+1
	CALL __ASRW8
	ST   X,R30
; 0000 0107         if (++tx_buffer_end_slave==TX_BUFFER_SIZE) tx_buffer_end_slave=0;
	LDS  R26,_tx_buffer_end_slave
	SUBI R26,-LOW(1)
	STS  _tx_buffer_end_slave,R26
	CPI  R26,LOW(0x80)
	BRNE _0x28
	LDI  R30,LOW(0)
	STS  _tx_buffer_end_slave,R30
; 0000 0108         TX_slave_on;                            //
_0x28:
	SBI  0x3,2
; 0000 0109         tx_en_slave=1;crc_slave=0xffff;transmitter_on;
	SET
	BLD  R3,3
	LDI  R30,LOW(65535)
	LDI  R31,HIGH(65535)
	STS  _crc_slave,R30
	STS  _crc_slave+1,R31
	LDI  R30,LOW(216)
	OUT  0xA,R30
; 0000 010A         #asm("cli");
	cli
; 0000 010B             UDR0=tx_buffer_slave[tx_buffer_begin_slave];
	LDS  R30,_tx_buffer_begin_slave
	LDI  R31,0
	SUBI R30,LOW(-_tx_buffer_slave)
	SBCI R31,HIGH(-_tx_buffer_slave)
	LD   R30,Z
	OUT  0xC,R30
; 0000 010C         #asm("sei");
	sei
; 0000 010D     //rx_c_slave=0;rx_m_slave=0;rx_wr_index_slave=0;rx_counter_slave=0;
; 0000 010E }
; 0000 010F if(rx_buffer_slave[rx_wr_index_slave-7]==0x03&rx_buffer_slave[rx_wr_index_slave-6]==0x00&rx_buffer_slave[rx_wr_index_sla ...
_0x1B:
	LDS  R30,_rx_wr_index_slave
	LDI  R31,0
	MOVW R22,R30
	SBIW R30,7
	SUBI R30,LOW(-_rx_buffer_slave)
	SBCI R31,HIGH(-_rx_buffer_slave)
	LD   R26,Z
	LDI  R30,LOW(3)
	CALL __EQB12
	MOV  R0,R30
	MOVW R30,R22
	SBIW R30,6
	SUBI R30,LOW(-_rx_buffer_slave)
	SBCI R31,HIGH(-_rx_buffer_slave)
	LD   R26,Z
	LDI  R30,LOW(0)
	CALL __EQB12
	AND  R0,R30
	MOVW R30,R22
	SBIW R30,4
	SUBI R30,LOW(-_rx_buffer_slave)
	SBCI R31,HIGH(-_rx_buffer_slave)
	LD   R26,Z
	LDI  R30,LOW(0)
	CALL __EQB12
	AND  R0,R30
	MOVW R30,R22
	SBIW R30,3
	SUBI R30,LOW(-_rx_buffer_slave)
	SBCI R31,HIGH(-_rx_buffer_slave)
	LD   R26,Z
	LDI  R30,LOW(1)
	CALL __EQB12
	AND  R30,R0
	BRNE PC+2
	RJMP _0x29
; 0000 0110 if(rx_buffer_slave[rx_wr_index_slave-5]==0x90){rx_buffer_slave[rx_wr_index_slave-6]=0x02;rx_buffer_slave[rx_wr_index_sla ...
	LDS  R30,_rx_wr_index_slave
	LDI  R31,0
	SBIW R30,5
	SUBI R30,LOW(-_rx_buffer_slave)
	SBCI R31,HIGH(-_rx_buffer_slave)
	LD   R26,Z
	CPI  R26,LOW(0x90)
	BRNE _0x2A
	LDS  R30,_rx_wr_index_slave
	LDI  R31,0
	SBIW R30,6
	SUBI R30,LOW(-_rx_buffer_slave)
	SBCI R31,HIGH(-_rx_buffer_slave)
	LDI  R26,LOW(2)
	STD  Z+0,R26
	LDS  R30,_rx_wr_index_slave
	LDI  R31,0
	SBIW R30,5
	SUBI R30,LOW(-_rx_buffer_slave)
	SBCI R31,HIGH(-_rx_buffer_slave)
	LDS  R26,_AverSKZprcnt
	STD  Z+0,R26
	LDS  R30,_rx_wr_index_slave
	LDI  R31,0
	SBIW R30,4
	SUBI R30,LOW(-_rx_buffer_slave)
	SBCI R31,HIGH(-_rx_buffer_slave)
	ST   Z,R4
; 0000 0111 if(rx_buffer_slave[rx_wr_index_slave-5]==0x91){rx_buffer_slave[rx_wr_index_slave-6]=0x02;rx_buffer_slave[rx_wr_index_sla ...
_0x2A:
	LDS  R30,_rx_wr_index_slave
	LDI  R31,0
	SBIW R30,5
	SUBI R30,LOW(-_rx_buffer_slave)
	SBCI R31,HIGH(-_rx_buffer_slave)
	LD   R26,Z
	CPI  R26,LOW(0x91)
	BRNE _0x2B
	LDS  R30,_rx_wr_index_slave
	LDI  R31,0
	SBIW R30,6
	SUBI R30,LOW(-_rx_buffer_slave)
	SBCI R31,HIGH(-_rx_buffer_slave)
	LDI  R26,LOW(2)
	STD  Z+0,R26
	LDS  R30,_rx_wr_index_slave
	LDI  R31,0
	SBIW R30,5
	SUBI R30,LOW(-_rx_buffer_slave)
	SBCI R31,HIGH(-_rx_buffer_slave)
	MOVW R0,R30
	LDS  R30,_warning_flag
	LDS  R31,_warning_flag+1
	CALL __LNEGW1
	LSL  R30
	LDS  R26,_blink_flag
	OR   R30,R26
	MOV  R26,R30
	LDS  R30,_warning_flag
	LDS  R31,_warning_flag+1
	CALL __LNEGW1
	OR   R30,R26
	MOVW R26,R0
	ST   X,R30
	LDS  R30,_rx_wr_index_slave
	LDI  R31,0
	SBIW R30,4
	SUBI R30,LOW(-_rx_buffer_slave)
	SBCI R31,HIGH(-_rx_buffer_slave)
	LDS  R26,_reg91_answer
	STD  Z+0,R26
	SET
	BLD  R2,4
; 0000 0112 if(rx_buffer_slave[rx_wr_index_slave-5]==0x92){rx_buffer_slave[rx_wr_index_slave-6]=0x02;rx_buffer_slave[rx_wr_index_sla ...
_0x2B:
	LDS  R30,_rx_wr_index_slave
	LDI  R31,0
	SBIW R30,5
	SUBI R30,LOW(-_rx_buffer_slave)
	SBCI R31,HIGH(-_rx_buffer_slave)
	LD   R26,Z
	CPI  R26,LOW(0x92)
	BRNE _0x2C
	LDS  R30,_rx_wr_index_slave
	LDI  R31,0
	SBIW R30,6
	SUBI R30,LOW(-_rx_buffer_slave)
	SBCI R31,HIGH(-_rx_buffer_slave)
	LDI  R26,LOW(2)
	STD  Z+0,R26
	LDS  R30,_rx_wr_index_slave
	LDI  R31,0
	SBIW R30,5
	SUBI R30,LOW(-_rx_buffer_slave)
	SBCI R31,HIGH(-_rx_buffer_slave)
	MOVW R22,R30
	LDS  R26,_AverTime_Value
	LDS  R27,_AverTime_Value+1
	LDI  R30,LOW(30)
	LDI  R31,HIGH(30)
	CALL __DIVW21
	MOVW R26,R22
	ST   X,R30
	LDS  R30,_rx_wr_index_slave
	LDI  R31,0
	SBIW R30,4
	SUBI R30,LOW(-_rx_buffer_slave)
	SBCI R31,HIGH(-_rx_buffer_slave)
	LDS  R26,_FrequencyQ
	STD  Z+0,R26
; 0000 0113 if(rx_buffer_slave[rx_wr_index_slave-5]==0x93){rx_buffer_slave[rx_wr_index_slave-6]=0x02;rx_buffer_slave[rx_wr_index_sla ...
_0x2C:
	LDS  R30,_rx_wr_index_slave
	LDI  R31,0
	SBIW R30,5
	SUBI R30,LOW(-_rx_buffer_slave)
	SBCI R31,HIGH(-_rx_buffer_slave)
	LD   R26,Z
	CPI  R26,LOW(0x93)
	BRNE _0x2D
	LDS  R30,_rx_wr_index_slave
	LDI  R31,0
	SBIW R30,6
	SUBI R30,LOW(-_rx_buffer_slave)
	SBCI R31,HIGH(-_rx_buffer_slave)
	LDI  R26,LOW(2)
	STD  Z+0,R26
	LDS  R30,_rx_wr_index_slave
	LDI  R31,0
	SBIW R30,5
	SUBI R30,LOW(-_rx_buffer_slave)
	SBCI R31,HIGH(-_rx_buffer_slave)
	LDI  R26,LOW(0)
	STD  Z+0,R26
	LDS  R30,_rx_wr_index_slave
	LDI  R31,0
	SBIW R30,4
	SUBI R30,LOW(-_rx_buffer_slave)
	SBCI R31,HIGH(-_rx_buffer_slave)
	LDS  R26,_ModBusAddress
	STD  Z+0,R26
; 0000 0114 if(rx_buffer_slave[rx_wr_index_slave-5]==0x94){rx_buffer_slave[rx_wr_index_slave-6]=0x02;rx_buffer_slave[rx_wr_index_sla ...
_0x2D:
	LDS  R30,_rx_wr_index_slave
	LDI  R31,0
	SBIW R30,5
	SUBI R30,LOW(-_rx_buffer_slave)
	SBCI R31,HIGH(-_rx_buffer_slave)
	LD   R26,Z
	CPI  R26,LOW(0x94)
	BRNE _0x2E
	LDS  R30,_rx_wr_index_slave
	LDI  R31,0
	SBIW R30,6
	SUBI R30,LOW(-_rx_buffer_slave)
	SBCI R31,HIGH(-_rx_buffer_slave)
	LDI  R26,LOW(2)
	STD  Z+0,R26
	LDS  R30,_rx_wr_index_slave
	LDI  R31,0
	SBIW R30,5
	SUBI R30,LOW(-_rx_buffer_slave)
	SBCI R31,HIGH(-_rx_buffer_slave)
	MOVW R26,R30
	LDS  R30,_minimal_SKZ_val+1
	ST   X,R30
	LDS  R30,_rx_wr_index_slave
	LDI  R31,0
	SBIW R30,4
	SUBI R30,LOW(-_rx_buffer_slave)
	SBCI R31,HIGH(-_rx_buffer_slave)
	LDS  R26,_minimal_SKZ_val
	STD  Z+0,R26
; 0000 0115 if(rx_buffer_slave[rx_wr_index_slave-5]==0x95){rx_buffer_slave[rx_wr_index_slave-6]=0x02;rx_buffer_slave[rx_wr_index_sla ...
_0x2E:
	LDS  R30,_rx_wr_index_slave
	LDI  R31,0
	SBIW R30,5
	SUBI R30,LOW(-_rx_buffer_slave)
	SBCI R31,HIGH(-_rx_buffer_slave)
	LD   R26,Z
	CPI  R26,LOW(0x95)
	BRNE _0x2F
	LDS  R30,_rx_wr_index_slave
	LDI  R31,0
	SBIW R30,6
	SUBI R30,LOW(-_rx_buffer_slave)
	SBCI R31,HIGH(-_rx_buffer_slave)
	LDI  R26,LOW(2)
	STD  Z+0,R26
	LDS  R30,_rx_wr_index_slave
	LDI  R31,0
	SBIW R30,5
	SUBI R30,LOW(-_rx_buffer_slave)
	SBCI R31,HIGH(-_rx_buffer_slave)
	MOVW R26,R30
	LDS  R30,_minimal_object_enabled_level+1
	ST   X,R30
	LDS  R30,_rx_wr_index_slave
	LDI  R31,0
	SBIW R30,4
	SUBI R30,LOW(-_rx_buffer_slave)
	SBCI R31,HIGH(-_rx_buffer_slave)
	LDS  R26,_minimal_object_enabled_level
	STD  Z+0,R26
; 0000 0116 if(rx_buffer_slave[rx_wr_index_slave-5]==0x96){rx_buffer_slave[rx_wr_index_slave-6]=0x02;rx_buffer_slave[rx_wr_index_sla ...
_0x2F:
	LDS  R30,_rx_wr_index_slave
	LDI  R31,0
	SBIW R30,5
	SUBI R30,LOW(-_rx_buffer_slave)
	SBCI R31,HIGH(-_rx_buffer_slave)
	LD   R26,Z
	CPI  R26,LOW(0x96)
	BRNE _0x30
	LDS  R30,_rx_wr_index_slave
	LDI  R31,0
	SBIW R30,6
	SUBI R30,LOW(-_rx_buffer_slave)
	SBCI R31,HIGH(-_rx_buffer_slave)
	LDI  R26,LOW(2)
	STD  Z+0,R26
	LDS  R30,_rx_wr_index_slave
	LDI  R31,0
	SBIW R30,5
	SUBI R30,LOW(-_rx_buffer_slave)
	SBCI R31,HIGH(-_rx_buffer_slave)
	LDI  R26,LOW(0)
	STD  Z+0,R26
	LDS  R30,_rx_wr_index_slave
	LDI  R31,0
	SBIW R30,4
	SUBI R30,LOW(-_rx_buffer_slave)
	SBCI R31,HIGH(-_rx_buffer_slave)
	LDS  R26,_DeviceID_G000
	STD  Z+0,R26
; 0000 0117 if(rx_buffer_slave[rx_wr_index_slave-5]==0x97){rx_buffer_slave[rx_wr_index_slave-6]=0x02;rx_buffer_slave[rx_wr_index_sla ...
_0x30:
	LDS  R30,_rx_wr_index_slave
	LDI  R31,0
	SBIW R30,5
	SUBI R30,LOW(-_rx_buffer_slave)
	SBCI R31,HIGH(-_rx_buffer_slave)
	LD   R26,Z
	CPI  R26,LOW(0x97)
	BRNE _0x31
	LDS  R30,_rx_wr_index_slave
	LDI  R31,0
	SBIW R30,6
	SUBI R30,LOW(-_rx_buffer_slave)
	SBCI R31,HIGH(-_rx_buffer_slave)
	LDI  R26,LOW(2)
	STD  Z+0,R26
	LDS  R30,_rx_wr_index_slave
	LDI  R31,0
	SBIW R30,5
	SUBI R30,LOW(-_rx_buffer_slave)
	SBCI R31,HIGH(-_rx_buffer_slave)
	MOVW R22,R30
	LDS  R26,_AverSKZ_Value
	LDI  R30,LOW(8)
	CALL __LSRB12
	MOVW R26,R22
	ST   X,R30
	LDS  R30,_rx_wr_index_slave
	LDI  R31,0
	SBIW R30,4
	SUBI R30,LOW(-_rx_buffer_slave)
	SBCI R31,HIGH(-_rx_buffer_slave)
	LDS  R26,_AverSKZ_Value
	STD  Z+0,R26
; 0000 0118 if(rx_buffer_slave[rx_wr_index_slave-5]==0x98){rx_buffer_slave[rx_wr_index_slave-6]=0x02;rx_buffer_slave[rx_wr_index_sla ...
_0x31:
	LDS  R30,_rx_wr_index_slave
	LDI  R31,0
	SBIW R30,5
	SUBI R30,LOW(-_rx_buffer_slave)
	SBCI R31,HIGH(-_rx_buffer_slave)
	LD   R26,Z
	CPI  R26,LOW(0x98)
	BRNE _0x32
	LDS  R30,_rx_wr_index_slave
	LDI  R31,0
	SBIW R30,6
	SUBI R30,LOW(-_rx_buffer_slave)
	SBCI R31,HIGH(-_rx_buffer_slave)
	LDI  R26,LOW(2)
	STD  Z+0,R26
	LDS  R30,_rx_wr_index_slave
	LDI  R31,0
	SBIW R30,5
	SUBI R30,LOW(-_rx_buffer_slave)
	SBCI R31,HIGH(-_rx_buffer_slave)
	MOVW R26,R30
	LDS  R30,_true_skz+1
	ST   X,R30
	LDS  R30,_rx_wr_index_slave
	LDI  R31,0
	SBIW R30,4
	SUBI R30,LOW(-_rx_buffer_slave)
	SBCI R31,HIGH(-_rx_buffer_slave)
	LDS  R26,_true_skz
	STD  Z+0,R26
; 0000 0119 if(rx_buffer_slave[rx_wr_index_slave-5]==0x99){rx_buffer_slave[rx_wr_index_slave-6]=0x02;rx_buffer_slave[rx_wr_index_sla ...
_0x32:
	LDS  R30,_rx_wr_index_slave
	LDI  R31,0
	SBIW R30,5
	SUBI R30,LOW(-_rx_buffer_slave)
	SBCI R31,HIGH(-_rx_buffer_slave)
	LD   R26,Z
	CPI  R26,LOW(0x99)
	BRNE _0x33
	LDS  R30,_rx_wr_index_slave
	LDI  R31,0
	SBIW R30,6
	SUBI R30,LOW(-_rx_buffer_slave)
	SBCI R31,HIGH(-_rx_buffer_slave)
	LDI  R26,LOW(2)
	STD  Z+0,R26
	LDS  R30,_rx_wr_index_slave
	LDI  R31,0
	SBIW R30,5
	SUBI R30,LOW(-_rx_buffer_slave)
	SBCI R31,HIGH(-_rx_buffer_slave)
	ST   Z,R9
	LDS  R30,_rx_wr_index_slave
	LDI  R31,0
	SBIW R30,4
	SUBI R30,LOW(-_rx_buffer_slave)
	SBCI R31,HIGH(-_rx_buffer_slave)
	ST   Z,R8
; 0000 011A if(rx_buffer_slave[rx_wr_index_slave-5]==0x9a){rx_buffer_slave[rx_wr_index_slave-6]=0x02;rx_buffer_slave[rx_wr_index_sla ...
_0x33:
	LDS  R30,_rx_wr_index_slave
	LDI  R31,0
	SBIW R30,5
	SUBI R30,LOW(-_rx_buffer_slave)
	SBCI R31,HIGH(-_rx_buffer_slave)
	LD   R26,Z
	CPI  R26,LOW(0x9A)
	BRNE _0x34
	LDS  R30,_rx_wr_index_slave
	LDI  R31,0
	SBIW R30,6
	SUBI R30,LOW(-_rx_buffer_slave)
	SBCI R31,HIGH(-_rx_buffer_slave)
	LDI  R26,LOW(2)
	STD  Z+0,R26
	LDS  R30,_rx_wr_index_slave
	LDI  R31,0
	SBIW R30,5
	SUBI R30,LOW(-_rx_buffer_slave)
	SBCI R31,HIGH(-_rx_buffer_slave)
	ST   Z,R11
	LDS  R30,_rx_wr_index_slave
	LDI  R31,0
	SBIW R30,4
	SUBI R30,LOW(-_rx_buffer_slave)
	SBCI R31,HIGH(-_rx_buffer_slave)
	ST   Z,R10
; 0000 011B CRCHigh=0xff;
_0x34:
	LDI  R30,LOW(255)
	STS  _CRCHigh,R30
; 0000 011C CRCLow=0xff;
	STS  _CRCLow,R30
; 0000 011D for (r=0;r<5;r++)
	LDI  R30,LOW(0)
	STS  _r,R30
_0x36:
	LDS  R26,_r
	CPI  R26,LOW(0x5)
	BRSH _0x37
; 0000 011E {
; 0000 011F 	//#asm("cli");    		        //
; 0000 0120         CRC_update(rx_buffer_slave[r]);
	LDS  R30,_r
	LDI  R31,0
	SUBI R30,LOW(-_rx_buffer_slave)
	SBCI R31,HIGH(-_rx_buffer_slave)
	LD   R26,Z
	CALL _CRC_update
; 0000 0121 //	tx_buffer_counter_slave++;	        //
; 0000 0122 	tx_buffer_slave[tx_buffer_end_slave]=rx_buffer_slave[r]; //
	LDS  R26,_tx_buffer_end_slave
	LDI  R27,0
	SUBI R26,LOW(-_tx_buffer_slave)
	SBCI R27,HIGH(-_tx_buffer_slave)
	LDS  R30,_r
	LDI  R31,0
	SUBI R30,LOW(-_rx_buffer_slave)
	SBCI R31,HIGH(-_rx_buffer_slave)
	LD   R30,Z
	ST   X,R30
; 0000 0123 	if (++tx_buffer_end_slave==TX_BUFFER_SIZE) tx_buffer_end_slave=0;//
	LDS  R26,_tx_buffer_end_slave
	SUBI R26,-LOW(1)
	STS  _tx_buffer_end_slave,R26
	CPI  R26,LOW(0x80)
	BRNE _0x38
	LDI  R30,LOW(0)
	STS  _tx_buffer_end_slave,R30
; 0000 0124 //	#asm("sei");
; 0000 0125 }
_0x38:
	LDS  R30,_r
	SUBI R30,-LOW(1)
	STS  _r,R30
	RJMP _0x36
_0x37:
; 0000 0126 
; 0000 0127 crc_slave=((unsigned int)CRCLow<<8)|CRCHigh;
	LDS  R27,_CRCLow
	LDI  R26,LOW(0)
	LDS  R30,_CRCHigh
	LDI  R31,0
	OR   R30,R26
	OR   R31,R27
	STS  _crc_slave,R30
	STS  _crc_slave+1,R31
; 0000 0128    //     tx_buffer_counter_slave++;
; 0000 0129    //     #asm("cli");        //
; 0000 012A 	tx_buffer_slave[tx_buffer_end_slave]=crc_slave; //
	LDS  R30,_tx_buffer_end_slave
	LDI  R31,0
	SUBI R30,LOW(-_tx_buffer_slave)
	SBCI R31,HIGH(-_tx_buffer_slave)
	LDS  R26,_crc_slave
	STD  Z+0,R26
; 0000 012B 	if (++tx_buffer_end_slave==TX_BUFFER_SIZE) tx_buffer_end_slave=0;
	LDS  R26,_tx_buffer_end_slave
	SUBI R26,-LOW(1)
	STS  _tx_buffer_end_slave,R26
	CPI  R26,LOW(0x80)
	BRNE _0x39
	LDI  R30,LOW(0)
	STS  _tx_buffer_end_slave,R30
; 0000 012C     //    tx_buffer_counter_slave++;	        //
; 0000 012D 	tx_buffer_slave[tx_buffer_end_slave]=(crc_slave>>8); //
_0x39:
	LDS  R26,_tx_buffer_end_slave
	LDI  R27,0
	SUBI R26,LOW(-_tx_buffer_slave)
	SBCI R27,HIGH(-_tx_buffer_slave)
	LDS  R30,_crc_slave
	LDS  R31,_crc_slave+1
	CALL __ASRW8
	ST   X,R30
; 0000 012E 	if (++tx_buffer_end_slave==TX_BUFFER_SIZE) tx_buffer_end_slave=0;
	LDS  R26,_tx_buffer_end_slave
	SUBI R26,-LOW(1)
	STS  _tx_buffer_end_slave,R26
	CPI  R26,LOW(0x80)
	BRNE _0x3A
	LDI  R30,LOW(0)
	STS  _tx_buffer_end_slave,R30
; 0000 012F 	TX_slave_on;                            //
_0x3A:
	SBI  0x3,2
; 0000 0130     tx_en_slave=1;crc_slave=0xffff;transmitter_on;
	SET
	BLD  R3,3
	LDI  R30,LOW(65535)
	LDI  R31,HIGH(65535)
	STS  _crc_slave,R30
	STS  _crc_slave+1,R31
	LDI  R30,LOW(216)
	OUT  0xA,R30
; 0000 0131     #asm("cli");
	cli
; 0000 0132     UDR0=tx_buffer_slave[tx_buffer_begin_slave];
	LDS  R30,_tx_buffer_begin_slave
	LDI  R31,0
	SUBI R30,LOW(-_tx_buffer_slave)
	SBCI R31,HIGH(-_tx_buffer_slave)
	LD   R30,Z
	OUT  0xC,R30
; 0000 0133     #asm("sei");
	sei
; 0000 0134 //rx_c_slave=0;rx_m_slave=0;rx_wr_index_slave=0;rx_counter_slave=0;
; 0000 0135 }//w=w+8;//TX_slave_on;
; 0000 0136 
; 0000 0137 }//rx_c_slave=0;rx_m_slave=0;rx_wr_index_slave=0;rx_counter_slave=0;
_0x29:
; 0000 0138 }
_0x1A:
; 0000 0139  if(rx_c_slave==1&mod_time_slave==0){rx_c_slave=0;rx_m_slave=0;rx_wr_index_slave=0;rx_counter_slave=0;//rd_counts=0;
_0x19:
	LDI  R26,0
	SBRC R3,5
	LDI  R26,1
	LDI  R30,LOW(1)
	CALL __EQB12
	MOV  R0,R30
	LDS  R26,_mod_time_slave
	LDI  R30,LOW(0)
	CALL __EQB12
	AND  R30,R0
	BREQ _0x3B
	CLT
	BLD  R3,5
	BLD  R3,4
	LDI  R30,LOW(0)
	STS  _rx_wr_index_slave,R30
	STS  _rx_counter_slave,R30
; 0000 013A  }
; 0000 013B 	}
_0x3B:
	CALL __LOADLOCR4
	ADIW R28,4
	LD   R30,Y+
	OUT  SREG,R30
	LD   R31,Y+
	LD   R30,Y+
	LD   R27,Y+
	LD   R26,Y+
	LD   R25,Y+
	LD   R24,Y+
	LD   R23,Y+
	LD   R22,Y+
	LD   R15,Y+
	LD   R1,Y+
	LD   R0,Y+
	RETI
; .FEND
;//--------------------------------------//
;// USART1 Transmitter interrupt service routine
;//--------------------------------------//
;
;char tx_buffer_master[TX_BUFFER_SIZE];
;unsigned char tx_buffer_begin_master,tx_buffer_end_master;
;interrupt [USART1_TXC] void usart1_tx_isr(void)
; 0000 0143 	{
_usart1_tx_isr:
; .FSTART _usart1_tx_isr
	ST   -Y,R24
	ST   -Y,R25
	ST   -Y,R26
	ST   -Y,R30
	ST   -Y,R31
	IN   R30,SREG
	ST   -Y,R30
; 0000 0144 
; 0000 0145 	if (tx_en_master==1)
	SBRS R2,0
	RJMP _0x3C
; 0000 0146 		{
; 0000 0147 		delay_us(100);
	__DELAY_USW 200
; 0000 0148 		if (++tx_buffer_begin_master>=TX_BUFFER_SIZE) tx_buffer_begin_master=0;
	LDS  R26,_tx_buffer_begin_master
	SUBI R26,-LOW(1)
	STS  _tx_buffer_begin_master,R26
	CPI  R26,LOW(0x80)
	BRLO _0x3D
	LDI  R30,LOW(0)
	STS  _tx_buffer_begin_master,R30
; 0000 0149 		if (tx_buffer_begin_master!=tx_buffer_end_master) {UDR1=tx_buffer_master[tx_buffer_begin_master];}
_0x3D:
	LDS  R30,_tx_buffer_end_master
	LDS  R26,_tx_buffer_begin_master
	CP   R30,R26
	BREQ _0x3E
	LDS  R30,_tx_buffer_begin_master
	LDI  R31,0
	SUBI R30,LOW(-_tx_buffer_master)
	SBCI R31,HIGH(-_tx_buffer_master)
	LD   R30,Z
	STS  156,R30
; 0000 014A 		else {tx_en_master=0;rx_m_master=0;TX_master_off;}
	RJMP _0x3F
_0x3E:
	CLT
	BLD  R2,0
	BLD  R2,1
	CBI  0x12,4
_0x3F:
; 0000 014B 		}
; 0000 014C 
; 0000 014D 	}
_0x3C:
	LD   R30,Y+
	OUT  SREG,R30
	LD   R31,Y+
	LD   R30,Y+
	LD   R26,Y+
	LD   R25,Y+
	LD   R24,Y+
	RETI
; .FEND
;//--------------------------------------//
;// USART0 Transmitter interrupt service routine
;//--------------------------------------//
;
;interrupt [USART0_TXC] void usart0_tx_isr(void)
; 0000 0153 	{
_usart0_tx_isr:
; .FSTART _usart0_tx_isr
	ST   -Y,R26
	ST   -Y,R30
	ST   -Y,R31
	IN   R30,SREG
	ST   -Y,R30
; 0000 0154      #asm("cli");
	cli
; 0000 0155        //#asm ("cli")
; 0000 0156 	if (tx_en_slave==1)
	SBRS R3,3
	RJMP _0x42
; 0000 0157 		{
; 0000 0158 		if (++tx_buffer_begin_slave>=TX_BUFFER_SIZE) tx_buffer_begin_slave=0;
	LDS  R26,_tx_buffer_begin_slave
	SUBI R26,-LOW(1)
	STS  _tx_buffer_begin_slave,R26
	CPI  R26,LOW(0x80)
	BRLO _0x43
	LDI  R30,LOW(0)
	STS  _tx_buffer_begin_slave,R30
; 0000 0159 		if (tx_buffer_begin_slave!=tx_buffer_end_slave) {UDR0=tx_buffer_slave[tx_buffer_begin_slave];}
_0x43:
	LDS  R30,_tx_buffer_end_slave
	LDS  R26,_tx_buffer_begin_slave
	CP   R30,R26
	BREQ _0x44
	LDS  R30,_tx_buffer_begin_slave
	LDI  R31,0
	SUBI R30,LOW(-_tx_buffer_slave)
	SBCI R31,HIGH(-_tx_buffer_slave)
	LD   R30,Z
	OUT  0xC,R30
; 0000 015A 		else {tx_en_slave=0;rx_m_slave=0;TX_slave_off;tx_buffer_begin_slave=0;tx_buffer_end_slave=0;uart_slave_disable;transmi ...
	RJMP _0x45
_0x44:
	CLT
	BLD  R3,3
	BLD  R3,4
	CBI  0x3,2
	LDI  R30,LOW(0)
	STS  _tx_buffer_begin_slave,R30
	STS  _tx_buffer_end_slave,R30
	OUT  0xA,R30
	LDI  R30,LOW(144)
	OUT  0xA,R30
_0x45:
; 0000 015B        	}
; 0000 015C         //new_message=0;
; 0000 015D           //  #asm ("sei")
; 0000 015E         #asm("sei");
_0x42:
	sei
; 0000 015F 	}
	LD   R30,Y+
	OUT  SREG,R30
	LD   R31,Y+
	LD   R30,Y+
	LD   R26,Y+
	RETI
; .FEND
;//--------------------------------------//
;// Timer 0 overflow interrupt service routine
;//--------------------------------------//
;interrupt [TIM0_OVF] void timer0_ovf_isr(void)
; 0000 0164         {
_timer0_ovf_isr:
; .FSTART _timer0_ovf_isr
	ST   -Y,R30
	IN   R30,SREG
	ST   -Y,R30
; 0000 0165         #asm ("cli")
	cli
; 0000 0166         TCNT0=0x07;//250us
	LDI  R30,LOW(7)
	OUT  0x32,R30
; 0000 0167 	//#asm("wdr");
; 0000 0168 	if (mod_time_slave==0){if(rx_m_slave==1) rx_c_slave=1;}   else 	mod_time_slave--;
	LDS  R30,_mod_time_slave
	CPI  R30,0
	BRNE _0x46
	SBRS R3,4
	RJMP _0x47
	SET
	BLD  R3,5
_0x47:
	RJMP _0x48
_0x46:
	LDS  R30,_mod_time_slave
	SUBI R30,LOW(1)
	STS  _mod_time_slave,R30
; 0000 0169 	if (mod_time_master==0){if(rx_m_master==1) rx_c_master=1;}else 	mod_time_master--;
_0x48:
	LDS  R30,_mod_time_master
	CPI  R30,0
	BRNE _0x49
	SBRS R2,1
	RJMP _0x4A
	SET
	BLD  R2,2
_0x4A:
	RJMP _0x4B
_0x49:
	LDS  R30,_mod_time_master
	SUBI R30,LOW(1)
	STS  _mod_time_master,R30
; 0000 016A 
; 0000 016B     #asm ("sei")
_0x4B:
	sei
; 0000 016C         }
	LD   R30,Y+
	OUT  SREG,R30
	LD   R30,Y+
	RETI
; .FEND
;//--------------------------------------//
;// SPI interrupt service routine
;interrupt [SPI_STC] void spi_isr(void)
; 0000 0170 {
_spi_isr:
; .FSTART _spi_isr
	ST   -Y,R24
	ST   -Y,R25
	ST   -Y,R30
	IN   R30,SREG
	ST   -Y,R30
; 0000 0171 //unsigned char data;
; 0000 0172 //data=SPDR;
; 0000 0173 // Place your code here
; 0000 0174 if(SPI_tEnd==0){
	LDS  R30,_SPI_tEnd
	CPI  R30,0
	BRNE _0x4C
; 0000 0175 SPDR=tok;
	LDS  R30,_tok
	OUT  0xF,R30
; 0000 0176 SPI_tEnd=1;
	LDI  R30,LOW(1)
	STS  _SPI_tEnd,R30
; 0000 0177 delay_us(200);
	__DELAY_USW 400
; 0000 0178 PORTB.4=0;
	CBI  0x18,4
; 0000 0179 PORTB.0=1;
; 0000 017A }
; 0000 017B //delay_us(2);
; 0000 017C else PORTB.0=1;
_0x4C:
_0x416:
	SBI  0x18,0
; 0000 017D //else PORTB.0=1;
; 0000 017E }
	LD   R30,Y+
	OUT  SREG,R30
	LD   R30,Y+
	LD   R25,Y+
	LD   R24,Y+
	RETI
; .FEND
;//-------------------------------------------
;// модуль токового интерфейса
;//-------------------------------------------
;void current_out(unsigned int out)
; 0000 0183         {
_current_out:
; .FSTART _current_out
; 0000 0184 //        char i;
; 0000 0185 //        DDRB = DDRB|0b00110111;
; 0000 0186 //        PORTB=PORTB|0b00110111;
; 0000 0187 //        PORTB.0=0;//
; 0000 0188 //        out=out<<4;
; 0000 0189 //        for (i=0;i<12;i++)
; 0000 018A //                {
; 0000 018B //                if(out>=0x8000)PORTB.2=1;//
; 0000 018C //                else PORTB.2=0;//
; 0000 018D //                PORTB.1=0;PORTB.1=1;//
; 0000 018E //                out<<=1;
; 0000 018F //                }
; 0000 0190 //        PORTB.0=1;PORTB.4=0;PORTB.4=1;
; 0000 0191            PORTB.4=0;
	ST   -Y,R27
	ST   -Y,R26
;	out -> Y+0
	CBI  0x18,4
; 0000 0192            delay_us(200);
	__DELAY_USW 400
; 0000 0193            PORTB.4=1;PORTB.0=0;
	SBI  0x18,4
	CBI  0x18,0
; 0000 0194            delay_us(200);
	__DELAY_USW 400
; 0000 0195 //        PORTB.2=1;
; 0000 0196 //        PORTB.0=0;
; 0000 0197         if(SPI_tEnd==1)
	LDS  R26,_SPI_tEnd
	CPI  R26,LOW(0x1)
	BRNE _0x5A
; 0000 0198             {SPI_tEnd=0;
	LDI  R30,LOW(0)
	STS  _SPI_tEnd,R30
; 0000 0199 
; 0000 019A              SPDR=out>>8;
	LDD  R30,Y+1
	ANDI R31,HIGH(0x0)
	OUT  0xF,R30
; 0000 019B             // PORTB.2=0;
; 0000 019C             // PORTB.4=0;
; 0000 019D             }
; 0000 019E         }
_0x5A:
	RJMP _0x20A0006
; .FEND
;
;
;void EEPROM_write(unsigned int eeAddress, unsigned char eeData)
; 0000 01A2 {
_EEPROM_write:
; .FSTART _EEPROM_write
; 0000 01A3 /* Wait for completion of previous write */
; 0000 01A4 while(EECR&0x02)//  (1<<EEWE))
	ST   -Y,R26
;	eeAddress -> Y+1
;	eeData -> Y+0
_0x5B:
	SBIC 0x1C,1
; 0000 01A5 ;
	RJMP _0x5B
; 0000 01A6 /* Set up address and data registers */
; 0000 01A7 EEAR = eeAddress;
	LDD  R30,Y+1
	LDD  R31,Y+1+1
	OUT  0x1E+1,R31
	OUT  0x1E,R30
; 0000 01A8 EEDR = eeData;
	LD   R30,Y
	OUT  0x1D,R30
; 0000 01A9 /* Write logical one to EEMWE */
; 0000 01AA EECR |= 0x04;//(1<<EEMWE);
	SBI  0x1C,2
; 0000 01AB /* Start eeprom write by setting EEWE */
; 0000 01AC EECR |= 0x02;//(1<<EEWE);
	SBI  0x1C,1
; 0000 01AD  }
	ADIW R28,3
	RET
; .FEND
;
;
;
;unsigned char EEPROM_read(unsigned int eeAddress)
; 0000 01B2 {
_EEPROM_read:
; .FSTART _EEPROM_read
; 0000 01B3 /* Wait for completion of previous write */
; 0000 01B4 while(EECR & 0x02)//(1<<EEWE))
	ST   -Y,R27
	ST   -Y,R26
;	eeAddress -> Y+0
_0x5E:
	SBIC 0x1C,1
; 0000 01B5 ;
	RJMP _0x5E
; 0000 01B6 /* Set up address register */
; 0000 01B7 EEAR = eeAddress;
	LD   R30,Y
	LDD  R31,Y+1
	OUT  0x1E+1,R31
	OUT  0x1E,R30
; 0000 01B8 /* Start eeprom read by writing EERE */
; 0000 01B9 EECR |= 0x01;//(1<<EERE);
	SBI  0x1C,0
; 0000 01BA /* Return data from data register */
; 0000 01BB return EEDR;
	IN   R30,0x1D
_0x20A0006:
	ADIW R28,2
	RET
; 0000 01BC }
; .FEND
;
;void eeprom_reset()
; 0000 01BF {
; 0000 01C0     int i;
; 0000 01C1     for(i=0;i<0x1000;i++)
;	i -> R16,R17
; 0000 01C2     {
; 0000 01C3     if(i==eeAddressModBusAddr)i++;
; 0000 01C4     EEPROM_write(i,0xff);
; 0000 01C5     }
; 0000 01C6 }
;
;//--------------------------------------//
;
;
;eeprom float kv=100;
;eeprom float kn=100;
;
;unsigned char save_reg(unsigned int d,unsigned int a);
;char check_cr_master();
;char check_cr_slave();
;void crc_rtu_master(char a);			//
;void crc_rtu_slave(char a);			//
;void crc_end_master();			//
;	//
;void mov_buf_master(char a);
;void mov_buf0(char a);			//
;void mov_buf_slave(char a);
;void mov_buf1(char a);			//
;unsigned int valskz;
;void response_m_err(char a);                     //
;void response_m_aa4();                     //
;void response_m_aa6();                     //
;
;
;void led(unsigned char a)
; 0000 01E0         {
_led:
; .FSTART _led
; 0000 01E1         switch (a)
	ST   -Y,R26
;	a -> Y+0
	LD   R30,Y
	LDI  R31,0
; 0000 01E2                 {
; 0000 01E3                 case 0: {
	SBIW R30,0
	BRNE _0x68
; 0000 01E4           led_20_off;led_19_off;led_18_off;led_17_off;led_16_off;led_15_off;led_14_off;led_13_off;led_12_off;led_11_off;
	LDS  R30,98
	ANDI R30,0xFB
	STS  98,R30
	LDS  R30,98
	ANDI R30,0xFE
	STS  98,R30
	LDS  R30,98
	ANDI R30,0xBF
	STS  98,R30
	LDS  R30,98
	ANDI R30,0xFD
	STS  98,R30
	LDS  R30,98
	ANDI R30,0XF7
	STS  98,R30
	LDS  R30,98
	ANDI R30,0xDF
	STS  98,R30
	LDS  R30,98
	ANDI R30,0x7F
	STS  98,R30
	CBI  0x1B,0
	CBI  0x1B,1
	CBI  0x1B,3
; 0000 01E5           led_10_off;led_09_off;led_08_off;led_07_off;led_06_off;led_05_off;led_04_off;led_03_on;led_02_on;led_01_on;bre ...
	CBI  0x1B,4
	CBI  0x1B,5
	CBI  0x1B,6
	CBI  0x1B,7
	CBI  0x15,6
	CBI  0x15,7
	CBI  0x15,4
	SBI  0x15,3
	SBI  0x15,2
	SBI  0x15,1
	RJMP _0x67
; 0000 01E6                 case 1: {
_0x68:
	CPI  R30,LOW(0x1)
	LDI  R26,HIGH(0x1)
	CPC  R31,R26
	BRNE _0x83
; 0000 01E7           led_20_off;led_19_off;led_18_off;led_17_off;led_16_off;led_15_off;led_14_off;led_13_off;led_12_off;led_11_off;
	LDS  R30,98
	ANDI R30,0xFB
	STS  98,R30
	LDS  R30,98
	ANDI R30,0xFE
	STS  98,R30
	LDS  R30,98
	ANDI R30,0xBF
	STS  98,R30
	LDS  R30,98
	ANDI R30,0xFD
	STS  98,R30
	LDS  R30,98
	ANDI R30,0XF7
	STS  98,R30
	LDS  R30,98
	ANDI R30,0xDF
	STS  98,R30
	LDS  R30,98
	ANDI R30,0x7F
	STS  98,R30
	CBI  0x1B,0
	CBI  0x1B,1
	CBI  0x1B,3
; 0000 01E8           led_10_off;led_09_off;led_08_off;led_07_off;led_06_off;led_05_off;led_04_off;led_03_off;led_02_off;led_01_on;b ...
	CBI  0x1B,4
	CBI  0x1B,5
	CBI  0x1B,6
	CBI  0x1B,7
	CBI  0x15,6
	CBI  0x15,7
	CBI  0x15,4
	CBI  0x15,3
	CBI  0x15,2
	SBI  0x15,1
	RJMP _0x67
; 0000 01E9                 case 2: {
_0x83:
	CPI  R30,LOW(0x2)
	LDI  R26,HIGH(0x2)
	CPC  R31,R26
	BRNE _0x9E
; 0000 01EA           led_20_off;led_19_off;led_18_off;led_17_off;led_16_off;led_15_off;led_14_off;led_13_off;led_12_off;led_11_off;
	LDS  R30,98
	ANDI R30,0xFB
	STS  98,R30
	LDS  R30,98
	ANDI R30,0xFE
	STS  98,R30
	LDS  R30,98
	ANDI R30,0xBF
	STS  98,R30
	LDS  R30,98
	ANDI R30,0xFD
	STS  98,R30
	LDS  R30,98
	ANDI R30,0XF7
	STS  98,R30
	LDS  R30,98
	ANDI R30,0xDF
	STS  98,R30
	LDS  R30,98
	ANDI R30,0x7F
	STS  98,R30
	CBI  0x1B,0
	CBI  0x1B,1
	CBI  0x1B,3
; 0000 01EB           led_10_off;led_09_off;led_08_off;led_07_off;led_06_off;led_05_off;led_04_off;led_03_off;led_02_on;led_01_on;br ...
	CBI  0x1B,4
	CBI  0x1B,5
	CBI  0x1B,6
	CBI  0x1B,7
	CBI  0x15,6
	CBI  0x15,7
	CBI  0x15,4
	CBI  0x15,3
	SBI  0x15,2
	SBI  0x15,1
	RJMP _0x67
; 0000 01EC                 case 3: {
_0x9E:
	CPI  R30,LOW(0x3)
	LDI  R26,HIGH(0x3)
	CPC  R31,R26
	BRNE _0xB9
; 0000 01ED           led_20_off;led_19_off;led_18_off;led_17_off;led_16_off;led_15_off;led_14_off;led_13_off;led_12_off;led_11_off;
	LDS  R30,98
	ANDI R30,0xFB
	STS  98,R30
	LDS  R30,98
	ANDI R30,0xFE
	STS  98,R30
	LDS  R30,98
	ANDI R30,0xBF
	STS  98,R30
	LDS  R30,98
	ANDI R30,0xFD
	STS  98,R30
	LDS  R30,98
	ANDI R30,0XF7
	STS  98,R30
	LDS  R30,98
	ANDI R30,0xDF
	STS  98,R30
	LDS  R30,98
	ANDI R30,0x7F
	STS  98,R30
	CBI  0x1B,0
	CBI  0x1B,1
	CBI  0x1B,3
; 0000 01EE           led_10_off;led_09_off;led_08_off;led_07_off;led_06_off;led_05_off;led_04_off;led_03_on;led_02_on;led_01_on;bre ...
	CBI  0x1B,4
	CBI  0x1B,5
	CBI  0x1B,6
	CBI  0x1B,7
	CBI  0x15,6
	CBI  0x15,7
	CBI  0x15,4
	SBI  0x15,3
	SBI  0x15,2
	SBI  0x15,1
	RJMP _0x67
; 0000 01EF                 case 4: {
_0xB9:
	CPI  R30,LOW(0x4)
	LDI  R26,HIGH(0x4)
	CPC  R31,R26
	BRNE _0xD4
; 0000 01F0           led_20_off;led_19_off;led_18_off;led_17_off;led_16_off;led_15_off;led_14_off;led_13_off;led_12_off;led_11_off;
	LDS  R30,98
	ANDI R30,0xFB
	STS  98,R30
	LDS  R30,98
	ANDI R30,0xFE
	STS  98,R30
	LDS  R30,98
	ANDI R30,0xBF
	STS  98,R30
	LDS  R30,98
	ANDI R30,0xFD
	STS  98,R30
	LDS  R30,98
	ANDI R30,0XF7
	STS  98,R30
	LDS  R30,98
	ANDI R30,0xDF
	STS  98,R30
	LDS  R30,98
	ANDI R30,0x7F
	STS  98,R30
	CBI  0x1B,0
	CBI  0x1B,1
	CBI  0x1B,3
; 0000 01F1           led_10_off;led_09_off;led_08_off;led_07_off;led_06_off;led_05_off;led_04_on;led_03_off;led_02_off;led_01_off;b ...
	CBI  0x1B,4
	CBI  0x1B,5
	CBI  0x1B,6
	CBI  0x1B,7
	CBI  0x15,6
	CBI  0x15,7
	RJMP _0x417
; 0000 01F2                 case 5: {
_0xD4:
	CPI  R30,LOW(0x5)
	LDI  R26,HIGH(0x5)
	CPC  R31,R26
	BRNE _0xEF
; 0000 01F3           led_20_off;led_19_off;led_18_off;led_17_off;led_16_off;led_15_off;led_14_off;led_13_off;led_12_off;led_11_off;
	LDS  R30,98
	ANDI R30,0xFB
	STS  98,R30
	LDS  R30,98
	ANDI R30,0xFE
	STS  98,R30
	LDS  R30,98
	ANDI R30,0xBF
	STS  98,R30
	LDS  R30,98
	ANDI R30,0xFD
	STS  98,R30
	LDS  R30,98
	ANDI R30,0XF7
	STS  98,R30
	LDS  R30,98
	ANDI R30,0xDF
	STS  98,R30
	LDS  R30,98
	ANDI R30,0x7F
	STS  98,R30
	CBI  0x1B,0
	CBI  0x1B,1
	CBI  0x1B,3
; 0000 01F4           led_10_off;led_09_off;led_08_off;led_07_off;led_06_off;led_05_on;led_04_on;led_03_off;led_02_off;led_01_off;br ...
	CBI  0x1B,4
	CBI  0x1B,5
	CBI  0x1B,6
	CBI  0x1B,7
	CBI  0x15,6
	RJMP _0x418
; 0000 01F5                 case 6: {
_0xEF:
	CPI  R30,LOW(0x6)
	LDI  R26,HIGH(0x6)
	CPC  R31,R26
	BRNE _0x10A
; 0000 01F6           led_20_off;led_19_off;led_18_off;led_17_off;led_16_off;led_15_off;led_14_off;led_13_off;led_12_off;led_11_off;
	LDS  R30,98
	ANDI R30,0xFB
	STS  98,R30
	LDS  R30,98
	ANDI R30,0xFE
	STS  98,R30
	LDS  R30,98
	ANDI R30,0xBF
	STS  98,R30
	LDS  R30,98
	ANDI R30,0xFD
	STS  98,R30
	LDS  R30,98
	ANDI R30,0XF7
	STS  98,R30
	LDS  R30,98
	ANDI R30,0xDF
	STS  98,R30
	LDS  R30,98
	ANDI R30,0x7F
	STS  98,R30
	CBI  0x1B,0
	CBI  0x1B,1
	CBI  0x1B,3
; 0000 01F7           led_10_off;led_09_off;led_08_off;led_07_off;led_06_on;led_05_on;led_04_on;led_03_off;led_02_off;led_01_off;bre ...
	CBI  0x1B,4
	CBI  0x1B,5
	CBI  0x1B,6
	CBI  0x1B,7
	RJMP _0x419
; 0000 01F8                 case 7: {
_0x10A:
	CPI  R30,LOW(0x7)
	LDI  R26,HIGH(0x7)
	CPC  R31,R26
	BRNE _0x125
; 0000 01F9           led_20_off;led_19_off;led_18_off;led_17_off;led_16_off;led_15_off;led_14_off;led_13_off;led_12_off;led_11_off;
	LDS  R30,98
	ANDI R30,0xFB
	STS  98,R30
	LDS  R30,98
	ANDI R30,0xFE
	STS  98,R30
	LDS  R30,98
	ANDI R30,0xBF
	STS  98,R30
	LDS  R30,98
	ANDI R30,0xFD
	STS  98,R30
	LDS  R30,98
	ANDI R30,0XF7
	STS  98,R30
	LDS  R30,98
	ANDI R30,0xDF
	STS  98,R30
	LDS  R30,98
	ANDI R30,0x7F
	STS  98,R30
	CBI  0x1B,0
	CBI  0x1B,1
	CBI  0x1B,3
; 0000 01FA           led_10_off;led_09_off;led_08_off;led_07_on;led_06_on;led_05_on;led_04_on;led_03_off;led_02_off;led_01_off;brea ...
	CBI  0x1B,4
	CBI  0x1B,5
	CBI  0x1B,6
	RJMP _0x41A
; 0000 01FB                 case 8: {
_0x125:
	CPI  R30,LOW(0x8)
	LDI  R26,HIGH(0x8)
	CPC  R31,R26
	BRNE _0x140
; 0000 01FC           led_20_off;led_19_off;led_18_off;led_17_off;led_16_off;led_15_off;led_14_off;led_13_off;led_12_off;led_11_off;
	LDS  R30,98
	ANDI R30,0xFB
	STS  98,R30
	LDS  R30,98
	ANDI R30,0xFE
	STS  98,R30
	LDS  R30,98
	ANDI R30,0xBF
	STS  98,R30
	LDS  R30,98
	ANDI R30,0xFD
	STS  98,R30
	LDS  R30,98
	ANDI R30,0XF7
	STS  98,R30
	LDS  R30,98
	ANDI R30,0xDF
	STS  98,R30
	LDS  R30,98
	ANDI R30,0x7F
	STS  98,R30
	CBI  0x1B,0
	CBI  0x1B,1
	CBI  0x1B,3
; 0000 01FD           led_10_off;led_09_off;led_08_on;led_07_on;led_06_on;led_05_on;led_04_on;led_03_off;led_02_off;led_01_off;break ...
	CBI  0x1B,4
	CBI  0x1B,5
	RJMP _0x41B
; 0000 01FE                 case 9: {
_0x140:
	CPI  R30,LOW(0x9)
	LDI  R26,HIGH(0x9)
	CPC  R31,R26
	BRNE _0x15B
; 0000 01FF           led_20_off;led_19_off;led_18_off;led_17_off;led_16_off;led_15_off;led_14_off;led_13_off;led_12_off;led_11_off;
	LDS  R30,98
	ANDI R30,0xFB
	STS  98,R30
	LDS  R30,98
	ANDI R30,0xFE
	STS  98,R30
	LDS  R30,98
	ANDI R30,0xBF
	STS  98,R30
	LDS  R30,98
	ANDI R30,0xFD
	STS  98,R30
	LDS  R30,98
	ANDI R30,0XF7
	STS  98,R30
	LDS  R30,98
	ANDI R30,0xDF
	STS  98,R30
	LDS  R30,98
	ANDI R30,0x7F
	STS  98,R30
	CBI  0x1B,0
	CBI  0x1B,1
	CBI  0x1B,3
; 0000 0200           led_10_off;led_09_on;led_08_on;led_07_on;led_06_on;led_05_on;led_04_on;led_03_off;led_02_off;led_01_off;break; ...
	CBI  0x1B,4
	RJMP _0x41C
; 0000 0201                 case 10: {
_0x15B:
	CPI  R30,LOW(0xA)
	LDI  R26,HIGH(0xA)
	CPC  R31,R26
	BRNE _0x176
; 0000 0202           led_20_off;led_19_off;led_18_off;led_17_off;led_16_off;led_15_off;led_14_off;led_13_off;led_12_off;led_11_off;
	LDS  R30,98
	ANDI R30,0xFB
	STS  98,R30
	LDS  R30,98
	ANDI R30,0xFE
	STS  98,R30
	LDS  R30,98
	ANDI R30,0xBF
	STS  98,R30
	LDS  R30,98
	ANDI R30,0xFD
	STS  98,R30
	LDS  R30,98
	ANDI R30,0XF7
	STS  98,R30
	LDS  R30,98
	ANDI R30,0xDF
	STS  98,R30
	LDS  R30,98
	ANDI R30,0x7F
	STS  98,R30
	CBI  0x1B,0
	CBI  0x1B,1
	CBI  0x1B,3
; 0000 0203           led_10_on;led_09_on;led_08_on;led_07_on;led_06_on;led_05_on;led_04_on;led_03_off;led_02_off;led_01_off;break;}
	RJMP _0x41D
; 0000 0204                 case 11: {
_0x176:
	CPI  R30,LOW(0xB)
	LDI  R26,HIGH(0xB)
	CPC  R31,R26
	BRNE _0x191
; 0000 0205           led_20_off;led_19_off;led_18_off;led_17_off;led_16_off;led_15_off;led_14_off;led_13_off;led_12_off;led_11_on;
	LDS  R30,98
	ANDI R30,0xFB
	STS  98,R30
	LDS  R30,98
	ANDI R30,0xFE
	STS  98,R30
	LDS  R30,98
	ANDI R30,0xBF
	STS  98,R30
	LDS  R30,98
	ANDI R30,0xFD
	STS  98,R30
	LDS  R30,98
	ANDI R30,0XF7
	STS  98,R30
	LDS  R30,98
	ANDI R30,0xDF
	STS  98,R30
	LDS  R30,98
	ANDI R30,0x7F
	STS  98,R30
	CBI  0x1B,0
	CBI  0x1B,1
	RJMP _0x41E
; 0000 0206           led_10_on;led_09_on;led_08_on;led_07_on;led_06_on;led_05_on;led_04_on;led_03_off;led_02_off;led_01_off;break;}
; 0000 0207                 case 12: {
_0x191:
	CPI  R30,LOW(0xC)
	LDI  R26,HIGH(0xC)
	CPC  R31,R26
	BRNE _0x1AC
; 0000 0208           led_20_off;led_19_off;led_18_off;led_17_off;led_16_off;led_15_off;led_14_off;led_13_off;led_12_on;led_11_on;
	LDS  R30,98
	ANDI R30,0xFB
	STS  98,R30
	LDS  R30,98
	ANDI R30,0xFE
	STS  98,R30
	LDS  R30,98
	ANDI R30,0xBF
	STS  98,R30
	LDS  R30,98
	ANDI R30,0xFD
	STS  98,R30
	LDS  R30,98
	ANDI R30,0XF7
	STS  98,R30
	LDS  R30,98
	ANDI R30,0xDF
	STS  98,R30
	LDS  R30,98
	ANDI R30,0x7F
	STS  98,R30
	CBI  0x1B,0
	RJMP _0x41F
; 0000 0209           led_10_on;led_09_on;led_08_on;led_07_on;led_06_on;led_05_on;led_04_on;led_03_off;led_02_off;led_01_off;break;}
; 0000 020A                 case 13: {
_0x1AC:
	CPI  R30,LOW(0xD)
	LDI  R26,HIGH(0xD)
	CPC  R31,R26
	BRNE _0x1C7
; 0000 020B           led_20_off;led_19_off;led_18_off;led_17_off;led_16_off;led_15_off;led_14_off;led_13_on;led_12_on;led_11_on;
	LDS  R30,98
	ANDI R30,0xFB
	STS  98,R30
	LDS  R30,98
	ANDI R30,0xFE
	STS  98,R30
	LDS  R30,98
	ANDI R30,0xBF
	STS  98,R30
	LDS  R30,98
	ANDI R30,0xFD
	STS  98,R30
	LDS  R30,98
	ANDI R30,0XF7
	STS  98,R30
	LDS  R30,98
	ANDI R30,0xDF
	STS  98,R30
	LDS  R30,98
	ANDI R30,0x7F
	RJMP _0x420
; 0000 020C           led_10_on;led_09_on;led_08_on;led_07_on;led_06_on;led_05_on;led_04_on;led_03_off;led_02_off;led_01_off;break;}
; 0000 020D                 case 14: {
_0x1C7:
	CPI  R30,LOW(0xE)
	LDI  R26,HIGH(0xE)
	CPC  R31,R26
	BRNE _0x1E2
; 0000 020E           led_20_off;led_19_off;led_18_off;led_17_off;led_16_off;led_15_off;led_14_on;led_13_on;led_12_on;led_11_on;
	LDS  R30,98
	ANDI R30,0xFB
	STS  98,R30
	LDS  R30,98
	ANDI R30,0xFE
	STS  98,R30
	LDS  R30,98
	ANDI R30,0xBF
	STS  98,R30
	LDS  R30,98
	ANDI R30,0xFD
	STS  98,R30
	LDS  R30,98
	ANDI R30,0XF7
	STS  98,R30
	LDS  R30,98
	ANDI R30,0xDF
	RJMP _0x421
; 0000 020F           led_10_on;led_09_on;led_08_on;led_07_on;led_06_on;led_05_on;led_04_on;led_03_off;led_02_off;led_01_off;break;}
; 0000 0210                 case 15: {
_0x1E2:
	CPI  R30,LOW(0xF)
	LDI  R26,HIGH(0xF)
	CPC  R31,R26
	BRNE _0x1FD
; 0000 0211           led_20_off;led_19_off;led_18_off;led_17_off;led_16_off;led_15_on;led_14_on;led_13_on;led_12_on;led_11_on;
	LDS  R30,98
	ANDI R30,0xFB
	STS  98,R30
	LDS  R30,98
	ANDI R30,0xFE
	STS  98,R30
	LDS  R30,98
	ANDI R30,0xBF
	STS  98,R30
	LDS  R30,98
	ANDI R30,0xFD
	STS  98,R30
	LDS  R30,98
	ANDI R30,0XF7
	RJMP _0x422
; 0000 0212           led_10_on;led_09_on;led_08_on;led_07_on;led_06_on;led_05_on;led_04_on;led_03_off;led_02_off;led_01_off;break;}
; 0000 0213                 case 16: {
_0x1FD:
	CPI  R30,LOW(0x10)
	LDI  R26,HIGH(0x10)
	CPC  R31,R26
	BRNE _0x218
; 0000 0214           led_20_off;led_19_off;led_18_off;led_17_off;led_16_on;led_15_on;led_14_on;led_13_on;led_12_on;led_11_on;
	LDS  R30,98
	ANDI R30,0xFB
	STS  98,R30
	LDS  R30,98
	ANDI R30,0xFE
	STS  98,R30
	LDS  R30,98
	ANDI R30,0xBF
	STS  98,R30
	LDS  R30,98
	ANDI R30,0xFD
	RJMP _0x423
; 0000 0215           led_10_on;led_09_on;led_08_on;led_07_on;led_06_on;led_05_on;led_04_on;led_03_off;led_02_off;led_01_off;break;}
; 0000 0216                 case 17: {
_0x218:
	CPI  R30,LOW(0x11)
	LDI  R26,HIGH(0x11)
	CPC  R31,R26
	BRNE _0x233
; 0000 0217           led_20_off;led_19_off;led_18_off;led_17_on;led_16_on;led_15_on;led_14_on;led_13_on;led_12_on;led_11_on;
	LDS  R30,98
	ANDI R30,0xFB
	STS  98,R30
	LDS  R30,98
	ANDI R30,0xFE
	STS  98,R30
	LDS  R30,98
	ANDI R30,0xBF
	RJMP _0x424
; 0000 0218           led_10_on;led_09_on;led_08_on;led_07_on;led_06_on;led_05_on;led_04_on;led_03_off;led_02_off;led_01_off;break;}
; 0000 0219                 case 18: {
_0x233:
	CPI  R30,LOW(0x12)
	LDI  R26,HIGH(0x12)
	CPC  R31,R26
	BRNE _0x24E
; 0000 021A           led_20_off;led_19_off;led_18_on;led_17_on;led_16_on;led_15_on;led_14_on;led_13_on;led_12_on;led_11_on;
	LDS  R30,98
	ANDI R30,0xFB
	STS  98,R30
	LDS  R30,98
	ANDI R30,0xFE
	RJMP _0x425
; 0000 021B           led_10_on;led_09_on;led_08_on;led_07_on;led_06_on;led_05_on;led_04_on;led_03_off;led_02_off;led_01_off;break;}
; 0000 021C                 case 19: {
_0x24E:
	CPI  R30,LOW(0x13)
	LDI  R26,HIGH(0x13)
	CPC  R31,R26
	BRNE _0x269
; 0000 021D           led_20_off;led_19_on;led_18_on;led_17_on;led_16_on;led_15_on;led_14_on;led_13_on;led_12_on;led_11_on;
	LDS  R30,98
	ANDI R30,0xFB
	RJMP _0x426
; 0000 021E           led_10_on;led_09_on;led_08_on;led_07_on;led_06_on;led_05_on;led_04_on;led_03_off;led_02_off;led_01_off;break;}
; 0000 021F                 case 20: {
_0x269:
	CPI  R30,LOW(0x14)
	LDI  R26,HIGH(0x14)
	CPC  R31,R26
	BREQ _0x427
; 0000 0220           led_20_on;led_19_on;led_18_on;led_17_on;led_16_on;led_15_on;led_14_on;led_13_on;led_12_on;led_11_on;
; 0000 0221           led_10_on;led_09_on;led_08_on;led_07_on;led_06_on;led_05_on;led_04_on;led_03_off;led_02_off;led_01_off;break;}
; 0000 0222                 case 30: {
	CPI  R30,LOW(0x1E)
	LDI  R26,HIGH(0x1E)
	CPC  R31,R26
	BRNE _0x2BA
; 0000 0223           led_20_off;led_19_off;led_18_off;led_17_off;led_16_off;led_15_off;led_14_off;led_13_off;led_12_off;led_11_off;
	LDS  R30,98
	ANDI R30,0xFB
	STS  98,R30
	LDS  R30,98
	ANDI R30,0xFE
	STS  98,R30
	LDS  R30,98
	ANDI R30,0xBF
	STS  98,R30
	LDS  R30,98
	ANDI R30,0xFD
	STS  98,R30
	LDS  R30,98
	ANDI R30,0XF7
	STS  98,R30
	LDS  R30,98
	ANDI R30,0xDF
	STS  98,R30
	LDS  R30,98
	ANDI R30,0x7F
	STS  98,R30
	CBI  0x1B,0
	CBI  0x1B,1
	CBI  0x1B,3
; 0000 0224           led_10_off;led_09_off;led_08_off;led_07_off;led_06_off;led_05_off;led_04_off;led_03_off;led_02_off;led_01_off; ...
	CBI  0x1B,4
	CBI  0x1B,5
	CBI  0x1B,6
	CBI  0x1B,7
	CBI  0x15,6
	CBI  0x15,7
	CBI  0x15,4
	RJMP _0x428
; 0000 0225                 default: {
_0x2BA:
; 0000 0226           led_20_on;led_19_on;led_18_on;led_17_on;led_16_on;led_15_on;led_14_on;led_13_on;led_12_on;led_11_on;
_0x427:
	LDS  R30,98
	ORI  R30,4
_0x426:
	STS  98,R30
	LDS  R30,98
	ORI  R30,1
_0x425:
	STS  98,R30
	LDS  R30,98
	ORI  R30,0x40
_0x424:
	STS  98,R30
	LDS  R30,98
	ORI  R30,2
_0x423:
	STS  98,R30
	LDS  R30,98
	ORI  R30,8
_0x422:
	STS  98,R30
	LDS  R30,98
	ORI  R30,0x20
_0x421:
	STS  98,R30
	LDS  R30,98
	ORI  R30,0x80
_0x420:
	STS  98,R30
	SBI  0x1B,0
_0x41F:
	SBI  0x1B,1
_0x41E:
	SBI  0x1B,3
; 0000 0227           led_10_on;led_09_on;led_08_on;led_07_on;led_06_on;led_05_on;led_04_on;led_03_off;led_02_off;led_01_off;break;}
_0x41D:
	SBI  0x1B,4
_0x41C:
	SBI  0x1B,5
_0x41B:
	SBI  0x1B,6
_0x41A:
	SBI  0x1B,7
_0x419:
	SBI  0x15,6
_0x418:
	SBI  0x15,7
_0x417:
	SBI  0x15,4
_0x428:
	CBI  0x15,3
	CBI  0x15,2
	CBI  0x15,1
; 0000 0228               }
_0x67:
; 0000 0229         }
	ADIW R28,1
	RET
; .FEND
;
;
;interrupt [TIM3_OVF] void timer3_ovf_isr(void)
; 0000 022D {
_timer3_ovf_isr:
; .FSTART _timer3_ovf_isr
	ST   -Y,R26
	ST   -Y,R27
	ST   -Y,R30
	ST   -Y,R31
	IN   R30,SREG
	ST   -Y,R30
; 0000 022E // Reinitialize Timer 3 value
; 0000 022F //if(AvTimer%2==0)testing_blink_on;
; 0000 0230 //else testing_blink_off;
; 0000 0231 //#asm(" cli")
; 0000 0232 AvTimer_on;
	LDI  R30,LOW(0)
	STS  139,R30
	LDI  R30,LOW(4)
	STS  138,R30
	LDI  R30,LOW(129)
	STS  137,R30
	LDI  R30,LOW(11)
	STS  136,R30
	LDI  R30,LOW(4)
	STS  125,R30
; 0000 0233           // включаем таймер
; 0000 0234 // Place your code here
; 0000 0235 //SendSKZsave_req=1;   //этот флаг показывает, что нужно обратиться к БПС и сохранить значение СКЗ (в процентах)
; 0000 0236 AvTimer++;                    //наращиваем значение таймера
	LDI  R26,LOW(_AvTimer)
	LDI  R27,HIGH(_AvTimer)
	LD   R30,X+
	LD   R31,X+
	ADIW R30,1
	ST   -X,R31
	ST   -X,R30
; 0000 0237 //#asm(" sei")
; 0000 0238 }
	LD   R30,Y+
	OUT  SREG,R30
	LD   R31,Y+
	LD   R30,Y+
	LD   R27,Y+
	LD   R26,Y+
	RETI
; .FEND
;
;interrupt [TIM2_OVF] void timer2_ovf_isr(void)
; 0000 023B {
_timer2_ovf_isr:
; .FSTART _timer2_ovf_isr
	ST   -Y,R26
	ST   -Y,R27
	ST   -Y,R30
	ST   -Y,R31
	IN   R30,SREG
	ST   -Y,R30
; 0000 023C TCCR2=0x05;
	LDI  R30,LOW(5)
	OUT  0x25,R30
; 0000 023D TCNT2=0x00;
	LDI  R30,LOW(0)
	OUT  0x24,R30
; 0000 023E OCR2=0x00;
	OUT  0x23,R30
; 0000 023F TIMSK=TIMSK|0x40;
	IN   R30,0x37
	ORI  R30,0x40
	OUT  0x37,R30
; 0000 0240 
; 0000 0241 BlinkCounter_Calibration++;
	LDI  R26,LOW(_BlinkCounter_Calibration)
	LDI  R27,HIGH(_BlinkCounter_Calibration)
	LD   R30,X+
	LD   R31,X+
	ADIW R30,1
	ST   -X,R31
	ST   -X,R30
; 0000 0242 if(BlinkCounter_Calibration==17){BlinkCounter_Calibration=0;}
	LDS  R26,_BlinkCounter_Calibration
	LDS  R27,_BlinkCounter_Calibration+1
	SBIW R26,17
	BRNE _0x2D5
	LDI  R30,LOW(0)
	STS  _BlinkCounter_Calibration,R30
	STS  _BlinkCounter_Calibration+1,R30
; 0000 0243 led_warning_on&warning_flag;
_0x2D5:
	LDS  R26,98
	LDS  R30,_warning_flag
	ANDI R30,LOW(0x10)
	OR   R30,R26
	STS  98,R30
; 0000 0244 if((BlinkCounter_Calibration>=9)&&(warning_flag==1)&&(blink_flag==1))led_warning_on;
	LDS  R26,_BlinkCounter_Calibration
	LDS  R27,_BlinkCounter_Calibration+1
	SBIW R26,9
	BRLO _0x2D7
	LDS  R26,_warning_flag
	LDS  R27,_warning_flag+1
	SBIW R26,1
	BRNE _0x2D7
	LDS  R26,_blink_flag
	LDS  R27,_blink_flag+1
	SBIW R26,1
	BREQ _0x2D8
_0x2D7:
	RJMP _0x2D6
_0x2D8:
	LDS  R30,98
	ORI  R30,0x10
	STS  98,R30
; 0000 0245 if((BlinkCounter_Calibration>=9)&&(red==1))led_calibration_on;
_0x2D6:
	LDS  R26,_BlinkCounter_Calibration
	LDS  R27,_BlinkCounter_Calibration+1
	SBIW R26,9
	BRLO _0x2DA
	LDS  R26,_red
	LDS  R27,_red+1
	SBIW R26,1
	BREQ _0x2DB
_0x2DA:
	RJMP _0x2D9
_0x2DB:
	SBI  0x1B,2
; 0000 0246 if((BlinkCounter_Calibration<9)&&(red==1))led_calibration_off;
_0x2D9:
	LDS  R26,_BlinkCounter_Calibration
	LDS  R27,_BlinkCounter_Calibration+1
	SBIW R26,9
	BRSH _0x2DF
	LDS  R26,_red
	LDS  R27,_red+1
	SBIW R26,1
	BREQ _0x2E0
_0x2DF:
	RJMP _0x2DE
_0x2E0:
	CBI  0x1B,2
; 0000 0247 if((BlinkCounter_Calibration<9)&&(warning_flag==1)&&(blink_flag==1))led_warning_off;
_0x2DE:
	LDS  R26,_BlinkCounter_Calibration
	LDS  R27,_BlinkCounter_Calibration+1
	SBIW R26,9
	BRSH _0x2E4
	LDS  R26,_warning_flag
	LDS  R27,_warning_flag+1
	SBIW R26,1
	BRNE _0x2E4
	LDS  R26,_blink_flag
	LDS  R27,_blink_flag+1
	SBIW R26,1
	BREQ _0x2E5
_0x2E4:
	RJMP _0x2E3
_0x2E5:
	LDS  R30,98
	ANDI R30,0xEF
	STS  98,R30
; 0000 0248 
; 0000 0249 //#asm("wdr");
; 0000 024A 
; 0000 024B }
_0x2E3:
	LD   R30,Y+
	OUT  SREG,R30
	LD   R31,Y+
	LD   R30,Y+
	LD   R27,Y+
	LD   R26,Y+
	RETI
; .FEND
;void blink_on()
; 0000 024D {
_blink_on:
; .FSTART _blink_on
; 0000 024E TCCR2=0x05;
	LDI  R30,LOW(5)
	OUT  0x25,R30
; 0000 024F TCNT2=0x00;
	LDI  R30,LOW(0)
	OUT  0x24,R30
; 0000 0250 OCR2=0x00;
	OUT  0x23,R30
; 0000 0251 TIMSK=TIMSK|0x40;}
	IN   R30,0x37
	ORI  R30,0x40
	RJMP _0x20A0005
; .FEND
;
;void blink_off()
; 0000 0254 {
_blink_off:
; .FSTART _blink_off
; 0000 0255 TCCR2=0x00;
	LDI  R30,LOW(0)
	OUT  0x25,R30
; 0000 0256 TCNT2=0x00;
	OUT  0x24,R30
; 0000 0257 OCR2=0x00;
	OUT  0x23,R30
; 0000 0258 TIMSK=0x01;}
	LDI  R30,LOW(1)
_0x20A0005:
	OUT  0x37,R30
	RET
; .FEND
;/*
;void blink_display(int value) //отображение информации о содержимом буфера мастера
;        {
;        char i;
;        led_green_on;
;        led_red_on;
;        delay_ms(1000);
;        led_green_off;
;        led_red_off;
;        delay_ms(1000);
;
;        for(i=1;i<(value/10);i++)
;        {led_green_on;
;        delay_ms(200);
;        led_green_off;
;        delay_ms(200);}
;        led_green_on;
;        led_red_on;
;        delay_ms(600);
;        led_green_off;
;        led_red_off;
;        delay_ms(600);
;        } */
;
;//-------------------------------------------
;void send_skz()
; 0000 0273 {crc_master=0xFFFF;
; 0000 0274 mov_buf_master(0x01);
; 0000 0275 mov_buf_master(0x0c);
; 0000 0276 mov_buf_master(EEPROM_read(eeAddressSKZ1H));     //функция отправляет сохраненные в еепром значения точек СКЗ1 и СКЗ2
; 0000 0277 mov_buf_master(EEPROM_read(eeAddressSKZ1L));     //это псевдо модбас функция
; 0000 0278 mov_buf_master(EEPROM_read(eeAddressSKZ2H));
; 0000 0279 mov_buf_master(EEPROM_read(eeAddressSKZ2L));
; 0000 027A crc_end_master();}
;
;/*void req_recieve_skz_array()
;{unsigned int m;
;crc_master=0xFFFF;
;mov_buf_master(0x01);
;for(m=2;m<79;m++)mov_buf_master(0xcc);
;crc_end_master();}   */
;
;//void blink_intro()
;//{
;//led_20_on;led_19_on;led_18_on;led_17_on;led_16_on;led_15_on;led_14_on;led_13_on;led_12_on;led_11_on;led_10_on;led_09_o ...
;//led_20_off;led_19_off;led_18_off;led_17_off;led_16_off;led_15_off;led_14_off;led_13_off;led_12_off;led_11_off;led_10_o ...
;//}
;void save_skz_arrays(unsigned int skz1or2)//данная функция производит съем значений массива Config.SKZ_1 u Config.SKZ_2
; 0000 0289 {unsigned int m;                          // а также сразу сохраняет его в памяти eeprom БКИ
_save_skz_arrays:
; .FSTART _save_skz_arrays
; 0000 028A unsigned int val1, val2,addrval;
; 0000 028B 
; 0000 028C  ProcessingEEPROM=1;
	ST   -Y,R27
	ST   -Y,R26
	SBIW R28,2
	CALL __SAVELOCR6
;	skz1or2 -> Y+8
;	m -> R16,R17
;	val1 -> R18,R19
;	val2 -> R20,R21
;	addrval -> Y+6
	SET
	BLD  R2,5
; 0000 028D  led_warning_off;
	LDS  R30,98
	ANDI R30,0xEF
	STS  98,R30
; 0000 028E led_calibration_on;
	SBI  0x1B,2
; 0000 028F blink_off();
	RCALL _blink_off
; 0000 0290 reg91_answer=(object_state|(!BPS_absent)<<5)|(red<<4)|((ProcessingEEPROM)<<3)|((red|ProcessingEEPROM)<<2)|((warning_flag ...
	LDS  R30,_BPS_absent
	LDS  R31,_BPS_absent+1
	CALL __LNEGW1
	SWAP R30
	ANDI R30,0xF0
	LSL  R30
	LDS  R26,_object_state
	OR   R30,R26
	MOV  R26,R30
	LDS  R30,_red
	SWAP R30
	ANDI R30,0xF0
	OR   R30,R26
	MOV  R0,R30
	LDI  R26,0
	SBRC R2,5
	LDI  R26,1
	MOV  R30,R26
	LSL  R30
	LSL  R30
	LSL  R30
	OR   R0,R30
	LDI  R30,0
	SBRC R2,5
	LDI  R30,1
	LDS  R26,_red
	OR   R30,R26
	LSL  R30
	LSL  R30
	OR   R0,R30
	LDS  R30,_blink_flag
	LDS  R31,_blink_flag+1
	CALL __LNEGW1
	LSL  R30
	LDS  R26,_warning_flag
	AND  R30,R26
	OR   R0,R30
	LDS  R30,_blink_flag
	LDS  R31,_blink_flag+1
	CALL __LNEGW1
	AND  R30,R26
	LDS  R26,_blink_flag
	OR   R30,R26
	OR   R30,R0
	STS  _reg91_answer,R30
; 0000 0291  delay_ms(3200);
	LDI  R26,LOW(3200)
	LDI  R27,HIGH(3200)
	CALL _delay_ms
; 0000 0292 
; 0000 0293 if(skz1or2==1){val1=0;val2=19;addrval=0x20;}        //адреса addrval подобраны исходя из адресов команд модбас для чтени ...
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	SBIW R26,1
	BRNE _0x2E8
	__GETWRN 18,19,0
	__GETWRN 20,21,19
	LDI  R30,LOW(32)
	LDI  R31,HIGH(32)
	STD  Y+6,R30
	STD  Y+6+1,R31
; 0000 0294 if(skz1or2==0){val1=19;val2=38;addrval=0x2D;}
_0x2E8:
	LDD  R30,Y+8
	LDD  R31,Y+8+1
	SBIW R30,0
	BRNE _0x2E9
	__GETWRN 18,19,19
	__GETWRN 20,21,38
	LDI  R30,LOW(45)
	LDI  R31,HIGH(45)
	STD  Y+6,R30
	STD  Y+6+1,R31
; 0000 0295 for (m=val1;m<val2;m++){
_0x2E9:
	MOVW R16,R18
_0x2EB:
	__CPWRR 16,17,20,21
	BRLO PC+2
	RJMP _0x2EC
; 0000 0296 
; 0000 0297 //led_red_on;
; 0000 0298 /*if(skz1or2==1)led_red_on;
; 0000 0299 else {led_red_off;
; 0000 029A      if(!warning_flag)led_green_off;
; 0000 029B      else led_green_on;}*/
; 0000 029C rx_c_master=0;rx_m_master=0;rx_wr_index_master=0;rx_counter_master=0;
	CLT
	BLD  R2,2
	BLD  R2,1
	LDI  R30,LOW(0)
	STS  _rx_wr_index_master,R30
	STS  _rx_counter_master,R30
; 0000 029D rx_buffer_master[0]=0;
	STS  _rx_buffer_master,R30
; 0000 029E rx_buffer_master[1]=0;
	__PUTB1MN _rx_buffer_master,1
; 0000 029F rx_buffer_master[2]=0;
	__PUTB1MN _rx_buffer_master,2
; 0000 02A0 rx_buffer_master[3]=0;
	__PUTB1MN _rx_buffer_master,3
; 0000 02A1 rx_buffer_master[4]=0;
	__PUTB1MN _rx_buffer_master,4
; 0000 02A2 rx_buffer_master[5]=0;
	__PUTB1MN _rx_buffer_master,5
; 0000 02A3 rx_buffer_master[6]=0;
	__PUTB1MN _rx_buffer_master,6
; 0000 02A4 rx_buffer_master[7]=0;
	__PUTB1MN _rx_buffer_master,7
; 0000 02A5 rx_buffer_master[8]=0;
	__PUTB1MN _rx_buffer_master,8
; 0000 02A6 rx_buffer_master[9]=0;
	__PUTB1MN _rx_buffer_master,9
; 0000 02A7 crc_master=0xFFFF;
	LDI  R30,LOW(65535)
	LDI  R31,HIGH(65535)
	STS  _crc_master,R30
	STS  _crc_master+1,R31
; 0000 02A8 mov_buf_master(0x01);
	LDI  R26,LOW(1)
	CALL _mov_buf_master
; 0000 02A9 mov_buf_master(0x04);
	LDI  R26,LOW(4)
	CALL _mov_buf_master
; 0000 02AA mov_buf_master(0x00);
	LDI  R26,LOW(0)
	CALL _mov_buf_master
; 0000 02AB mov_buf_master(m+addrval);
	LDD  R26,Y+6
	ADD  R26,R16
	CALL _mov_buf_master
; 0000 02AC mov_buf_master(0x00);
	LDI  R26,LOW(0)
	CALL _mov_buf_master
; 0000 02AD mov_buf_master(0x01);
	LDI  R26,LOW(1)
	CALL _mov_buf_master
; 0000 02AE crc_end_master();
	CALL _crc_end_master
; 0000 02AF 
; 0000 02B0 whait_read;
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	OUT  0x2C+1,R31
	OUT  0x2C,R30
	LDI  R30,LOW(3)
	OUT  0x2E,R30
_0x2ED:
	IN   R30,0x36
	SBRS R30,2
	RJMP _0x2ED
	LDI  R30,LOW(0)
	OUT  0x2E,R30
	IN   R30,0x36
	OUT  0x36,R30
; 0000 02B1 //delay_ms(65);
; 0000 02B2  /*if((skz1or2==0)&&(blink_flag==1)&&(warning_flag==0)){
; 0000 02B3  led_red_off;
; 0000 02B4  led_green_off;
; 0000 02B5  delay_ms(300);} */
; 0000 02B6 
; 0000 02B7 //if(BKI_state_sent==0){;}
; 0000 02B8 
; 0000 02B9 if (check_cr_master()==1)
	CALL _check_cr_master
	CPI  R30,LOW(0x1)
	BRNE _0x2F0
; 0000 02BA               {SKZ_read=0;
	LDI  R30,LOW(0)
	STS  _SKZ_read,R30
	STS  _SKZ_read+1,R30
; 0000 02BB               if(rx_counter_master==7){SKZ_read=((unsigned int)rx_buffer_master[3]<<8)+rx_buffer_master[4];BPS_absent=0; ...
	LDS  R26,_rx_counter_master
	CPI  R26,LOW(0x7)
	BRNE _0x2F1
	__GETBRMN 27,_rx_buffer_master,3
	LDI  R26,LOW(0)
	__GETB1MN _rx_buffer_master,4
	LDI  R31,0
	ADD  R30,R26
	ADC  R31,R27
	STS  _SKZ_read,R30
	STS  _SKZ_read+1,R31
	LDI  R30,LOW(0)
	STS  _BPS_absent,R30
	STS  _BPS_absent+1,R30
_0x2F1:
; 0000 02BC               else BPS_absent=1;
	RJMP _0x2F2
_0x2F0:
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	STS  _BPS_absent,R30
	STS  _BPS_absent+1,R31
; 0000 02BD               #asm(" sei")
_0x2F2:
	 sei
; 0000 02BE               EEPROM_write(0x0405+2*m, rx_buffer_master[3]);
	__MULBNWRU 16,17,2
	SUBI R30,LOW(-1029)
	SBCI R31,HIGH(-1029)
	ST   -Y,R31
	ST   -Y,R30
	__GETB2MN _rx_buffer_master,3
	RCALL _EEPROM_write
; 0000 02BF               EEPROM_write(0x0405+2*m+1, rx_buffer_master[4] );
	__MULBNWRU 16,17,2
	SUBI R30,LOW(-1030)
	SBCI R31,HIGH(-1030)
	ST   -Y,R31
	ST   -Y,R30
	__GETB2MN _rx_buffer_master,4
	RCALL _EEPROM_write
; 0000 02C0               #asm(" cli")
	 cli
; 0000 02C1 
; 0000 02C2 //              blink_display (rx_buffer_master[3]);
; 0000 02C3 //              blink_display (rx_buffer_master[4]);
; 0000 02C4 }
	__ADDWRN 16,17,1
	RJMP _0x2EB
_0x2EC:
; 0000 02C5  ProcessingEEPROM=0;led_calibration_off;if(warning_flag)led_warning_on; blink_on(); }
	CLT
	BLD  R2,5
	CBI  0x1B,2
	LDS  R30,_warning_flag
	LDS  R31,_warning_flag+1
	SBIW R30,0
	BREQ _0x2F5
	LDS  R30,98
	ORI  R30,0x10
	STS  98,R30
_0x2F5:
	RCALL _blink_on
	CALL __LOADLOCR6
	ADIW R28,10
	RET
; .FEND
;
;
;void save_freq_order()//функция читает порядок частот и сохраняет в БКИ
; 0000 02C9 {unsigned int m;      // а также сразу сохраняет его в памяти eeprom БКИ
_save_freq_order:
; .FSTART _save_freq_order
; 0000 02CA unsigned int val,addrval;
; 0000 02CB val=0;addrval=0x60;ProcessingEEPROM=1;        //адреса addrval подобраны исходя из адресов команд модбас для чтения указ ...
	CALL __SAVELOCR6
;	m -> R16,R17
;	val -> R18,R19
;	addrval -> R20,R21
	__GETWRN 18,19,0
	__GETWRN 20,21,96
	SET
	BLD  R2,5
; 0000 02CC for (m=val;m<19;m++){
	MOVW R16,R18
_0x2F7:
	__CPWRN 16,17,19
	BRLO PC+2
	RJMP _0x2F8
; 0000 02CD led_warning_off;
	LDS  R30,98
	ANDI R30,0xEF
	STS  98,R30
; 0000 02CE led_calibration_on;
	SBI  0x1B,2
; 0000 02CF blink_off();
	RCALL _blink_off
; 0000 02D0 //led_red_on;
; 0000 02D1 /*if(skz1or2==1)led_red_on;
; 0000 02D2 else {led_red_off;
; 0000 02D3      if(!warning_flag)led_green_off;
; 0000 02D4      else led_green_on;}*/
; 0000 02D5 rx_c_master=0;rx_m_master=0;rx_wr_index_master=0;rx_counter_master=0;ClearBuf_master;
	CLT
	BLD  R2,2
	BLD  R2,1
	LDI  R30,LOW(0)
	STS  _rx_wr_index_master,R30
	STS  _rx_counter_master,R30
	STS  _rx_buffer_master,R30
	__PUTB1MN _rx_buffer_master,1
	__PUTB1MN _rx_buffer_master,2
	__PUTB1MN _rx_buffer_master,3
	__PUTB1MN _rx_buffer_master,4
	__PUTB1MN _rx_buffer_master,5
	__PUTB1MN _rx_buffer_master,6
	__PUTB1MN _rx_buffer_master,7
	__PUTB1MN _rx_buffer_master,8
	__PUTB1MN _rx_buffer_master,9
; 0000 02D6 crc_master=0xFFFF;
	LDI  R30,LOW(65535)
	LDI  R31,HIGH(65535)
	STS  _crc_master,R30
	STS  _crc_master+1,R31
; 0000 02D7 mov_buf_master(0x01);
	LDI  R26,LOW(1)
	CALL _mov_buf_master
; 0000 02D8 mov_buf_master(0x04);
	LDI  R26,LOW(4)
	CALL _mov_buf_master
; 0000 02D9 mov_buf_master(0x00);
	LDI  R26,LOW(0)
	CALL _mov_buf_master
; 0000 02DA mov_buf_master(m+addrval);
	MOV  R26,R20
	ADD  R26,R16
	CALL _mov_buf_master
; 0000 02DB mov_buf_master(0x00);
	LDI  R26,LOW(0)
	CALL _mov_buf_master
; 0000 02DC mov_buf_master(0x01);
	LDI  R26,LOW(1)
	CALL _mov_buf_master
; 0000 02DD crc_end_master();
	CALL _crc_end_master
; 0000 02DE 
; 0000 02DF //delay_ms(65);
; 0000 02E0 whait_read;
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	OUT  0x2C+1,R31
	OUT  0x2C,R30
	LDI  R30,LOW(3)
	OUT  0x2E,R30
_0x2FB:
	IN   R30,0x36
	SBRS R30,2
	RJMP _0x2FB
	LDI  R30,LOW(0)
	OUT  0x2E,R30
	IN   R30,0x36
	OUT  0x36,R30
; 0000 02E1  /*if((skz1or2==0)&&(blink_flag==1)&&(warning_flag==0)){
; 0000 02E2  led_red_off;
; 0000 02E3  led_green_off;
; 0000 02E4  delay_ms(300);} */
; 0000 02E5 
; 0000 02E6 //delay_ms(15000);
; 0000 02E7 if (check_cr_master()==1)
	CALL _check_cr_master
	CPI  R30,LOW(0x1)
	BRNE _0x2FE
; 0000 02E8               {SKZ_read=0;
	LDI  R30,LOW(0)
	STS  _SKZ_read,R30
	STS  _SKZ_read+1,R30
; 0000 02E9               if(rx_counter_master==7){FreqOrder_read=rx_buffer_master[3]|rx_buffer_master[4];BPS_absent=0;}}
	LDS  R26,_rx_counter_master
	CPI  R26,LOW(0x7)
	BRNE _0x2FF
	__GETB2MN _rx_buffer_master,3
	__GETB1MN _rx_buffer_master,4
	OR   R30,R26
	STS  _FreqOrder_read,R30
	LDI  R30,LOW(0)
	STS  _BPS_absent,R30
	STS  _BPS_absent+1,R30
_0x2FF:
; 0000 02EA               else BPS_absent=1;
	RJMP _0x300
_0x2FE:
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	STS  _BPS_absent,R30
	STS  _BPS_absent+1,R31
; 0000 02EB               #asm(" sei")
_0x300:
	 sei
; 0000 02EC               EEPROM_write(eeAddressFirstFreq, FreqOrder_read);
	LDI  R30,LOW(1541)
	LDI  R31,HIGH(1541)
	ST   -Y,R31
	ST   -Y,R30
	LDS  R26,_FreqOrder_read
	RCALL _EEPROM_write
; 0000 02ED               #asm(" cli")
	 cli
; 0000 02EE 
; 0000 02EF //              blink_display (rx_buffer_master[3]);
; 0000 02F0 //              blink_display (rx_buffer_master[4]);
; 0000 02F1 }ProcessingEEPROM=0;led_calibration_off;if(warning_flag)led_warning_on; blink_on(); }
	__ADDWRN 16,17,1
	RJMP _0x2F7
_0x2F8:
	CLT
	BLD  R2,5
	CBI  0x1B,2
	LDS  R30,_warning_flag
	LDS  R31,_warning_flag+1
	SBIW R30,0
	BREQ _0x303
	LDS  R30,98
	ORI  R30,0x10
	STS  98,R30
_0x303:
	RCALL _blink_on
	CALL __LOADLOCR6
	ADIW R28,6
	RET
; .FEND
;
;/*void recieve_skz_array()
;{unsigned int m;
;rx_c_master=0;rx_m_master=0;rx_wr_index_master=0;rx_counter_master=0;
;for(m=0;m<80;m++)rx_buffer_master[m]=0;
;if (check_cr_master()==1){
;if(rx_counter_master==80){
;for (m=0;m<38;m++)
;{
; //#asm(" sei")
; EEPROM_write(eeAdrSKZ1ar+m, rx_buffer_master[m+2] );               //сохраняем его в еепром
;// #asm(" cli")}
; for (m=0;m<38;m++)
;{
;// #asm(" sei")
; EEPROM_write(eeAdrSKZ2ar+m, rx_buffer_master[m+40] );               //сохраняем его в еепром
;// #asm(" cli")}            } }
;} */
;
;void send_frequency_value()              //функция отправляющая на БПС значение величину количества рабочих частот, сохр ...
; 0000 0306 {unsigned int m;
_send_frequency_value:
; .FSTART _send_frequency_value
; 0000 0307 rx_c_master=0;rx_m_master=0;
	ST   -Y,R17
	ST   -Y,R16
;	m -> R16,R17
	CLT
	BLD  R2,2
	BLD  R2,1
; 0000 0308 rx_wr_index_master=0;rx_counter_master=0;
	LDI  R30,LOW(0)
	STS  _rx_wr_index_master,R30
	STS  _rx_counter_master,R30
; 0000 0309 rx_c_slave=0;rx_m_slave=0;
	BLD  R3,5
	BLD  R3,4
; 0000 030A rx_wr_index_slave=0;rx_counter_slave=0;
	STS  _rx_wr_index_slave,R30
	STS  _rx_counter_slave,R30
; 0000 030B //for(m=0;m<80;m++)tx_buffer_master[m]=0;
; 0000 030C crc_master=0xFFFF;
	LDI  R30,LOW(65535)
	LDI  R31,HIGH(65535)
	STS  _crc_master,R30
	STS  _crc_master+1,R31
; 0000 030D mov_buf_master(0x01);
	LDI  R26,LOW(1)
	CALL _mov_buf_master
; 0000 030E mov_buf_master(0xcc);
	LDI  R26,LOW(204)
	CALL _mov_buf_master
; 0000 030F mov_buf_master(FrequencyQ);
	LDS  R26,_FrequencyQ
	CALL _mov_buf_master
; 0000 0310 mov_buf_master(FrequencyQ);
	LDS  R26,_FrequencyQ
	CALL _mov_buf_master
; 0000 0311  crc_end_master();
	RJMP _0x20A0003
; 0000 0312 }
; .FEND
;
;void send_SKZMIN_value()              //функция отправляющая на БПС величину минимального СКЗ сохраненные в еепром БКИ
; 0000 0315 {unsigned int m;
_send_SKZMIN_value:
; .FSTART _send_SKZMIN_value
; 0000 0316 rx_c_master=0;rx_m_master=0;
	ST   -Y,R17
	ST   -Y,R16
;	m -> R16,R17
	CLT
	BLD  R2,2
	BLD  R2,1
; 0000 0317 rx_wr_index_master=0;rx_counter_master=0;
	LDI  R30,LOW(0)
	STS  _rx_wr_index_master,R30
	STS  _rx_counter_master,R30
; 0000 0318 rx_c_slave=0;rx_m_slave=0;
	BLD  R3,5
	BLD  R3,4
; 0000 0319 rx_wr_index_slave=0;rx_counter_slave=0;
	STS  _rx_wr_index_slave,R30
	STS  _rx_counter_slave,R30
; 0000 031A //for(m=0;m<80;m++)tx_buffer_master[m]=0;
; 0000 031B crc_master=0xFFFF;
	LDI  R30,LOW(65535)
	LDI  R31,HIGH(65535)
	STS  _crc_master,R30
	STS  _crc_master+1,R31
; 0000 031C mov_buf_master(0x01);
	LDI  R26,LOW(1)
	CALL _mov_buf_master
; 0000 031D mov_buf_master(0xcb);
	LDI  R26,LOW(203)
	CALL _mov_buf_master
; 0000 031E mov_buf_master((char)(minimal_SKZ_val>>8));
	LDS  R30,_minimal_SKZ_val+1
	MOV  R26,R30
	CALL _mov_buf_master
; 0000 031F mov_buf_master(minimal_SKZ_val);
	LDS  R26,_minimal_SKZ_val
	CALL _mov_buf_master
; 0000 0320  crc_end_master();
	CALL _crc_end_master
; 0000 0321  whait_read;
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	OUT  0x2C+1,R31
	OUT  0x2C,R30
	LDI  R30,LOW(3)
	OUT  0x2E,R30
_0x304:
	IN   R30,0x36
	SBRS R30,2
	RJMP _0x304
	LDI  R30,LOW(0)
	OUT  0x2E,R30
	IN   R30,0x36
	OUT  0x36,R30
; 0000 0322 }
	RJMP _0x20A0004
; .FEND
;void send_minimal_operat_val()              //функция отправляющая на БПС величину значения СКЗ, соответствующего уровню ...
; 0000 0324 {unsigned int m;
_send_minimal_operat_val:
; .FSTART _send_minimal_operat_val
; 0000 0325 rx_c_master=0;rx_m_master=0;
	ST   -Y,R17
	ST   -Y,R16
;	m -> R16,R17
	CLT
	BLD  R2,2
	BLD  R2,1
; 0000 0326 rx_wr_index_master=0;rx_counter_master=0;
	LDI  R30,LOW(0)
	STS  _rx_wr_index_master,R30
	STS  _rx_counter_master,R30
; 0000 0327 rx_c_slave=0;rx_m_slave=0;
	BLD  R3,5
	BLD  R3,4
; 0000 0328 rx_wr_index_slave=0;rx_counter_slave=0;
	STS  _rx_wr_index_slave,R30
	STS  _rx_counter_slave,R30
; 0000 0329 //for(m=0;m<80;m++)tx_buffer_master[m]=0;
; 0000 032A crc_master=0xFFFF;
	LDI  R30,LOW(65535)
	LDI  R31,HIGH(65535)
	STS  _crc_master,R30
	STS  _crc_master+1,R31
; 0000 032B mov_buf_master(0x01);
	LDI  R26,LOW(1)
	CALL _mov_buf_master
; 0000 032C mov_buf_master(0xcf);
	LDI  R26,LOW(207)
	CALL _mov_buf_master
; 0000 032D mov_buf_master((int)(minimal_object_enabled_level>>8));
	LDS  R30,_minimal_object_enabled_level+1
	MOV  R26,R30
	CALL _mov_buf_master
; 0000 032E mov_buf_master(minimal_object_enabled_level);
	LDS  R26,_minimal_object_enabled_level
	CALL _mov_buf_master
; 0000 032F  crc_end_master();
	CALL _crc_end_master
; 0000 0330  whait_read;
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	OUT  0x2C+1,R31
	OUT  0x2C,R30
	LDI  R30,LOW(3)
	OUT  0x2E,R30
_0x307:
	IN   R30,0x36
	SBRS R30,2
	RJMP _0x307
	LDI  R30,LOW(0)
	OUT  0x2E,R30
	IN   R30,0x36
	OUT  0x36,R30
; 0000 0331 //transmitter_on;TX_slave_on;printf("eval1=%d eval2=%d\r\n",(int)(minimal_object_enabled_level>>8),minimal_object_enable ...
; 0000 0332 }
	RJMP _0x20A0004
; .FEND
;void send_skz_array()              //функция отправляющая на БПС значение массивов СКЗ1 и СКЗ2 сохраненные в еепром БКИ
; 0000 0334 {unsigned int m;
_send_skz_array:
; .FSTART _send_skz_array
; 0000 0335 rx_c_master=0;rx_m_master=0;
	ST   -Y,R17
	ST   -Y,R16
;	m -> R16,R17
	CLT
	BLD  R2,2
	BLD  R2,1
; 0000 0336 rx_wr_index_master=0;rx_counter_master=0;
	LDI  R30,LOW(0)
	STS  _rx_wr_index_master,R30
	STS  _rx_counter_master,R30
; 0000 0337 rx_c_slave=0;rx_m_slave=0;
	BLD  R3,5
	BLD  R3,4
; 0000 0338 rx_wr_index_slave=0;rx_counter_slave=0;
	STS  _rx_wr_index_slave,R30
	STS  _rx_counter_slave,R30
; 0000 0339 //for(m=0;m<80;m++)tx_buffer_master[m]=0;
; 0000 033A crc_master=0xFFFF;
	LDI  R30,LOW(65535)
	LDI  R31,HIGH(65535)
	STS  _crc_master,R30
	STS  _crc_master+1,R31
; 0000 033B mov_buf_master(0x01);
	LDI  R26,LOW(1)
	CALL _mov_buf_master
; 0000 033C mov_buf_master(0xcd);
	LDI  R26,LOW(205)
	CALL _mov_buf_master
; 0000 033D for (m=0;m<76;m++)
	__GETWRN 16,17,0
_0x30B:
	__CPWRN 16,17,76
	BRSH _0x30C
; 0000 033E {
; 0000 033F // #asm(" sei")
; 0000 0340  mov_buf_master(EEPROM_read(0x0405+m));    }           //читаем массив из памяти
	MOVW R26,R16
	SUBI R26,LOW(-1029)
	SBCI R27,HIGH(-1029)
	CALL _EEPROM_read
	MOV  R26,R30
	CALL _mov_buf_master
	__ADDWRN 16,17,1
	RJMP _0x30B
_0x30C:
; 0000 0341 // #asm(" cli")}
; 0000 0342  crc_end_master();
	RJMP _0x20A0003
; 0000 0343 }
; .FEND
;
;void send_freq_order()              //функция отправляющая на БПС значение массивов СКЗ1 и СКЗ2 сохраненные в еепром БКИ
; 0000 0346 {unsigned int m;
_send_freq_order:
; .FSTART _send_freq_order
; 0000 0347 rx_c_master=0;rx_m_master=0;
	ST   -Y,R17
	ST   -Y,R16
;	m -> R16,R17
	CLT
	BLD  R2,2
	BLD  R2,1
; 0000 0348 rx_wr_index_master=0;rx_counter_master=0;
	LDI  R30,LOW(0)
	STS  _rx_wr_index_master,R30
	STS  _rx_counter_master,R30
; 0000 0349 //for(m=0;m<80;m++)tx_buffer_master[m]=0;
; 0000 034A crc_master=0xFFFF;
	LDI  R30,LOW(65535)
	LDI  R31,HIGH(65535)
	STS  _crc_master,R30
	STS  _crc_master+1,R31
; 0000 034B mov_buf_master(0x01);
	LDI  R26,LOW(1)
	CALL _mov_buf_master
; 0000 034C mov_buf_master(0xce);
	LDI  R26,LOW(206)
	CALL _mov_buf_master
; 0000 034D for (m=0;m<19;m++)
	__GETWRN 16,17,0
_0x30E:
	__CPWRN 16,17,19
	BRSH _0x30F
; 0000 034E {
; 0000 034F // #asm(" sei")
; 0000 0350  mov_buf_master(EEPROM_read(eeAddressFirstFreq+m));    }           //читаем массив из памяти
	MOVW R26,R16
	SUBI R26,LOW(-1541)
	SBCI R27,HIGH(-1541)
	CALL _EEPROM_read
	MOV  R26,R30
	CALL _mov_buf_master
	__ADDWRN 16,17,1
	RJMP _0x30E
_0x30F:
; 0000 0351 // #asm(" cli")}
; 0000 0352  crc_end_master();
_0x20A0003:
	CALL _crc_end_master
; 0000 0353 }
_0x20A0004:
	LD   R16,Y+
	LD   R17,Y+
	RET
; .FEND
;
;void go_main_menu(){
; 0000 0355 void go_main_menu(){
; 0000 0356 //TX_master_on;
; 0000 0357 TX_slave_on;
; 0000 0358 printf("\r\n if you want to set Modbus address please type 'a' letter \r\n");
; 0000 0359 printf("\r\n if you want to set Averaging out time value please type 'v' letter \r\n");
; 0000 035A printf("\r\n if you want to set the number of working frequencies please type 'f' letter \r\n");
; 0000 035B printf("\r\n if you want to set the minimal SKZ value in ADC units please type 'm' letter \r\n");
; 0000 035C printf("\r\n if you want to overview the current configuration  please type 'o' letter \r\n");
; 0000 035D //TX_master_off;
; 0000 035E TX_slave_off;
; 0000 035F }
;
;void echo_answer_0x03(){
; 0000 0361 void echo_answer_0x03(){
; 0000 0362 crc_slave=0xFFFF;
; 0000 0363 mov_buf_slave(rx_buffer_slave[0]);
; 0000 0364 mov_buf_slave(rx_buffer_slave[1]);
; 0000 0365 mov_buf_slave(rx_buffer_slave[2]);
; 0000 0366 mov_buf_slave(rx_buffer_slave[3]);
; 0000 0367 mov_buf_slave(rx_buffer_slave[4]);
; 0000 0368 crc_end_slave();
; 0000 0369 //whait_read;
; 0000 036A }
;
;void echo_answer_0x06(){
; 0000 036C void echo_answer_0x06(){
; 0000 036D mov_buf_slave(rx_buffer_slave[0]);
; 0000 036E mov_buf_slave(rx_buffer_slave[1]);
; 0000 036F mov_buf_slave(rx_buffer_slave[2]);
; 0000 0370 mov_buf_slave(rx_buffer_slave[3]);
; 0000 0371 mov_buf_slave(rx_buffer_slave[4]);
; 0000 0372 mov_buf_slave(rx_buffer_slave[5]);
; 0000 0373 crc_end_slave();
; 0000 0374 //whait_read;
; 0000 0375 }
;
;int ind_select(signed int ind_val){
; 0000 0377 int ind_select(signed int ind_val){
_ind_select:
; .FSTART _ind_select
; 0000 0378 signed int out_val;
; 0000 0379 if(ind_val>=90)out_val=1;
	ST   -Y,R27
	ST   -Y,R26
	ST   -Y,R17
	ST   -Y,R16
;	ind_val -> Y+2
;	out_val -> R16,R17
	LDD  R26,Y+2
	LDD  R27,Y+2+1
	CPI  R26,LOW(0x5A)
	LDI  R30,HIGH(0x5A)
	CPC  R27,R30
	BRLT _0x310
	__GETWRN 16,17,1
; 0000 037A if((ind_val>10)&(ind_val<90))out_val=(99-ind_val)/10+1;
_0x310:
	LDD  R26,Y+2
	LDD  R27,Y+2+1
	LDI  R30,LOW(10)
	LDI  R31,HIGH(10)
	CALL __GTW12
	MOV  R0,R30
	LDI  R30,LOW(90)
	LDI  R31,HIGH(90)
	CALL __LTW12
	AND  R30,R0
	BREQ _0x311
	LDI  R30,LOW(99)
	LDI  R31,HIGH(99)
	SUB  R30,R26
	SBC  R31,R27
	MOVW R26,R30
	LDI  R30,LOW(10)
	LDI  R31,HIGH(10)
	CALL __DIVW21
	ADIW R30,1
	MOVW R16,R30
; 0000 037B if((ind_val<=10)&(ind_val>=0))out_val=10;
_0x311:
	LDD  R26,Y+2
	LDD  R27,Y+2+1
	LDI  R30,LOW(10)
	LDI  R31,HIGH(10)
	CALL __LEW12
	MOV  R0,R30
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	CALL __GEW12
	AND  R30,R0
	BREQ _0x312
	__GETWRN 16,17,10
; 0000 037C if((ind_val<0)&(ind_val>-90))out_val=(100-ind_val)/10+1;
_0x312:
	LDD  R26,Y+2
	LDD  R27,Y+2+1
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	CALL __LTW12
	MOV  R0,R30
	LDI  R30,LOW(65446)
	LDI  R31,HIGH(65446)
	CALL __GTW12
	AND  R30,R0
	BREQ _0x313
	LDI  R30,LOW(100)
	LDI  R31,HIGH(100)
	SUB  R30,R26
	SBC  R31,R27
	MOVW R26,R30
	LDI  R30,LOW(10)
	LDI  R31,HIGH(10)
	CALL __DIVW21
	ADIW R30,1
	MOVW R16,R30
; 0000 037D if(ind_val<=-90)out_val=20;
_0x313:
	LDD  R26,Y+2
	LDD  R27,Y+2+1
	LDI  R30,LOW(65446)
	LDI  R31,HIGH(65446)
	CP   R30,R26
	CPC  R31,R27
	BRLT _0x314
	__GETWRN 16,17,20
; 0000 037E return out_val;}
_0x314:
	MOVW R30,R16
	LDD  R17,Y+1
	LDD  R16,Y+0
	ADIW R28,4
	RET
; .FEND
;
;//int ind_select(signed int ind_val){
;//signed int out_val;
;//if(ind_val<=-90)out_val=1;
;//if((ind_val<-9)&(ind_val>-90))out_val=(ind_val+100)/10+1;
;//if((ind_val>-9)&(ind_val<0))out_val=10;
;//if((ind_val>=0)&(ind_val<90))out_val=(ind_val+100)/10+1;
;//if(ind_val>=90)out_val=20;
;//return out_val;}
;
;void print_int(unsigned int int_val){
; 0000 0389 void print_int(unsigned int int_val){
; 0000 038A unsigned char char_val[3], dig_counter=0;
; 0000 038B char_val[0]=int_val/100+0x30;
;	int_val -> Y+4
;	char_val -> Y+1
;	dig_counter -> R17
; 0000 038C int_val=int_val%100;
; 0000 038D char_val[1]=int_val/10+0x30;
; 0000 038E int_val=int_val%10;
; 0000 038F char_val[2]=int_val+0x30;
; 0000 0390 for (dig_counter=0;dig_counter<3;dig_counter++)putchar(char_val[dig_counter]);}
;
;void print_int5(unsigned int int_val){
; 0000 0392 void print_int5(unsigned int int_val){
; 0000 0393 unsigned char char_val[5], dig_counter=0;
; 0000 0394 char_val[0]=int_val/10000+0x30;
;	int_val -> Y+6
;	char_val -> Y+1
;	dig_counter -> R17
; 0000 0395 int_val=int_val%10000;
; 0000 0396 char_val[1]=int_val/1000+0x30;
; 0000 0397 int_val=int_val%1000;
; 0000 0398 char_val[2]=int_val/100+0x30;
; 0000 0399 int_val=int_val%100;
; 0000 039A char_val[3]=int_val/10+0x30;
; 0000 039B int_val=int_val%10;
; 0000 039C char_val[4]=int_val+0x30;
; 0000 039D for (dig_counter=0;dig_counter<5;dig_counter++)putchar(char_val[dig_counter]);}
;
;
;void terminal_commander(unsigned char RData, int mode){
; 0000 03A0 void terminal_commander(unsigned char RData, int mode){
_terminal_commander:
; .FSTART _terminal_commander
; 0000 03A1 
; 0000 03A2 if(ModbusMessage==62){EEPROM_write(eeAddressAverTimeV,AverTime_Value);EEPROM_write(eeAddressFreqQ,FrequencyQ);send_frequ ...
	ST   -Y,R27
	ST   -Y,R26
;	RData -> Y+2
;	mode -> Y+0
	LDS  R26,_ModbusMessage
	LDS  R27,_ModbusMessage+1
	SBIW R26,62
	BRNE _0x31B
	LDI  R30,LOW(1537)
	LDI  R31,HIGH(1537)
	ST   -Y,R31
	ST   -Y,R30
	LDS  R26,_AverTime_Value
	CALL _EEPROM_write
	LDI  R30,LOW(1538)
	LDI  R31,HIGH(1538)
	ST   -Y,R31
	ST   -Y,R30
	LDS  R26,_FrequencyQ
	CALL _EEPROM_write
	RCALL _send_frequency_value
	LDI  R30,LOW(0)
	STS  _ModbusMessage,R30
	STS  _ModbusMessage+1,R30
; 0000 03A3 if(ModbusMessage==63){EEPROM_write(eeAddressModBusAddr,ModBusAddress);ModbusMessage=0;}
_0x31B:
	LDS  R26,_ModbusMessage
	LDS  R27,_ModbusMessage+1
	SBIW R26,63
	BRNE _0x31C
	LDI  R30,LOW(1536)
	LDI  R31,HIGH(1536)
	ST   -Y,R31
	ST   -Y,R30
	LDS  R26,_ModBusAddress
	CALL _EEPROM_write
	LDI  R30,LOW(0)
	STS  _ModbusMessage,R30
	STS  _ModbusMessage+1,R30
; 0000 03A4 if(ModbusMessage==64){EEPROM_write(eeAddressMINSKZH,(unsigned char)(minimal_SKZ_val>>8));EEPROM_write(eeAddressMINSKZL,( ...
_0x31C:
	LDS  R26,_ModbusMessage
	LDS  R27,_ModbusMessage+1
	CPI  R26,LOW(0x40)
	LDI  R30,HIGH(0x40)
	CPC  R27,R30
	BRNE _0x31D
	LDI  R30,LOW(1539)
	LDI  R31,HIGH(1539)
	ST   -Y,R31
	ST   -Y,R30
	LDS  R30,_minimal_SKZ_val+1
	MOV  R26,R30
	CALL _EEPROM_write
	LDI  R30,LOW(1540)
	LDI  R31,HIGH(1540)
	ST   -Y,R31
	ST   -Y,R30
	LDS  R26,_minimal_SKZ_val
	CALL _EEPROM_write
	RCALL _send_SKZMIN_value
	LDI  R30,LOW(0)
	STS  _ModbusMessage,R30
	STS  _ModbusMessage+1,R30
; 0000 03A5 if(ModbusMessage==65){EEPROM_write(eeAddressMINOPLH,(unsigned char)(minimal_object_enabled_level>>8));EEPROM_write(eeAdd ...
_0x31D:
	LDS  R26,_ModbusMessage
	LDS  R27,_ModbusMessage+1
	CPI  R26,LOW(0x41)
	LDI  R30,HIGH(0x41)
	CPC  R27,R30
	BRNE _0x31E
	LDI  R30,LOW(1542)
	LDI  R31,HIGH(1542)
	ST   -Y,R31
	ST   -Y,R30
	LDS  R30,_minimal_object_enabled_level+1
	MOV  R26,R30
	CALL _EEPROM_write
	LDI  R30,LOW(1543)
	LDI  R31,HIGH(1543)
	ST   -Y,R31
	ST   -Y,R30
	LDS  R26,_minimal_object_enabled_level
	CALL _EEPROM_write
	RCALL _send_minimal_operat_val
	LDI  R30,LOW(0)
	STS  _ModbusMessage,R30
	STS  _ModbusMessage+1,R30
; 0000 03A6 new_message=0;
_0x31E:
	CLT
	BLD  R2,3
; 0000 03A7 }
	ADIW R28,3
	RET
; .FEND
;
;//{crc_master=0xFFFF;mov_buf_master(0x01);mov_buf_master(0x06);mov_buf_master(0x00);mov_buf_master(0x82);mov_buf_master( ...
;
;
;
;void main(void)
; 0000 03AE {
_main:
; .FSTART _main
; 0000 03AF //signed int AverSKZ_Value=0;
; 0000 03B0 int k=0,no_press=1;
; 0000 03B1 signed int x1,x2;
; 0000 03B2 char disabling_counter=0,object_state_tmp;
; 0000 03B3 //char n;
; 0000 03B4 float y;
; 0000 03B5 //,reg1,reg2,reg;
; 0000 03B6 DDRA=0b11111111;
	SBIW R28,8
	LDI  R30,LOW(0)
	STD  Y+5,R30
;	k -> R16,R17
;	no_press -> R18,R19
;	x1 -> R20,R21
;	x2 -> Y+6
;	disabling_counter -> Y+5
;	object_state_tmp -> Y+4
;	y -> Y+0
	__GETWRN 16,17,0
	__GETWRN 18,19,1
	LDI  R30,LOW(255)
	OUT  0x1A,R30
; 0000 03B7 PORTA=0b00000000;
	LDI  R30,LOW(0)
	OUT  0x1B,R30
; 0000 03B8 //DDRB=0b00001100;PORTB=0b00000000;
; 0000 03B9 DDRC=0b11011111;PORTC=0b00100000;
	LDI  R30,LOW(223)
	OUT  0x14,R30
	LDI  R30,LOW(32)
	OUT  0x15,R30
; 0000 03BA DDRD=0b00011000;PORTD=0b10000000;
	LDI  R30,LOW(24)
	OUT  0x11,R30
	LDI  R30,LOW(128)
	OUT  0x12,R30
; 0000 03BB //PORTE=0b00000000;DDRE=0b00000110;
; 0000 03BC DDRF=0b11111111;PORTF=0b00000000;
	LDI  R30,LOW(255)
	STS  97,R30
	LDI  R30,LOW(0)
	STS  98,R30
; 0000 03BD DDRG=0b00000000;PORTG=0b00000000;
	STS  100,R30
	STS  101,R30
; 0000 03BE UCSR0A=0x00;UCSR0B=0xD8;UCSR0C=0x06;UBRR0H=0x00;UBRR0L=0x2F;
	OUT  0xB,R30
	LDI  R30,LOW(216)
	OUT  0xA,R30
	LDI  R30,LOW(6)
	STS  149,R30
	LDI  R30,LOW(0)
	STS  144,R30
	LDI  R30,LOW(47)
	OUT  0x9,R30
; 0000 03BF UCSR1A=0x00;UCSR1B=0xD8;UCSR1C=0x06;UBRR1H=0x00;UBRR1L=0x2F;
	LDI  R30,LOW(0)
	STS  155,R30
	LDI  R30,LOW(216)
	STS  154,R30
	LDI  R30,LOW(6)
	STS  157,R30
	LDI  R30,LOW(0)
	STS  152,R30
	LDI  R30,LOW(47)
	STS  153,R30
; 0000 03C0 DDRC.0=1;
	SBI  0x14,0
; 0000 03C1 ACSR=0x80;SFIOR=0x00;ASSR=0x00;
	LDI  R30,LOW(128)
	OUT  0x8,R30
	LDI  R30,LOW(0)
	OUT  0x20,R30
	OUT  0x30,R30
; 0000 03C2 TCCR0=0x02;TCNT0=0x00;OCR0=0x00;
	LDI  R30,LOW(2)
	OUT  0x33,R30
	LDI  R30,LOW(0)
	OUT  0x32,R30
	OUT  0x31,R30
; 0000 03C3 DDRB=0x37;
	LDI  R30,LOW(55)
	OUT  0x17,R30
; 0000 03C4 PORTB=0x31;   //CS
	LDI  R30,LOW(49)
	OUT  0x18,R30
; 0000 03C5 //PORTB.5=1;   //CLR
; 0000 03C6 // SPI initialization
; 0000 03C7 // SPI Type: Master
; 0000 03C8 // SPI Clock Rate: 62,500 kHz
; 0000 03C9 // SPI Clock Phase: Cycle Start
; 0000 03CA // SPI Clock Polarity: High
; 0000 03CB // SPI Data Order: LSB First
; 0000 03CC SPCR=0xDE;
	LDI  R30,LOW(222)
	OUT  0xD,R30
; 0000 03CD SPSR=0x00;
	LDI  R30,LOW(0)
	OUT  0xE,R30
; 0000 03CE // Clear the SPI interrupt flag
; 0000 03CF #asm
; 0000 03D0     in   r30,spsr
    in   r30,spsr
; 0000 03D1     in   r30,spdr
    in   r30,spdr
; 0000 03D2 #endasm
; 0000 03D3 //led(0);
; 0000 03D4 //delay_ms(100);
; 0000 03D5 // led(21);
; 0000 03D6 ClearBuf_slave;
	LDI  R30,LOW(0)
	STS  _rx_buffer_slave,R30
	__PUTB1MN _rx_buffer_slave,1
	__PUTB1MN _rx_buffer_slave,2
	__PUTB1MN _rx_buffer_slave,3
	__PUTB1MN _rx_buffer_slave,4
	__PUTB1MN _rx_buffer_slave,5
	__PUTB1MN _rx_buffer_slave,6
	__PUTB1MN _rx_buffer_slave,7
	__PUTB1MN _rx_buffer_slave,8
	__PUTB1MN _rx_buffer_slave,9
	__PUTB1MN _rx_buffer_slave,10
; 0000 03D7 
; 0000 03D8 TIMSK=0x01;//ETIMSK=0x00;
	LDI  R30,LOW(1)
	OUT  0x37,R30
; 0000 03D9 //TCCR3B=0x04;ETIFR=0x04;ETIMSK=0x04;TCCR3A=0x00;
; 0000 03DA rx_c_master=0;rx_m_master=0;
	CLT
	BLD  R2,2
	BLD  R2,1
; 0000 03DB rx_wr_index_master=0;rx_counter_master=0;
	LDI  R30,LOW(0)
	STS  _rx_wr_index_master,R30
	STS  _rx_counter_master,R30
; 0000 03DC rx_c_slave=0;rx_m_slave=0;
	BLD  R3,5
	BLD  R3,4
; 0000 03DD rx_wr_index_slave=0;rx_counter_slave=0;
	STS  _rx_wr_index_slave,R30
	STS  _rx_counter_slave,R30
; 0000 03DE //        send_save_skz1;
; 0000 03DF //        whait_read;
; 0000 03E0 //        send_save_skz2;
; 0000 03E1 //        whait_read;
; 0000 03E2 Led_Intro1_on;
	SBI  0x1B,4
	SBI  0x1B,5
	SBI  0x1B,6
	SBI  0x1B,7
	SBI  0x15,6
	SBI  0x15,7
	SBI  0x15,4
	SBI  0x15,3
	SBI  0x15,2
	SBI  0x15,1
; 0000 03E3 delay_ms(500);
	LDI  R26,LOW(500)
	LDI  R27,HIGH(500)
	CALL _delay_ms
; 0000 03E4 Led_Intro2_on;
	LDS  R30,98
	ORI  R30,0x10
	STS  98,R30
	SBI  0x1B,2
	LDS  R30,98
	ORI  R30,4
	STS  98,R30
	LDS  R30,98
	ORI  R30,1
	STS  98,R30
	LDS  R30,98
	ORI  R30,0x40
	STS  98,R30
	LDS  R30,98
	ORI  R30,2
	STS  98,R30
	LDS  R30,98
	ORI  R30,8
	STS  98,R30
	LDS  R30,98
	ORI  R30,0x20
	STS  98,R30
	LDS  R30,98
	ORI  R30,0x80
	STS  98,R30
	SBI  0x1B,0
	SBI  0x1B,1
	SBI  0x1B,3
	CBI  0x1B,4
	CBI  0x1B,5
	CBI  0x1B,6
	CBI  0x1B,7
	CBI  0x15,6
	CBI  0x15,7
	CBI  0x15,4
	CBI  0x15,3
	CBI  0x15,2
	CBI  0x15,1
; 0000 03E5 delay_ms(500);
	LDI  R26,LOW(500)
	LDI  R27,HIGH(500)
	CALL _delay_ms
; 0000 03E6 Led_Intro2_off;
	LDS  R30,98
	ANDI R30,0xEF
	STS  98,R30
	CBI  0x1B,2
	LDS  R30,98
	ANDI R30,0xFB
	STS  98,R30
	LDS  R30,98
	ANDI R30,0xFE
	STS  98,R30
	LDS  R30,98
	ANDI R30,0xBF
	STS  98,R30
	LDS  R30,98
	ANDI R30,0xFD
	STS  98,R30
	LDS  R30,98
	ANDI R30,0XF7
	STS  98,R30
	LDS  R30,98
	ANDI R30,0xDF
	STS  98,R30
	LDS  R30,98
	ANDI R30,0x7F
	STS  98,R30
	CBI  0x1B,0
	CBI  0x1B,1
	CBI  0x1B,3
	CBI  0x1B,4
	CBI  0x1B,5
	CBI  0x1B,6
	CBI  0x1B,7
	CBI  0x15,6
	CBI  0x15,7
	CBI  0x15,4
	CBI  0x15,3
	CBI  0x15,2
	CBI  0x15,1
; 0000 03E7 //delay_ms(200);
; 0000 03E8 
; 0000 03E9 #asm("sei")
	sei
; 0000 03EA //delay_ms(200);
; 0000 03EB 
; 0000 03EC CalibrFlag=EEPROM_read(eeAddrCalibrFlag);
	LDI  R26,LOW(1279)
	LDI  R27,HIGH(1279)
	CALL _EEPROM_read
	STS  _CalibrFlag,R30
; 0000 03ED if(EEPROM_read(eeAddressAverTimeV)!=0xff)AverTime_Value=EEPROM_read(eeAddressAverTimeV);
	LDI  R26,LOW(1537)
	LDI  R27,HIGH(1537)
	CALL _EEPROM_read
	CPI  R30,LOW(0xFF)
	BREQ _0x36D
	LDI  R26,LOW(1537)
	LDI  R27,HIGH(1537)
	CALL _EEPROM_read
	LDI  R31,0
	STS  _AverTime_Value,R30
	STS  _AverTime_Value+1,R31
; 0000 03EE if(EEPROM_read(eeAddressFreqQ)!=0xff)FrequencyQ=EEPROM_read(eeAddressFreqQ);
_0x36D:
	LDI  R26,LOW(1538)
	LDI  R27,HIGH(1538)
	CALL _EEPROM_read
	CPI  R30,LOW(0xFF)
	BREQ _0x36E
	LDI  R26,LOW(1538)
	LDI  R27,HIGH(1538)
	CALL _EEPROM_read
	LDI  R31,0
	STS  _FrequencyQ,R30
	STS  _FrequencyQ+1,R31
; 0000 03EF if(EEPROM_read(eeAddressModBusAddr)!=0xff)ModBusAddress=EEPROM_read(eeAddressModBusAddr);
_0x36E:
	LDI  R26,LOW(1536)
	LDI  R27,HIGH(1536)
	CALL _EEPROM_read
	CPI  R30,LOW(0xFF)
	BREQ _0x36F
	LDI  R26,LOW(1536)
	LDI  R27,HIGH(1536)
	CALL _EEPROM_read
	LDI  R31,0
	STS  _ModBusAddress,R30
	STS  _ModBusAddress+1,R31
; 0000 03F0 if(EEPROM_read(eeAddressMINSKZH)!=0xff&EEPROM_read(eeAddressMINSKZL)!=0xff){minimal_SKZ_val=(unsigned int)(EEPROM_read(e ...
_0x36F:
	LDI  R26,LOW(1539)
	LDI  R27,HIGH(1539)
	CALL _EEPROM_read
	LDI  R26,LOW(255)
	CALL __NEB12
	PUSH R30
	LDI  R26,LOW(1540)
	LDI  R27,HIGH(1540)
	CALL _EEPROM_read
	LDI  R26,LOW(255)
	CALL __NEB12
	POP  R26
	AND  R30,R26
	BREQ _0x370
	LDI  R26,LOW(1539)
	LDI  R27,HIGH(1539)
	CALL _EEPROM_read
	MOV  R31,R30
	LDI  R30,0
	STS  _minimal_SKZ_val,R30
	STS  _minimal_SKZ_val+1,R31
	LDI  R26,LOW(1540)
	LDI  R27,HIGH(1540)
	CALL _EEPROM_read
	LDI  R31,0
	LDS  R26,_minimal_SKZ_val
	LDS  R27,_minimal_SKZ_val+1
	ADD  R30,R26
	ADC  R31,R27
	STS  _minimal_SKZ_val,R30
	STS  _minimal_SKZ_val+1,R31
; 0000 03F1 if(EEPROM_read(eeAddressMINOPLH)!=0xff&EEPROM_read(eeAddressMINOPLL)!=0xff){minimal_object_enabled_level=(unsigned int)( ...
_0x370:
	LDI  R26,LOW(1542)
	LDI  R27,HIGH(1542)
	CALL _EEPROM_read
	LDI  R26,LOW(255)
	CALL __NEB12
	PUSH R30
	LDI  R26,LOW(1543)
	LDI  R27,HIGH(1543)
	CALL _EEPROM_read
	LDI  R26,LOW(255)
	CALL __NEB12
	POP  R26
	AND  R30,R26
	BREQ _0x371
	LDI  R26,LOW(1542)
	LDI  R27,HIGH(1542)
	CALL _EEPROM_read
	MOV  R31,R30
	LDI  R30,0
	STS  _minimal_object_enabled_level,R30
	STS  _minimal_object_enabled_level+1,R31
	LDI  R26,LOW(1543)
	LDI  R27,HIGH(1543)
	CALL _EEPROM_read
	LDI  R31,0
	LDS  R26,_minimal_object_enabled_level
	LDS  R27,_minimal_object_enabled_level+1
	ADD  R30,R26
	ADC  R31,R27
	STS  _minimal_object_enabled_level,R30
	STS  _minimal_object_enabled_level+1,R31
; 0000 03F2 if((AverTime_Value!=0)&(red==0))AvTimer_on;
_0x371:
	LDS  R26,_AverTime_Value
	LDS  R27,_AverTime_Value+1
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	CALL __NEW12
	MOV  R0,R30
	LDS  R26,_red
	LDS  R27,_red+1
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	CALL __EQW12
	AND  R30,R0
	BREQ _0x372
	LDI  R30,LOW(0)
	STS  139,R30
	LDI  R30,LOW(4)
	STS  138,R30
	LDI  R30,LOW(129)
	STS  137,R30
	LDI  R30,LOW(11)
	STS  136,R30
	LDI  R30,LOW(4)
	STS  125,R30
_0x372:
; 0000 03F3 
; 0000 03F4 //go_main_menu();
; 0000 03F5 //TX_slave_on;printf("AverSKZ_Value=%d,skz_counter=%d testval=%e\r\n",AverSKZ_Value,SKZread_counter,testval);TX_slave_of ...
; 0000 03F6 //led(0);
; 0000 03F7 send_frequency_value();
	RCALL _send_frequency_value
; 0000 03F8  whait_read;
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	OUT  0x2C+1,R31
	OUT  0x2C,R30
	LDI  R30,LOW(3)
	OUT  0x2E,R30
_0x373:
	IN   R30,0x36
	SBRS R30,2
	RJMP _0x373
	LDI  R30,LOW(0)
	OUT  0x2E,R30
	IN   R30,0x36
	OUT  0x36,R30
; 0000 03F9 
; 0000 03FA  //delay_ms(65);
; 0000 03FB  rx_c_master=0;rx_m_master=0;
	CLT
	BLD  R2,2
	BLD  R2,1
; 0000 03FC  rx_wr_index_master=0;rx_counter_master=0;
	LDI  R30,LOW(0)
	STS  _rx_wr_index_master,R30
	STS  _rx_counter_master,R30
; 0000 03FD ClearBuf_master;
	STS  _rx_buffer_master,R30
	__PUTB1MN _rx_buffer_master,1
	__PUTB1MN _rx_buffer_master,2
	__PUTB1MN _rx_buffer_master,3
	__PUTB1MN _rx_buffer_master,4
	__PUTB1MN _rx_buffer_master,5
	__PUTB1MN _rx_buffer_master,6
	__PUTB1MN _rx_buffer_master,7
	__PUTB1MN _rx_buffer_master,8
	__PUTB1MN _rx_buffer_master,9
; 0000 03FE  send_SKZMIN_value();
	RCALL _send_SKZMIN_value
; 0000 03FF rx_c_master=0;rx_m_master=0;
	CLT
	BLD  R2,2
	BLD  R2,1
; 0000 0400  rx_wr_index_master=0;rx_counter_master=0;
	LDI  R30,LOW(0)
	STS  _rx_wr_index_master,R30
	STS  _rx_counter_master,R30
; 0000 0401 ClearBuf_master;
	STS  _rx_buffer_master,R30
	__PUTB1MN _rx_buffer_master,1
	__PUTB1MN _rx_buffer_master,2
	__PUTB1MN _rx_buffer_master,3
	__PUTB1MN _rx_buffer_master,4
	__PUTB1MN _rx_buffer_master,5
	__PUTB1MN _rx_buffer_master,6
	__PUTB1MN _rx_buffer_master,7
	__PUTB1MN _rx_buffer_master,8
	__PUTB1MN _rx_buffer_master,9
; 0000 0402  whait_read;
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	OUT  0x2C+1,R31
	OUT  0x2C,R30
	LDI  R30,LOW(3)
	OUT  0x2E,R30
_0x376:
	IN   R30,0x36
	SBRS R30,2
	RJMP _0x376
	LDI  R30,LOW(0)
	OUT  0x2E,R30
	IN   R30,0x36
	OUT  0x36,R30
; 0000 0403 send_minimal_operat_val();
	RCALL _send_minimal_operat_val
; 0000 0404  whait_read;
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	OUT  0x2C+1,R31
	OUT  0x2C,R30
	LDI  R30,LOW(3)
	OUT  0x2E,R30
_0x379:
	IN   R30,0x36
	SBRS R30,2
	RJMP _0x379
	LDI  R30,LOW(0)
	OUT  0x2E,R30
	IN   R30,0x36
	OUT  0x36,R30
; 0000 0405  //delay_ms(65);
; 0000 0406 SKZ_1=0;SKZ_2=0;
	CLR  R8
	CLR  R9
	CLR  R10
	CLR  R11
; 0000 0407 if(CalibrFlag==1){
	LDS  R26,_CalibrFlag
	CPI  R26,LOW(0x1)
	BREQ PC+2
	RJMP _0x37C
; 0000 0408 if(EEPROM_read(eeAddressSKZ1H)!=0xff&EEPROM_read(eeAddressSKZ1L)!=0xff)
	LDI  R26,LOW(1024)
	LDI  R27,HIGH(1024)
	CALL _EEPROM_read
	LDI  R26,LOW(255)
	CALL __NEB12
	PUSH R30
	LDI  R26,LOW(1025)
	LDI  R27,HIGH(1025)
	CALL _EEPROM_read
	LDI  R26,LOW(255)
	CALL __NEB12
	POP  R26
	AND  R30,R26
	BREQ _0x37D
; 0000 0409     {            //        загружаем СКЗ1 и СКЗ2 из еепром
; 0000 040A     SKZ_1 = ((unsigned int)EEPROM_read(eeAddressSKZ1H)<<8)+EEPROM_read(eeAddressSKZ1L);
	LDI  R26,LOW(1024)
	LDI  R27,HIGH(1024)
	CALL _EEPROM_read
	MOV  R31,R30
	LDI  R30,0
	PUSH R31
	PUSH R30
	LDI  R26,LOW(1025)
	LDI  R27,HIGH(1025)
	CALL _EEPROM_read
	LDI  R31,0
	POP  R26
	POP  R27
	ADD  R30,R26
	ADC  R31,R27
	MOVW R8,R30
; 0000 040B     }
; 0000 040C if(EEPROM_read(eeAddressSKZ2H)!=0xff&EEPROM_read(eeAddressSKZ2L)!=0xff){
_0x37D:
	LDI  R26,LOW(1026)
	LDI  R27,HIGH(1026)
	CALL _EEPROM_read
	LDI  R26,LOW(255)
	CALL __NEB12
	PUSH R30
	LDI  R26,LOW(1027)
	LDI  R27,HIGH(1027)
	CALL _EEPROM_read
	LDI  R26,LOW(255)
	CALL __NEB12
	POP  R26
	AND  R30,R26
	BREQ _0x37E
; 0000 040D SKZ_2 = ((unsigned int)EEPROM_read(eeAddressSKZ2H)<<8)+EEPROM_read(eeAddressSKZ2L);}        //v
	LDI  R26,LOW(1026)
	LDI  R27,HIGH(1026)
	CALL _EEPROM_read
	MOV  R31,R30
	LDI  R30,0
	PUSH R31
	PUSH R30
	LDI  R26,LOW(1027)
	LDI  R27,HIGH(1027)
	CALL _EEPROM_read
	LDI  R31,0
	POP  R26
	POP  R27
	ADD  R30,R26
	ADC  R31,R27
	MOVW R10,R30
; 0000 040E SKZ1toSKZ2 =   EEPROM_read(eeAddressSKZ1toSKZ2);
_0x37E:
	LDI  R26,LOW(1028)
	LDI  R27,HIGH(1028)
	CALL _EEPROM_read
	MOV  R12,R30
	CLR  R13
; 0000 040F if(SKZ1toSKZ2!=0xff){
	LDI  R30,LOW(255)
	LDI  R31,HIGH(255)
	CP   R30,R12
	CPC  R31,R13
	BREQ _0x37F
; 0000 0410                                       if(SKZ1toSKZ2<=40){warning_flag=1;
	LDI  R30,LOW(40)
	LDI  R31,HIGH(40)
	CP   R30,R12
	CPC  R31,R13
	BRLO _0x380
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	STS  _warning_flag,R30
	STS  _warning_flag+1,R31
; 0000 0411                                       if(SKZ1toSKZ2<=20){blink_flag=1;blink_on();}
	LDI  R30,LOW(20)
	LDI  R31,HIGH(20)
	CP   R30,R12
	CPC  R31,R13
	BRLO _0x381
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	STS  _blink_flag,R30
	STS  _blink_flag+1,R31
	CALL _blink_on
; 0000 0412                                       else {led_warning_on;blink_flag=0;blink_off();}
	RJMP _0x382
_0x381:
	LDS  R30,98
	ORI  R30,0x10
	STS  98,R30
	LDI  R30,LOW(0)
	STS  _blink_flag,R30
	STS  _blink_flag+1,R30
	CALL _blink_off
_0x382:
; 0000 0413                                       }
; 0000 0414                                       else {warning_flag=0;led_warning_off;blink_off(); }}
	RJMP _0x383
_0x380:
	LDI  R30,LOW(0)
	STS  _warning_flag,R30
	STS  _warning_flag+1,R30
	LDS  R30,98
	ANDI R30,0xEF
	STS  98,R30
	CALL _blink_off
_0x383:
; 0000 0415                                    //    blink_display(SKZ_1);  blink_display(SKZ_2);
; 0000 0416                                       //delay_ms(300);
; 0000 0417                                       send_freq_order();
_0x37F:
	RCALL _send_freq_order
; 0000 0418                                       whait_read;
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	OUT  0x2C+1,R31
	OUT  0x2C,R30
	LDI  R30,LOW(3)
	OUT  0x2E,R30
_0x384:
	IN   R30,0x36
	SBRS R30,2
	RJMP _0x384
	LDI  R30,LOW(0)
	OUT  0x2E,R30
	IN   R30,0x36
	OUT  0x36,R30
; 0000 0419                                       //delay_ms(65);
; 0000 041A                                       send_skz_array();
	RCALL _send_skz_array
; 0000 041B                                       whait_read;
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	OUT  0x2C+1,R31
	OUT  0x2C,R30
	LDI  R30,LOW(3)
	OUT  0x2E,R30
_0x387:
	IN   R30,0x36
	SBRS R30,2
	RJMP _0x387
	LDI  R30,LOW(0)
	OUT  0x2E,R30
	IN   R30,0x36
	OUT  0x36,R30
; 0000 041C                                       //delay_ms(65);
; 0000 041D                                         }
; 0000 041E 
; 0000 041F 
; 0000 0420                                   /*    if((SKZ_1==0xffff)&&(SKZ_2==0xffff))no_press=0;
; 0000 0421                                       else{ send_save_frq;
; 0000 0422                                             whait_read;
; 0000 0423                                             send_skz();
; 0000 0424                                             whait_read;}*/
; 0000 0425 
; 0000 0426 while (1)
_0x37C:
_0x38A:
; 0000 0427         {
; 0000 0428 if(flash_erase_flag ==1)
	LDS  R26,_flash_erase_flag
	LDS  R27,_flash_erase_flag+1
	SBIW R26,1
	BRNE _0x38D
; 0000 0429     {
; 0000 042A         //eeprom_reset();
; 0000 042B     led(30);
	LDI  R26,LOW(30)
	CALL _led
; 0000 042C     EEPROM_write(0,0xff);
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R26,LOW(255)
	CALL _EEPROM_write
; 0000 042D     EEPROM_write(1,0xff);
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R26,LOW(255)
	CALL _EEPROM_write
; 0000 042E    // #asm("JMP 0")
; 0000 042F     WDTCR=0x18;
	LDI  R30,LOW(24)
	OUT  0x21,R30
; 0000 0430     WDTCR=0x08;
	LDI  R30,LOW(8)
	OUT  0x21,R30
; 0000 0431     #asm("cli")
	cli
; 0000 0432     delay_ms(3000);
	LDI  R26,LOW(3000)
	LDI  R27,HIGH(3000)
	CALL _delay_ms
; 0000 0433     }
; 0000 0434       //  if(k==0) {blink_intro();k=1;}
; 0000 0435 reg91_answer=(object_state|(!BPS_absent)<<5)|(red<<4)|((ProcessingEEPROM)<<3)|((red|ProcessingEEPROM)<<2)|((warning_flag ...
_0x38D:
	LDS  R30,_BPS_absent
	LDS  R31,_BPS_absent+1
	CALL __LNEGW1
	SWAP R30
	ANDI R30,0xF0
	LSL  R30
	LDS  R26,_object_state
	OR   R30,R26
	MOV  R26,R30
	LDS  R30,_red
	SWAP R30
	ANDI R30,0xF0
	OR   R30,R26
	MOV  R0,R30
	LDI  R26,0
	SBRC R2,5
	LDI  R26,1
	MOV  R30,R26
	LSL  R30
	LSL  R30
	LSL  R30
	OR   R0,R30
	LDI  R30,0
	SBRC R2,5
	LDI  R30,1
	LDS  R26,_red
	OR   R30,R26
	LSL  R30
	LSL  R30
	OR   R0,R30
	LDS  R30,_blink_flag
	LDS  R31,_blink_flag+1
	CALL __LNEGW1
	LSL  R30
	LDS  R26,_warning_flag
	AND  R30,R26
	OR   R0,R30
	LDS  R30,_blink_flag
	LDS  R31,_blink_flag+1
	CALL __LNEGW1
	AND  R30,R26
	LDS  R26,_blink_flag
	OR   R30,R26
	OR   R30,R0
	STS  _reg91_answer,R30
; 0000 0436 
; 0000 0437  if((blink_flag)|(red))blink_on();
	LDS  R30,_red
	LDS  R31,_red+1
	LDS  R26,_blink_flag
	LDS  R27,_blink_flag+1
	OR   R30,R26
	OR   R31,R27
	SBIW R30,0
	BREQ _0x38E
	CALL _blink_on
; 0000 0438  else blink_off();
	RJMP _0x38F
_0x38E:
	CALL _blink_off
; 0000 0439  if(BPS_absent){PORTC.1=!PORTC.1;PORTC.2=!PORTC.2;PORTC.3=!PORTC.3;}
_0x38F:
	LDS  R30,_BPS_absent
	LDS  R31,_BPS_absent+1
	SBIW R30,0
	BREQ _0x390
	SBIS 0x15,1
	RJMP _0x391
	CBI  0x15,1
	RJMP _0x392
_0x391:
	SBI  0x15,1
_0x392:
	SBIS 0x15,2
	RJMP _0x393
	CBI  0x15,2
	RJMP _0x394
_0x393:
	SBI  0x15,2
_0x394:
	SBIS 0x15,3
	RJMP _0x395
	CBI  0x15,3
	RJMP _0x396
_0x395:
	SBI  0x15,3
_0x396:
; 0000 043A  else{PORTC.1=PORTC.1&1;PORTC.2=PORTC.2&1;PORTC.3=PORTC.3&1;}
	RJMP _0x397
_0x390:
	LDI  R26,0
	SBIC 0x15,1
	LDI  R26,1
	LDI  R30,LOW(1)
	AND  R30,R26
	BRNE _0x398
	CBI  0x15,1
	RJMP _0x399
_0x398:
	SBI  0x15,1
_0x399:
	LDI  R26,0
	SBIC 0x15,2
	LDI  R26,1
	LDI  R30,LOW(1)
	AND  R30,R26
	BRNE _0x39A
	CBI  0x15,2
	RJMP _0x39B
_0x39A:
	SBI  0x15,2
_0x39B:
	LDI  R26,0
	SBIC 0x15,3
	LDI  R26,1
	LDI  R30,LOW(1)
	AND  R30,R26
	BRNE _0x39C
	CBI  0x15,3
	RJMP _0x39D
_0x39C:
	SBI  0x15,3
_0x39D:
_0x397:
; 0000 043B  if((object_state==0)&(!BPS_absent))
	LDS  R26,_object_state
	LDI  R30,LOW(0)
	CALL __EQB12
	MOV  R26,R30
	LDS  R30,_BPS_absent
	LDS  R31,_BPS_absent+1
	CALL __LNEGW1
	AND  R30,R26
	BREQ _0x39E
; 0000 043C  {
; 0000 043D         if(PORTF&0x40==0x40)
	LDS  R30,98
	ANDI R30,LOW(0x1)
	BREQ _0x39F
; 0000 043E         {
; 0000 043F                     PORTF=PORTF&0b10111111;
	LDS  R30,98
	ANDI R30,0xBF
	STS  98,R30
; 0000 0440                     PORTF=PORTF&0b11111110;
	LDS  R30,98
	ANDI R30,0xFE
	STS  98,R30
; 0000 0441                     PORTF=PORTF&0b11111011;
	LDS  R30,98
	ANDI R30,0xFB
	STS  98,R30
; 0000 0442                     PORTC.1=0;PORTC.2=0;PORTC.3=0;
	CBI  0x15,1
	CBI  0x15,2
	CBI  0x15,3
; 0000 0443         }
; 0000 0444         else
	RJMP _0x3A6
_0x39F:
; 0000 0445         {
; 0000 0446                     PORTF=PORTF|0b01000000;
	LDS  R30,98
	ORI  R30,0x40
	STS  98,R30
; 0000 0447                     PORTF=PORTF|0b00000001;
	LDS  R30,98
	ORI  R30,1
	STS  98,R30
; 0000 0448                     PORTF=PORTF|0b00000100;
	LDS  R30,98
	ORI  R30,4
	STS  98,R30
; 0000 0449                     PORTC.1=1;PORTC.2=1;PORTC.3=1;
	SBI  0x15,1
	SBI  0x15,2
	SBI  0x15,3
; 0000 044A         }
_0x3A6:
; 0000 044B  }
; 0000 044C current_out(tok);
_0x39E:
	LDS  R26,_tok
	LDS  R27,_tok+1
	CALL _current_out
; 0000 044D if(new_message)
	SBRS R2,3
	RJMP _0x3AD
; 0000 044E {
; 0000 044F     if(ModbusMessage==62)
	LDS  R26,_ModbusMessage
	LDS  R27,_ModbusMessage+1
	SBIW R26,62
	BRNE _0x3AE
; 0000 0450         send_frequency_value();
	RCALL _send_frequency_value
; 0000 0451     terminal_commander(RData, terminal_mode);
_0x3AE:
	LDS  R30,_RData
	ST   -Y,R30
	LDS  R26,_terminal_mode
	LDS  R27,_terminal_mode+1
	RCALL _terminal_commander
; 0000 0452 
; 0000 0453 }
; 0000 0454 rx_c_master=0;rx_m_master=0;
_0x3AD:
	CLT
	BLD  R2,2
	BLD  R2,1
; 0000 0455 rx_wr_index_master=0;rx_counter_master=0;
	LDI  R30,LOW(0)
	STS  _rx_wr_index_master,R30
	STS  _rx_counter_master,R30
; 0000 0456 current_out(tok);
	LDS  R26,_tok
	LDS  R27,_tok+1
	CALL _current_out
; 0000 0457 ClearBuf_master;
	LDI  R30,LOW(0)
	STS  _rx_buffer_master,R30
	__PUTB1MN _rx_buffer_master,1
	__PUTB1MN _rx_buffer_master,2
	__PUTB1MN _rx_buffer_master,3
	__PUTB1MN _rx_buffer_master,4
	__PUTB1MN _rx_buffer_master,5
	__PUTB1MN _rx_buffer_master,6
	__PUTB1MN _rx_buffer_master,7
	__PUTB1MN _rx_buffer_master,8
	__PUTB1MN _rx_buffer_master,9
; 0000 0458 send_read_skz;
	LDI  R30,LOW(65535)
	LDI  R31,HIGH(65535)
	STS  _crc_master,R30
	STS  _crc_master+1,R31
	LDI  R26,LOW(1)
	RCALL _mov_buf_master
	LDI  R26,LOW(4)
	RCALL _mov_buf_master
	LDI  R26,LOW(0)
	RCALL _mov_buf_master
	LDI  R26,LOW(134)
	RCALL _mov_buf_master
	LDI  R26,LOW(0)
	RCALL _mov_buf_master
	LDI  R26,LOW(1)
	RCALL _mov_buf_master
	RCALL _crc_end_master
; 0000 0459 current_out(tok);
	LDS  R26,_tok
	LDS  R27,_tok+1
	CALL _current_out
; 0000 045A whait_read;
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	OUT  0x2C+1,R31
	OUT  0x2C,R30
	LDI  R30,LOW(3)
	OUT  0x2E,R30
_0x3AF:
	IN   R30,0x36
	SBRS R30,2
	RJMP _0x3AF
	LDI  R30,LOW(0)
	OUT  0x2E,R30
	IN   R30,0x36
	OUT  0x36,R30
; 0000 045B current_out(tok);
	LDS  R26,_tok
	LDS  R27,_tok+1
	CALL _current_out
; 0000 045C         //delay_ms(65);
; 0000 045D            if (check_cr_master()==1)
	RCALL _check_cr_master
	CPI  R30,LOW(0x1)
	BREQ PC+2
	RJMP _0x3B2
; 0000 045E                 {
; 0000 045F                 rms=0;
	CLR  R6
	CLR  R7
; 0000 0460                 if(rx_counter_master==7) rms=((int)rx_buffer_master[3])<<8|(char)rx_buffer_master[4];
	LDS  R26,_rx_counter_master
	CPI  R26,LOW(0x7)
	BRNE _0x3B3
	__GETBRMN 27,_rx_buffer_master,3
	LDI  R26,LOW(0)
	__GETB1MN _rx_buffer_master,4
	LDI  R31,0
	OR   R30,R26
	OR   R31,R27
	MOVW R6,R30
; 0000 0461 
; 0000 0462                 SKZread_counter++;
_0x3B3:
	LDI  R26,LOW(_SKZread_counter)
	LDI  R27,HIGH(_SKZread_counter)
	CALL __GETD1P_INC
	__SUBD1N -1
	CALL __PUTDP1_DEC
; 0000 0463                 BPS_absent=0;
	LDI  R30,LOW(0)
	STS  _BPS_absent,R30
	STS  _BPS_absent+1,R30
; 0000 0464                 bps_absent_ctr=0;
	STS  _bps_absent_ctr,R30
	STS  _bps_absent_ctr+1,R30
; 0000 0465                 AverSKZ_Value=(float)AverSKZ_Value*((float)((float)SKZread_counter-1)/(float)SKZread_counter)+(float)((f ...
	LDS  R30,_AverSKZ_Value
	LDS  R31,_AverSKZ_Value+1
	CALL __CWD1
	CALL __CDF1
	PUSH R23
	PUSH R22
	PUSH R31
	PUSH R30
	LDS  R30,_SKZread_counter
	LDS  R31,_SKZread_counter+1
	LDS  R22,_SKZread_counter+2
	LDS  R23,_SKZread_counter+3
	CALL __CDF1
	MOVW R26,R30
	MOVW R24,R22
	__GETD1N 0x3F800000
	CALL __SWAPD12
	CALL __SUBF12
	MOVW R26,R30
	MOVW R24,R22
	LDS  R30,_SKZread_counter
	LDS  R31,_SKZread_counter+1
	LDS  R22,_SKZread_counter+2
	LDS  R23,_SKZread_counter+3
	CALL __CDF1
	CALL __DIVF21
	POP  R26
	POP  R27
	POP  R24
	POP  R25
	CALL __MULF12
	PUSH R23
	PUSH R22
	PUSH R31
	PUSH R30
	MOVW R30,R6
	CALL __CWD1
	CALL __CDF1
	MOVW R26,R30
	MOVW R24,R22
	LDS  R30,_SKZread_counter
	LDS  R31,_SKZread_counter+1
	LDS  R22,_SKZread_counter+2
	LDS  R23,_SKZread_counter+3
	CALL __CDF1
	CALL __DIVF21
	POP  R26
	POP  R27
	POP  R24
	POP  R25
	CALL __ADDF12
	LDI  R26,LOW(_AverSKZ_Value)
	LDI  R27,HIGH(_AverSKZ_Value)
	CALL __CFD1
	ST   X+,R30
	ST   X,R31
; 0000 0466               //  if(AverSKZ_Value<minimal_object_enabled_level)disabling_counter++;    (SKZ1-SKZ/SKZ1-SKZ2)    => SKZ = ...
; 0000 0467                 }
; 0000 0468                 else
	RJMP _0x3B4
_0x3B2:
; 0000 0469                 {
; 0000 046A                 bps_absent_ctr++;
	LDI  R26,LOW(_bps_absent_ctr)
	LDI  R27,HIGH(_bps_absent_ctr)
	LD   R30,X+
	LD   R31,X+
	ADIW R30,1
	ST   -X,R31
	ST   -X,R30
; 0000 046B                 if(bps_absent_ctr>=4)BPS_absent=1;
	LDS  R26,_bps_absent_ctr
	LDS  R27,_bps_absent_ctr+1
	SBIW R26,4
	BRLT _0x3B5
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	STS  _BPS_absent,R30
	STS  _BPS_absent+1,R31
; 0000 046C                 }
_0x3B5:
_0x3B4:
; 0000 046D current_out(tok);
	LDS  R26,_tok
	LDS  R27,_tok+1
	CALL _current_out
; 0000 046E rx_c_master=0;rx_m_master=0;
	CLT
	BLD  R2,2
	BLD  R2,1
; 0000 046F rx_wr_index_master=0;rx_counter_master=0;
	LDI  R30,LOW(0)
	STS  _rx_wr_index_master,R30
	STS  _rx_counter_master,R30
; 0000 0470 ClearBuf_master;
	STS  _rx_buffer_master,R30
	__PUTB1MN _rx_buffer_master,1
	__PUTB1MN _rx_buffer_master,2
	__PUTB1MN _rx_buffer_master,3
	__PUTB1MN _rx_buffer_master,4
	__PUTB1MN _rx_buffer_master,5
	__PUTB1MN _rx_buffer_master,6
	__PUTB1MN _rx_buffer_master,7
	__PUTB1MN _rx_buffer_master,8
	__PUTB1MN _rx_buffer_master,9
; 0000 0471     send_read_object_state;
	LDI  R30,LOW(65535)
	LDI  R31,HIGH(65535)
	STS  _crc_master,R30
	STS  _crc_master+1,R31
	LDI  R26,LOW(1)
	RCALL _mov_buf_master
	LDI  R26,LOW(4)
	RCALL _mov_buf_master
	LDI  R26,LOW(0)
	RCALL _mov_buf_master
	LDI  R26,LOW(136)
	RCALL _mov_buf_master
	LDI  R26,LOW(0)
	RCALL _mov_buf_master
	LDI  R26,LOW(1)
	RCALL _mov_buf_master
	RCALL _crc_end_master
; 0000 0472     current_out(tok);
	LDS  R26,_tok
	LDS  R27,_tok+1
	CALL _current_out
; 0000 0473     whait_read;
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	OUT  0x2C+1,R31
	OUT  0x2C,R30
	LDI  R30,LOW(3)
	OUT  0x2E,R30
_0x3B6:
	IN   R30,0x36
	SBRS R30,2
	RJMP _0x3B6
	LDI  R30,LOW(0)
	OUT  0x2E,R30
	IN   R30,0x36
	OUT  0x36,R30
; 0000 0474     current_out(tok);
	LDS  R26,_tok
	LDS  R27,_tok+1
	CALL _current_out
; 0000 0475      if (check_cr_master()==1)
	RCALL _check_cr_master
; 0000 0476      {
; 0000 0477      //   object_state_tmp=0;
; 0000 0478      //   if(rx_counter_master==7)object_state_tmp=((int)rx_buffer_master[3])<<8|(char)rx_buffer_master[4];
; 0000 0479      //   if(object_state_tmp==0)disabling_counter++;
; 0000 047A 
; 0000 047B     //transmitter_on;TX_slave_on;printf("AverSKZ_Value=%d,skz_counter=%d,enabled:%d\r\n",AverSKZ_Value,SKZread_counter,o ...
; 0000 047C      }
; 0000 047D                // if(BPS_absent)BPS_link_failed;
; 0000 047E                //    blink_display(rms*100);
; 0000 047F                 //if(rms>0x10000)
; 0000 0480                 //rms=0-rms;
; 0000 0481                 //rms=(float)((float)0.065*rms+10.5);
; 0000 0482             //    }
; 0000 0483        // }
; 0000 0484        // y=(float)((float)0.5*rms+(float)0.5*y+0.5);
; 0000 0485 
; 0000 0486                  if((AvTimer>=(AverTime_Value))&(AverTime_Value!=0)&(!BPS_absent))
	LDS  R30,_AverTime_Value
	LDS  R31,_AverTime_Value+1
	LDS  R26,_AvTimer
	LDS  R27,_AvTimer+1
	CALL __GEW12
	MOV  R0,R30
	LDS  R26,_AverTime_Value
	LDS  R27,_AverTime_Value+1
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	CALL __NEW12
	AND  R30,R0
	MOV  R26,R30
	LDS  R30,_BPS_absent
	LDS  R31,_BPS_absent+1
	CALL __LNEGW1
	AND  R30,R26
	BRNE PC+2
	RJMP _0x3BA
; 0000 0487                  {
; 0000 0488                    // if(disabling_counter>=(AverTime_Value*2))object_state=0;
; 0000 0489                     true_skz=(float)SKZ_1-(float)(SKZ_1-SKZ_2)*AverSKZ_Value/100;
	MOVW R30,R8
	CLR  R22
	CLR  R23
	CALL __CDF1
	PUSH R23
	PUSH R22
	PUSH R31
	PUSH R30
	MOVW R30,R8
	SUB  R30,R10
	SBC  R31,R11
	CLR  R22
	CLR  R23
	CALL __CDF1
	MOVW R26,R30
	MOVW R24,R22
	LDS  R30,_AverSKZ_Value
	LDS  R31,_AverSKZ_Value+1
	CALL __CWD1
	CALL __CDF1
	CALL __MULF12
	MOVW R26,R30
	MOVW R24,R22
	__GETD1N 0x42C80000
	CALL __DIVF21
	POP  R26
	POP  R27
	POP  R24
	POP  R25
	CALL __SWAPD12
	CALL __SUBF12
	LDI  R26,LOW(_true_skz)
	LDI  R27,HIGH(_true_skz)
	CALL __CFD1U
	ST   X+,R30
	ST   X,R31
; 0000 048A                     if(true_skz<minimal_object_enabled_level)object_state = 0;
	LDS  R30,_minimal_object_enabled_level
	LDS  R31,_minimal_object_enabled_level+1
	LDS  R26,_true_skz
	LDS  R27,_true_skz+1
	CP   R26,R30
	CPC  R27,R31
	BRSH _0x3BB
	LDI  R30,LOW(0)
	RJMP _0x429
; 0000 048B                     else object_state=0x40;
_0x3BB:
	LDI  R30,LOW(64)
_0x429:
	STS  _object_state,R30
; 0000 048C                     AvTimer=0;
	LDI  R30,LOW(0)
	STS  _AvTimer,R30
	STS  _AvTimer+1,R30
; 0000 048D                     disabling_counter=0;
	STD  Y+5,R30
; 0000 048E                     //  if(SKZread_counter==0)SKZread_counter=1;
; 0000 048F                     //  AverSKZ_Value=(int)AverSKZ_Value/SKZread_counter;
; 0000 0490                     //if(AverSKZ_Value<0)rms=(int)AverSKZ_Value;
; 0000 0491                     //if(AverSKZ_Value>0)rms=(int)AverSKZ_Value;
; 0000 0492                     if(AverSKZ_Value==0)rms=0;
	LDS  R30,_AverSKZ_Value
	LDS  R31,_AverSKZ_Value+1
	SBIW R30,0
	BRNE _0x3BD
	CLR  R6
	CLR  R7
; 0000 0493                     // transmitter_on;TX_slave_on;printf("rms=%d object_state:%d\r\n",rms,object_state);TX_slave_off;tra ...
; 0000 0494                     //  TX_slave_on;printf("AverSKZ_Value=%d rms=%d \r\n",AverSKZ_Value,rms);TX_slave_off;
; 0000 0495                     SKZread_counter=0;
_0x3BD:
	LDI  R30,LOW(0)
	STS  _SKZread_counter,R30
	STS  _SKZread_counter+1,R30
	STS  _SKZread_counter+2,R30
	STS  _SKZread_counter+3,R30
; 0000 0496                     if(rms>=127|rms<-127)
	MOVW R26,R6
	LDI  R30,LOW(127)
	LDI  R31,HIGH(127)
	CALL __GEW12
	MOV  R0,R30
	LDI  R30,LOW(65409)
	LDI  R31,HIGH(65409)
	CALL __LTW12
	OR   R30,R0
	BREQ _0x3BE
; 0000 0497                     {
; 0000 0498                         if(rms>=127)AverSKZprcnt=127;
	LDI  R30,LOW(127)
	LDI  R31,HIGH(127)
	CP   R6,R30
	CPC  R7,R31
	BRLT _0x3BF
	STS  _AverSKZprcnt,R30
; 0000 0499                         if(rms<-127)AverSKZprcnt=-127;
_0x3BF:
	LDI  R30,LOW(65409)
	LDI  R31,HIGH(65409)
	CP   R6,R30
	CPC  R7,R31
	BRGE _0x3C0
	STS  _AverSKZprcnt,R30
; 0000 049A                     }
_0x3C0:
; 0000 049B                     else AverSKZprcnt=(char)rms;
	RJMP _0x3C1
_0x3BE:
	STS  _AverSKZprcnt,R6
; 0000 049C 
; 0000 049D                     //  transmitter_on;TX_slave_on;printf("rms=%d, AverSKZprcn%d object_state:%d\r\n",rms,AverSKZprcnt,o ...
; 0000 049E                     // TX_slave_on;printf("AverSKZprcnt=%d\r\n",AverSKZprcnt);TX_slave_off;
; 0000 049F 
; 0000 04A0                     led(30);
_0x3C1:
	LDI  R26,LOW(30)
	CALL _led
; 0000 04A1                     if(object_state==0)   //в случае, если треть пришедших сообщений сигнализируют выключенное состояние ...
	LDS  R30,_object_state
	CPI  R30,0
	BRNE _0x3C2
; 0000 04A2                     {
; 0000 04A3                     PORTF=PORTF|0b01000000;
	LDS  R30,98
	ORI  R30,0x40
	STS  98,R30
; 0000 04A4                     PORTF=PORTF|0b00000001;
	LDS  R30,98
	ORI  R30,1
	STS  98,R30
; 0000 04A5                     PORTF=PORTF|0b00000100;
	LDS  R30,98
	ORI  R30,4
	STS  98,R30
; 0000 04A6                     LedQ=0;
	CLR  R4
	CLR  R5
; 0000 04A7                     AverSKZprcnt=100;
	LDI  R30,LOW(100)
	STS  _AverSKZprcnt,R30
; 0000 04A8                     //SPCR=0x00;
; 0000 04A9                     tok=0;
	LDI  R30,LOW(0)
	STS  _tok,R30
	STS  _tok+1,R30
; 0000 04AA                     }
; 0000 04AB                 else
	RJMP _0x3C3
_0x3C2:
; 0000 04AC                     {
; 0000 04AD                     PORTF=PORTF&0b10111111;
	LDS  R30,98
	ANDI R30,0xBF
	STS  98,R30
; 0000 04AE                     PORTF=PORTF&0b11111110;
	LDS  R30,98
	ANDI R30,0xFE
	STS  98,R30
; 0000 04AF                     PORTF=PORTF&0b11111011;
	LDS  R30,98
	ANDI R30,0xFB
	STS  98,R30
; 0000 04B0                     LedQ=ind_select(rms);
	MOVW R26,R6
	CALL _ind_select
	MOVW R4,R30
; 0000 04B1                     SPCR=0xDE;
	LDI  R30,LOW(222)
	OUT  0xD,R30
; 0000 04B2                     //transmitter_on;TX_slave_on;printf("LedQ=%d\r\n",LedQ);TX_slave_off;transmitter_off;
; 0000 04B3                     led(LedQ);
	MOV  R26,R4
	CALL _led
; 0000 04B4                     if (AverSKZprcnt<-100)tok=2000;
	LDS  R26,_AverSKZprcnt
	CPI  R26,LOW(0x9C)
	BRGE _0x3C4
	LDI  R30,LOW(2000)
	LDI  R31,HIGH(2000)
	RJMP _0x42A
; 0000 04B5                     else tok=8*(100-AverSKZprcnt)+400;
_0x3C4:
	LDS  R30,_AverSKZprcnt
	LDI  R31,0
	SBRC R30,7
	SER  R31
	LDI  R26,LOW(100)
	LDI  R27,HIGH(100)
	CALL __SWAPW12
	SUB  R30,R26
	SBC  R31,R27
	CALL __LSLW3
	SUBI R30,LOW(-400)
	SBCI R31,HIGH(-400)
_0x42A:
	STS  _tok,R30
	STS  _tok+1,R31
; 0000 04B6                     if (tok<400)tok=400;
	LDS  R26,_tok
	LDS  R27,_tok+1
	CPI  R26,LOW(0x190)
	LDI  R30,HIGH(0x190)
	CPC  R27,R30
	BRSH _0x3C6
	LDI  R30,LOW(400)
	LDI  R31,HIGH(400)
	STS  _tok,R30
	STS  _tok+1,R31
; 0000 04B7                     current_out(tok);
_0x3C6:
	LDS  R26,_tok
	LDS  R27,_tok+1
	CALL _current_out
; 0000 04B8                     }
_0x3C3:
; 0000 04B9                 //transmitter_on;TX_slave_on;printf("rms=%d\r\n",rms);TX_slave_off;transmitter_off;
; 0000 04BA                 //current interface module with SPI
; 0000 04BB 
; 0000 04BC //end of module
; 0000 04BD                 AverSKZ_Value=0;}
	LDI  R30,LOW(0)
	STS  _AverSKZ_Value,R30
	STS  _AverSKZ_Value+1,R30
; 0000 04BE 
; 0000 04BF //if(BPS_absent){PORTC.1=!PORTC.1;PORTC.2=!PORTC.2;PORTC.3=!PORTC.3;}
; 0000 04C0 
; 0000 04C1       //  y=(float)((float)0.5*rms+(float)0.5*y+0.5);
; 0000 04C2 
; 0000 04C3       // if (y>20) y=20;if (y<1) y=1;
; 0000 04C4       //}  */
; 0000 04C5 //        if(blink_flag==1) led_green_off;
; 0000 04C6 //-------------------------------------------
; 0000 04C7 // модуль токового интерфейса
; 0000 04C8 //-------------------------------------------
; 0000 04C9 
; 0000 04CA /*******************************************************/
; 0000 04CB 
; 0000 04CC         if(start_calibration==1)
_0x3BA:
	LDS  R26,_start_calibration
	LDS  R27,_start_calibration+1
	SBIW R26,1
	BRNE _0x3C7
; 0000 04CD         {
; 0000 04CE         press=0;key=0;
	CLT
	BLD  R2,6
	CBI  0x13,5
; 0000 04CF         if ((first_press==1)&&(second_press==1))
	SBRS R2,7
	RJMP _0x3CB
	SBRC R3,0
	RJMP _0x3CC
_0x3CB:
	RJMP _0x3CA
_0x3CC:
; 0000 04D0             {
; 0000 04D1             first_press=0;second_press=0;
	CLT
	BLD  R2,7
	BLD  R3,0
; 0000 04D2             }
; 0000 04D3         }
_0x3CA:
; 0000 04D4         //if(finish_calibration==1){key=1;drebezg=2;}
; 0000 04D5         if(((key==0)&&(press==0))|start_calibration)
_0x3C7:
	SBIC 0x13,5
	RJMP _0x3CE
	SBRC R2,6
	RJMP _0x3CE
	LDI  R30,1
	RJMP _0x3CF
_0x3CE:
	LDI  R30,0
_0x3CF:
	MOV  R26,R30
	LDS  R30,_start_calibration
	LDS  R31,_start_calibration+1
	OR   R30,R26
	SBIW R30,0
	BRNE PC+2
	RJMP _0x3CD
; 0000 04D6                 {
; 0000 04D7 
; 0000 04D8                 warning_flag=0;
	LDI  R30,LOW(0)
	STS  _warning_flag,R30
	STS  _warning_flag+1,R30
; 0000 04D9                 blink_flag=0;
	STS  _blink_flag,R30
	STS  _blink_flag+1,R30
; 0000 04DA                 //TCNT3H=0;
; 0000 04DB                 //TCNT3L=0;
; 0000 04DC 
; 0000 04DD                 press=1;drebezg=0;
	SET
	BLD  R2,6
	STS  _drebezg,R30
; 0000 04DE                 if(((first_press==0)&&(second_press==0)))
	SBRC R2,7
	RJMP _0x3D1
	SBRS R3,0
	RJMP _0x3D2
_0x3D1:
	RJMP _0x3D0
_0x3D2:
; 0000 04DF                         {
; 0000 04E0                         start_calibration=0;
	LDI  R30,LOW(0)
	STS  _start_calibration,R30
	STS  _start_calibration+1,R30
; 0000 04E1                         no_press=0;
	__GETWRN 18,19,0
; 0000 04E2                         red = 1;
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	STS  _red,R30
	STS  _red+1,R31
; 0000 04E3 //                        led_green_off;
; 0000 04E4 
; 0000 04E5                         first_press=1;
	SET
	BLD  R2,7
; 0000 04E6                      	send_save_skz1;         //сохраняем в БПС скз1
	LDI  R30,LOW(65535)
	LDI  R31,HIGH(65535)
	STS  _crc_master,R30
	STS  _crc_master+1,R31
	LDI  R26,LOW(1)
	RCALL _mov_buf_master
	LDI  R26,LOW(6)
	RCALL _mov_buf_master
	LDI  R26,LOW(0)
	RCALL _mov_buf_master
	LDI  R26,LOW(129)
	RCALL _mov_buf_master
	LDI  R26,LOW(0)
	RCALL _mov_buf_master
	LDI  R26,LOW(1)
	RCALL _mov_buf_master
	RCALL _crc_end_master
; 0000 04E7                         whait_read;
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	OUT  0x2C+1,R31
	OUT  0x2C,R30
	LDI  R30,LOW(3)
	OUT  0x2E,R30
_0x3D3:
	IN   R30,0x36
	SBRS R30,2
	RJMP _0x3D3
	LDI  R30,LOW(0)
	OUT  0x2E,R30
	IN   R30,0x36
	OUT  0x36,R30
; 0000 04E8                         //delay_ms(65);
; 0000 04E9                         save_skz_arrays(red);
	LDS  R26,_red
	LDS  R27,_red+1
	CALL _save_skz_arrays
; 0000 04EA                           save_freq_order();
	CALL _save_freq_order
; 0000 04EB                         }
; 0000 04EC                 else if(((first_press==1)&&(second_press==0)))
	RJMP _0x3D6
_0x3D0:
	SBRS R2,7
	RJMP _0x3D8
	SBRS R3,0
	RJMP _0x3D9
_0x3D8:
	RJMP _0x3D7
_0x3D9:
; 0000 04ED                         {
; 0000 04EE                         start_calibration=0;
	LDI  R30,LOW(0)
	STS  _start_calibration,R30
	STS  _start_calibration+1,R30
; 0000 04EF                         red=0;
	STS  _red,R30
	STS  _red+1,R30
; 0000 04F0                         second_press=1;
	SET
	BLD  R3,0
; 0000 04F1                 	    send_save_skz2;
	LDI  R30,LOW(65535)
	LDI  R31,HIGH(65535)
	STS  _crc_master,R30
	STS  _crc_master+1,R31
	LDI  R26,LOW(1)
	RCALL _mov_buf_master
	LDI  R26,LOW(6)
	RCALL _mov_buf_master
	LDI  R26,LOW(0)
	RCALL _mov_buf_master
	LDI  R26,LOW(130)
	RCALL _mov_buf_master
	LDI  R26,LOW(0)
	RCALL _mov_buf_master
	LDI  R26,LOW(1)
	RCALL _mov_buf_master
	RCALL _crc_end_master
; 0000 04F2                         whait_read;
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	OUT  0x2C+1,R31
	OUT  0x2C,R30
	LDI  R30,LOW(3)
	OUT  0x2E,R30
_0x3DA:
	IN   R30,0x36
	SBRS R30,2
	RJMP _0x3DA
	LDI  R30,LOW(0)
	OUT  0x2E,R30
	IN   R30,0x36
	OUT  0x36,R30
; 0000 04F3                         //delay_ms(65);
; 0000 04F4                  // if(finish_calibration){key=1;drebezg=2;finish_calibration=0;}
; 0000 04F5                	        rx_c_master=0;rx_m_master=0;rx_wr_index_master=0;rx_counter_master=0;       //обнуляем буфер мас ...
	CLT
	BLD  R2,2
	BLD  R2,1
	LDI  R30,LOW(0)
	STS  _rx_wr_index_master,R30
	STS  _rx_counter_master,R30
; 0000 04F6                         rx_buffer_master[1]=0;
	__PUTB1MN _rx_buffer_master,1
; 0000 04F7                         rx_buffer_master[2]=0;
	__PUTB1MN _rx_buffer_master,2
; 0000 04F8                         rx_buffer_master[3]=0;
	__PUTB1MN _rx_buffer_master,3
; 0000 04F9                         rx_buffer_master[4]=0;
	__PUTB1MN _rx_buffer_master,4
; 0000 04FA                         rx_buffer_master[5]=0;
	__PUTB1MN _rx_buffer_master,5
; 0000 04FB                         rx_buffer_master[6]=0;
	__PUTB1MN _rx_buffer_master,6
; 0000 04FC                         rx_buffer_master[7]=0;
	__PUTB1MN _rx_buffer_master,7
; 0000 04FD                         rx_buffer_master[8]=0;
	__PUTB1MN _rx_buffer_master,8
; 0000 04FE                         rx_buffer_master[9]=0;
	__PUTB1MN _rx_buffer_master,9
; 0000 04FF                         send_read_skzrel;//читаем значение относительного изменения сигнала
	LDI  R30,LOW(65535)
	LDI  R31,HIGH(65535)
	STS  _crc_master,R30
	STS  _crc_master+1,R31
	LDI  R26,LOW(1)
	RCALL _mov_buf_master
	LDI  R26,LOW(4)
	RCALL _mov_buf_master
	LDI  R26,LOW(0)
	RCALL _mov_buf_master
	LDI  R26,LOW(135)
	RCALL _mov_buf_master
	LDI  R26,LOW(0)
	RCALL _mov_buf_master
	LDI  R26,LOW(1)
	RCALL _mov_buf_master
	RCALL _crc_end_master
; 0000 0500                         whait_read;
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	OUT  0x2C+1,R31
	OUT  0x2C,R30
	LDI  R30,LOW(3)
	OUT  0x2E,R30
_0x3DD:
	IN   R30,0x36
	SBRS R30,2
	RJMP _0x3DD
	LDI  R30,LOW(0)
	OUT  0x2E,R30
	IN   R30,0x36
	OUT  0x36,R30
; 0000 0501                          //delay_ms(65);
; 0000 0502                         if (check_cr_master()==1)
	RCALL _check_cr_master
	CPI  R30,LOW(0x1)
	BRNE _0x3E0
; 0000 0503                                  {
; 0000 0504                                  SKZ1toSKZ2=0;
	CLR  R12
	CLR  R13
; 0000 0505                                  if(rx_counter_master==7)SKZ1toSKZ2=((unsigned int)rx_buffer_master[3]<<8)+rx_buffer_mas ...
	LDS  R26,_rx_counter_master
	CPI  R26,LOW(0x7)
	BRNE _0x3E1
	__GETBRMN 27,_rx_buffer_master,3
	LDI  R26,LOW(0)
	__GETB1MN _rx_buffer_master,4
	LDI  R31,0
	ADD  R30,R26
	ADC  R31,R27
	MOVW R12,R30
_0x3E1:
	LDI  R30,LOW(0)
	STS  _BPS_absent,R30
	STS  _BPS_absent+1,R30
; 0000 0506                                  }
; 0000 0507                          else BPS_absent=1;
	RJMP _0x3E2
_0x3E0:
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	STS  _BPS_absent,R30
	STS  _BPS_absent+1,R31
; 0000 0508                              {
_0x3E2:
; 0000 0509                                 rx_c_master=0;rx_m_master=0;
	CLT
	BLD  R2,2
	BLD  R2,1
; 0000 050A                                 rx_wr_index_master=0;rx_counter_master=0;
	LDI  R30,LOW(0)
	STS  _rx_wr_index_master,R30
	STS  _rx_counter_master,R30
; 0000 050B                                 ClearBuf_master;
	STS  _rx_buffer_master,R30
	__PUTB1MN _rx_buffer_master,1
	__PUTB1MN _rx_buffer_master,2
	__PUTB1MN _rx_buffer_master,3
	__PUTB1MN _rx_buffer_master,4
	__PUTB1MN _rx_buffer_master,5
	__PUTB1MN _rx_buffer_master,6
	__PUTB1MN _rx_buffer_master,7
	__PUTB1MN _rx_buffer_master,8
	__PUTB1MN _rx_buffer_master,9
; 0000 050C                                 send_read_skz1;
	LDI  R30,LOW(65535)
	LDI  R31,HIGH(65535)
	STS  _crc_master,R30
	STS  _crc_master+1,R31
	LDI  R26,LOW(1)
	RCALL _mov_buf_master
	LDI  R26,LOW(4)
	RCALL _mov_buf_master
	LDI  R26,LOW(0)
	RCALL _mov_buf_master
	LDI  R26,LOW(131)
	RCALL _mov_buf_master
	LDI  R26,LOW(0)
	RCALL _mov_buf_master
	LDI  R26,LOW(1)
	RCALL _mov_buf_master
	RCALL _crc_end_master
; 0000 050D                                 whait_read;
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	OUT  0x2C+1,R31
	OUT  0x2C,R30
	LDI  R30,LOW(3)
	OUT  0x2E,R30
_0x3E3:
	IN   R30,0x36
	SBRS R30,2
	RJMP _0x3E3
	LDI  R30,LOW(0)
	OUT  0x2E,R30
	IN   R30,0x36
	OUT  0x36,R30
; 0000 050E                                 if (check_cr_master()==1)
	RCALL _check_cr_master
	CPI  R30,LOW(0x1)
	BRNE _0x3E6
; 0000 050F                                 {
; 0000 0510                                 if(rx_counter_master==7) SKZ_1=((int)rx_buffer_master[3])<<8|(char)rx_buffer_master[4];
	LDS  R26,_rx_counter_master
	CPI  R26,LOW(0x7)
	BRNE _0x3E7
	__GETBRMN 27,_rx_buffer_master,3
	LDI  R26,LOW(0)
	__GETB1MN _rx_buffer_master,4
	LDI  R31,0
	OR   R30,R26
	OR   R31,R27
	MOVW R8,R30
; 0000 0511                                 }
_0x3E7:
; 0000 0512                                 rx_c_master=0;rx_m_master=0;
_0x3E6:
	CLT
	BLD  R2,2
	BLD  R2,1
; 0000 0513                                 rx_wr_index_master=0;rx_counter_master=0;
	LDI  R30,LOW(0)
	STS  _rx_wr_index_master,R30
	STS  _rx_counter_master,R30
; 0000 0514                                 ClearBuf_master;
	STS  _rx_buffer_master,R30
	__PUTB1MN _rx_buffer_master,1
	__PUTB1MN _rx_buffer_master,2
	__PUTB1MN _rx_buffer_master,3
	__PUTB1MN _rx_buffer_master,4
	__PUTB1MN _rx_buffer_master,5
	__PUTB1MN _rx_buffer_master,6
	__PUTB1MN _rx_buffer_master,7
	__PUTB1MN _rx_buffer_master,8
	__PUTB1MN _rx_buffer_master,9
; 0000 0515                                 send_read_skz2;
	LDI  R30,LOW(65535)
	LDI  R31,HIGH(65535)
	STS  _crc_master,R30
	STS  _crc_master+1,R31
	LDI  R26,LOW(1)
	RCALL _mov_buf_master
	LDI  R26,LOW(4)
	RCALL _mov_buf_master
	LDI  R26,LOW(0)
	RCALL _mov_buf_master
	LDI  R26,LOW(132)
	RCALL _mov_buf_master
	LDI  R26,LOW(0)
	RCALL _mov_buf_master
	LDI  R26,LOW(1)
	RCALL _mov_buf_master
	RCALL _crc_end_master
; 0000 0516                                 whait_read;
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	OUT  0x2C+1,R31
	OUT  0x2C,R30
	LDI  R30,LOW(3)
	OUT  0x2E,R30
_0x3E8:
	IN   R30,0x36
	SBRS R30,2
	RJMP _0x3E8
	LDI  R30,LOW(0)
	OUT  0x2E,R30
	IN   R30,0x36
	OUT  0x36,R30
; 0000 0517                                 if (check_cr_master()==1)
	RCALL _check_cr_master
	CPI  R30,LOW(0x1)
	BRNE _0x3EB
; 0000 0518                                 {
; 0000 0519                                 if(rx_counter_master==7) SKZ_2=((int)rx_buffer_master[3])<<8|(char)rx_buffer_master[4];
	LDS  R26,_rx_counter_master
	CPI  R26,LOW(0x7)
	BRNE _0x3EC
	__GETBRMN 27,_rx_buffer_master,3
	LDI  R26,LOW(0)
	__GETB1MN _rx_buffer_master,4
	LDI  R31,0
	OR   R30,R26
	OR   R31,R27
	MOVW R10,R30
; 0000 051A                                 }
_0x3EC:
; 0000 051B                             }
_0x3EB:
; 0000 051C                          EEPROM_write(eeAddressSKZ1toSKZ2, SKZ1toSKZ2);
	LDI  R30,LOW(1028)
	LDI  R31,HIGH(1028)
	ST   -Y,R31
	ST   -Y,R30
	MOV  R26,R12
	CALL _EEPROM_write
; 0000 051D                          EEPROM_write(eeAddressSKZ1H, SKZ_1>>8);
	LDI  R30,LOW(1024)
	LDI  R31,HIGH(1024)
	ST   -Y,R31
	ST   -Y,R30
	MOV  R26,R9
	CALL _EEPROM_write
; 0000 051E                          EEPROM_write(eeAddressSKZ1L, SKZ_1);
	LDI  R30,LOW(1025)
	LDI  R31,HIGH(1025)
	ST   -Y,R31
	ST   -Y,R30
	MOV  R26,R8
	CALL _EEPROM_write
; 0000 051F                          EEPROM_write(eeAddressSKZ2H, SKZ_2>>8);
	LDI  R30,LOW(1026)
	LDI  R31,HIGH(1026)
	ST   -Y,R31
	ST   -Y,R30
	MOV  R26,R11
	CALL _EEPROM_write
; 0000 0520                          EEPROM_write(eeAddressSKZ2L, SKZ_2);
	LDI  R30,LOW(1027)
	LDI  R31,HIGH(1027)
	ST   -Y,R31
	ST   -Y,R30
	MOV  R26,R10
	CALL _EEPROM_write
; 0000 0521  //                               blink_display(SKZ1toSKZ2);     //вспомогательная функция для просмотра содержимого буф ...
; 0000 0522                                       if(SKZ1toSKZ2<=40)
	LDI  R30,LOW(40)
	LDI  R31,HIGH(40)
	CP   R30,R12
	CPC  R31,R13
	BRLO _0x3ED
; 0000 0523                                       {
; 0000 0524                                         warning_flag=1;
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	STS  _warning_flag,R30
	STS  _warning_flag+1,R31
; 0000 0525                                         if(SKZ1toSKZ2<=20)blink_flag=1;
	LDI  R30,LOW(20)
	LDI  R31,HIGH(20)
	CP   R30,R12
	CPC  R31,R13
	BRLO _0x3EE
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	STS  _blink_flag,R30
	STS  _blink_flag+1,R31
; 0000 0526                                         else blink_flag=0;
	RJMP _0x3EF
_0x3EE:
	LDI  R30,LOW(0)
	STS  _blink_flag,R30
	STS  _blink_flag+1,R30
; 0000 0527                                       }
_0x3EF:
; 0000 0528                                       else warning_flag=0;
	RJMP _0x3F0
_0x3ED:
	LDI  R30,LOW(0)
	STS  _warning_flag,R30
	STS  _warning_flag+1,R30
; 0000 0529                                       CalibrFlag=1;
_0x3F0:
	LDI  R30,LOW(1)
	STS  _CalibrFlag,R30
; 0000 052A save_skz_arrays(red);save_freq_order();
	LDS  R26,_red
	LDS  R27,_red+1
	CALL _save_skz_arrays
	CALL _save_freq_order
; 0000 052B send_frequency_value();
	CALL _send_frequency_value
; 0000 052C EEPROM_write(eeAddrCalibrFlag, CalibrFlag);
	LDI  R30,LOW(1279)
	LDI  R31,HIGH(1279)
	ST   -Y,R31
	ST   -Y,R30
	LDS  R26,_CalibrFlag
	CALL _EEPROM_write
; 0000 052D 
; 0000 052E                         }
; 0000 052F 
; 0000 0530                 }
_0x3D7:
_0x3D6:
; 0000 0531 
; 0000 0532 
; 0000 0533         if(key==1)if(++drebezg>1)
_0x3CD:
	SBIS 0x13,5
	RJMP _0x3F1
	LDS  R26,_drebezg
	SUBI R26,-LOW(1)
	STS  _drebezg,R26
	CPI  R26,LOW(0x2)
	BRLO _0x3F2
; 0000 0534             {
; 0000 0535             press=0;drebezg=0;
	CLT
	BLD  R2,6
	LDI  R30,LOW(0)
	STS  _drebezg,R30
; 0000 0536             if ((first_press==1)&&(second_press==1))
	SBRS R2,7
	RJMP _0x3F4
	SBRC R3,0
	RJMP _0x3F5
_0x3F4:
	RJMP _0x3F3
_0x3F5:
; 0000 0537                {
; 0000 0538                first_press=0;
	CLT
	BLD  R2,7
; 0000 0539                second_press=0;//после 2го нажатия на кнопку, сбрасываем флаги сработавших нажатий
	BLD  R3,0
; 0000 053A                }
; 0000 053B             }
_0x3F3:
; 0000 053C /*        if (rx_c_slave==1)
; 0000 053D                 {
; 0000 053E                 if (check_cr_slave()==1)
; 0000 053F                         {
; 0000 0540         		crc_slave=0xffff;
; 0000 0541         		switch (rx_buffer_slave[1])
; 0000 0542                                 {
; 0000 0543         		        case 4:{if (rx_counter_slave==8)response_m_aa4();
; 0000 0544         	          	     	else   response_m_err(1);
; 0000 0545         	          	     	break;}
; 0000 0546         		        case 6:{if (rx_counter_slave==8)response_m_aa6();
; 0000 0547         	          	     	else   response_m_err(1);
; 0000 0548         	          	     	break;}
; 0000 0549         		        default:response_m_err(2);
; 0000 054A         		        }
; 0000 054B                         }
; 0000 054C        	        rx_c_master=0;rx_m_master=0;rx_wr_index_master=0;rx_counter_master=0;
; 0000 054D        	        rx_c_slave=0;rx_m_slave=0;rx_wr_index_slave=0;rx_counter_slave=0;
; 0000 054E                 }    */
; 0000 054F                 rx_c_master=0;rx_m_master=0;rx_wr_index_master=0;rx_counter_master=0;
_0x3F2:
_0x3F1:
	CLT
	BLD  R2,2
	BLD  R2,1
	LDI  R30,LOW(0)
	STS  _rx_wr_index_master,R30
	STS  _rx_counter_master,R30
; 0000 0550        	     //   rx_c_slave=0;rx_m_slave=0;rx_wr_index_slave=0;rx_counter_slave=0;
; 0000 0551           //led_red_off;
; 0000 0552         }
	RJMP _0x38A
; 0000 0553 }
_0x3F6:
	RJMP _0x3F6
; .FEND
;//------проверка контрольной суммы master-------//
;char check_cr_master()                          //
; 0000 0556         {                                       //
_check_cr_master:
; .FSTART _check_cr_master
; 0000 0557         char error;                             //
; 0000 0558 	error=1;crc_master=0xFFFF;i=0;          //
	ST   -Y,R17
;	error -> R17
	LDI  R17,LOW(1)
	LDI  R30,LOW(65535)
	LDI  R31,HIGH(65535)
	STS  _crc_master,R30
	STS  _crc_master+1,R31
	LDI  R30,LOW(0)
	STS  _i,R30
; 0000 0559 	while (i<(rx_wr_index_master-1)){crc_rtu_master(rx_buffer_master[i]);i++;}
_0x3F7:
	LDS  R30,_rx_wr_index_master
	LDI  R31,0
	SBIW R30,1
	LDS  R26,_i
	LDI  R27,0
	CP   R26,R30
	CPC  R27,R31
	BRGE _0x3F9
	LDS  R30,_i
	LDI  R31,0
	SUBI R30,LOW(-_rx_buffer_master)
	SBCI R31,HIGH(-_rx_buffer_master)
	LD   R26,Z
	RCALL _crc_rtu_master
	LDS  R30,_i
	SUBI R30,-LOW(1)
	STS  _i,R30
	RJMP _0x3F7
_0x3F9:
; 0000 055A 	if ((rx_buffer_master[rx_wr_index_master])!=(crc_master>>8)) error=0;
	LDS  R30,_rx_wr_index_master
	LDI  R31,0
	SUBI R30,LOW(-_rx_buffer_master)
	SBCI R31,HIGH(-_rx_buffer_master)
	LD   R26,Z
	LDS  R30,_crc_master
	LDS  R31,_crc_master+1
	CALL __ASRW8
	LDI  R27,0
	CP   R30,R26
	CPC  R31,R27
	BREQ _0x3FA
	LDI  R17,LOW(0)
; 0000 055B 	if ((rx_buffer_master[rx_wr_index_master-1])!=(crc_master&0x00FF)) error=0;
_0x3FA:
	LDS  R30,_rx_wr_index_master
	LDI  R31,0
	SBIW R30,1
	SUBI R30,LOW(-_rx_buffer_master)
	SBCI R31,HIGH(-_rx_buffer_master)
	LD   R26,Z
	LDS  R30,_crc_master
	LDS  R31,_crc_master+1
	ANDI R31,HIGH(0xFF)
	LDI  R27,0
	CP   R30,R26
	CPC  R31,R27
	BREQ _0x3FB
	LDI  R17,LOW(0)
; 0000 055C 	return error;                           //
_0x3FB:
	MOV  R30,R17
	LD   R17,Y+
	RET
; 0000 055D         }                                       //
; .FEND
;//------проверка контрольной суммы slave--------//
;char check_cr_slave()                           //
; 0000 0560         {                                       //
; 0000 0561         char error;                             //
; 0000 0562 	error=1;crc_slave=0xFFFF;i=0;           //
;	error -> R17
; 0000 0563 	while (i<(rx_wr_index_slave-1)){crc_rtu_slave(rx_buffer_slave[i]);i++;}
; 0000 0564 	if ((rx_buffer_slave[rx_wr_index_slave])!=(crc_slave>>8)) error=0;
; 0000 0565 	if ((rx_buffer_slave[rx_wr_index_slave-1])!=(crc_slave&0x00FF)) error=0;
; 0000 0566 	return error;                           //
; 0000 0567         }                                       //
;//------расчет контрольной суммы master---------//
;void crc_rtu_master(char a)		        //
; 0000 056A 	{				        //
_crc_rtu_master:
; .FSTART _crc_rtu_master
; 0000 056B 	char n;                                 //
; 0000 056C 	crc_master = a^crc_master;	        //
	ST   -Y,R26
	ST   -Y,R17
;	a -> Y+1
;	n -> R17
	LDD  R30,Y+1
	LDI  R31,0
	LDS  R26,_crc_master
	LDS  R27,_crc_master+1
	EOR  R30,R26
	EOR  R31,R27
	STS  _crc_master,R30
	STS  _crc_master+1,R31
; 0000 056D 	for(n=0; n<8; n++)		        //
	LDI  R17,LOW(0)
_0x402:
	CPI  R17,8
	BRSH _0x403
; 0000 056E 		{			        //
; 0000 056F 		if(crc_master & 0x0001 == 1)	//
	LDS  R30,_crc_master
	ANDI R30,LOW(0x1)
	BREQ _0x404
; 0000 0570 			{		        //
; 0000 0571 			crc_master = crc_master>>1;//
	LDS  R30,_crc_master
	LDS  R31,_crc_master+1
	ASR  R31
	ROR  R30
	STS  _crc_master,R30
	STS  _crc_master+1,R31
; 0000 0572 			crc_master=crc_master&0x7fff;//
	__ANDBMNN _crc_master,1,127
; 0000 0573 			crc_master = crc_master^0xA001;//
	LDS  R26,_crc_master
	LDS  R27,_crc_master+1
	LDI  R30,LOW(40961)
	LDI  R31,HIGH(40961)
	EOR  R30,R26
	EOR  R31,R27
	STS  _crc_master,R30
	STS  _crc_master+1,R31
; 0000 0574 			}		        //
; 0000 0575 		else			        //
	RJMP _0x405
_0x404:
; 0000 0576 			{ 		        //
; 0000 0577 			crc_master = crc_master>>1;//
	LDS  R30,_crc_master
	LDS  R31,_crc_master+1
	ASR  R31
	ROR  R30
	STS  _crc_master,R30
	STS  _crc_master+1,R31
; 0000 0578 			crc_master=crc_master&0x7fff;//
	__ANDBMNN _crc_master,1,127
; 0000 0579 			} 		        //
_0x405:
; 0000 057A 		}			        //
	SUBI R17,-1
	RJMP _0x402
_0x403:
; 0000 057B 	}
	RJMP _0x20A0002
; .FEND
;
;void  CRC_update(unsigned char d){
; 0000 057D void  CRC_update(unsigned char d){
_CRC_update:
; .FSTART _CRC_update
; 0000 057E   unsigned char uindex;
; 0000 057F   uindex = CRCHigh^d;
	ST   -Y,R26
	ST   -Y,R17
;	d -> Y+1
;	uindex -> R17
	LDD  R30,Y+1
	LDS  R26,_CRCHigh
	EOR  R30,R26
	MOV  R17,R30
; 0000 0580   CRCHigh=CRCLow^(crctable[uindex]>>8);
	LDI  R26,LOW(_crctable_G000)
	LDI  R27,HIGH(_crctable_G000)
	LDI  R31,0
	LSL  R30
	ROL  R31
	ADD  R26,R30
	ADC  R27,R31
	CALL __GETW1P
	CALL __ASRW8
	LDS  R26,_CRCLow
	EOR  R30,R26
	STS  _CRCHigh,R30
; 0000 0581   CRCLow=crctable[uindex];
	MOV  R30,R17
	LDI  R26,LOW(_crctable_G000)
	LDI  R27,HIGH(_crctable_G000)
	LDI  R31,0
	LSL  R30
	ROL  R31
	ADD  R26,R30
	ADC  R27,R31
	LD   R30,X
	STS  _CRCLow,R30
; 0000 0582 
; 0000 0583 }			        //
_0x20A0002:
	LDD  R17,Y+0
	ADIW R28,2
	RET
; .FEND
;//------расчет контрольной суммы slave----------//
;void crc_rtu_slave(char a)		        //
; 0000 0586 	{				        //
; 0000 0587 	char n;                                 //
; 0000 0588 	crc_slave = a^crc_slave;	        //
;	a -> Y+1
;	n -> R17
; 0000 0589 	for(n=0; n<8; n++)		        //
; 0000 058A 		{			        //
; 0000 058B 		if(crc_slave & 0x0001 == 1)     //
; 0000 058C 			{		        //
; 0000 058D 			crc_slave =crc_slave>>1;//
; 0000 058E 			crc_slave=crc_slave&0x7fff;//
; 0000 058F 			crc_slave = crc_slave^0xA001;//
; 0000 0590 			}		        //
; 0000 0591 		else			        //
; 0000 0592 			{ 		        //
; 0000 0593 			crc_slave = crc_slave>>1;//
; 0000 0594 			crc_slave=crc_slave&0x7fff;//
; 0000 0595 			} 		        //
; 0000 0596 		}			        //
; 0000 0597 	}
;       //
;//------байт в буффер передатчика master--------//
;void mov_buf_master(char a){crc_rtu_master(a);mov_buf0(a);}//
; 0000 059A void mov_buf_master(char a){crc_rtu_master(a);mov_buf0(a);}
_mov_buf_master:
; .FSTART _mov_buf_master
	ST   -Y,R26
;	a -> Y+0
	LD   R26,Y
	RCALL _crc_rtu_master
	LD   R26,Y
	RCALL _mov_buf0
	RJMP _0x20A0001
; .FEND
;void mov_buf0(char a)			        //
; 0000 059C 	{				        //
_mov_buf0:
; .FSTART _mov_buf0
; 0000 059D 	#asm("cli");    		        //
	ST   -Y,R26
;	a -> Y+0
	cli
; 0000 059E 	tx_buffer_counter_master++;	        //
	LDS  R30,_tx_buffer_counter_master
	SUBI R30,-LOW(1)
	STS  _tx_buffer_counter_master,R30
; 0000 059F 	tx_buffer_master[tx_buffer_end_master]=a;//
	LDS  R30,_tx_buffer_end_master
	LDI  R31,0
	SUBI R30,LOW(-_tx_buffer_master)
	SBCI R31,HIGH(-_tx_buffer_master)
	LD   R26,Y
	STD  Z+0,R26
; 0000 05A0 	if (++tx_buffer_end_master==TX_BUFFER_SIZE) tx_buffer_end_master=0;//
	LDS  R26,_tx_buffer_end_master
	SUBI R26,-LOW(1)
	STS  _tx_buffer_end_master,R26
	CPI  R26,LOW(0x80)
	BRNE _0x40B
	LDI  R30,LOW(0)
	STS  _tx_buffer_end_master,R30
; 0000 05A1 	#asm("sei");			        //
_0x40B:
	sei
; 0000 05A2 	}				        //
_0x20A0001:
	ADIW R28,1
	RET
; .FEND
;//------байт в буффер передатчика slave---------//
;void mov_buf_slave(char a){CRC_update(a);mov_buf1(a);}//
; 0000 05A4 void mov_buf_slave(char a){CRC_update(a);mov_buf1(a);}
;	a -> Y+0
;void mov_buf1(char a)			        //
; 0000 05A6 	{				        //
; 0000 05A7 	#asm("cli");    		        //
;	a -> Y+0
; 0000 05A8 	tx_buffer_counter_slave++;	        //
; 0000 05A9 	tx_buffer_slave[tx_buffer_end_slave]=a; //
; 0000 05AA 	if (++tx_buffer_end_slave==TX_BUFFER_SIZE) tx_buffer_end_slave=0;//
; 0000 05AB 	#asm("sei");			        //
; 0000 05AC 	}				        //
;//------посылка контрольной суммы---------------//
;//------начало передачи по master---------------//
;void crc_end_master()				//
; 0000 05B0 	{				        //
_crc_end_master:
; .FSTART _crc_end_master
; 0000 05B1 	mov_buf0(crc_master);mov_buf0(crc_master>>8);//
	LDS  R26,_crc_master
	RCALL _mov_buf0
	LDS  R30,_crc_master
	LDS  R31,_crc_master+1
	CALL __ASRW8
	MOV  R26,R30
	RCALL _mov_buf0
; 0000 05B2 	TX_master_on;                              //
	SBI  0x12,4
; 0000 05B3        	UDR1=tx_buffer_master[tx_buffer_begin_master];//
	LDS  R30,_tx_buffer_begin_master
	LDI  R31,0
	SUBI R30,LOW(-_tx_buffer_master)
	SBCI R31,HIGH(-_tx_buffer_master)
	LD   R30,Z
	STS  156,R30
; 0000 05B4 	tx_en_master=1;crc_master=0xffff;       //
	SET
	BLD  R2,0
	LDI  R30,LOW(65535)
	LDI  R31,HIGH(65535)
	STS  _crc_master,R30
	STS  _crc_master+1,R31
; 0000 05B5 	}				        //
	RET
; .FEND
;//------посылка контрольной суммы---------------//
;//------начало передачи по slave----------------//
;void crc_end_slave()				//
; 0000 05B9 	{				        //
; 0000 05BA 	mov_buf1(crc_slave);mov_buf1(crc_slave>>8);//
; 0000 05BB 	TX_slave_on;                            //
; 0000 05BC        	UDR0=tx_buffer_slave[tx_buffer_begin_slave];//
; 0000 05BD 	tx_en_slave=1;crc_slave=0xffff;	        //
; 0000 05BE 	}				        //
;void send_test()				//
; 0000 05C0 	{				        //
; 0000 05C1 	TX_slave_on;                            //
; 0000 05C2        	UDR0=tx_buffer_slave[tx_buffer_begin_slave];//
; 0000 05C3 	tx_en_slave=1;
; 0000 05C4 	}
;//------ответ ошибка----------------------------//
;void response_m_err(char a)                     //
; 0000 05C7         {                                       //
; 0000 05C8 	mov_buf_slave(rx_buffer_slave[0]);      //
;	a -> Y+0
; 0000 05C9 	mov_buf_slave(rx_buffer_slave[1]|128);  //
; 0000 05CA 	mov_buf_slave(a);                       //
; 0000 05CB         crc_end_slave();                        //
; 0000 05CC         }                                       //
;//----------------------------------------------//
;unsigned char save_reg(unsigned int d,unsigned int a)
; 0000 05CF         {                                       //
; 0000 05D0         if      (a==0x01)               kn=d;   //
;	d -> Y+2
;	a -> Y+0
; 0000 05D1         else if (a==0x02)               kv=d;   //
; 0000 05D2         else                            return 0;//
; 0000 05D3         return 1;                               //
; 0000 05D4         }                                       //
;//----------------------------------------------//
;void response_m_aa4()                           //
; 0000 05D7         {                                       //
; 0000 05D8 //       	crc_master=0xFFFF;                      //
; 0000 05D9 //       	for (i=0;i<rx_counter_slave-2;i++){mov_buf_master(rx_buffer_slave[i]);}
; 0000 05DA //        crc_end_master();crc_master=0xFFFF;     //
; 0000 05DB //        TCNT1=0x0000;TCCR1B=0x03;//8000000/8==1us*65535=65ms
; 0000 05DC //        while ((TIFR&0b00000100)==0);           //
; 0000 05DD //        TCCR1B=0;TIFR=TIFR;                     //
; 0000 05DE //       	crc_slave=0xFFFF;                       //
; 0000 05DF //       	for (i=0;i<rx_counter_master-2;i++){mov_buf_slave(rx_buffer_master[i]);}
; 0000 05E0 //        crc_end_slave();                        //
; 0000 05E1         }                                       //
;//----------------------------------------------//
;void response_m_aa6()                           //
; 0000 05E4         {                                       //
; 0000 05E5 //        unsigned int d,a,i;                     //
; 0000 05E6 //        a=rx_buffer_slave[2];a=(a<<8)+rx_buffer_slave[3];d=rx_buffer_slave[4];d=(d<<8)+rx_buffer_slave[5];
; 0000 05E7 //	if (save_reg(d,a)==1){for (i=0;i<6;i++)mov_buf_slave(rx_buffer_slave[i]);crc_end_slave();}
; 0000 05E8 //	else                                    //
; 0000 05E9 //	        {                               //
; 0000 05EA //               	crc_master=0xFFFF;              //
; 0000 05EB //               	for (i=0;i<rx_counter_slave-2;i++)
; 0000 05EC //               	        {mov_buf_master(rx_buffer_slave[i]);}
; 0000 05ED //                crc_end_master();crc_master=0xFFFF;
; 0000 05EE //                TCNT1=0x0000;TCCR1B=0x03;//8000000/8==1us*65535=65ms
; 0000 05EF //                while ((TIFR&0b00000100)==0);  //
; 0000 05F0 //                TCCR1B=0;                      //
; 0000 05F1 //                TIFR=TIFR;                     //
; 0000 05F2 //               	crc_slave=0xFFFF;              //
; 0000 05F3 //               	for (i=0;i<rx_counter_master-2;i++){mov_buf_slave(rx_buffer_master[i]);}
; 0000 05F4 //                crc_end_slave();               //
; 0000 05F5 //	        }                              //
; 0000 05F6         }                                      //
;//----------------------------------------------//
;
;
;
;void GetCRC16(char len)
; 0000 05FC {int b;
; 0000 05FD  crc_slave = 0xFFFF;
;	len -> Y+2
;	b -> R16,R17
; 0000 05FE  for(b=0;b<len;b++)
; 0000 05FF   {
; 0000 0600    crc_slave = crctable[((crc_slave>>8)^rx_buffer_slave[b])&0xFF] ^ (crc_slave<<8);
; 0000 0601   }
; 0000 0602  crc_slave ^= 0xFFFF;
; 0000 0603  //return crc_slave;
; 0000 0604 }
;

	.CSEG
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

	.CSEG

	.CSEG

	.DSEG

	.CSEG

	.CSEG

	.CSEG

	.DSEG
_SKZ_read:
	.BYTE 0x2
_true_skz:
	.BYTE 0x2
_terminal_mode:
	.BYTE 0x2
_BPS_absent:
	.BYTE 0x2
_bps_absent_ctr:
	.BYTE 0x2
_rx_buffer_master:
	.BYTE 0x80
_rd_counts:
	.BYTE 0x1
_CalibrFlag:
	.BYTE 0x1
_r:
	.BYTE 0x1
_object_state:
	.BYTE 0x1
_SPI_tEnd:
	.BYTE 0x1
_ModBusAddress:
	.BYTE 0x2
_minimal_SKZ_val:
	.BYTE 0x2
_minimal_object_enabled_level:
	.BYTE 0x2
_rx_wr_index_master:
	.BYTE 0x1
_rx_counter_master:
	.BYTE 0x1
_mod_time_master:
	.BYTE 0x1
_CRCHigh:
	.BYTE 0x1
_CRCLow:
	.BYTE 0x1
_reg91_answer:
	.BYTE 0x1
_crc_master:
	.BYTE 0x2
_crc_slave:
	.BYTE 0x2
_AverTime_Value:
	.BYTE 0x2
_AvTimer:
	.BYTE 0x2
_start_calibration:
	.BYTE 0x2
_flash_erase_flag:
	.BYTE 0x2
_AverSKZ_Value:
	.BYTE 0x2
_tx_buffer_counter_master:
	.BYTE 0x1
_tx_buffer_counter_slave:
	.BYTE 0x1
_FreqOrder_read:
	.BYTE 0x1
_i:
	.BYTE 0x1
_drebezg:
	.BYTE 0x1
_AverSKZprcnt:
	.BYTE 0x1
_BlinkCounter_Calibration:
	.BYTE 0x2
_tok:
	.BYTE 0x2
_warning_flag:
	.BYTE 0x2
_FrequencyQ:
	.BYTE 0x2
_ModbusMessage:
	.BYTE 0x2
_blink_flag:
	.BYTE 0x2
_red:
	.BYTE 0x2
_SKZread_counter:
	.BYTE 0x4
_DeviceID_G000:
	.BYTE 0x2
_crctable_G000:
	.BYTE 0x200
_rx_buffer_slave:
	.BYTE 0x80
_RData:
	.BYTE 0x1
_rx_wr_index_slave:
	.BYTE 0x1
_rx_counter_slave:
	.BYTE 0x1
_mod_time_slave:
	.BYTE 0x1
_tx_buffer_slave:
	.BYTE 0x80
_tx_buffer_begin_slave:
	.BYTE 0x1
_tx_buffer_end_slave:
	.BYTE 0x1
_tx_buffer_master:
	.BYTE 0x80
_tx_buffer_begin_master:
	.BYTE 0x1
_tx_buffer_end_master:
	.BYTE 0x1

	.ESEG
_kv:
	.DB  0x0,0x0,0xC8,0x42
_kn:
	.DB  0x0,0x0,0xC8,0x42

	.DSEG
__seed_G102:
	.BYTE 0x4

	.CSEG

	.CSEG
_delay_ms:
	adiw r26,0
	breq __delay_ms1
__delay_ms0:
	__DELAY_USW 0x7D0
	wdr
	sbiw r26,1
	brne __delay_ms0
__delay_ms1:
	ret

__ROUND_REPACK:
	TST  R21
	BRPL __REPACK
	CPI  R21,0x80
	BRNE __ROUND_REPACK0
	SBRS R30,0
	RJMP __REPACK
__ROUND_REPACK0:
	ADIW R30,1
	ADC  R22,R25
	ADC  R23,R25
	BRVS __REPACK1

__REPACK:
	LDI  R21,0x80
	EOR  R21,R23
	BRNE __REPACK0
	PUSH R21
	RJMP __ZERORES
__REPACK0:
	CPI  R21,0xFF
	BREQ __REPACK1
	LSL  R22
	LSL  R0
	ROR  R21
	ROR  R22
	MOV  R23,R21
	RET
__REPACK1:
	PUSH R21
	TST  R0
	BRMI __REPACK2
	RJMP __MAXRES
__REPACK2:
	RJMP __MINRES

__UNPACK:
	LDI  R21,0x80
	MOV  R1,R25
	AND  R1,R21
	LSL  R24
	ROL  R25
	EOR  R25,R21
	LSL  R21
	ROR  R24

__UNPACK1:
	LDI  R21,0x80
	MOV  R0,R23
	AND  R0,R21
	LSL  R22
	ROL  R23
	EOR  R23,R21
	LSL  R21
	ROR  R22
	RET

__CFD1U:
	SET
	RJMP __CFD1U0
__CFD1:
	CLT
__CFD1U0:
	PUSH R21
	RCALL __UNPACK1
	CPI  R23,0x80
	BRLO __CFD10
	CPI  R23,0xFF
	BRCC __CFD10
	RJMP __ZERORES
__CFD10:
	LDI  R21,22
	SUB  R21,R23
	BRPL __CFD11
	NEG  R21
	CPI  R21,8
	BRTC __CFD19
	CPI  R21,9
__CFD19:
	BRLO __CFD17
	SER  R30
	SER  R31
	SER  R22
	LDI  R23,0x7F
	BLD  R23,7
	RJMP __CFD15
__CFD17:
	CLR  R23
	TST  R21
	BREQ __CFD15
__CFD18:
	LSL  R30
	ROL  R31
	ROL  R22
	ROL  R23
	DEC  R21
	BRNE __CFD18
	RJMP __CFD15
__CFD11:
	CLR  R23
__CFD12:
	CPI  R21,8
	BRLO __CFD13
	MOV  R30,R31
	MOV  R31,R22
	MOV  R22,R23
	SUBI R21,8
	RJMP __CFD12
__CFD13:
	TST  R21
	BREQ __CFD15
__CFD14:
	LSR  R23
	ROR  R22
	ROR  R31
	ROR  R30
	DEC  R21
	BRNE __CFD14
__CFD15:
	TST  R0
	BRPL __CFD16
	RCALL __ANEGD1
__CFD16:
	POP  R21
	RET

__CDF1U:
	SET
	RJMP __CDF1U0
__CDF1:
	CLT
__CDF1U0:
	SBIW R30,0
	SBCI R22,0
	SBCI R23,0
	BREQ __CDF10
	CLR  R0
	BRTS __CDF11
	TST  R23
	BRPL __CDF11
	COM  R0
	RCALL __ANEGD1
__CDF11:
	MOV  R1,R23
	LDI  R23,30
	TST  R1
__CDF12:
	BRMI __CDF13
	DEC  R23
	LSL  R30
	ROL  R31
	ROL  R22
	ROL  R1
	RJMP __CDF12
__CDF13:
	MOV  R30,R31
	MOV  R31,R22
	MOV  R22,R1
	PUSH R21
	RCALL __REPACK
	POP  R21
__CDF10:
	RET

__SWAPACC:
	PUSH R20
	MOVW R20,R30
	MOVW R30,R26
	MOVW R26,R20
	MOVW R20,R22
	MOVW R22,R24
	MOVW R24,R20
	MOV  R20,R0
	MOV  R0,R1
	MOV  R1,R20
	POP  R20
	RET

__UADD12:
	ADD  R30,R26
	ADC  R31,R27
	ADC  R22,R24
	RET

__NEGMAN1:
	COM  R30
	COM  R31
	COM  R22
	SUBI R30,-1
	SBCI R31,-1
	SBCI R22,-1
	RET

__SUBF12:
	PUSH R21
	RCALL __UNPACK
	CPI  R25,0x80
	BREQ __ADDF129
	LDI  R21,0x80
	EOR  R1,R21

	RJMP __ADDF120

__ADDF12:
	PUSH R21
	RCALL __UNPACK
	CPI  R25,0x80
	BREQ __ADDF129

__ADDF120:
	CPI  R23,0x80
	BREQ __ADDF128
__ADDF121:
	MOV  R21,R23
	SUB  R21,R25
	BRVS __ADDF1211
	BRPL __ADDF122
	RCALL __SWAPACC
	RJMP __ADDF121
__ADDF122:
	CPI  R21,24
	BRLO __ADDF123
	CLR  R26
	CLR  R27
	CLR  R24
__ADDF123:
	CPI  R21,8
	BRLO __ADDF124
	MOV  R26,R27
	MOV  R27,R24
	CLR  R24
	SUBI R21,8
	RJMP __ADDF123
__ADDF124:
	TST  R21
	BREQ __ADDF126
__ADDF125:
	LSR  R24
	ROR  R27
	ROR  R26
	DEC  R21
	BRNE __ADDF125
__ADDF126:
	MOV  R21,R0
	EOR  R21,R1
	BRMI __ADDF127
	RCALL __UADD12
	BRCC __ADDF129
	ROR  R22
	ROR  R31
	ROR  R30
	INC  R23
	BRVC __ADDF129
	RJMP __MAXRES
__ADDF128:
	RCALL __SWAPACC
__ADDF129:
	RCALL __REPACK
	POP  R21
	RET
__ADDF1211:
	BRCC __ADDF128
	RJMP __ADDF129
__ADDF127:
	SUB  R30,R26
	SBC  R31,R27
	SBC  R22,R24
	BREQ __ZERORES
	BRCC __ADDF1210
	COM  R0
	RCALL __NEGMAN1
__ADDF1210:
	TST  R22
	BRMI __ADDF129
	LSL  R30
	ROL  R31
	ROL  R22
	DEC  R23
	BRVC __ADDF1210

__ZERORES:
	CLR  R30
	CLR  R31
	CLR  R22
	CLR  R23
	POP  R21
	RET

__MINRES:
	SER  R30
	SER  R31
	LDI  R22,0x7F
	SER  R23
	POP  R21
	RET

__MAXRES:
	SER  R30
	SER  R31
	LDI  R22,0x7F
	LDI  R23,0x7F
	POP  R21
	RET

__MULF12:
	PUSH R21
	RCALL __UNPACK
	CPI  R23,0x80
	BREQ __ZERORES
	CPI  R25,0x80
	BREQ __ZERORES
	EOR  R0,R1
	SEC
	ADC  R23,R25
	BRVC __MULF124
	BRLT __ZERORES
__MULF125:
	TST  R0
	BRMI __MINRES
	RJMP __MAXRES
__MULF124:
	PUSH R0
	PUSH R17
	PUSH R18
	PUSH R19
	PUSH R20
	CLR  R17
	CLR  R18
	CLR  R25
	MUL  R22,R24
	MOVW R20,R0
	MUL  R24,R31
	MOV  R19,R0
	ADD  R20,R1
	ADC  R21,R25
	MUL  R22,R27
	ADD  R19,R0
	ADC  R20,R1
	ADC  R21,R25
	MUL  R24,R30
	RCALL __MULF126
	MUL  R27,R31
	RCALL __MULF126
	MUL  R22,R26
	RCALL __MULF126
	MUL  R27,R30
	RCALL __MULF127
	MUL  R26,R31
	RCALL __MULF127
	MUL  R26,R30
	ADD  R17,R1
	ADC  R18,R25
	ADC  R19,R25
	ADC  R20,R25
	ADC  R21,R25
	MOV  R30,R19
	MOV  R31,R20
	MOV  R22,R21
	MOV  R21,R18
	POP  R20
	POP  R19
	POP  R18
	POP  R17
	POP  R0
	TST  R22
	BRMI __MULF122
	LSL  R21
	ROL  R30
	ROL  R31
	ROL  R22
	RJMP __MULF123
__MULF122:
	INC  R23
	BRVS __MULF125
__MULF123:
	RCALL __ROUND_REPACK
	POP  R21
	RET

__MULF127:
	ADD  R17,R0
	ADC  R18,R1
	ADC  R19,R25
	RJMP __MULF128
__MULF126:
	ADD  R18,R0
	ADC  R19,R1
__MULF128:
	ADC  R20,R25
	ADC  R21,R25
	RET

__DIVF21:
	PUSH R21
	RCALL __UNPACK
	CPI  R23,0x80
	BRNE __DIVF210
	TST  R1
__DIVF211:
	BRPL __DIVF219
	RJMP __MINRES
__DIVF219:
	RJMP __MAXRES
__DIVF210:
	CPI  R25,0x80
	BRNE __DIVF218
__DIVF217:
	RJMP __ZERORES
__DIVF218:
	EOR  R0,R1
	SEC
	SBC  R25,R23
	BRVC __DIVF216
	BRLT __DIVF217
	TST  R0
	RJMP __DIVF211
__DIVF216:
	MOV  R23,R25
	PUSH R17
	PUSH R18
	PUSH R19
	PUSH R20
	CLR  R1
	CLR  R17
	CLR  R18
	CLR  R19
	CLR  R20
	CLR  R21
	LDI  R25,32
__DIVF212:
	CP   R26,R30
	CPC  R27,R31
	CPC  R24,R22
	CPC  R20,R17
	BRLO __DIVF213
	SUB  R26,R30
	SBC  R27,R31
	SBC  R24,R22
	SBC  R20,R17
	SEC
	RJMP __DIVF214
__DIVF213:
	CLC
__DIVF214:
	ROL  R21
	ROL  R18
	ROL  R19
	ROL  R1
	ROL  R26
	ROL  R27
	ROL  R24
	ROL  R20
	DEC  R25
	BRNE __DIVF212
	MOVW R30,R18
	MOV  R22,R1
	POP  R20
	POP  R19
	POP  R18
	POP  R17
	TST  R22
	BRMI __DIVF215
	LSL  R21
	ROL  R30
	ROL  R31
	ROL  R22
	DEC  R23
	BRVS __DIVF217
__DIVF215:
	RCALL __ROUND_REPACK
	POP  R21
	RET

__ANEGW1:
	NEG  R31
	NEG  R30
	SBCI R31,0
	RET

__ANEGD1:
	COM  R31
	COM  R22
	COM  R23
	NEG  R30
	SBCI R31,-1
	SBCI R22,-1
	SBCI R23,-1
	RET

__LSRB12:
	TST  R30
	MOV  R0,R30
	MOV  R30,R26
	BREQ __LSRB12R
__LSRB12L:
	LSR  R30
	DEC  R0
	BRNE __LSRB12L
__LSRB12R:
	RET

__LSLW3:
	LSL  R30
	ROL  R31
__LSLW2:
	LSL  R30
	ROL  R31
	LSL  R30
	ROL  R31
	RET

__ASRW4:
	ASR  R31
	ROR  R30
__ASRW3:
	ASR  R31
	ROR  R30
__ASRW2:
	ASR  R31
	ROR  R30
	ASR  R31
	ROR  R30
	RET

__ASRW8:
	MOV  R30,R31
	CLR  R31
	SBRC R30,7
	SER  R31
	RET

__CWD1:
	MOV  R22,R31
	ADD  R22,R22
	SBC  R22,R22
	MOV  R23,R22
	RET

__EQB12:
	CP   R30,R26
	LDI  R30,1
	BREQ __EQB12T
	CLR  R30
__EQB12T:
	RET

__NEB12:
	CP   R30,R26
	LDI  R30,1
	BRNE __NEB12T
	CLR  R30
__NEB12T:
	RET

__EQW12:
	CP   R30,R26
	CPC  R31,R27
	LDI  R30,1
	BREQ __EQW12T
	CLR  R30
__EQW12T:
	RET

__NEW12:
	CP   R30,R26
	CPC  R31,R27
	LDI  R30,1
	BRNE __NEW12T
	CLR  R30
__NEW12T:
	RET

__LEW12:
	CP   R30,R26
	CPC  R31,R27
	LDI  R30,1
	BRGE __LEW12T
	CLR  R30
__LEW12T:
	RET

__GEW12:
	CP   R26,R30
	CPC  R27,R31
	LDI  R30,1
	BRGE __GEW12T
	CLR  R30
__GEW12T:
	RET

__LTW12:
	CP   R26,R30
	CPC  R27,R31
	LDI  R30,1
	BRLT __LTW12T
	CLR  R30
__LTW12T:
	RET

__GTW12:
	CP   R30,R26
	CPC  R31,R27
	LDI  R30,1
	BRLT __GTW12T
	CLR  R30
__GTW12T:
	RET

__LNEGW1:
	OR   R30,R31
	LDI  R30,1
	BREQ __LNEGW1F
	LDI  R30,0
__LNEGW1F:
	RET

__DIVW21U:
	CLR  R0
	CLR  R1
	LDI  R25,16
__DIVW21U1:
	LSL  R26
	ROL  R27
	ROL  R0
	ROL  R1
	SUB  R0,R30
	SBC  R1,R31
	BRCC __DIVW21U2
	ADD  R0,R30
	ADC  R1,R31
	RJMP __DIVW21U3
__DIVW21U2:
	SBR  R26,1
__DIVW21U3:
	DEC  R25
	BRNE __DIVW21U1
	MOVW R30,R26
	MOVW R26,R0
	RET

__DIVW21:
	RCALL __CHKSIGNW
	RCALL __DIVW21U
	BRTC __DIVW211
	RCALL __ANEGW1
__DIVW211:
	RET

__CHKSIGNW:
	CLT
	SBRS R31,7
	RJMP __CHKSW1
	RCALL __ANEGW1
	SET
__CHKSW1:
	SBRS R27,7
	RJMP __CHKSW2
	COM  R26
	COM  R27
	ADIW R26,1
	BLD  R0,0
	INC  R0
	BST  R0,0
__CHKSW2:
	RET

__GETW1P:
	LD   R30,X+
	LD   R31,X
	SBIW R26,1
	RET

__GETD1P_INC:
	LD   R30,X+
	LD   R31,X+
	LD   R22,X+
	LD   R23,X+
	RET

__PUTDP1_DEC:
	ST   -X,R23
	ST   -X,R22
	ST   -X,R31
	ST   -X,R30
	RET

__SWAPD12:
	MOV  R1,R24
	MOV  R24,R22
	MOV  R22,R1
	MOV  R1,R25
	MOV  R25,R23
	MOV  R23,R1

__SWAPW12:
	MOV  R1,R27
	MOV  R27,R31
	MOV  R31,R1

__SWAPB12:
	MOV  R1,R26
	MOV  R26,R30
	MOV  R30,R1
	RET

__SAVELOCR6:
	ST   -Y,R21
__SAVELOCR5:
	ST   -Y,R20
__SAVELOCR4:
	ST   -Y,R19
__SAVELOCR3:
	ST   -Y,R18
__SAVELOCR2:
	ST   -Y,R17
	ST   -Y,R16
	RET

__LOADLOCR6:
	LDD  R21,Y+5
__LOADLOCR5:
	LDD  R20,Y+4
__LOADLOCR4:
	LDD  R19,Y+3
__LOADLOCR3:
	LDD  R18,Y+2
__LOADLOCR2:
	LDD  R17,Y+1
	LD   R16,Y
	RET

;END OF CODE MARKER
__END_OF_CODE:
