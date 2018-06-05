library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity regalarme is
port (valor_set: in integer;
		alarme_ativo: out std_logic);
end regalarme;

architecture regalarme of regalarme is
begin
	process(valor_set)
	begin
		if(valor_set = 4) then
			alarme_ativo <= '1';
		else 
			alarme_ativo <= '0';
		end if;
	end process;
end regalarme;