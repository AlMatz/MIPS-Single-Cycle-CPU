library ieee;
use ieee.std_logic_1164.all;

entity immediate_extender_matz is
port (
			immediate_in_matz : in std_logic_vector(15 downto 0);
			extend_type : in std_logic;
			extended_immediate_out_matz : out std_logic_vector(31 downto 0)
);
end immediate_extender_matz;


architecture immex of immediate_extender_matz is
begin
extended_immediate_out_matz <= (x"0000" & immediate_in_matz) when extend_type = '0' or immediate_in_matz(15) = '0' else
										 (x"FFFF" & immediate_in_matz);
end immex;