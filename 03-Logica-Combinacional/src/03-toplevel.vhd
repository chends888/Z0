-- =========================================
-- Elementos de Sistemas
-- by Rafael.corsi@insper.edu.br
-- TopLevel para teste dos módulos combinacionais
-- Agosto 2017
--
-- Bugs conhecidos :
--
-- Melhorias :
--
-- TODO :
--
-- ========================================
-- Material da disciplina : Elementos de Sistemas
-- Engenharia Computacao Insper 
-- https://github.com/Insper/Elementos-De-Sistema
-- 
-- Direitos reservados.
-- =========================================

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity topLevel03 is
  generic(
    -- Logic
    TEST_NAND       : boolean := false;    -- Nand_vhd;
    TEST_AND16      : boolean := False;    -- And16
    TEST_OR16       : boolean := False;    -- Or16
    TEST_NOT16      : boolean := False;    -- Not16
    TEST_OR8WAY     : boolean := False;    -- Or8Way
    TEST_NOR8WAY    : boolean := True;    -- Nor8Way
    -- BarrelShifter
    TEST_BS8        : boolean := False;    -- BarrelShiter8
    TEST_BS16       : boolean := False;    -- BarrelShiter16
    -- Dmux
    TEST_DMUX2      : boolean := False;    -- DMux2Way
    TEST_DMUX4      : boolean := False;    -- Dmux4Way
    TEST_DMUX8      : boolean := False;    -- Dmux8Way
    TEST_DMUX8WAY16 : boolean := False;    -- Dmux8Way16
    -- Mux
    TEST_MUX2WAY    : boolean := False;    -- Mux2Way
    TEST_MUX4WAY    : boolean := False;    -- Mux4Way
    TEST_MUX8WAy    : boolean := False;    -- Mux8Way
    TEST_MUX16      : boolean := false;    -- Mux16
    TEST_MUX4WAY16  : boolean := False;    -- Mux4Way16
    TEST_MUX8WAY16  : boolean := False     -- Mux8Way16
  );
  port (
    SW       : in  STD_LOGIC_VECTOR(9 downto 0);
	 SEVENSEG : out STD_LOGIC_VECTOR(6 downto 0);
    LEDR 	 : out STD_LOGIC_VECTOR(9 downto 0)
  );
end entity;

architecture rtl of topLevel03 is

-------------------
-- Portas lógicas
-------------------

component And16 is
	port (
			a:   in  STD_LOGIC_VECTOR(15 downto 0);
			b:   in  STD_LOGIC_VECTOR(15 downto 0);
			q:   out STD_LOGIC_VECTOR(15 downto 0));
end component;

component Not16 is
	port (
    a:   in  STD_LOGIC_VECTOR(15 downto 0);
    q:   out STD_LOGIC_VECTOR(15 downto 0));
end component;

component Or16 is
	port (
    a:   in  STD_LOGIC_VECTOR(15 downto 0);
    b:   in  STD_LOGIC_VECTOR(15 downto 0);
    q:   out STD_LOGIC_VECTOR(15 downto 0));
end component;

component Or8Way is
	port (
    a:   in  STD_LOGIC;
    b:   in  STD_LOGIC;
    c:   in  STD_LOGIC;
    d:   in  STD_LOGIC;
    e:   in  STD_LOGIC;
    f:   in  STD_LOGIC;
    g:   in  STD_LOGIC;
    h:   in  STD_LOGIC;
    q:   out STD_LOGIC);
end component;

component Nor8Way is
	port (
    a:   in  STD_LOGIC;
    b:   in  STD_LOGIC;
    c:   in  STD_LOGIC;
    d:   in  STD_LOGIC;
    e:   in  STD_LOGIC;
    f:   in  STD_LOGIC;
    g:   in  STD_LOGIC;
    h:   in  STD_LOGIC;
    q:   out STD_LOGIC);
end component;

component nand_vhdl is
  port(a:in  std_logic;
	     b:in  std_logic;
	     q:out std_logic
       );
end component;

------------------
-- Shift
------------------

component BarrelShifter8 is
	port (
    a:    in  STD_LOGIC_VECTOR(7 downto 0);   -- input vector
    dir:  in  std_logic;                      -- 0=>left 1=>right
    size: in  std_logic_vector(2 downto 0);   -- shift amount
    q:    out STD_LOGIC_VECTOR(7 downto 0));  -- output vector (shifted)
end component;

component BarrelShifter16 is
	port (
    a:    in  STD_LOGIC_VECTOR(15 downto 0);   -- input vector
    dir:  in  std_logic;                       -- 0=>left 1=>right
    size: in  std_logic_vector(2 downto 0);    -- shift amount
    q:    out STD_LOGIC_VECTOR(15 downto 0));  -- output vector (shifted)
end component;

------------------
-- Dmux
------------------

component DMux2Way is
	port (
    a:   in  STD_LOGIC;
    sel: in  STD_LOGIC;
    q0:  out STD_LOGIC;
    q1:  out STD_LOGIC);
end component;

component DMux4Way is
	port (
    a:   in  STD_LOGIC;
    sel: in  STD_LOGIC_VECTOR(1 downto 0);
    q0:  out STD_LOGIC;
    q1:  out STD_LOGIC;
    q2:  out STD_LOGIC;
    q3:  out STD_LOGIC);
end component;

component DMux8Way is
	port (
    a:   in  STD_LOGIC;
    sel: in  STD_LOGIC_VECTOR(2 downto 0);
    q0:  out STD_LOGIC;
    q1:  out STD_LOGIC;
    q2:  out STD_LOGIC;
    q3:  out STD_LOGIC;
    q4:  out STD_LOGIC;
    q5:  out STD_LOGIC;
    q6:  out STD_LOGIC;
    q7:  out STD_LOGIC);
end component;

component DMux8Way16 is
	port (
		a:   in  STD_LOGIC_VECTOR(15 downto 0);
		sel: in  STD_LOGIC_VECTOR(2 downto 0);
		q0:  out STD_LOGIC_VECTOR(15 downto 0);
		q1:  out STD_LOGIC_VECTOR(15 downto 0);
		q2:  out STD_LOGIC_VECTOR(15 downto 0);
		q3:  out STD_LOGIC_VECTOR(15 downto 0);
		q4:  out STD_LOGIC_VECTOR(15 downto 0);
		q5:  out STD_LOGIC_VECTOR(15 downto 0);
		q6:  out STD_LOGIC_VECTOR(15 downto 0);
		q7:  out STD_LOGIC_VECTOR(15 downto 0)
    );
end component;

------------------
-- MUX b
------------------

component Mux2Way is
	port (
    a:   in  STD_LOGIC;
    b:   in  STD_LOGIC;
    sel: in  STD_LOGIC;
    q:   out STD_LOGIC);
end component;

component Mux4Way is
	port (
    a:   in  STD_LOGIC;
    b:   in  STD_LOGIC;
    c:   in  STD_LOGIC;
    d:   in  STD_LOGIC;
    sel: in  STD_LOGIC_VECTOR(1 downto 0);
    q:   out STD_LOGIC);
end component;

component Mux4Way16 is
	port (
    a:   in  STD_LOGIC_VECTOR(15 downto 0);
    b:   in  STD_LOGIC_VECTOR(15 downto 0);
    c:   in  STD_LOGIC_VECTOR(15 downto 0);
    d:   in  STD_LOGIC_VECTOR(15 downto 0);
    sel: in  STD_LOGIC_VECTOR(1 downto 0);
    q:   out STD_LOGIC_VECTOR(15 downto 0));
end component;

component Mux8Way is
	port (
    a:   in  STD_LOGIC;
    b:   in  STD_LOGIC;
    c:   in  STD_LOGIC;
    d:   in  STD_LOGIC;
    e:   in  STD_LOGIC;
    f:   in  STD_LOGIC;
    g:   in  STD_LOGIC;
    h:   in  STD_LOGIC;
    sel: in  STD_LOGIC_VECTOR(2 downto 0);
    q:   out STD_LOGIC);
end component;

component Mux8Way16 is
	port (
    a:   in  STD_LOGIC_VECTOR(15 downto 0);
    b:   in  STD_LOGIC_VECTOR(15 downto 0);
    c:   in  STD_LOGIC_VECTOR(15 downto 0);
    d:   in  STD_LOGIC_VECTOR(15 downto 0);
    e:   in  STD_LOGIC_VECTOR(15 downto 0);
    f:   in  STD_LOGIC_VECTOR(15 downto 0);
    g:   in  STD_LOGIC_VECTOR(15 downto 0);
    h:   in  STD_LOGIC_VECTOR(15 downto 0);
    sel: in  STD_LOGIC_VECTOR(2 downto 0);
    q:   out STD_LOGIC_VECTOR(15 downto 0));
end component;

component Mux16 is
	port (
    a:   in  STD_LOGIC_VECTOR(15 downto 0);
    b:   in  STD_LOGIC_VECTOR(15 downto 0);
    sel: in  STD_LOGIC;
    q:   out STD_LOGIC_VECTOR(15 downto 0));
end component;

begin

------------------
-- Logic
------------------

  TestAnd16: if TEST_AND16 generate
    Uand16 : And16 port map(
          a(4  downto 0) => SW(4 downto 0),
          a(15 downto 5) => (others => '0'),
          b(4  downto 0) => SW(9 downto 5),
          b(15 downto 5) => (others => '0'),
          q(4  downto 0) => LEDR(4 downto 0),
          q(15 downto 5) => OPEN
      );
      LEDR(9 downto 5) <= (others => '0');
  end generate;

  TestNot16 : if TEST_NOT16 generate
    Unot16 : not16 port map(
      a(9  downto 0) => SW(9 downto 0),
      q(9  downto 0) => LEDR(9 downto 0),
      q(15 downto 10) => open
      );
    LEDR(9 downto 5) <= (others => '0');
  end generate;

  TestOr16: if TEST_OR16 generate
    Uor16 : Or16 port map(
      a(4  downto 0) => SW(4 downto 0),
      a(15 downto 5) => (others => '0'),
      b(4  downto 0) => SW(9 downto 5),
      b(15 downto 5) => (others => '0'),
      q(4  downto 0) => LEDR(4 downto 0),
      q(15 downto 5) => OPEN
      );
    LEDR(9 downto 5) <= (others => '0');
  end generate;

  TestOr8Way: if TEST_OR8WAY generate
    Uor8way : Or8Way port map(
      a => SW(0),
      b => SW(1),
      c => SW(2),
      d => SW(3),
      e => SW(4),
      f => SW(5),
      g => SW(6),
      h => SW(7),
      q => LEDR(0)
      );
    LEDR(9 downto 1) <= (others => '0');
  end generate;

  TestNor8Way: if TEST_NOR8WAY generate
    Unor8way : Nor8Way port map(
      a => SW(0),
      b => SW(1),
      c => SW(2),
      d => SW(3),
      e => SW(4),
      f => SW(5),
      g => SW(6),
      h => SW(7),
      q => LEDR(0)
      );
    LEDR(9 downto 1) <= (others => '0');
  end generate;

  TestNand: if TEST_NAND generate
    Unand : Nand_vhdl port map(
      a => SW(0),
      b => SW(1),
      q => LEDR(0)
      );
    LEDR(9 downto 1) <= (others => '0');
  end generate;

------------------
-- Barrel
------------------

  --
  -- A    (in) SW(5..0)
  -- Dir  (in) SW(9)
  -- Size (in) SW(8..6)
  --
  TestBS8: if TEST_BS8 generate
    UBS8 : BarrelShifter8 port map(
      a(5  downto 0)  => SW(5 downto 0),
      a(7 downto 6)  => (others => '0'),
      size            => SW(8 downto 6),
      dir             => SW(9),
      q(7  downto 0)  => LEDR(7 downto 0)
    );
    LEDR(9 downto 8) <= (others => '0');
  end generate;

  --
  -- A    (in) SW(5..0)
  -- Dir  (in) SW(9)
  -- Size (in) SW(8..6)
  --
  TestBS16: if TEST_BS16 generate
    UBS16 : BarrelShifter16 port map(
      a(5  downto 0)  => SW(5 downto 0),
      a(15 downto 7)  => (others => '0'),
      size            => SW(8 downto 6),
      dir             => SW(9),
      q(9  downto 0)  => LEDR(9 downto 0),
      q(15 downto 0)  => OPEN
    );
  end generate;

------------------
-- Dmux
------------------

  --
  -- A     (in)  SW(0)
  -- SEL   (in)  SW(1)
  -- q1,q0 (out) LED(1..0)
  --
  TestDMUX2: if TEST_DMUX2 generate
    Udmux2 : DMux2Way port map(
      a   => SW(3),
      sel => Sw(0),
      q0  => LEDR(0),
      q1  => LEDR(1)
    );
    LEDR(9 downto 2) <= (others => '0');
  end generate;

  --
  -- A     (in)  SW(0)
  -- SEL   (in)  SW(2..1)
  -- q3,q2,q1,q0 (out) LED(3..0)
  --
  TestDMUX4: if TEST_DMUX4 generate
    Udmux4 : DMux4Way port map(
      a   => SW(3),
      sel => Sw(1 downto 0),
      q0  => LEDR(0),
      q1  => LEDR(1),
      q2  => LEDR(2),
      q3  => LEDR(3)
      );
    LEDR(9 downto 4) <= (others => '0');
  end generate;

  --
  -- A     (in)  SW(0)
  -- SEL   (in)  SW(2..1)
  -- q7,..,q2,q1,q0 (out) LED(7..0)
  --
  TestDMUX8: if TEST_DMUX8 generate
    Udmux8 : DMux8Way port map(
      a   => SW(3),
      sel => SW(2 downto 0),
      q0  => LEDR(0),
      q1  => LEDR(1),
      q2  => LEDR(2),
      q3  => LEDR(3),
      q4  => LEDR(4),
      q5  => LEDR(5),
      q6  => LEDR(6),
      q7  => LEDR(7)
      );
    LEDR(9 downto 8) <= (others => '0');
  end generate;

  --
  -- A     (in)  SW(0)
  -- SEL   (in)  SW(2..1)
  -- q7,..,q2,q1,q0 (out) LED(7..0)
  --
  TestDMUX8WAY16: if TEST_DMUX8WAY16 generate
    Udmux8way16 : DMux8Way16 port map(
      a(0)  => SW(3),
      a(15 downto 1) => (others => '0'),
      sel   => SW(2 downto 0),
      q0(0) => LEDR(0),
      q0(15 downto 1) => open,
      q1(0) => LEDR(1),
      q1(15 downto 1) => open,
      q2(0) => LEDR(2),
      q2(15 downto 1) => open,
      q3(0) => LEDR(3),
      q3(15 downto 1) => open,
      q4(0) => LEDR(4),
      q4(15 downto 1) => open,
      q5(0) => LEDR(5),
      q5(15 downto 1) => open,
      q6(0) => LEDR(6),
      q6(15 downto 1) => open,
      q7(0) => LEDR(7),
      q6(15 downto 1) => open
      );
    LEDR(9 downto 8) <= (others => '0');
  end generate;

------------------
-- Mux
------------------

  --
  -- A     (in)  SW(3)
  -- B     (in)  SW(4)
  -- SEL   (in)  SW(0)
  -- q     (out) LED(0)
  --
  TestMUX2WAY: if TEST_MUX2WAY generate
    Umux2way : Mux2Way port map(
      sel   => SW(0),
      a     => SW(3),
      b     => SW(4),
      q     => LEDR(0)
    );
    LEDR(9 downto 1) <= (others => '0');
  end generate;

  --
  -- D,C,B,A (in)  SW(6..3)
  -- SEL     (in)  SW(1..0)
  -- q       (out) LED(0)
  --
  TestMUX4WAY: if TEST_MUX4WAY generate
    Umux4way : Mux4Way port map(
      sel   => SW(1 downto 0),
      a     => SW(3),
      b     => SW(4),
      c     => SW(5),
      d     => SW(6),
      q     => LEDR(0)
      );
    LEDR(9 downto 1) <= (others => '0');
  end generate;

  --
  -- h..,C,B,A (in)  SW(10..3)
  -- SEL     (in)  SW(2..0)
  -- q       (out) LED(0)
  --
  TestMUX8WAY: if TEST_MUX8WAY generate
    Umux8way : Mux8Way port map(
      sel   => SW(2 downto 0),
      a     => SW(3),
      b     => SW(4),
      c     => SW(5),
      d     => SW(6),
      e     => SW(7),
      f     => SW(8),
      g     => SW(9),
      h     => SW(10),
      q     => LEDR(0)
      );
    LEDR(9 downto 1) <= (others => '0');
  end generate;

  --
  --
  TestMUX4WAY16: if TEST_MUX4WAY16 generate
    Umux4way16 : Mux4Way16 port map(
      sel   => SW(1 downto 0),
      a(1  downto 0)  => SW(4 downto 2),
      a(15 downto 2)  => (others => '0'),
      b(1  downto 0)  => SW(5 downto 4),
      b(15 downto 2)  => (others => '0'),
      c(1  downto 0)  => SW(7 downto 6),
      c(15 downto 2)  => (others => '0'),
      d(1  downto 0)  => SW(9 downto 8),
      d(15 downto 2)  => (others => '0'),
      q(9  downto 0)  => LEDR(9 downto 0),
      q(15 downto 10) => open
      );
  end generate;

end architecture;
