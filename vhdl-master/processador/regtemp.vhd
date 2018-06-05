-- controller
library IEEE;
library numeric_std;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use numeric_std.all;


entity regtemp is
  port ( rst   : in STD_LOGIC;
         clk   : in STD_LOGIC;       
         valor_antigo   : in std_logic_vector(3 downto 0);
			valor_atual  : out std_logic_vector(3 downto 0)
       );
end regtemp;

architecture regtemp of regtemp is
 begin
		process(clk)
		begin
		if(rst = '1') then
			valor_atual <= "0000";
		elsif(clk'event and clk='1') then
			valor_atual <= valor_antigo;
		end if;
	end process;
end regtemp;