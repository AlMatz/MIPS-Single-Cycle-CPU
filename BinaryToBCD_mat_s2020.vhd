library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity BinaryToBCD_mat_s2020 is
	generic (Nbits: integer := 32);
	port (
			binary_in_mat : in std_logic_vector(Nbits-1 downto 0);
			sign_flag_mat : in std_logic;
			decimal_mat : out std_logic_vector(4*((Nbits-1)/3+1)-1 downto 0);
			sign_neg_or_post_val_mat : out std_logic; --signVal
			unsigned_or_sign_mat : out std_logic --SignUnsign
	);
end BinaryToBCD_mat_s2020;

architecture behavioural of BinaryToBCD_mat_s2020 is

begin
	myProcess: process(binary_in_mat)
	variable conv_var_mat : std_logic_vector(Nbits - 1 downto 0); --twos comp
	variable temp_var_mat : std_logic_vector(Nbits - 1 downto 0);
	variable bcd_val_mat : UNSIGNED(4*((Nbits-1)/3+1)-1 downto 0) := (others => '0');
	
	begin
		if sign_flag_mat = '1' and binary_in_mat(Nbits-1) = '1' then --this means we have the sign switch on and its a negative number
			
			conv_var_mat := not binary_in_mat;
			conv_var_mat := std_logic_vector(unsigned(conv_var_mat)+1);
			sign_neg_or_post_val_mat <= '1';
			unsigned_or_sign_mat <= '1';
			
		elsif sign_flag_mat = '1' and binary_in_mat(Nbits-1) = '0' then -- sign switch and a positive number
			
			conv_var_mat := binary_in_mat;
			sign_neg_or_post_val_mat <= '0';
			unsigned_or_sign_mat <= '1';
			
		else
			conv_var_mat := binary_in_mat;
			sign_neg_or_post_val_mat <= '-';
			unsigned_or_sign_mat <= '0';
		end if;
		
		bcd_val_mat := (others => '0');
		temp_var_mat(Nbits-1 downto 0) := conv_var_mat;
		
		for T in 0 to Nbits-1 loop
			for L in 0 to (Nbits-1)/3 loop
				if (bcd_val_mat((L+1)*4-1 downto L*4) > 4) then
					bcd_val_mat((L+1)*4-1 downto L*4) :=  bcd_val_mat((L+1)*4-1 downto L*4)+3;
				end if;
		end loop;
		
			bcd_val_mat:= bcd_val_mat(4*((Nbits-1)/3+1) -2 downto 0) & temp_var_mat(Nbits-1);
			temp_var_mat:= temp_var_mat((Nbits)-2 downto 0) & '0';
		end loop;
		
		decimal_mat <= std_logic_vector(bcd_val_mat(4*((Nbits-1)/3+1)-1 downto 0));
		end process myProcess;
end behavioural;

	
	