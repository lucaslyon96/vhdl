library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity mux is
port (clk: in std_logic; -- o clock será o próprio botão mode
		valor_atual_mux: out integer := 0; -- Retornará a saida do mux
		aux_mux: in integer := 0);
end mux;

architecture mux of mux is
begin
	process(clk)
	begin
		if(clk'event and clk='1') then
			if(aux_mux = 2) then
				valor_atual_mux <= 0;
			else
				valor_atual_mux <= aux_mux + 1;
				end if;
			end if;
		end process;
	--valor_atual_mux <= aux;
end mux;