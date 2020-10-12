library ieee;
use ieee.std_logic_1164.all;

entity immediate_PC_extender_matz is
port (
			immediate_in_matz : in std_logic_vector(15 downto 0) := x"0000";
			extended_immediate_out_matz : out std_logic_vector(31 downto 0) := x"00000000"
);
end immediate_PC_extender_matz;


architecture immex2 of immediate_PC_extender_matz is
begin
extended_immediate_out_matz <= (x"000" & "00" & immediate_in_matz & "00") when immediate_in_matz(15) = '0' else
										 (x"FFF" & "11" & immediate_in_matz & "00");
end immex2;