-- controller
library IEEE;
library numeric_std;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use numeric_std.all;


entity ctrl is
  port ( rst   : in  STD_LOGIC;
         start : in STD_LOGIC;
         clk   : in STD_LOGIC;       
         imm   : out std_logic_vector(3 downto 0);
			OP: out std_logic_vector(3 downto 0); --CONTEM A INSTRUCAO PARA O DP
			en_acc : out std_logic;
			en_rf : out std_logic;
			sel_mux : out std_logic
       );
end ctrl;

architecture fsm of ctrl is
  type state_type is (s0,s1,s2,s3,s4,s4_1,s4_2,s4_3,done);
  signal state : state_type;
  --signal endereco : std_logic_vector(3 downto 0);  

	-- constants declared for ease of reading code
	
	constant mova    : std_logic_vector(3 downto 0) := "0000";
	constant movr    : std_logic_vector(3 downto 0) := "0001";
	constant load    : std_logic_vector(3 downto 0) := "0010";
	constant add	   : std_logic_vector(3 downto 0) := "0011";
	constant sub	   : std_logic_vector(3 downto 0) := "0100";
	constant andr    : std_logic_vector(3 downto 0) := "0101";
	constant orr     : std_logic_vector(3 downto 0) := "0110";
	constant jmp	   : std_logic_vector(3 downto 0) := "0111";
	constant inv     : std_logic_vector(3 downto 0) := "1000";
	constant halt	   : std_logic_vector(3 downto 0) := "1001";


	-- as you add more code for your algorithms make sure to increase the
	-- array size. ie. 2 lines of code here, means array size of 0 to 1.
	type PM_BLOCK is array (0 to 5) of std_logic_vector(7 downto 0);
	constant PM : PM_BLOCK := (	

	-- This algorithm loads an immediate value of 3 and then stops
    	-- This algorithm loads an 	ediate value of 3 and then stops
	 --"00100111", -- load 4 para acumullator
	 "00100110",
	 --"01110011",
	 "00011000", -- movr rd, acumullator para register[11]
	 "00101010",
	 "00001000", -- mova rd, acumullator para register[11]
	 --"00111000", -- Add rd, acumullator=acumullator+register[11]
	 --"01001000", -- sub rd, acumullator=acumullator-register[11]
	 --"01011000", -- acumullator=acumullator and register[11]
	 --"01101000", -- acumullator=acumullator or register[11]
    --"01110000", -- PC = adress[0000]
	 "10000000", -- acumullator = not acumullator
	 "10011111"  -- halt
	 );
  		 
begin
	process (clk)
	-- these variables declared here don't change.
	-- these are the only data allowed inside
	-- our otherwise pure FSM
  
	variable IR : std_logic_vector(7 downto 0);
	variable OPCODE : std_logic_vector( 3 downto 0);
	variable ADDRESS : std_logic_vector (3 downto 0);
	variable PC : integer;
	--variable Prov : integer;
    
	begin
		-- don't forget to take care of rst
    
		if (clk'event and clk = '1') then			
    
      case state is
        
        when s0 =>    -- steady state
          PC := 0;
          imm <= "0000";
          if start = '1' then
            state <= s1;
          else 
            state <= s0;
          end if;
          
        when s1 =>				-- fetch instruction
		  -- ESTADO INICIAL DE OBTENSAO DE DADOS
          IR := PM(PC);
          OPCODE := IR(7 downto 4); -- CARREGA A INSTRUCAO
          ADDRESS:= IR(3 downto 0); -- CARREGA IMMEDIATE
          state <= s2;
          
        when s2 =>				-- increment PC
          PC := PC + 1;
          state <= s4;
			 
		  when s3 =>
			 PC:= conv_integer(unsigned(ADDRESS));
			 state <= s1;
			 
        when s4 =>				-- decode instruction
          case OPCODE IS
            when load =>                       -- notice we can use
                                                -- the instruction
              state <= s4_2;   
            when halt =>                      -- and the machine code
             
					 OP <= halt;
					 imm <= ADDRESS;
					 sel_mux <= '1';
					 en_acc <= '0';
					 en_rf <= '0';                                  -- interchangeably
					 state <= done;
				  
				when mova =>
					en_rf <= '0';
					state <= s4_2;
					
				when movr =>
					en_rf <= '1';
					state <= s4_3;
					
				when add =>
					state <= s4_1;
					
				when sub =>
					state <= s4_1;
					
				when andr =>
					state <= s4_1;
					
				when orr =>
					state <= s4_1;
					
				when inv =>
					state <= s4_1;
					
				when jmp =>
					state <= s3;
					
            when others =>
              state <= s1;
          end case;
        
			-- these states are the ones in which you actually
			-- start sending signals across
			-- to the datapath depending on what opcode is decoded.
			-- you add more states here.
			
		  when s4_1 =>
			 en_acc <= '0';
			 en_rf <= '0';
			 sel_mux <= '0';
			 imm <= ADDRESS;
			 OP <= OPCODE;
			 state <= s4_2;
			 
		  when s4_2 =>
			 en_acc <= '1';
			 case OPCODE is
				when mova =>
					OP <= OPCODE;
					imm <= ADDRESS;
					sel_mux <= '0';
					state <= s1;
				when load =>
					OP <= OPCODE;
					imm <= ADDRESS;
					sel_mux <= '1';
					state <= s1;
			   when others =>
					state <= s1;
				end case;
			
			when s4_3 =>
				en_rf <= '0';
				en_acc <= '0';
				sel_mux <= '0';
				imm <= ADDRESS;
				OP <= OPCODE;
				state <= s1;

        when done =>
          state <= done;  
        when others =>
          
      end case;
      
    end if;
  end process;				
end fsm;