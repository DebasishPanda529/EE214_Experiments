library ieee;
use ieee.std_logic_1164.all;

library work;
use work.Gates.all;

entity XNOR_GATE is 
 port (A, B: in std_logic; OUTPUT: out std_logic);
end entity XNOR_GATE;

architecture Unique of XNOR_GATE is
 signal S1, S2, S3, S4: std_logic;

for all: NAND_2
use entity work.NAND_2(Equations);

begin
 NAND1: NAND_2 port map (A => A, B => B, Y => S1);
 NAND2: NAND_2 port map (A => A, B => S1, Y => S2);
 NAND3: NAND_2 port map (A => S1, B => B, Y => S3);
 NAND4: NAND_2 port map (A => S2, B => S3, Y => OUTPUT);
 --NAND5: NAND_2 port map (A => S4, B => S4, Y => OUTPUT);
end Unique;

------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
library work;
use work.Gates.all;

entity NOR_GATE is
 port (A, B: in std_logic; OUTPUT: out std_logic);
end entity NOR_GATE;

architecture Struct of NOR_GATE is
 signal A_BAR, B_BAR, S : std_logic;

for all: NAND_2
use entity work.NAND_2(Equations);  
 
begin
  NAND1: NAND_2 port map (A => A, B => A, Y => A_BAR);
  NAND2: NAND_2 port map (A => B, B => B, Y => B_BAR);
  NAND3: NAND_2 port map (A => A_BAR, B => B_BAR, Y => OUTPUT);
  --NAND4: NAND_2 port map (A => S, B => S, Y => OUTPUT); 
end Struct;

-------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
library work;
use work.Gates.all;

entity Half_Borrow is
 port (A, B: in std_logic; P: out std_logic);
end entity Half_Borrow;

architecture Easy of Half_Borrow is

signal A1, A2: std_logic;

for all: NAND_2
use entity work.NAND_2(Equations);

begin
 NAND1: NAND_2 port map (A => A, B => B, Y => A1);
 NAND2: NAND_2 port map (A => A1, B => B, Y => A2);
 NAND3: NAND_2 port map (A => A2, B => A2, Y => P);
end Easy;

-------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
library work;
use work.Gates.all;

entity HS is
 port (A, B: in std_logic; T, C1: out std_logic);
end entity HS;

architecture Simple of HS is
 
component XNOR_GATE is
 port (A, B: in std_logic; OUTPUT: out std_logic);
end component XNOR_GATE;

component Half_Borrow is
 port (A, B: in std_logic; P: out std_logic);
end component Half_Borrow;
 
for all: XNOR_GATE
use entity work.XNOR_GATE(Unique);

for all: Half_Borrow
use entity work.Half_Borrow(Easy);

begin
  XNOR1: XNOR_GATE port map (A => A, B => B, OUTPUT => T);
  Half_Borrow1: Half_Borrow port map (A => A, B => B, P => C1);
end Simple;

-------------------------------------------------------------------- 

library ieee;
use ieee.std_logic_1164.all;
library work;
use work.Gates.all;

entity FS is 
 port (A, B, C_i: in std_logic; S, C:out std_logic);
end entity FS;

architecture Complex of FS is

signal S1, S2, S3: std_logic;

component HS is
 port (A, B: in std_logic; T, C1: out std_logic);
end component HS;

component NOR_GATE is
 port (A, B: in std_logic; OUTPUT: out std_logic);
end component NOR_GATE;

for all: HS
use entity work.HS(Simple);

for all: NOR_GATE
use entity work.NOR_GATE(Struct);

begin
 HS1: HS port map (A => A, B => B, T => S1, C1 => S2);
 HS2: HS port map (A => S1, B => C_i, T => S, C1 => S3);
 NOR1: NOR_GATE port map (A => S2, B => S3, OUTPUT => C);
end Complex;
  


