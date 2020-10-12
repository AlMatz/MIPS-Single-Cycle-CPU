library ieee;
use ieee.std_logic_1164.all;

entity conv_sign_bcd_to_7seg_mat is
	port ( 			
			 sign_neg_or_post_val_mat : in std_logic; --signVal
			 unsigned_or_sign_mat : in std_logic; --SignUnsign
			 output_display_mat : out std_logic_vector(6 downto 0)
			);
end conv_sign_bcd_to_7seg_mat;

architecture behavioural of conv_sign_bcd_to_7seg_mat is

begin
	process(sign_neg_or_post_val_mat, unsigned_or_sign_mat)
	begin
		if unsigned_or_sign_mat = '0' then
			output_display_mat <= "1111111";
		elsif sign_neg_or_post_val_mat = '0' then
			output_display_mat <= "1001110";
		else
			output_display_mat <= "1111110";
		end if;
	end process;
end behavioural;