-- Elementos de Sistemas
-- by Luciano Soares
-- Ram4K.vhd

Library ieee; 
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
  
entity Ram4K is
	port(
		clock:   in  STD_LOGIC;
		input:   in  STD_LOGIC_VECTOR(15 downto 0);
		load:    in  STD_LOGIC;
		address: in  STD_LOGIC_VECTOR(11 downto 0);
		output:  out STD_LOGIC_VECTOR(15 downto 0)
	);
end entity;

architecture rtl of Ram4K is
	type memory is array(0 to 4095) of STD_LOGIC_VECTOR(15 downto 0);
	signal signal_ram: memory;

begin 

	process(clock)
	begin 
		if(clock'event and clock ='1' and load='1') then
				signal_ram(to_integer(unsigned(address))) <= input;
		end if;
	end process;

	output <= signal_ram(to_integer(unsigned(address)));

end rtl;
