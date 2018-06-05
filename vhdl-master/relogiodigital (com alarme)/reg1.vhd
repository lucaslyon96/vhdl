library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity reg1 is
port (str_sto: in std_logic;
		valoratual: in std_logic;
		inicia_pausa: out std_logic);
end reg1;

architecture reg1 of reg1 is
begin
	process(str_sto)
	begin
		-- Só irá armazenar se o usuário apertar o botão "str_sto"
		if(str_sto'event and str_sto='1') then
			-- Se apertar, a saída será igual ao o que ele tinha antes barrado
			inicia_pausa <= not valoratual;
		end if;
	end process;
end reg1;