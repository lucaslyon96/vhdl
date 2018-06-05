LIBRARY ieee ;
USE ieee.std_logic_1164.all ;
ENTITY reg8 IS
	PORT ( D : IN STD_LOGIC_VECTOR(7 DOWNTO 0) ;
			Resetn, Clock, bloqueado: IN STD_LOGIC ;
			Q : OUT STD_LOGIC_VECTOR(7 DOWNTO 0) ) ;
			
END reg8 ;
ARCHITECTURE Behavior OF reg8 IS
	BEGIN
		PROCESS ( Resetn, Clock,bloqueado )
		BEGIN
			IF Resetn = '0' and bloqueado = '1'  THEN
			-- Não faz nada, ou seja, bloqueia o sistema	quando sistema bloqueado e reset está em zero.
			else 
				IF Clock'EVENT AND Clock = '1'   THEN Q <= D;
				end IF;
			end IF;
	END PROCESS ;
END Behavior ;