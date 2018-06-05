-- cpu (top level entity)
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;

-- these should probably stay the same
entity cpu is
   port ( rst           : in STD_LOGIC;
			 start     : in STD_LOGIC;
          clk           : in STD_LOGIC;
			 output      : out STD_LOGIC_VECTOR (3 downto 0);
       	  a0,b0,c0,d0,e0,f0,g0 : out std_logic;
			  a,b,c,d,e,f,g : out std_logic;
			  a1,b1,c1,d1,e1,f1,g1 : out std_logic;
			  a2,b2,c2,d2,e2,f2,g2 : out std_logic;
			  a3,b3,c3,d3,e3,f3,g3 : out std_logic;
			  a4,b4,c4,d4,e4,f4,g4 : out std_logic;
			  opcode_teste: out std_LOGIC_VECTOR(3 downto 0)
			 -- teste_en_acc : out std_logic;
			  --teste_en_rf : out std_logic;
			 -- teste_sel_mux : out std_logic
        );
end cpu;

architecture struc of cpu is
component ctrl 
   port ( rst   : in STD_LOGIC;
    	  start : in STD_LOGIC;
          clk   : in STD_LOGIC;
          imm   : out std_logic_vector(3 downto 0);
			 OP	 : out std_logic_vector(3 downto 0);
          en_acc : out std_LOGIC;
			 en_rf : out std_logic;
			 sel_mux : out std_logic
        );
end component;

component dp
   port ( rst     : in STD_LOGIC;
          clk     : in STD_LOGIC;
			 imm     : in std_logic_vector(3 downto 0);
			 OP		: in std_logic_vector(3 downto 0);
          output_4: out STD_LOGIC_VECTOR (3 downto 0);
			 en_acc  : in std_logic;
			 en_rf   : in std_logic;
			 sel_mux : in std_logic;
          en_acc1 : out std_logic;
			 en_rf1 : out std_logic;
			 sel_mux1: out std_logic
        );
end component;

signal immediate : std_logic_vector(3 downto 0);
signal cpu_out : std_logic_vector(3 downto 0);
signal OPCODE : std_logic_vector(3 downto 0);
signal en_acc : std_logic;
signal en_rf : std_logic;
signal sel_mux : std_logic;
signal en_acc1 : std_logic;
signal en_rf1 : std_logic;
signal sel_mux1: std_logic;
signal opcode_in : std_logic_vector(3 downto 0);
begin

-- notice how the output from the datapath is tied to a signal
-- this output signal is then used as input for a decoder.
-- we can also see the output as "output".
-- the output from the datapath should be coming from the accumulator.
-- this is because all actions take place on the accumulator, including
-- all results of any alu operation. naturally, this is because of the 
-- nature of the instruction set.

  controller: ctrl port map(rst, start, clk, immediate, OPCODE, en_acc, en_rf, sel_mux);
  datapath: dp port map(rst, clk, immediate, OPCODE, cpu_out, en_acc, en_rf, sel_mux,en_acc1, en_rf1, sel_mux1);
  process(rst, clk, cpu_out)
  begin

    -- take care of rst case here

    if(clk'event and clk='1') then
    output <= cpu_out;
	 opcode_teste <= OPCODE;
	 opcode_in<= OPCODE;
	 --teste_en_acc <= en_acc1;
	 --teste_sel_mux <= sel_mux1;
	-- teste_en_rf <= en_rf1;
    -- this acts like a BCD to 7-segment decoder,
    -- can see output in waveforms as cpu_out
       case cpu_out is
         when "0000"  => --00
           a0 <= '0'; 
			  b0 <= '0'; 
			  c0 <= '0'; 
			  d0 <= '0'; 
           e0 <= '0'; 
			  f0 <= '0'; 
			  g0 <= '1';
			  
			  a <= '0'; 
			  b <= '0'; 
			  c <= '0'; 
			  d <= '0'; 
           e <= '0'; 
			  f <= '0'; 
			  g <= '1';
         when "0001" => -- 01
           a0 <= '0'; 
			  b0 <= '0'; 
			  c0 <= '0'; 
			  d0 <= '0'; 
           e0 <= '0'; 
			  f0 <= '0'; 
			  g0 <= '1';
			  
			  a <= '1'; 
			  b <= '0'; 
			  c <= '0'; 
			  d <= '1'; 
           e <= '1'; 
			  f <= '1'; 
			  g <= '1';
         when "0010"  =>  --02
			  a0 <= '0'; 
			  b0 <= '0'; 
			  c0 <= '0'; 
			  d0 <= '0'; 
           e0 <= '0'; 
			  f0 <= '0'; 
			  g0 <= '1';
			  
			  a <= '0'; 
			  b <= '0'; 
			  c <= '1'; 
			  d <= '0'; 
           e <= '0'; 
			  f <= '1'; 
			  g <= '0';
         when "0011" =>  --03
			  a0 <= '0'; 
			  b0 <= '0'; 
			  c0 <= '0'; 
			  d0 <= '0'; 
           e0 <= '0'; 
			  f0 <= '0'; 
			  g0 <= '1';
			  
           a <= '0'; 
			  b <= '0'; 
			  c <= '0'; 
			  d <= '0'; 
           e <= '1'; 
			  f <= '1'; 
			  g <= '0';
         when "0100" =>  --04
			  a0 <= '0'; 
			  b0 <= '0'; 
			  c0 <= '0'; 
			  d0 <= '0'; 
           e0 <= '0'; 
			  f0 <= '0'; 
			  g0 <= '1';
			  
           a <= '1'; 
			  b <= '0'; 
			  c <= '0'; 
			  d <= '1'; 
           e <= '1'; 
			  f <= '0'; 
			  g <= '0';
         when "0101" =>  --05
			  a0 <= '0'; 
			  b0 <= '0'; 
			  c0 <= '0'; 
			  d0 <= '0'; 
           e0 <= '0'; 
			  f0 <= '0'; 
			  g0 <= '1';
			  
           a <= '0'; 
			  b <= '1'; 
			  c <= '0'; 
			  d <= '0'; 
           e <= '1'; 
			  f <= '0'; 
			  g <= '0';
         when "0110" =>  --06
			  a0 <= '0'; 
			  b0 <= '0'; 
			  c0 <= '0'; 
			  d0 <= '0'; 
           e0 <= '0'; 
			  f0 <= '0'; 
			  g0 <= '1';
			  
           a <= '0'; 
			  b <= '1'; 
			  c <= '0'; 
			  d <= '0'; 
           e <= '0'; 
			  f <= '0'; 
			  g <= '0';
         when "0111" =>  --07
			  a0 <= '0'; 
			  b0 <= '0'; 
			  c0 <= '0'; 
			  d0 <= '0'; 
           e0 <= '0'; 
			  f0 <= '0'; 
			  g0 <= '1';
			  
           a <= '0'; 
			  b <= '0'; 
			  c <= '0'; 
			  d <= '1'; 
           e <= '1'; 
			  f <= '1'; 
			  g <= '1';
         when "1000" =>  --08
			  a0 <= '0'; 
			  b0 <= '0'; 
			  c0 <= '0'; 
			  d0 <= '0'; 
           e0 <= '0'; 
			  f0 <= '0'; 
			  g0 <= '1';
			  
           a <= '0'; 
			  b <= '0'; 
			  c <= '0'; 
			  d <= '0'; 
           e <= '0'; 
			  f <= '0'; 
			  g <= '0';
         when "1001" =>  --09
			  a0 <= '0'; 
			  b0 <= '0'; 
			  c0 <= '0'; 
			  d0 <= '0'; 
           e0 <= '0'; 
			  f0 <= '0'; 
			  g0 <= '1';
			  
           a <= '0'; 
			  b <= '0'; 
			  c <= '0'; 
			  d <= '0'; 
           e <= '0'; 
			  f <= '1'; 
			  g <= '0';
			   when "1010" =>  --10
           a0 <= '1'; 
			  b0 <= '0'; 
			  c0 <= '0'; 
			  d0 <= '1'; 
           e0 <= '1'; 
			  f0 <= '1'; 
			  g0 <= '1';
			  
			  a <= '0'; 
			  b <= '0'; 
			  c <= '0'; 
			  d <= '0'; 
           e <= '0'; 
			  f <= '0'; 
			  g <= '1';
			   when "1011" =>  --11
           a0 <= '1'; 
			  b0 <= '0'; 
			  c0 <= '0'; 
			  d0 <= '1'; 
           e0 <= '1'; 
			  f0 <= '1'; 
			  g0 <= '1';
			  
			  a <= '1'; 
			  b <= '0'; 
			  c <= '0'; 
			  d <= '1'; 
           e <= '1'; 
			  f <= '1'; 
			  g <= '1';
 
			   when "1100" => --12
           a0 <= '1'; 
			  b0 <= '0'; 
			  c0 <= '0'; 
			  d0 <= '1'; 
           e0 <= '1'; 
			  f0 <= '1'; 
			  g0 <= '1';
			  
			  a <= '0'; 
			  b <= '0'; 
			  c <= '1'; 
			  d <= '0'; 
           e <= '0'; 
			  f <= '1'; 
			  g <= '0';
			   when "1101" => --13
           a0 <= '1'; 
			  b0 <= '0'; 
			  c0 <= '0'; 
			  d0 <= '1'; 
           e0 <= '1'; 
			  f0 <= '1'; 
			  g0 <= '1';
			  
			   a <= '0'; 
			  b <= '0'; 
			  c <= '0'; 
			  d <= '0'; 
           e <= '1'; 
			  f <= '1'; 
			  g <= '0';
			   when "1110" => --14
           a0 <= '1'; 
			  b0 <= '0'; 
			  c0 <= '0'; 
			  d0 <= '1'; 
           e0 <= '1'; 
			  f0 <= '1'; 
			  g0 <= '1';
			  
			a <= '1'; 
			  b <= '0'; 
			  c <= '0'; 
			  d <= '1'; 
           e <= '1'; 
			  f <= '0'; 
			  g <= '0';
			   when "1111" =>  --15
           a0 <= '1'; 
			  b0 <= '0'; 
			  c0 <= '0'; 
			  d0 <= '1'; 
           e0 <= '1'; 
			  f0 <= '1'; 
			  g0 <= '1';
			  
			 a <= '0'; 
			  b <= '1'; 
			  c <= '0'; 
			  d <= '0'; 
           e <= '1'; 
			  f <= '0'; 
			  g <= '0';
         when others =>
       end case;
	
		 case opcode_in is 
			when "0000" =>
			  a1 <= '0'; 
			  b1 <= '0'; 
			  c1 <= '0'; 
			  d1 <= '0'; 
           e1 <= '0'; 
			  f1 <= '0'; 
			  g1 <= '1';
			  	  a2 <= '0'; 
			  b2 <= '0'; 
			  c2 <= '0'; 
			  d2 <= '0'; 
           e2 <= '0'; 
			  f2 <= '0'; 
			  g2 <= '1';
			  	  a3 <= '0'; 
			  b3 <= '0'; 
			  c3 <= '0'; 
			  d3 <= '0'; 
           e3 <= '0'; 
			  f3 <= '0'; 
			  g3 <= '1';
					  a4 <= '0'; 
			  b4 <= '0'; 
			  c4 <= '0'; 
			  d4 <= '0'; 
           e4 <= '0'; 
			  f4 <= '0'; 
			  g4 <= '1';
			  when "0001" =>
			  a1 <= '0'; 
			  b1 <= '0'; 
			  c1 <= '0'; 
			  d1 <= '0'; 
           e1 <= '0'; 
			  f1 <= '0'; 
			  g1 <= '1';
			  	  a2 <= '0'; 
			  b2 <= '0'; 
			  c2 <= '0'; 
			  d2 <= '0'; 
           e2 <= '0'; 
			  f2 <= '0'; 
			  g2 <= '1';
			  	  a3 <= '0'; 
			  b3 <= '0'; 
			  c3 <= '0'; 
			  d3 <= '0'; 
           e3 <= '0'; 
			  f3 <= '0'; 
			  g3 <= '1';
					  a4 <= '1'; 
			  b4 <= '0'; 
			  c4 <= '0'; 
			  d4 <= '1'; 
           e4 <= '1'; 
			  f4 <= '1'; 
			  g4 <= '1';
			  when "0010" =>
			  a1 <= '0'; 
			  b1 <= '0'; 
			  c1 <= '0'; 
			  d1 <= '0'; 
           e1 <= '0'; 
			  f1 <= '0'; 
			  g1 <= '1';
			  	  a2 <= '0'; 
			  b2 <= '0'; 
			  c2 <= '0'; 
			  d2 <= '0'; 
           e2 <= '0'; 
			  f2 <= '0'; 
			  g2 <= '1';
			  	  a3 <= '1'; 
			  b3 <= '0'; 
			  c3 <= '0'; 
			  d3 <= '1'; 
           e3 <= '1'; 
			  f3 <= '1'; 
			  g3 <= '1';
					  a4 <= '0'; 
			  b4 <= '0'; 
			  c4 <= '0'; 
			  d4 <= '0'; 
           e4 <= '0'; 
			  f4 <= '0'; 
			  g4 <= '1';
			  when "0011" =>
			  a1 <= '0'; 
			  b1 <= '0'; 
			  c1 <= '0'; 
			  d1 <= '0'; 
           e1 <= '0'; 
			  f1 <= '0'; 
			  g1 <= '1';
			  	  a2 <= '0'; 
			  b2 <= '0'; 
			  c2 <= '0'; 
			  d2 <= '0'; 
           e2 <= '0'; 
			  f2 <= '0'; 
			  g2 <= '1';
			  	  a3 <= '1'; 
			  b3 <= '0'; 
			  c3 <= '0'; 
			  d3 <= '1'; 
           e3 <= '1'; 
			  f3 <= '1'; 
			  g3 <= '1';
					  a4 <= '1'; 
			  b4 <= '0'; 
			  c4 <= '0'; 
			  d4 <= '1'; 
           e4 <= '1'; 
			  f4 <= '1'; 
			  g4 <= '1';
			  when "0100" =>
			  a1 <= '0'; 
			  b1 <= '0'; 
			  c1 <= '0'; 
			  d1 <= '0'; 
           e1 <= '0'; 
			  f1 <= '0'; 
			  g1 <= '1';
			  	  a2 <= '1'; 
			  b2 <= '0'; 
			  c2 <= '0'; 
			  d2 <= '1'; 
           e2 <= '1'; 
			  f2 <= '1'; 
			  g2 <= '1';
			  	  a3 <= '0'; 
			  b3 <= '0'; 
			  c3 <= '0'; 
			  d3 <= '0'; 
           e3 <= '0'; 
			  f3 <= '0'; 
			  g3 <= '1';
					  a4 <= '0'; 
			  b4 <= '0'; 
			  c4 <= '0'; 
			  d4 <= '0'; 
           e4 <= '0'; 
			  f4 <= '0'; 
			  g4 <= '1';
			  when "0101" =>
			  a1 <= '1'; 
			  b1 <= '0'; 
			  c1 <= '0'; 
			  d1 <= '1'; 
           e1 <= '1'; 
			  f1 <= '1'; 
			  g1 <= '1';
			  	  a2 <= '0'; 
			  b2 <= '0'; 
			  c2 <= '0'; 
			  d2 <= '0'; 
           e2 <= '0'; 
			  f2 <= '0'; 
			  g2 <= '1';
			  	  a3 <= '1'; 
			  b3 <= '0'; 
			  c3 <= '0'; 
			  d3 <= '1'; 
           e3 <= '1'; 
			  f3 <= '1'; 
			  g3 <= '1';
					  a4 <= '0'; 
			  b4 <= '0'; 
			  c4 <= '0'; 
			  d4 <= '0'; 
           e4 <= '0'; 
			  f4 <= '0'; 
			  g4 <= '1';
			when "0110" =>
			  a1 <= '0'; 
			  b1 <= '0'; 
			  c1 <= '0'; 
			  d1 <= '0'; 
           e1 <= '0'; 
			  f1 <= '0'; 
			  g1 <= '1';
			  	  a2 <= '1'; 
			  b2 <= '0'; 
			  c2 <= '0'; 
			  d2 <= '1'; 
           e2 <= '1'; 
			  f2 <= '1'; 
			  g2 <= '1';
			  	  a3 <= '1'; 
			  b3 <= '0'; 
			  c3 <= '0'; 
			  d3 <= '1'; 
           e3 <= '1'; 
			  f3 <= '1'; 
			  g3 <= '1';
					  a4 <= '0'; 
			  b4 <= '0'; 
			  c4 <= '0'; 
			  d4 <= '0'; 
           e4 <= '0'; 
			  f4 <= '0'; 
			  g4 <= '1';
			  when "0111" =>
			  a1 <= '0'; 
			  b1 <= '0'; 
			  c1 <= '0'; 
			  d1 <= '0'; 
           e1 <= '0'; 
			  f1 <= '0'; 
			  g1 <= '1';
			  	  a2 <= '1'; 
			  b2 <= '0'; 
			  c2 <= '0'; 
			  d2 <= '1'; 
           e2 <= '1'; 
			  f2 <= '1'; 
			  g2 <= '1';
			  	  a3 <= '1'; 
			  b3 <= '0'; 
			  c3 <= '0'; 
			  d3 <= '1'; 
           e3 <= '1'; 
			  f3 <= '1'; 
			  g3 <= '1';
					  a4 <= '1'; 
			  b4 <= '0'; 
			  c4 <= '0'; 
			  d4 <= '1'; 
           e4 <= '1'; 
			  f4 <= '1'; 
			  g4 <= '1';
			  when "1000" =>
			  a1 <= '1'; 
			  b1 <= '0'; 
			  c1 <= '0'; 
			  d1 <= '1'; 
           e1 <= '1'; 
			  f1 <= '1'; 
			  g1 <= '1';
			  	  a2 <= '0'; 
			  b2 <= '0'; 
			  c2 <= '0'; 
			  d2 <= '0'; 
           e2 <= '0'; 
			  f2 <= '0'; 
			  g2 <= '1';
			  	  a3 <= '0'; 
			  b3 <= '0'; 
			  c3 <= '0'; 
			  d3 <= '0'; 
           e3 <= '0'; 
			  f3 <= '0'; 
			  g3 <= '1';
					  a4 <= '0'; 
			  b4 <= '0'; 
			  c4 <= '0'; 
			  d4 <= '0'; 
           e4 <= '0'; 
			  f4 <= '0'; 
			  g4 <= '1';
			  when "1001" =>
			  a1 <= '1'; 
			  b1 <= '0'; 
			  c1 <= '0'; 
			  d1 <= '1'; 
           e1 <= '1'; 
			  f1 <= '1'; 
			  g1 <= '1';
			  	  a2 <= '0'; 
			  b2 <= '0'; 
			  c2 <= '0'; 
			  d2 <= '0'; 
           e2 <= '0'; 
			  f2 <= '0'; 
			  g2 <= '1';
			  	  a3 <= '0'; 
			  b3 <= '0'; 
			  c3 <= '0'; 
			  d3 <= '0'; 
           e3 <= '0'; 
			  f3 <= '0'; 
			  g3 <= '1';
					  a4 <= '1'; 
			  b4 <= '0'; 
			  c4 <= '0'; 
			  d4 <= '1'; 
           e4 <= '1'; 
			  f4 <= '1'; 
			  g4 <= '1';
			  when others =>
			  end case;
	end if;
  end process;							

end struc;



