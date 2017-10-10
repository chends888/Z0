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

	CU: ControlUnit port map(instruction, zr, ng, muxALUI_A, muxAM_ALU, zx, nx, zy, ny, f, no, loadA, loadD, loadM, loadPC);

	inClock <= not inClock after 100 ps;

  main : process
    begin
    test_runner_setup(runner, runner_cfg);
    
    -- Teste: 0
    instruction <= "0111111111111111";
    wait for 200 ps;
    assert(loadA = '1' and loadD = '0' and loadM = '0')  report "Falha em load A instrucao tipo A" severity error;
     -- Simulation ends here

    -- Teste 1 tipo C (-D carrega em D) 
    instruction <= "1110001111010000";
    wait for 200 ps;
    assert(loadA = '0' and loadD = '1' and loadM = '0') report "Falha em load D instrução tipo C " severity error;
     

    -- Teste 2 tipo C (-A carrega em A)
    instruction <= "1110011001110000";
    wait for 200 ps;
    assert(loadA='1' and loadD='0' and loadM ='0') report "Falha em load A instrução tipo C" severity error;
    

    --Teste 3 tipo A (carrega 10 no registrador A)
    instruction <= "0000000000001010";
    wait for 200 ps;
    assert(loadA = '1' and loadD = '0' and loadM = '0') report "Falha em load A instrução tipo A" severity error;
    

    --Teste 4 tipo C (D+M carrega em AD)
    wait for 200 ps;
    instruction <= "1111000010110000";
    assert(loadA = '1' and loadD = '1' and loadM = '1') report "Falha em loadA e loadD instrucao tipo C" severity error;
    

    -- Teste 5 tipo C (D&M carrega em AMD)
    wait for 200 ps;
    instruction <= "1111000000111000";
    assert(loadA = '1' and loadD = '1' and loadM = '1') report "Falha em em loadA e loadD e loadM tipo C" severity error;
   
    test_runner_cleanup(runner);

    -- Teste 6 tipo C (carrega !A em M + JGE)
    --wait for 200 ps;
    --instruction <= "1111110001001011";
    --assert(loadA = '0' and loadD = '0' and loadM = '1' and loadPC = '?')




	   wait;
  end process;
end architecture;
