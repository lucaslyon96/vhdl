LIBRARY ieee ;
USE ieee.std_logic_1164.all ;
ENTITY reg_reset IS
	PORT ( reset : IN std_LOGIC;
			bloqueado, clock: IN STD_LOGIC ;
			R : OUT STD_LOGIC) ;
			
END reg_reset ;
ARCHITECTURE Behavior OF reg_reset IS
	BEGIN
		PROCESS ( reset,bloqueado, clock)
		BEGIN
			if bloqueado = '1' and reset = '1' then --Se reset for apertado e o sistema estiver bloqueado
				R <= reset;
			--elsif  clock'EVENT and clock='1' then
				--R <= '0';
			end if;
	END PROCESS ;
END Behavior ;