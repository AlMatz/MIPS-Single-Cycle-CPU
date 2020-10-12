library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;

entity Adder_32_Matzoros is
port (
		in_a_matz : in std_logic_vector(31 downto 0) := x"00000004";
		in_b_matz : in std_logic_vector(31 downto 0) := x"00000000";
		out_matz : out std_logic_vector(31 downto 0) := x"00000000"
);
end Adder_32_Matzoros;

architecture adder of Adder_32_Matzoros is
begin
	out_matz <= in_a_matz + in_b_matz;
end adder;
