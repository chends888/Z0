
-- FullAdder.vhd

-- Implementa Full Adder

Library ieee;
use ieee.std_logic_1164.all;

entity FullAdder is
	port(
		a,b,c:      in STD_LOGIC;   -- entradas
		soma,vaium: out STD_LOGIC   -- sum e carry
	);
end entity;

architecture Behavioral of FullAdder is

begin


soma <= a xor b xor c;
vaium <=(a and b) or (a and c) or (b and c);


end Behavioral;
