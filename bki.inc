
	.DEF _rx_wr_index_master=R5
	.DEF _rx_counter_master=R4
	.DEF _mod_time_master=R7
	.DEF _rx_wr_index_slave=R6
	.DEF _rx_counter_slave=R9
	.DEF _mod_time_slave=R8
	.DEF _tx_buffer_begin_master=R11
	.DEF _tx_buffer_end_master=R10
	.DEF _tx_buffer_begin_slave=R13
	.DEF _tx_buffer_end_slave=R12
_0x2A9:
	.DB  0x0,0x0
	.DB  0x0,0x0
_tbl10_G3:
	.DB  0x10,0x27,0xE8,0x3,0x64,0x0,0xA,0x0
	.DB  0x1,0x0
_tbl16_G3:
	.DB  0x0,0x10,0x0,0x1,0x10,0x0,0x1,0x0
_992:
	.DW  0x00

__GLOBAL_INI_TBL:
	.DW  0x02
	.DW  _p_S6D
	.DW  _992*2

	.DW  0
_0x404:
