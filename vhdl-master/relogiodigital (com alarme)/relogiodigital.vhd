library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity relogiodigital is
port (clk: in std_logic;
		mode: in std_logic;
		reset: in std_logic;
		str_sto: in std_logic;
		config: in std_logic;
		set: in std_logic;
		led_alarme_ativo: out std_logic := '0';
		led_aviso_alarme: out std_logic := '0';
		led_modo_conf: out std_logic;
		-- Saídas apenas para apagar casas inutilizadas
		s1: out std_logic_vector (6 downto 0);
		s2: out std_logic_vector (6 downto 0);
		--us_relogio_teste: out integer;
		-- U de unidade / D de dezena / S de segundo / M de minuto / H de hora
		-- Saídas do LCD para o relógio digital
		--um_relogio_teste: out integer;
		--dm_alarme_teste: out integer;
		--um_alarme_teste: out integer;
		us_relogio: out std_logic_vector (6 downto 0);
		ds_relogio: out std_logic_vector (6 downto 0);
		um_relogio: out std_logic_vector (6 downto 0);
		dm_relogio: out std_logic_vector (6 downto 0);
		uh_relogio: out std_logic_vector (6 downto 0);
		dh_relogio: out std_logic_vector (6 downto 0));
		
end relogiodigital;

architecture relogiodigital of relogiodigital is

component reg1 is
	port (str_sto: in std_logic;
	valoratual: in std_logic;
	inicia_pausa: out std_logic);
end component;
	
component digitalclock is
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
end component;

component cronometro is
	port (clk: in std_logic;
		us1: out integer;
		ds1: out integer;
		um1: out integer;
		dm1: out integer;
		uh1: out integer;
		dh1: out integer;
		inicia_pausa: in std_logic; --Botão de iniciar/pausar
		reset: in std_logic); -- Botão de reset
end component;

component alarme is
	port (config: in std_logic;
		str_sto: in std_logic;
		set: in std_logic;
		reset: in std_logic;
		alarme_ativado: out std_logic := '0';
		led_modo_conf: out std_logic;
		us_marcado: out integer;
		ds_marcado: out integer;
		um_marcado: out integer;
		dm_marcado: out integer;
		uh_marcado: out integer;
		dh_marcado: out integer);
end component;

component mux is
	port (clk: in std_logic;
			valor_atual_mux: out integer :=0;
			aux_mux: in integer :=0);
end component;

component codificador is
	port (entrada: in integer; -- inteiro 
			saida: out std_logic_vector (6 downto 0)); -- saida direta pro lcd
end component;

-- SINAIS
signal alarme_ativado: std_logic := '0'; -- LED que indica se há um alarme ativo
signal inicia_pausa: std_logic :='0'; -- Botão de iniciar e pausar (usado no component cronometro)
signal valoratual: std_logic; --Armazenar valor atual do inicia_pausa
signal entrada: integer; -- Valor do tempo para codificação
signal valor_atual_mux: integer :=0; -- Sinal auxiliar do botão mode
signal aux_mux: integer := 0; -- Sinal auxiliar do botão mode

--------------------------------- Saídas da codificação
-- Saidas do relógio
signal saidaus: std_logic_vector (6 downto 0);
signal saidads: std_logic_vector (6 downto 0);
signal saidaum: std_logic_vector (6 downto 0);
signal saidadm: std_logic_vector (6 downto 0);
signal saidauh: std_logic_vector (6 downto 0);
signal saidadh: std_logic_vector (6 downto 0);

-- Saídas do cronômetro
signal saidaus1: std_logic_vector (6 downto 0);
signal saidads1: std_logic_vector (6 downto 0);
signal saidaum1: std_logic_vector (6 downto 0);
signal saidadm1: std_logic_vector (6 downto 0);
signal saidauh1: std_logic_vector (6 downto 0);
signal saidadh1: std_logic_vector (6 downto 0);

-- Saídas do alarme
signal saidaus2: std_logic_vector (6 downto 0);
signal saidads2: std_logic_vector (6 downto 0);
signal saidaum2: std_logic_vector (6 downto 0);
signal saidadm2: std_logic_vector (6 downto 0);
signal saidauh2: std_logic_vector (6 downto 0);
signal saidadh2: std_logic_vector (6 downto 0);

-- SINAIS DE TESTE (PARA CADA PARTE DO DISPLAY)
signal us0: integer := 0;
signal ds0: integer := 0;
signal um0: integer := 0;
signal dm0: integer := 0;
signal uh0: integer := 0;
signal dh0: integer := 0;

signal us1: integer := 0;
signal ds1: integer := 0;
signal um1: integer := 0;
signal dm1: integer := 0;
signal uh1: integer := 0;
signal dh1: integer := 0;

signal us_marcado: integer := 0;
signal ds_marcado: integer := 0;
signal um_marcado: integer := 0;
signal dm_marcado: integer := 0;
signal uh_marcado: integer := 0;
signal dh_marcado: integer := 0;

begin
	-- Valor atual SEMPRE será igual ao que está armazenado em inicia_pausa
	valoratual <= inicia_pausa;
	aux_mux <= valor_atual_mux;
	
	reg_str_sto: reg1 port map(str_sto, valoratual,inicia_pausa); 
	relogio: digitalclock port map(clk, config, str_sto, set,us0, ds0, um0, dm0, uh0, dh0);
	cron: cronometro port map(clk, us1, ds1, um1, dm1, uh1, dh1, valoratual, reset);
	modo: mux port map(mode, valor_atual_mux, aux_mux); 
	modo_alarme: alarme port map(config, str_sto, set, reset, alarme_ativado, led_modo_conf, us_marcado, ds_marcado, um_marcado, dm_marcado,
	uh_marcado, dh_marcado);
	
	--um_relogio_teste <= um0;
	--um_alarme_teste <= um_marcado;
	--dm_alarme_teste <= dm_marcado;
	--us_relogio_teste <= us0;

	-- CODIFICAÇÃO PARA O LCD (relógio)
	cod: codificador port map(us0, saidaus);
	cod1: codificador port map(ds0, saidads);
	cod2: codificador port map(um0, saidaum);
	cod3: codificador port map(dm0, saidadm);
	cod4: codificador port map(uh0, saidauh);
	cod5: codificador port map(dh0, saidadh);
	
	-- CODIFICAÇÃO PARA O LCD (cronômetro)
	cod6: codificador port map(us1, saidaus1);
	cod7: codificador port map(ds1, saidads1);
	cod8: codificador port map(um1, saidaum1);
	cod9: codificador port map(dm1, saidadm1);
	cod10: codificador port map(uh1, saidauh1);
	cod11: codificador port map(dh1, saidadh1);
	
	-- CODIFICAÇÃO PARA O LCD (alarme)
	cod12: codificador port map(us_marcado, saidaus2);
	cod13: codificador port map(ds_marcado, saidads2);
	cod14: codificador port map(um_marcado, saidaum2);
	cod15: codificador port map(dm_marcado, saidadm2);
	cod16: codificador port map(uh_marcado, saidauh2);
	cod17: codificador port map(dh_marcado, saidadh2);
	
	process(valor_atual_mux)
	begin
		if(valor_atual_mux = 0) then
			us_relogio <= saidaus;
			ds_relogio <= saidads;
			um_relogio <= saidaum;
			dm_relogio <= saidadm;
			uh_relogio <= saidauh;
			dh_relogio <= saidadh;
			s1 <= "0001001";
			s2 <= "0010010";
		elsif(valor_atual_mux = 1) then
			us_relogio <= saidaus1;
			ds_relogio <= saidads1;
			um_relogio <= saidaum1;
			dm_relogio <= saidadm1;
			uh_relogio <= saidauh1;
			dh_relogio <= saidadh1;
			s1 <= "1000110";
			s2 <= "1000000";
		elsif(valor_atual_mux = 2) then
			us_relogio <= saidaus2;
			ds_relogio <= saidads2;
			um_relogio <= saidaum2;
			dm_relogio <= saidadm2;
			uh_relogio <= saidauh2;
			dh_relogio <= saidadh2;
			s1 <= "0001000";
			s2 <= "1000111";
		end if;
		
		if(alarme_ativado = '1') then
			--led_alarme_ativo <= '1';
			if(dh0 = dh_marcado and uh0 = uh_marcado and dm0 = dm_marcado and um0 = um_marcado) then
				led_aviso_alarme <= '1';
			else
				led_aviso_alarme <= '0';
			end if;
		end if;
		
		led_alarme_ativo <= alarme_ativado;
	end process;
end relogiodigital;