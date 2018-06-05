library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity codificador is
port (entrada: in integer;
		saida: out std_logic_vector (6 downto 0));
		
end codificador;

architecture codificador of codificador is
	
	signal lcd : std_logic_vector (6 downto 0);
	
	begin	
		process(entrada)
		begin
		
			case(entrada) is
				when 0 => lcd <="1000000";  -- '0'
            when 1 => lcd <="1111001";  -- '1'
            when 2 => lcd <="0100100";  -- '2'
            when 3 => lcd <="0110000";  -- '3'
            when 4 => lcd <="0011001";  -- '4' 
            when 5 => lcd <="0010010";  -- '5'
            when 6 => lcd <="0000010";  -- '6'
            when 7 => lcd <="1111000";  -- '7'
            when 8 => lcd <="0000000";  -- '8'
            when 9 => lcd <="0010000";  -- '9'
            when others=> lcd <="1000000";
         end case;

		end process;
	
	saida <= lcd;
		
end codificador;