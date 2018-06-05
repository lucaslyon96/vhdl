library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity digitalclock is
port (clk: in std_logic;
		config: in std_logic;
		str_sto: in std_logic;
		set: in std_logic;
		us0: out integer;
		ds0: out integer;
		um0: out integer;
		dm0: out integer;
		uh0: out integer;
		dh0: out integer);
end digitalclock;

architecture digitalclock of digitalclock is
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
	
	component regset is
	port (set: in std_logic;
			valoratual_set: in integer;
			valor_set: out integer);
	end component;
	
	component reg1 is
		port (config: in std_logic;
		valoratual_conf: in std_logic;
		config_registrado: out std_logic);
	end component;
	
	component regstrsto is
		port (str_sto: in std_logic;
		valoratual_strsto: in integer;
		valor_set: in integer;
		valor_strsto: out integer);
	end component;
	
	signal cont: integer :=1; -- contador para divisor de clock
	signal estado: std_logic :='0'; -- clock de 1s
	
	--signal valor_set: integer :=0;
	--signal valor_strsto: integer :=0;
	--signal valoratual_conf: std_logic :='0';
	--ignal valoratual_strsto: integer :=0;
	--signal valoratual_set: integer :=0;
	--signal config_registrado: std_logic := '0';
	
	signal us: integer := 0;
	signal ds: integer := 0;
	signal um: integer := 0;
	signal dm: integer := 0;
	signal uh: integer := 0;
	signal dh: integer := 0;

	begin
		--valoratual_conf <= config;	
		--valoratual_set <= valor_set;
		--valoratual_strsto <= valor_strsto;		
		
		--reg_conf: reg1 port map(config, valoratual_conf, config_registrado);
		--reg_str_sto: regstrsto port map(str_tro, valoratual_strsto, valor_set, valor_strsto); 
		--reg_set: regset port map(set, valor_set); 
		-- transformando numeros inteiros (0 a 60) para binario
		--sec <= conv_std_logic_vector(segundos,6);
		--min <= conv_std_logic_vector(minutos,6);
		--hours <= conv_std_logic_vector(horas,5);

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
	
		contador_tempo: contador port map(estado,'1','0',us,ds,um,dm,uh,dh);
		
		us0 <= us;
		ds0 <= ds;
		um0 <= um;
		dm0 <= dm;
		uh0 <= uh;
		dh0 <= dh;
		
end digitalclock;