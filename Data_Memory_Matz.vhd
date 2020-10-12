library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Data_Memory_Matz is
	port(
		wenable_matz : in std_logic;
		write_value_in_matz : in std_logic_vector(31 downto 0);
		address_in_matz : in std_logic_vector(31 downto 0);
		clock_matz : in std_logic;
		read_value_out_matz : out std_logic_vector(31 downto 0)		
	);
end Data_Memory_Matz;

architecture datamem of Data_Memory_Matz is
	signal holder_address : std_logic_vector(5 downto 0);
	type data_array_matz is array (0 to 63) of std_logic_vector(31 downto 0);
	signal data_matz : data_array_matz := (x"00000001",x"00000002", x"00000003", x"00000004", x"00000005", others => x"00000000");
begin
	holder_address <= address_in_matz(5 downto 0);
process(clock_matz)
begin
		if rising_edge(clock_matz) then
			if wenable_matz = '1' then
					data_matz(to_integer(unsigned(holder_address))) <= write_value_in_matz;
			end if;
		end if;
end process;

		read_value_out_matz <= data_matz(to_integer(unsigned(holder_address)));

end architecture;