-- Elementos de Sistemas
-- by Luciano Soares
-- Register16.vhd

Library ieee; 
use ieee.std_logic_1164.all;
  
entity Register16 is
	port(
		clock:   in STD_LOGIC;
		input:   in STD_LOGIC_VECTOR(15 downto 0);
		load:    in STD_LOGIC;
		output: out STD_LOGIC_VECTOR(15 downto 0)
	);
end entity;

architecture rtl of Register16 is

begin

process(clock)

	begin 
		if(clock'event and clock ='1' and load='1') then
				output <= input;
		end if;
	end process;

end rtl;



