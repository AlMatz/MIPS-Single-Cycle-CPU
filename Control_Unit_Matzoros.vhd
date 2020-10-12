library ieee;
use ieee.std_logic_1164.all;

entity Control_Unit_Matzoros is
port (
			OpCode_in_matz : in std_logic_vector(5 downto 0);
			RegDST_matz : out std_logic;
			ALUSrc_matz : out std_logic;
			MemtoReg_matz : out std_logic;
			RegWrite_matz : out std_logic;
			MemWrite_matz : out std_logic;
			PCSrc_matz : out std_logic;
			ExtOp_matz : out std_logic;
			ALUctrl_matz : out std_logic_vector(2 downto 0)
		);
end Control_Unit_Matzoros;
		
architecture ConUnit of Control_Unit_Matzoros is
begin
process(Opcode_in_matz)
begin
	if (Opcode_in_matz = "000000") then --add, subtract, and, or, xor, multiply, divide, slt; r type
			RegDST_matz <= '1';
			ALUSrc_matz <= '0';
			MemtoReg_matz <= '0';
			RegWrite_matz <= '1';
			MemWrite_matz <= '0';
			PCSrc_matz <= '0';
			ExtOp_matz <= '0';
			ALUctrl_matz <= "100";
	elsif (Opcode_in_matz = "001101") then --ori, i type
			RegDST_matz <= '0';
			ALUSrc_matz <= '1';
			MemtoReg_matz <= '0';
			RegWrite_matz <= '1';
			MemWrite_matz <= '0';
			PCSrc_matz <= '0';
			ExtOp_matz <= '0';
			ALUctrl_matz <= "010";
	elsif (Opcode_in_matz = "000100") then -- beq, 
			RegDST_matz <= '0';
			ALUSrc_matz <= '0';
			MemtoReg_matz <= '0';
			RegWrite_matz <= '0';
			MemWrite_matz <= '0';
			PCSrc_matz <= '1';
			ExtOp_matz <= '1';
			ALUctrl_matz <= "001";
	elsif (Opcode_in_matz = "100011") then --lw, i type
			RegDST_matz <= '0';
			ALUSrc_matz <= '1';
			MemtoReg_matz <= '1';
			RegWrite_matz <= '1';
			MemWrite_matz <= '0';
			PCSrc_matz <= '0';
			ExtOp_matz <= '1';
			ALUctrl_matz <= "000";
	elsif (Opcode_in_matz = "101011") then --sw, i type
			RegDST_matz <= '0';
			ALUSrc_matz <= '1';
			MemtoReg_matz <= '0';
			RegWrite_matz <= '0';
			MemWrite_matz <= '1';
			PCSrc_matz <= '0';
			ExtOp_matz <= '1';
			ALUctrl_matz <= "000";
	elsif (Opcode_in_matz = "001010") then --slti, i type
			RegDST_matz <= '0';
			ALUSrc_matz <= '1';
			MemtoReg_matz <= '0';
			RegWrite_matz <= '1';
			MemWrite_matz <= '0';
			PCSrc_matz <= '0';
			ExtOp_matz <= '1';
			ALUctrl_matz <= "011";
	end if;
end process;
end ConUnit;