library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity contador is
port (clk: in std_logic;
		enable_cron: in std_logic;
		reset: in std_logic;
		us: out integer;
		ds: out integer;
		um: out integer;
		dm: out integer;
		uh: out integer;
		dh: out integer);
end contador;

architecture contador of contador is

	signal us1: integer := 0;
	signal ds1: integer := 0;
	signal um1: integer := 0;
	signal dm1: integer := 0;
	signal uh1: integer := 0;
	signal dh1: integer := 0;
	
	begin
	
		process(clk) -- processo para um clock de 50 MHz para 1 Hz
		begin
			if(clk'EVENT and clk='1') then
				if(reset='1') then
					us1 <= 0;
					ds1 <= 0;
					um1 <= 0;
					dm1 <= 0;
					uh1 <= 0;
					dh1 <= 0;
				else
					if(enable_cron = '1') then
						us1 <= us1 + 1;
						if(us1 = 9) then
							us1 <= 0;
							ds1 <= ds1 + 1;
						end if;	
						if(ds1 = 5 and us1 = 9) then
							ds1 <= 0;
							um1 <= um1 + 1;
						end if;
						if(um1 = 9 and ds1 = 5 and us1 = 9) then
							um1 <= 0;
							dm1 <= dm1 + 1;
						end if;
						if(dm1 = 5 and um1=9 and ds1=5 and us1=9) then
							dm1 <= 0;
							uh1 <= uh1 + 1;
						end if;
						if(uh1 = 9 and dm1 = 5 and um1=9 and ds1=5 and us1=9) then
							uh1 <= 0;
							dh1 <= dh1 + 1;
						end if;
						if(dh1=2 and uh1 = 3 and dm1 = 5 and um1=9 and ds1=5 and us1=9) then
							uh1 <= 0;
							dh1 <= 0;
						end if;
					end if;
				end if;
			end if;
		end process;
		us <= us1;
		ds <= ds1;
		um <= um1;
		dm <= dm1;
		uh <= uh1;
		dh <= dh1;
end contador;