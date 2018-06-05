library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity regconf is
port (config: in std_logic;
		valoratual_conf: in std_logic;
		valor_conf: out std_logic);
end regconf;

architecture regconf of regconf is
begin
	process(config)
	begin
		-- Só irá armazenar se o usuário apertar o botão "str_sto"
		if(config'event and config='1') then
			-- Se apertar, a saída será igual ao o que ele tinha antes barrado
			valor_conf <= not valoratual_conf;
		end if;
	end process;
end regconf;