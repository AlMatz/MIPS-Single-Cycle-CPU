library ieee;
use ieee.std_logic_1164.all;

entity Program_Counter_Matzoros is
port(
	clck_matz : in std_logic;
   Address_in_Matz : in std_logic_vector(31 downto 0) := x"00000000";
   Address_out_Matz : out std_logic_vector(31 downto 0) := x"00000000"
 );
end Program_Counter_Matzoros;

architecture pcmatz of Program_Counter_Matzoros is
begin
process(clck_matz)
begin
if(rising_edge(clck_matz)) then
		Address_out_Matz <= Address_in_Matz;
end if;
end process;
end pcmatz;