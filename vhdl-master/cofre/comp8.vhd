library ieee;

use IEEE.std_logic_1164.all;

entity comp8 is
port(A,B: in std_logic_vector(7 downto 0);
igual: out std_logic);  --Declaração de variaveis de saida

END comp8;

architecture comp8 of comp8 is 

begin
igual <= '1' when (A=B)else '0'; --A=B, saida 1, se não 0 

END comp8;