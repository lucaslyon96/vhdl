library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;

entity mux is
  port ( in1   : in std_logic_vector(3 downto 0); --IMMEDIATE (entrada 1)
			in2	: in std_logic_vector(3 downto 0); --Entrada 2
			sel	: in std_logic;						  --COMANDO DE SELECAO
         output: out STD_LOGIC_VECTOR (3 downto 0)
       );
end mux;

architecture mux of mux is
begin
	process (sel)
	begin
		if (sel = '0') then
			output <= in1;
		else 
			output <= in2;
		end if;
	end process;
end mux;