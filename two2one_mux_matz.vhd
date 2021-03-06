library ieee;
use ieee.std_logic_1164.all;

entity two2one_mux_matz is
port (
			ina_matz : in std_logic_vector(31 downto 0) := x"00000000";
			inb_matz : in std_logic_vector(31 downto 0):= x"00000000";
			selc_matz : in std_logic := '0';
			out_matz : out std_logic_vector(31 downto 0) := x"00000000"
);
end two2one_mux_matz;


architecture mux21 of two2one_mux_matz is
begin
out_matz <= ina_matz when (selc_matz = '0') else
				inb_matz;

end mux21;