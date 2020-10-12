library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity immediate_holder_matz is
	port ( 
		immediate_out_matz : out std_logic_vector(15 downto 0);
		rd_address_out_matz : in std_logic_vector(4 downto 0);
		shift_value_matz : in std_logic_vector(4 downto 0);
		function_matz : in std_logic_vector(5 downto 0)
	);
end immediate_holder_matz;

architecture immhold of immediate_holder_matz is
begin
	immediate_out_matz <= rd_address_out_matz & shift_value_matz & function_matz;
end immhold;