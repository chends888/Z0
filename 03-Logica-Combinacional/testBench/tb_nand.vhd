-- Elementos de Sistemas
-- developed by Luciano Soares
-- file: tb_nand.vhd
-- date: 4/4/2017

library ieee;
use ieee.std_logic_1164.all;

library vunit_lib;
context vunit_lib.vunit_context;

entity tb_nand is
  generic (runner_cfg : string);
end entity;

architecture tb of tb_nand is

  component nand_vhdl is
    port(a:in  std_logic;
         b:in  std_logic;
         q:out std_logic
         );
  end component;

  signal  inA, inB, outQ : std_logic;

  -- Clock
  constant CLK_PERIOD : time := 1 ns;
  signal clk : std_logic := '0';

begin

  clk_process :process
  begin
    clk <= '0';
    wait for clk_period/2;  --for 0.5 ns signal is '0'.
    clk <= '1';
    wait for clk_period/2;  --for next 0.5 ns signal is '1'.
  end process;

  mapping: nand_vhdl port map(inA, inB, outQ);

  main : process
  begin
    test_runner_setup(runner, runner_cfg);

    -- Teste: 0 0
    inA <= '0'; inB <= '0';
    wait until clk='1';
    assert(outQ = '1')  report "Falha em teste: 0 nand 0 != 1" severity error;

    -- Teste: 0 1
    inA <= '0'; inB <= '1';
    wait until clk='1';
    assert(outQ = '1')  report "Falha em teste: 0 nand 1 != 1" severity error;

    -- Teste: 1 0
    inA <= '1'; inB <= '0';
    wait until clk='1';
    assert(outQ = '1')  report "Falha em teste: 1 nand 0 != 1" severity error;

    -- Teste: 1 1
    inA <= '1'; inB <= '1';
    wait until clk='1';
    assert(outQ = '0')  report "Falha em teste: 1 nand 1 != 0" severity error;

    test_runner_cleanup(runner); -- Simulation ends here

    wait;
  end process;
end architecture;
