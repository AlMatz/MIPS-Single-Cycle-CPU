library ieee;
use ieee.std_logic_1164.all;

entity display_it_mat is
	generic (Nbits: integer := 32);
	port (
		sign_input_mat : in std_logic;
		binary_input_mat : in std_logic_vector (31 downto 0);
		display_on_seg_mat : out std_logic_vector(7*((31)/3+1)-1 downto 0);
		display_sign_seg : out std_logic_vector(6 downto 0);
		binary_input_mat_second : out std_logic_vector(31 downto 0) --for leds
	);
end display_it_mat;

architecture structural of display_it_mat is
	signal val_of_bcd_mat : std_logic_vector(4*((Nbits-1)/3+1)-1 downto 0);
	signal display_seg_int_mat : std_logic_vector(7*((Nbits-1)/3+1)-1 downto 0);
	signal sign_val_mat : std_logic;
	signal is_it_zero_mat : std_logic;
	signal signed_unsigned_mat : std_logic;
	
	component BinaryToBCD_mat_s2020
		generic (Nbits: integer := 32);
	port (
			binary_in_mat : in std_logic_vector(Nbits-1 downto 0);
			sign_flag_mat : in std_logic;
			decimal_mat : out std_logic_vector(4*((Nbits-1)/3+1)-1 downto 0);
			sign_neg_or_post_val_mat : out std_logic; --signVal
			unsigned_or_sign_mat : out std_logic --SignUnsign
	);
	end component;
	
	component conv_sign_bcd_to_7seg_mat
		port ( 			
			 sign_neg_or_post_val_mat : in std_logic; --signVal
			 unsigned_or_sign_mat : in std_logic; --SignUnsign
			 output_display_mat : out std_logic_vector(6 downto 0)
			);
	end component;
	
	component conv_bcd_to_7seg_mat
		port ( input_mat : in std_logic_vector(3 downto 0);
			 output_display_mat : out std_logic_vector(6 downto 0)
			);
	end component;
	
begin
test : BinaryToBCD_mat_s2020 port map( binary_in_mat => binary_input_mat,
			sign_flag_mat => sign_input_mat,
			decimal_mat => val_of_bcd_mat,
			sign_neg_or_post_val_mat => sign_val_mat,
			unsigned_or_sign_mat => signed_unsigned_mat
			);
		
test2 : conv_sign_bcd_to_7seg_mat port map( sign_neg_or_post_val_mat => sign_val_mat,
			 unsigned_or_sign_mat => signed_unsigned_mat,
			 output_display_mat => display_sign_seg
			);
		ssd : for I in 0 to (Nbits-1)/3 generate
	test3: conv_bcd_to_7seg_mat port map( input_mat => val_of_bcd_mat(3+4*I downto 4*I),
			 output_display_mat => display_seg_int_mat(6+7*I downto 7*I)
			 );
		end generate ssd;
		
		for_lead_zero: process(val_of_bcd_mat)
			variable is_it_zero: boolean;
			begin
				binary_input_mat_second <= binary_input_mat;
				is_it_zero := false;
				for I in (Nbits-1)/3 downto 0 loop
					if I > 0 and not is_it_zero and val_of_bcd_mat(3+4*I downto 4*I) = "0000" then
						display_on_seg_mat(6+7*I downto 7*i) <= "1111111";
					else
						is_it_zero := true;
						display_on_seg_mat(6+7*I downto 7*I) <= display_seg_int_mat(6+7*I downto 7*I);
					end if;
				end loop;
			end process for_lead_zero;
end structural;
	