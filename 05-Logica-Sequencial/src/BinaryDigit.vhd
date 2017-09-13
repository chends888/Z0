-- Elementos de Sistemas
-- by Luciano Soares
-- BinaryDigit.vhd

Library ieee; 
use ieee.std_logic_1164.all;
  
entity BinaryDigit is
	port(
		clock:   in STD_LOGIC;
		input:   in STD_LOGIC;
		load:    in STD_LOGIC;
		output: out STD_LOGIC
	);
end entity;

architecture BinaryDigit_arch of BinaryDigit is
component FlipFlopD 
	port(
		clock:  in std_logic;
		d:      in std_logic;
		clear:  in std_logic;
		preset: in std_logic;
		q:     out std_logic
	);
end component;

component Mux2Way 
	port ( 
			a:   in  STD_LOGIC;
			b:   in  STD_LOGIC;
			sel: in  STD_LOGIC;
			q:   out STD_LOGIC);
end component;

signal l1,l2: STD_LOGIC;

begin 
	mux: Mux2Way port map(l1,input,load,l2);

	clk_flip: FlipFlopD port map(clock,l2,'1','1',l1);

	output<=l1;
end architecture;