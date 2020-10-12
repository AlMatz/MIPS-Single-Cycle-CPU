library ieee;
use ieee.std_logic_1164.all;

entity conv_bcd_to_7seg_mat is
	port ( input_mat : in std_logic_vector(3 downto 0);
			 output_display_mat : out std_logic_vector(6 downto 0)
			);
end conv_bcd_to_7seg_mat;

architecture behavioural of conv_bcd_to_7seg_mat is

begin
	process(input_mat)
		begin
			case input_mat is
			when "0000" => output_display_mat <= "0000001";
			when "0001" => output_display_mat <= "1001111";
			when "0010" => output_display_mat <= "0010010";
			when "0011" => output_display_mat <= "0000110";
			when "0100" => output_display_mat <= "1001100";
			when "0101" => output_display_mat <= "0100100";
			when "0110" => output_display_mat <= "1100000";
			when "0111" => output_display_mat <= "0001111";
			when "1000" => output_display_mat <= "0000000";
			when "1001" => output_display_mat <= "0001100";
			when others => output_display_mat <= "1111111";
		end case;
	end process;
end behavioural;