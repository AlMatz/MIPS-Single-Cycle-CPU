library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;
use ieee.numeric_std.all;

entity ALU_matz is
	port ( 
		ALUctrl_in_matz : in std_logic_vector(2 downto 0);
		input_operand_a_matz : in std_logic_vector(31 downto 0);
		input_operand_b_matz : in std_logic_vector(31 downto 0);
		zero_output_matz : out std_logic;
		output_matz : out std_logic_vector(31 downto 0)
	);
end ALU_matz;

architecture alumat of ALU_matz is
signal result : std_logic_vector(31 downto 0);
begin
process(ALUctrl_in_matz, input_operand_a_matz, input_operand_b_matz)
begin
case aluctrl_in_matz is
	when "000" => result <= input_operand_a_matz + input_operand_b_matz;
	when "001" => result <= input_operand_a_matz - input_operand_b_matz;
	when "010" => result <= input_operand_a_matz or input_operand_b_matz;
	when "111" => result <= input_operand_a_matz and input_operand_b_matz;
	when "101" => result <= input_operand_a_matz xor input_operand_b_matz;
	when "110" => result <= std_logic_vector(to_signed(to_integer(signed(input_operand_a_matz)) * to_integer(signed(input_operand_b_matz)),32));
	when "100" => result <= std_logic_vector(to_signed(to_integer(signed(input_operand_a_matz)) / to_integer(signed(input_operand_b_matz)),32));
	when "011" => 
		if(input_operand_a_matz<input_operand_b_matz) then result <= x"00000001";
		else result <= x"00000000";
		end if;
	when others => result <= input_operand_a_matz + input_operand_b_matz;
end case;
end process;
	zero_output_matz <= '1' when result=x"0000" else '0';
	output_matz <= result;
end alumat;

--output_matz <= (input_operand_a_matz + input_operand_b_matz) when (ALUctrl_in_matz = "000") else
--				 (input_operand_a_matz - input_operand_b_matz) when (ALUctrl_in_matz = "001") else
--				 (input_operand_a_matz or input_operand_b_matz) when (ALUctrl_in_matz = "010");
				
--zero_output_matz <= '1' when (ALUctrl_in_matz = "000" and input_operand_a_matz + input_operand_b_matz = "0") else
--					  '1' when (ALUctrl_in_matz = "000" and input_operand_a_matz - input_operand_b_matz = "0") else
--					  '0';