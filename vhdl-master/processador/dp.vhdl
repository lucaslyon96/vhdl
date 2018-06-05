-- datapath for microprocessor
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

entity alu is
  port ( rst   : in STD_LOGIC;
         clk   : in STD_LOGIC;
         imm   : in std_logic_vector(3 downto 0); --IMMEDIATE (entrada 1) register
			in2	: in std_logic_vector(3 downto 0); --Entrada 2 accumulator
			OP		: in std_logic_vector(3 downto 0); --COMANDO DE SELECAO
         output: out STD_LOGIC_VECTOR (3 downto 0)
         -- insert ports as need be. OK
       );
end alu;

architecture bhv of alu is
	--signal t : std_LOGIC_VECTOR(3 downto 0) := "1000";
	--signal t1 : std_LOGIC_VECTOR(3 downto 0) := "0011";
begin

	process (rst, clk,OP)
	begin
	  -- take care of rst state
	  if (rst = '1') then
			output <= "0000";
	  elsif(clk'event and clk = '1') then
			--MOVA
			if(OP = "0000") then
				--ACCUMULATOR = IMMEDIATE (QUANDO CHAMAR A ALU LEMBRAR DE SUBSTITUIR IMM POR REGISTER[DD])
				output <= imm;
				--ACCUMULATOR EH A SAIDA (SO CAI SER TRANSFERIDO PARA O RESISTRADOR NO RTL2)
				
			--MOVR
			elsif(OP = "0001") then
				--SAIDA = ENTRADA2 (QUANDO CHAMAR A ALU LEMBRAR DE SUBSTITUIR IMM POR ACCUMULATOR E REGISTER[DD] RECEBER A SAIDA)
				output <= in2;
				
			--LOAD IMM
			elsif(OP = "0010") then
				--ACCUMULATOR = IMMEDIATE
				output <= imm;
				
			--ADD RD
			elsif(OP = "0011") then
				--ACCUMULATOR = ACCUMULATOR + IMMEDIATE (QUANDO CHAMAR A ALU LEMBRAR DE SUBSTITUIR IMM POR REGISTER[DD])
				output <= imm + in2;
				--output <= t + t1;
				
			--SUB RD
			elsif(OP = "0100") then
				--ACCUMULATOR = ACCUMULATOR - IMMEDIATE (QUANDO CHAMAR A ALU LEMBRAR DE SUBSTITUIR IMM POR REGISTER[DD])
				output <= in2 - imm;
				
			--ANDR RD
			elsif(OP = "0101")then
				--ACCUMULATOR = ACCUMULATOR AND IMMEDIATE (QUANDO CHAMAR A ALU LEMBRAR DE SUBSTITUIR IMM POR REGISTER[DD])
				output <= imm and in2;
				
			--ORR RD
			elsif(OP = "0110")then
				--ACCUMULATOR = ACCUMULATOR OR IMMEDIATE (QUANDO CHAMAR A ALU LEMBRAR DE SUBSTITUIR IMM POR REGISTER[DD])
				output <= imm or in2;
				
			--INV
			elsif(OP = "1000") then
				--ACCUMULATOR = ACCUMULATOR - IMMEDIATE (QUANDO CHAMAR A ALU LEMBRAR DE SUBSTITUIR IMM POR REGISTER[DD])
				output <= not in2; --not imm;
			-- HALT
			elsif(OP = "1001") then
				output <= "1111";
			end if;
	  end if;
	end process;

end bhv;

-- *************************************************************************
-- The following is code for an accumulator. you need to figure out
-- the interconnections to the datapath
-- *************************************************************************
library IEEE;
use IEEE.std_logic_1164.all;

entity acc is
  port ( rst   : in STD_LOGIC;
         clk   : in STD_LOGIC;
         input : in STD_LOGIC_VECTOR (3 downto 0);
         enb   : in STD_LOGIC;
         output: out STD_LOGIC_VECTOR (3 downto 0)
       );
end acc;

architecture bhv of acc is -- ACCUMULATOR SALVA A ENTRADA EM TEMP

signal temp : STD_LOGIC_VECTOR(3 downto 0);

begin
	process (rst, input, enb, clk)
	begin
		if (rst = '1') then
			output <= "0000";
			temp <= "0000";
		elsif (clk'event and clk = '1') then
				if (enb = '1') then 
					output <= input;
					temp <= input;
				else
					output <= temp;
				end if;
		end if;
	end process;
end bhv;

-- ***********************************************************************
-- the following is code for a register file. you may use your own design.
-- you also need to figure out how to connect this inyour datapath.

-- the way the rf works is: it 1st checks for the enable, then checks to
-- see which register is selected and outputs the input into the file. 
-- otherwise, the output will be whatever is stored in the selected register.
-- ***********************************************************************
library IEEE;
use IEEE.std_logic_1164.all;

entity rf is --RESISTER FILE
  port ( rst    : in STD_LOGIC;
         clk    : in STD_LOGIC;
         input  : in std_logic_vector(3 downto 0);
         sel    : in std_logic_vector(1 downto 0);
         enb    : in std_logic;
         output : out std_logic_vector(3 downto 0)
       );
		
end rf;

architecture bhv of rf is
signal out0, out1, out2, out3 : std_logic_vector(3 downto 0);
begin
	process (rst, clk)
	begin
	
	  -- take care of rst state. OK
	  if (rst = '1') then
			output <= "0000";
			
	  elsif(clk'event and clk = '1') then
		 if enb = '0' then
			case (sel) is
			  when "00" => 
				 out0 <= input;
			  when "01" => 
				 -- insert proper statement here. OK
				 out1 <= input;
				 
			  when "10" => 
				 -- insert proper statement here. OK
				 out2 <= input;
				 
			  when "11" =>
				 -- insert proper statement here. OK
				 out3 <= input;
				 
			  when others =>
			end case;
		 else -- enb = 1
			case (sel) is
			  when "00" =>
				 output <= out0;
			  when "01" =>
				 output <= out1;
			  when "10" =>
				 output <= out2;
			  when "11" =>
				 output <= out3;
			  when others =>
			end case;
		 end if;
	  end if;
	end process;	
end bhv;

library IEEE;
use IEEE.std_logic_1164.all;

entity dp is
  port ( rst     : in STD_LOGIC;
         clk     : in STD_LOGIC;
			imm     : in std_logic_vector(3 downto 0); --IMMEDIATE 
			OP		  : in std_logic_vector(3 downto 0); --COMANDO DE SELECAO
         output_4: out STD_LOGIC_VECTOR (3 downto 0);
			en_acc  : in std_logic;
			en_rf   : in std_logic;
			sel_mux : in std_logic;
			en_acc1 : out std_logic;
			en_rf1 : out std_LOGIC;
			sel_mux1 : out std_logic
         --add ports as required. OK
       );
end dp;

architecture rtl2 of dp is

component alu is
  port ( rst   : in STD_LOGIC;
         clk   : in STD_LOGIC;
         imm   : in std_logic_vector(3 downto 0); --Entrada 1
			in2	: in std_logic_vector(3 downto 0); --Entrada 2
			OP		: in std_logic_vector(3 downto 0); --COMANDO DE SELECAO
         output: out STD_LOGIC_VECTOR (3 downto 0)
         -- add ports as required. OK
    );
end component;

component rf is --RESISTER FILE
  port ( rst    : in STD_LOGIC;
         clk    : in STD_LOGIC;
         input  : in std_logic_vector(3 downto 0);
         sel    : in std_logic_vector(1 downto 0);
         enb    : in std_logic;
         output : out std_logic_vector(3 downto 0)
       );
		
end component; --Registrador para armazenar os resultados

component acc is --acumulador
  port ( rst   : in STD_LOGIC;
         clk   : in STD_LOGIC;
         input : in STD_LOGIC_VECTOR (3 downto 0);
         enb   : in STD_LOGIC;
         output: out STD_LOGIC_VECTOR (3 downto 0)
       );
end component;

component mux is
  port ( in1   : in std_logic_vector(3 downto 0); --IMMEDIATE (entrada 1)
			in2	: in std_logic_vector(3 downto 0); --Entrada 2
			sel	: in std_logic;						  --COMANDO DE SELECAO
         output: out STD_LOGIC_VECTOR (3 downto 0)
       );
end component;

signal alu_out: std_logic_vector(3 downto 0);
signal acc_out: std_logic_vector(3 downto 0);
signal mux_out: std_logic_vector(3 downto 0);
signal rf_out : std_logic_vector(3 downto 0); --REGISTRADORES

begin
	  
	output_4 <= alu_out;

	en_acc1 <= en_acc;
	en_rf1 <= en_rf;
	sel_mux1 <= sel_mux;
	
	ULA		 	 : alu port map (rst, clk, rf_out, acc_out, op, alu_out);
	mux2X1		 : mux port map (alu_out, imm, sel_mux, mux_out);
	-- A entrada do acc tem que vir de um mux que entra a saida da ula e o imm
	Acumulador	 : acc port map (rst, clk, mux_out,en_acc,acc_out);
	Registradores: rf port map (rst, clk, acc_out, imm(3 downto 2), en_rf, rf_out);
end rtl2;