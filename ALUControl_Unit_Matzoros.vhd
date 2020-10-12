library ieee;
use ieee.std_logic_1164.all;

entity ALUControl_Unit_Matzoros is
port (
			Function_in_matz : in std_logic_vector(5 downto 0);
			ALUctrl_in_matz : in std_logic_vector(2 downto 0);
			ALUctrl_out_matz : out std_logic_vector(2 downto 0)
		);
end ALUControl_Unit_Matzoros;

architecture aluctrl of ALUControl_Unit_Matzoros is
signal answer: std_logic_vector(2 downto 0);
begin
process(Function_in_matz, ALUctrl_in_matz)
begin
case ALUctrl_in_matz is
when "100" =>
case Function_in_matz is
when "100000" => answer <= "000"; --add
when "100010" => answer <= "001"; --sub
when "100101" => answer <= "010"; --or
when "100011" => answer <= "101"; --xor
when "100100" => answer <= "111"; --and
when "011000" => answer <= "110"; --mult
when "011010" => answer <= "100"; --div
when "101010" => answer <= "011"; --slt
when others => answer <= "000";
end case;
when others => answer <= ALUctrl_in_matz;
end case;
end process;
ALUctrl_out_matz <= answer;
end architecture;

--begin
--	if (ALUctrl_in_matz = "100") then
--		if (Function_in_matz = "100000") then -- add
--			ALUctrl_out_matz <= "000";
--		elsif (Function_in_matz = "100010") then --sub
--			ALUctrl_out_matz <= "001";
--		elsif (Function_in_matz = "100101") then --or
--			ALUctrl_out_matz <= "010";
--		end if;

--	else 
--		ALUctrl_out_matz <= ALUctrl_in_matz;
--	end if;
--end process;
--end architecture;