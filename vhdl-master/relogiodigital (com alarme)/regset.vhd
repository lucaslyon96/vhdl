library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity regset is
port (set: in std_logic;
		valoratual_set: in integer;
		valor_set: out integer);
end regset;

architecture regset of regset is
signal aux: integer := valoratual_set;
begin
	--aux <= valor_atual;
	process(set)
	begin
		-- Só irá armazenar se o usuário apertar o botão "str_sto"
		if(set'event and set='1') then
			-- Se apertar, a saída será igual ao o que ele tinha antes barrado
			if(valoratual_set = 4) then
				aux <= 0;
			else
				aux <= aux + 1;
			end if;
		end if;
		valor_set <= aux;
	end process;
end regset;