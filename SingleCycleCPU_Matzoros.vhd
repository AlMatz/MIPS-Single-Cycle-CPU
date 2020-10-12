-- Copyright (C) 1991-2013 Altera Corporation
-- Your use of Altera Corporation's design tools, logic functions 
-- and other software and tools, and its AMPP partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Altera Program License 
-- Subscription Agreement, Altera MegaCore Function License 
-- Agreement, or other applicable license agreement, including, 
-- without limitation, that your use is for the sole purpose of 
-- programming logic devices manufactured by Altera and sold by 
-- Altera or its authorized distributors.  Please refer to the 
-- applicable agreement for further details.

-- PROGRAM		"Quartus II 64-Bit"
-- VERSION		"Version 13.0.1 Build 232 06/12/2013 Service Pack 1 SJ Web Edition"
-- CREATED		"Sun May 10 11:47:01 2020"

LIBRARY ieee;
USE ieee.std_logic_1164.all; 

LIBRARY work;

ENTITY SingleCycleCPU_Matzoros IS 
	PORT
	(
		clck_matz :  IN  STD_LOGIC;
		binary_input_mat_second :  OUT  STD_LOGIC_VECTOR(31 DOWNTO 0);
		display_on_seg_mat :  OUT  STD_LOGIC_VECTOR(76 DOWNTO 0);
		display_sign_seg :  OUT  STD_LOGIC_VECTOR(6 DOWNTO 0);
		out_matz :  OUT  STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END SingleCycleCPU_Matzoros;

ARCHITECTURE bdf_type OF SingleCycleCPU_Matzoros IS 

COMPONENT alucontrol_unit_matzoros
	PORT(ALUctrl_in_matz : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
		 Function_in_matz : IN STD_LOGIC_VECTOR(5 DOWNTO 0);
		 ALUctrl_out_matz : OUT STD_LOGIC_VECTOR(2 DOWNTO 0)
	);
END COMPONENT;

COMPONENT alu_matz
	PORT(ALUctrl_in_matz : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
		 input_operand_a_matz : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 input_operand_b_matz : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 zero_output_matz : OUT STD_LOGIC;
		 output_matz : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END COMPONENT;

COMPONENT adder_32_matzoros
	PORT(in_a_matz : IN STD_LOGIC_VECTOR(31 DOWNTO 0) := x"00000004";
		 in_b_matz : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 out_matz : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END COMPONENT;

COMPONENT two2one_mux_matz
	PORT(selc_matz : IN STD_LOGIC;
		 ina_matz : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 inb_matz : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 out_matz : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END COMPONENT;

COMPONENT immediate_pc_extender_matz
	PORT(immediate_in_matz : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		 extended_immediate_out_matz : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END COMPONENT;

COMPONENT data_memory_matz
	PORT(wenable_matz : IN STD_LOGIC;
		 clock_matz : IN STD_LOGIC;
		 address_in_matz : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 write_value_in_matz : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 read_value_out_matz : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END COMPONENT;

COMPONENT two2one_5bit_mux_matz
	PORT(selct_matz : IN STD_LOGIC;
		 a_in_matz : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
		 b_in_matz : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
		 output_matz : OUT STD_LOGIC_VECTOR(4 DOWNTO 0)
	);
END COMPONENT;

COMPONENT register_file_matz
	PORT(wenable_matz : IN STD_LOGIC;
		 clock_matz : IN STD_LOGIC;
		 rs_address_in_matz : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
		 rt_address_in_matz : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
		 write_register_address_matz : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
		 write_value_in_matz : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 read_rs_out_matz : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		 read_rt_out_matz : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END COMPONENT;

COMPONENT instruction_memory_matz
	PORT(pc_in_matz : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 instruction_out_matz : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END COMPONENT;

COMPONENT display_it_mat
GENERIC (Nbits : INTEGER
			);
	PORT(sign_input_mat : IN STD_LOGIC;
		 binary_input_mat : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 binary_input_mat_second : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		 display_on_seg_mat : OUT STD_LOGIC_VECTOR(76 DOWNTO 0);
		 display_sign_seg : OUT STD_LOGIC_VECTOR(6 DOWNTO 0)
	);
END COMPONENT;

COMPONENT control_unit_matzoros
	PORT(OpCode_in_matz : IN STD_LOGIC_VECTOR(5 DOWNTO 0);
		 RegDST_matz : OUT STD_LOGIC;
		 ALUSrc_matz : OUT STD_LOGIC;
		 MemtoReg_matz : OUT STD_LOGIC;
		 RegWrite_matz : OUT STD_LOGIC;
		 MemWrite_matz : OUT STD_LOGIC;
		 PCSrc_matz : OUT STD_LOGIC;
		 ExtOp_matz : OUT STD_LOGIC;
		 ALUctrl_matz : OUT STD_LOGIC_VECTOR(2 DOWNTO 0)
	);
END COMPONENT;

COMPONENT instruction_register_matz_s2020
	PORT(input_instruction_matz : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 function_matz : OUT STD_LOGIC_VECTOR(5 DOWNTO 0);
		 opcode_matz : OUT STD_LOGIC_VECTOR(5 DOWNTO 0);
		 rd_address_out_matz : OUT STD_LOGIC_VECTOR(4 DOWNTO 0);
		 rs_address_out_matz : OUT STD_LOGIC_VECTOR(4 DOWNTO 0);
		 rt_address_out_matz : OUT STD_LOGIC_VECTOR(4 DOWNTO 0);
		 shift_value_matz : OUT STD_LOGIC_VECTOR(4 DOWNTO 0)
	);
END COMPONENT;

COMPONENT immediate_extender_matz
	PORT(extend_type : IN STD_LOGIC;
		 immediate_in_matz : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		 extended_immediate_out_matz : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END COMPONENT;

COMPONENT immediate_holder_matz
	PORT(function_matz : IN STD_LOGIC_VECTOR(5 DOWNTO 0);
		 rd_address_out_matz : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
		 shift_value_matz : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
		 immediate_out_matz : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
	);
END COMPONENT;

COMPONENT program_counter_matzoros
	PORT(clck_matz : IN STD_LOGIC;
		 Address_in_Matz : IN STD_LOGIC_VECTOR(31 DOWNTO 0) := x"00000000";
		 Address_out_Matz : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END COMPONENT;

SIGNAL	SYNTHESIZED_WIRE_0 :  STD_LOGIC_VECTOR(2 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_42 :  STD_LOGIC_VECTOR(5 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_2 :  STD_LOGIC_VECTOR(2 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_3 :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_4 :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_43 :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_44 :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_7 :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_8 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_10 :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_45 :  STD_LOGIC_VECTOR(15 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_12 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_46 :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_47 :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_15 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_48 :  STD_LOGIC_VECTOR(4 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_49 :  STD_LOGIC_VECTOR(4 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_18 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_19 :  STD_LOGIC_VECTOR(4 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_21 :  STD_LOGIC_VECTOR(4 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_50 :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_23 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_24 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_26 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_28 :  STD_LOGIC_VECTOR(5 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_29 :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_30 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_32 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_34 :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_37 :  STD_LOGIC_VECTOR(4 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_38 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_40 :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_41 :  STD_LOGIC_VECTOR(31 DOWNTO 0);


BEGIN 
out_matz <= SYNTHESIZED_WIRE_50;
SYNTHESIZED_WIRE_26 <= '0';



b2v_inst : alucontrol_unit_matzoros
PORT MAP(ALUctrl_in_matz => SYNTHESIZED_WIRE_0,
		 Function_in_matz => SYNTHESIZED_WIRE_42,
		 ALUctrl_out_matz => SYNTHESIZED_WIRE_2);


b2v_inst1 : alu_matz
PORT MAP(ALUctrl_in_matz => SYNTHESIZED_WIRE_2,
		 input_operand_a_matz => SYNTHESIZED_WIRE_3,
		 input_operand_b_matz => SYNTHESIZED_WIRE_4,
		 zero_output_matz => SYNTHESIZED_WIRE_23,
		 output_matz => SYNTHESIZED_WIRE_46);


b2v_inst10 : adder_32_matzoros
PORT MAP(in_b_matz => SYNTHESIZED_WIRE_43,
		 out_matz => SYNTHESIZED_WIRE_44);


b2v_inst11 : adder_32_matzoros
PORT MAP(in_a_matz => SYNTHESIZED_WIRE_44,
		 in_b_matz => SYNTHESIZED_WIRE_7,
		 out_matz => SYNTHESIZED_WIRE_10);


b2v_inst12 : two2one_mux_matz
PORT MAP(selc_matz => SYNTHESIZED_WIRE_8,
		 ina_matz => SYNTHESIZED_WIRE_44,
		 inb_matz => SYNTHESIZED_WIRE_10,
		 out_matz => SYNTHESIZED_WIRE_41);


b2v_inst13 : immediate_pc_extender_matz
PORT MAP(immediate_in_matz => SYNTHESIZED_WIRE_45,
		 extended_immediate_out_matz => SYNTHESIZED_WIRE_7);


b2v_inst14 : data_memory_matz
PORT MAP(wenable_matz => SYNTHESIZED_WIRE_12,
		 clock_matz => clck_matz,
		 address_in_matz => SYNTHESIZED_WIRE_46,
		 write_value_in_matz => SYNTHESIZED_WIRE_47,
		 read_value_out_matz => SYNTHESIZED_WIRE_40);


b2v_inst15 : two2one_5bit_mux_matz
PORT MAP(selct_matz => SYNTHESIZED_WIRE_15,
		 a_in_matz => SYNTHESIZED_WIRE_48,
		 b_in_matz => SYNTHESIZED_WIRE_49,
		 output_matz => SYNTHESIZED_WIRE_21);


b2v_inst16 : register_file_matz
PORT MAP(wenable_matz => SYNTHESIZED_WIRE_18,
		 clock_matz => clck_matz,
		 rs_address_in_matz => SYNTHESIZED_WIRE_19,
		 rt_address_in_matz => SYNTHESIZED_WIRE_48,
		 write_register_address_matz => SYNTHESIZED_WIRE_21,
		 write_value_in_matz => SYNTHESIZED_WIRE_50,
		 read_rs_out_matz => SYNTHESIZED_WIRE_3,
		 read_rt_out_matz => SYNTHESIZED_WIRE_47);


SYNTHESIZED_WIRE_8 <= SYNTHESIZED_WIRE_23 AND SYNTHESIZED_WIRE_24;


b2v_inst2 : instruction_memory_matz
PORT MAP(pc_in_matz => SYNTHESIZED_WIRE_43,
		 instruction_out_matz => SYNTHESIZED_WIRE_29);


b2v_inst20 : display_it_mat
GENERIC MAP(Nbits => 32
			)
PORT MAP(sign_input_mat => SYNTHESIZED_WIRE_26,
		 binary_input_mat => SYNTHESIZED_WIRE_50,
		 binary_input_mat_second => binary_input_mat_second,
		 display_on_seg_mat => display_on_seg_mat,
		 display_sign_seg => display_sign_seg);



b2v_inst3 : control_unit_matzoros
PORT MAP(OpCode_in_matz => SYNTHESIZED_WIRE_28,
		 RegDST_matz => SYNTHESIZED_WIRE_15,
		 ALUSrc_matz => SYNTHESIZED_WIRE_32,
		 MemtoReg_matz => SYNTHESIZED_WIRE_38,
		 RegWrite_matz => SYNTHESIZED_WIRE_18,
		 MemWrite_matz => SYNTHESIZED_WIRE_12,
		 PCSrc_matz => SYNTHESIZED_WIRE_24,
		 ExtOp_matz => SYNTHESIZED_WIRE_30,
		 ALUctrl_matz => SYNTHESIZED_WIRE_0);


b2v_inst4 : instruction_register_matz_s2020
PORT MAP(input_instruction_matz => SYNTHESIZED_WIRE_29,
		 function_matz => SYNTHESIZED_WIRE_42,
		 opcode_matz => SYNTHESIZED_WIRE_28,
		 rd_address_out_matz => SYNTHESIZED_WIRE_49,
		 rs_address_out_matz => SYNTHESIZED_WIRE_19,
		 rt_address_out_matz => SYNTHESIZED_WIRE_48,
		 shift_value_matz => SYNTHESIZED_WIRE_37);


b2v_inst5 : immediate_extender_matz
PORT MAP(extend_type => SYNTHESIZED_WIRE_30,
		 immediate_in_matz => SYNTHESIZED_WIRE_45,
		 extended_immediate_out_matz => SYNTHESIZED_WIRE_34);


b2v_inst6 : two2one_mux_matz
PORT MAP(selc_matz => SYNTHESIZED_WIRE_32,
		 ina_matz => SYNTHESIZED_WIRE_47,
		 inb_matz => SYNTHESIZED_WIRE_34,
		 out_matz => SYNTHESIZED_WIRE_4);


b2v_inst7 : immediate_holder_matz
PORT MAP(function_matz => SYNTHESIZED_WIRE_42,
		 rd_address_out_matz => SYNTHESIZED_WIRE_49,
		 shift_value_matz => SYNTHESIZED_WIRE_37,
		 immediate_out_matz => SYNTHESIZED_WIRE_45);


b2v_inst8 : two2one_mux_matz
PORT MAP(selc_matz => SYNTHESIZED_WIRE_38,
		 ina_matz => SYNTHESIZED_WIRE_46,
		 inb_matz => SYNTHESIZED_WIRE_40,
		 out_matz => SYNTHESIZED_WIRE_50);


b2v_inst9 : program_counter_matzoros
PORT MAP(clck_matz => clck_matz,
		 Address_in_Matz => SYNTHESIZED_WIRE_41,
		 Address_out_Matz => SYNTHESIZED_WIRE_43);


END bdf_type;