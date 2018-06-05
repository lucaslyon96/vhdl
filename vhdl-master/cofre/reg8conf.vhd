LIBRARY ieee ;
USE ieee.std_logic_1164.all ;
ENTITY reg8conf IS
	PORT ( D : IN STD_LOGIC_VECTOR(7 DOWNTO 0) ;
			Resetn, Clock, enable: IN STD_LOGIC ;
			Q : OUT STD_LOGIC_VECTOR(7 DOWNTO 0) ) ;
			
END reg8conf ;
ARCHITECTURE Behavior OF reg8conf IS
	BEGIN
		PROCESS (Clock ,enable)
		BEGIN
			IF enable = '1' THEN
				IF Clock'EVENT AND Clock = '1'   THEN Q <= D;
				end IF;
			END IF ;
			
END PROCESS ;
END Behavior ;