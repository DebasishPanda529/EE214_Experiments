library ieee;
use ieee.std_logic_1164.all;

library Work;
use work.Gates.all;

entity XOR_GATE is
 port (A, B: in std_logic; OUTPUT: out std_logic);
end entity XOR_GATE;

architecture Pussy of XOR_GATE is
 signal S1, S2, S3: std_logic;
 
 for all: NAND_2
  use entity  work.NAND_2(Equations);
	
begin
 NAND1: NAND_2 port map (A => A, B => B, Y => S1);
 NAND2: NAND_2 port map (A => A, B => S1, Y => S2); 
 NAND3: NAND_2 port map (A => S1, B => B, Y => S3);
 NAND4: NAND_2 port map (A => S2, B => S3, Y => OUTPUT);
end Pussy;


---------------------------------------------------------------------------


library ieee;
use ieee.std_logic_1164.all;
library work;
use work.Gates.all;

entity OR_GATE  is
  port (A, B: in std_logic; OUTPUT: out std_logic);
end entity OR_GATE;

architecture Struct of OR_GATE is
  signal A_BAR, B_BAR : std_logic;
  
  for all: NAND_2
   use entity work.NAND_2(Equations);
	
begin
  NAND1: NAND_2 port map (A => A, B => A, Y => A_BAR);
  NAND2: NAND_2 port map (A => B, B => B, Y => B_BAR);
  NAND3: NAND_2 port map (A => A_BAR, B => B_BAR, Y => OUTPUT);
end Struct;


---------------------------------------------------------------------------


library ieee;
use ieee.std_logic_1164.all;

library Work;
use work.Gates.all;

entity HA is 
 port (A, B: in std_logic; S, C: out std_logic);
end entity HA;

architecture Cunt of HA is 

signal T: std_logic;
	
	component XOR_GATE is
	 port (A, B: in std_logic; OUTPUT: out std_logic);
	end component XOR_GATE;
	
	for all: XOR_GATE
	 use entity work.XOR_GATE(Pussy);
	
begin
 XOR_HA: XOR_GATE port map (A => A, B => B, OUTPUT => S);
 NAND1: NAND_2 port map (A => A, B => B, Y => T);
 NAND2: NAND_2 port map (A => T, B => T, Y => C);
end Cunt;


-----------------------------------------------------------------------------


library ieee;
use ieee.std_logic_1164.all;

library Work;
use work.Gates.all;

entity FA is
 port (A, B, C1: in std_logic; Sum, C2: out std_logic);
end entity FA;

architecture Titty of FA is

signal T1, T2, T3: std_logic;

   component HA is
    port (A, B: in std_logic; S, C: out std_logic);
   end component HA;

   for all: HA
    use entity work.HA(Cunt);
	 
	component OR_GATE is
	 port (A, B: in std_logic; OUTPUT: out std_logic);
	end component OR_GATE;
	
	for all: OR_GATE
	 use entity work.OR_GATE(Struct);
	
begin
 HA_1: HA port map (A => A, B => B, S => T1, C => T2);
 HA_2: HA port map (A => T1, B => C1, S => Sum, C => T3);
 OR_1: OR_GATE port map (A => T3, B => T2, OUTPUT => C2);
end Titty;  



 