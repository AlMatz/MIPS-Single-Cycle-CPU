library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity test_bench_matz_SCPU is
end test_bench_matz_SCPU;

architecture arch of test_bench_matz_SCPU is
component SingleCycleCPU_Matzoros IS 
	PORT
	(
		clck_matz :  IN  STD_LOGIC;
		binary_input_mat_second :  OUT  STD_LOGIC_VECTOR(31 DOWNTO 0);
		display_on_seg_mat :  OUT  STD_LOGIC_VECTOR(76 DOWNTO 0);
		display_sign_seg :  OUT  STD_LOGIC_VECTOR(6 DOWNTO 0);
		out_matz :  OUT  STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END component;
 signal clock : std_logic := '0';
 signal output : std_LOGIC_VECTOR(31 downto 0);
 signal display: std_LOGIC_VECTOR(76 downto 0);
 signal sign_display :  STD_LOGIC_VECTOR(6 DOWNTO 0);
 signal led_output :  STD_LOGIC_VECTOR(31 DOWNTO 0);
 signal error  : std_logic := '0';

begin
 uut : SingleCycleCPU_Matzoros port map ( clck_matz=> clock, binary_input_mat_second => led_output,
 display_on_seg_mat => display, display_sign_seg => sign_display, out_matz => output);
 process is
 begin
 clock <= '0';
 wait for 50 ns;
 clock <= '1';
 wait for 50 ns;
  clock <= '0';
 wait for 50 ns;
 clock <= '1';
 wait for 50 ns;
  clock <= '0';
 wait for 50 ns;
 clock <= '1';
 wait for 50 ns;
  clock <= '0';
 wait for 50 ns;
 clock <= '1';
 wait for 50 ns;
  clock <= '0';
 wait for 50 ns;
 clock <= '1';
 wait for 50 ns;
  clock <= '0';
 wait for 50 ns;
 clock <= '1';
 wait for 50 ns;
  clock <= '0';
 wait for 50 ns;
 clock <= '1';
 wait for 50 ns;
  clock <= '0';
 wait for 50 ns;
 clock <= '1';
 wait for 50 ns;
  clock <= '0';
 wait for 50 ns;
 clock <= '1';
 wait for 50 ns;
  clock <= '0';
 wait for 50 ns;
 clock <= '1';
 wait for 50 ns;
  clock <= '0';
 wait for 50 ns;
 clock <= '1';
 wait for 50 ns;
  clock <= '0';
 wait for 50 ns;
 clock <= '1';
 wait for 50 ns;
  clock <= '0';
 wait for 50 ns;
 clock <= '1';
 wait for 50 ns;
  clock <= '0';
 wait for 50 ns;
 clock <= '1';
 wait for 50 ns;
   clock <= '0';
 wait for 50 ns;
 clock <= '1';
 wait for 50 ns;
   clock <= '0';
 wait for 50 ns;
 clock <= '1';
 wait for 50 ns;
   clock <= '0';
 wait for 50 ns;
 clock <= '1';
 wait for 50 ns;
 clock <= '0';
  wait for 50 ns;
 clock <= '1';
 wait for 50 ns;
 clock <= '0';
if(error = '0') then
 report "No errors detected. Simulation successful" severity failure;
else
 report "Error detected" severity failure;
end if;
end process;
end arch;