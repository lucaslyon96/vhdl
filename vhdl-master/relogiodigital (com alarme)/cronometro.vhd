library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity cronometro is
port (clk: in std_logic;
		us1: out integer;
		ds1: out integer;
		um1: out integer;
		dm1: out integer;
		uh1: out integer;
		dh1: out integer;
		inicia_pausa: in std_logic; --Botão de iniciar/pausar
		reset: in std_logic); -- Botão de reset
end cronometro;

architecture cron of cronometro is
	component contador is
		port(clk: in std_logic;
		enable_cron: in std_logic;
		reset: in std_logic;
		us: out integer;
		ds: out integer;
		um: out integer;
		dm: out integer;
		uh: out integer;
		dh: out integer);
	end component;
	
	signal cont: integer :=1; -- contador para divisor de clock
	signal estado: std_logic :='0'; -- clock de 1s
	signal us: integer := 0;
	signal ds: integer := 0;
	signal um: integer := 0;
	signal dm: integer := 0;
	signal uh: integer := 0;
	signal dh: integer := 0;
	signal enable_cron: std_logic := '0';
	
	begin
		--transformando numeros inteiros (0 a 60) para binario
		--sec1 <= conv_std_logic_vector(segundos,6);
		--min1 <= conv_std_logic_vector(minutos,6);
		--hours1 <= conv_std_logic_vector(horas,5);
		
		process(clk) -- processo para um clock de 50 MHz para 1 Hz
		begin
			if(clk'EVENT and clk='1') then
				cont <= cont + 1;
				-- contador = 2 apenas para teste, o certo é 25000000
				if(cont = 25000000) then --25000000
					estado <= not estado;
					cont <= 1;
				end if;
			end if;
		end process;
		
		enable_cron <= inicia_pausa;
		contador_relogio: contador port map(estado,enable_cron,reset,us,ds,um,dm,uh,dh);
		
		us1 <= us;
		ds1 <= ds;
		um1 <= um;
		dm1 <= dm;
		uh1 <= uh;
		dh1 <= dh;
end cron;