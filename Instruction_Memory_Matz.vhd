library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Instruction_Memory_Matz is
	port(
		pc_in_matz : in std_logic_vector(31 downto 0) := x"00000000";
		instruction_out_matz : out std_logic_vector(31 downto 0) := x"00000000"		
	);
end Instruction_Memory_Matz;

architecture Instmem of Instruction_Memory_Matz is
	type inst_array_matz is array (0 to 127) of std_logic_vector(7 downto 0);
	signal inst_matz : inst_array_matz := (
 x"00",
 x"00",
 x"00",
 x"00",
 x"00",
 x"00",
 x"00",
 x"00",
 x"8c", --first instruction
 x"04",
 x"00",
 x"00", --lw $4, 0
 x"8c",
 x"05",
 x"00",
 x"01", --lw $5, 1
 x"00",
 x"85",
 x"30",
 x"20", --add $6, $4, $5
 x"ac",
 x"06",
 x"00",
 x"05", --sw $6, 5
 x"8c",
 x"04",
 x"00",
 x"02", --lw $4, 2
 x"8c",
 x"05",
 x"00",
 x"05", --lw $5, 5
 x"00",
 x"85",
 x"30",
 x"20", --add $6, $4, $5
 x"ac",
 x"06",
 x"00",
 x"05", --sw $6, 5
 x"8c",
 x"04",
 x"00",
 x"03", --lw $4, 3
 x"8c",
 x"05",
 x"00",
 x"05", --lw $5, 5
 x"00",
 x"85",
 x"30",
 x"20", --add $6, $4, $5
 x"ac",
 x"06",
 x"00",
 x"05", --sw $6, 5
 x"8c",
 x"04",
 x"00",
 x"04", --lw $4, 4
 x"8c",
 x"05",
 x"00",
 x"05", --lw $5, 5
 x"00",
 x"85",
 x"30",
 x"20", --add $6, $4, $5
 x"ac",
 x"06",
 x"00",
 x"05", --sw $6, 5
 x"8c",
 x"05",
 x"00",
 x"05", --lw $5, 5
 others => x"00");

begin
		instruction_out_matz <= inst_matz(to_integer(unsigned(pc_in_matz))) & inst_matz(to_integer(unsigned(pc_in_matz))+1) &
										inst_matz(to_integer(unsigned(pc_in_matz))+2) & inst_matz(to_integer(unsigned(pc_in_matz))+3);

end architecture;