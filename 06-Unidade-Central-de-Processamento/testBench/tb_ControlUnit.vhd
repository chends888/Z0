-- Elementos de Sistemas
-- developed by Luciano Soares
-- 1 tb_ControlUnit.vhd
-- date: 4/4/2017

Library ieee;
use ieee.std_logic_1164.all;

library vunit_lib;
context vunit_lib.vunit_context;

entity tb_ControlUnit is
  generic (runner_cfg : string);
end entity;

architecture tb of tb_ControlUnit is


  component ControlUnit is
      port(
            instruction                 : in STD_LOGIC_VECTOR(15 downto 0);  -- instrução para executar
            zr,ng                       : in STD_LOGIC;                      -- valores zr(se zero) e ng(se negativo) da ALU

            muxALUI_A                   : out STD_LOGIC;                     -- mux que seleciona entre instrução e ALU para reg. A
            muxAM_ALU                   : out STD_LOGIC;                     -- mux que seleciona entre reg. A e Mem. RAM para ALU
            zx, nx, zy, ny, f, no       : out STD_LOGIC;                     -- sinais de controle da ALU
            loadA, loadD, loadM, loadPC : out STD_LOGIC                      -- sinais de load do reg. A, reg. D, Mem. RAM e Program Counter
          );
    end component;

	signal inClock : std_logic := '0';

  signal instruction                 : STD_LOGIC_VECTOR(15 downto 0) := (others => '0');
  signal zr,ng                       : STD_LOGIC := '0';
  signal muxALUI_A                   : STD_LOGIC := '0';
  signal muxAM_ALU                   : STD_LOGIC := '0';
  signal zx, nx, zy, ny, f, no       : STD_LOGIC := '0';
  signal loadA, loadD, loadM, loadPC : STD_LOGIC := '0';

begin

	--CU: ControlUnit port map(instruction, zr, ng, maxALUIA_A, maxAM_ALU, zx, nx, zy, ny, f, no, loadA, loadD, loadM, loadPC);

	inClock <= not inClock after 100 ps;

  main : process
    begin
    test_runner_setup(runner, runner_cfg);

		-- Teste: 0
		wait for 200 ps;
    --instructions <= "0111111111111111111"
		--assert(loadA = '1' and loadD = '0' and loadM = '0')  report "Falha em load A instrucao tipo A" severity error;
    test_runner_cleanup(runner); -- Simulation ends here

	wait;
  end process;
end architecture;
