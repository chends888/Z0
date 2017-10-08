-- Elementos de Sistemas
-- developed by Luciano Soares
-- tb_BinaryDigit.vhd
-- date: 4/4/2017

Library ieee;
use ieee.std_logic_1164.all;

library vunit_lib;
context vunit_lib.vunit_context;

entity tb_Multiplicador is
  generic (runner_cfg : string);
end entity;

architecture tb of tb_Multiplicador is

	signal A, B, Y : std_logic_vector(15 downto 0);

  component MultiplicadorAcomB is
      port(
           A     : in  STD_LOGIC_VECTOR(15 downto 0);
           B     : in  STD_LOGIC_VECTOR(15 downto 0);
           Y     : out STD_LOGIC_VECTOR(15 downto 0)
    );
    end component;

begin

	u1: MultiplicadorAcomB port map(A,B,Y);

  main : process
  begin
    test_runner_setup(runner, runner_cfg);

		-- Teste: 0
    -- A <=
    -- B <=
		--wait for 200 ps;
		--assert(Y = X"00")  report "Falha em teste: 0" severity error;


    test_runner_cleanup(runner); -- Simulation ends here

	wait;
  end process;
end architecture;
