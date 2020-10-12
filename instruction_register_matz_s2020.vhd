library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity instruction_register_matz_s2020 is
	port ( 
--		clock_matz : in std_logic;
		input_instruction_matz : in std_logic_vector(31 downto 0);
		opcode_matz : out std_logic_vector(5 downto 0);
		rs_address_out_matz : out std_logic_vector(4 downto 0);
		rt_address_out_matz : out std_logic_vector(4 downto 0);
		rd_address_out_matz : out std_logic_vector(4 downto 0);
		shift_value_matz : out std_logic_vector(4 downto 0);
		function_matz : out std_logic_vector(5 downto 0)
	);
end instruction_register_matz_s2020;

--architecture regiarc of instruction_register_matz_s2020 is
--begin
--process(clock_matz)
--	variable hold_instruction : std_logic_vector(31 downto 0);
--begin
--	if rising_edge(clock_matz) then
--	hold_instruction := input_instruction_matz;
--	opcode_matz <= hold_instruction(31 downto 26);
--	rs_address_out_matz <= hold_instruction(25 downto 21);
--	rt_address_out_matz <= hold_instruction(20 downto 16);
--	rd_address_out_matz <= hold_instruction(15 downto 11);
--	shift_value_matz <= hold_instruction(10 downto 6);
--	function_matz <= hold_instruction(5 downto 0);
--	end if;
--end process;
--end regiarc;

architecture regiarc of instruction_register_matz_s2020 is
begin


	opcode_matz <= input_instruction_matz(31 downto 26);
	rs_address_out_matz <= input_instruction_matz(25 downto 21);
	rt_address_out_matz <= input_instruction_matz(20 downto 16);
	rd_address_out_matz <= input_instruction_matz(15 downto 11);
	shift_value_matz <= input_instruction_matz(10 downto 6);
	function_matz <= input_instruction_matz(5 downto 0);

end regiarc;