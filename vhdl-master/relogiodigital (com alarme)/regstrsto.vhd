library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity regstrsto is
port (str_sto: in std_logic;
		valoratual_strsto: in integer;
		valor_set: in integer;
		valor_strsto: out integer);
end regstrsto;

architecture regstrsto of regstrsto is
signal aux: integer := valoratual_strsto;
begin
	--aux <= valoratual_strsto;
	process(str_sto)
	begin
		if(str_sto'event and str_sto='1') then
			if(valor_set = 0) then
				if(valoratual_strsto = 2) then
					aux <= 0;
				else
					aux <= aux + 1;
				end if;
			elsif(valor_set = 1) then
				if(valoratual_strsto = 3) then
					aux <= 0;
				else
					aux <= aux + 1;
				end if;
			elsif(valor_set = 2) then
				if(valoratual_strsto = 5) then
					aux <= 0;
				else
					aux <= aux + 1;
				end if;
			elsif(valor_set = 3) then
				if(valoratual_strsto = 9) then
					aux <= 0;
				else
					aux <= aux + 1;
				end if;
			end if;
		end if;
		valor_strsto <= aux;
	end process;
end regstrsto;