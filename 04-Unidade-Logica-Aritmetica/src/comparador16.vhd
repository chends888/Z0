-- Elementos de Sistemas
-- by Luciano Soares
-- comparador16.vhd

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity comparador16 is
   port(
	    a   : in  STD_LOGIC_VECTOR(15 downto 0);
       	zr  : out STD_LOGIC;
		ng  : out STD_LOGIC
   );
end comparador16;

architecture strucComp16 of comparador16 is

begin

zr <= '1' when (a = "0000000000000000") else
'0';

ng <= '1' when (a(15) = '1') else 
'0'; 


end strucComp16;
