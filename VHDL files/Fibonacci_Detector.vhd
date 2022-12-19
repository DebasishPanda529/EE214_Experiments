library ieee;
use ieee.std_logic_1164.all;
library work;
use work.Gates.all;

entity Fibonacci_Detector is
 port (A, B, C, D: in std_logic; OUTPUT: out std_logic);
end entity Fibonacci_Detector;

architecture Struct of Fibonacci_Detector is
 signal S0, S1, S2, S3, S4, S5, S6, S7, S8: std_logic;

for all: AND_2
use entity work.AND_2(Equations);

for all: OR_2
use entity work.OR_2(Equations);

for all: INVERTER
use entity work.INVERTER(Equations);
 
begin
  INV1: INVERTER port map (A => A, Y => S0);
  INV2: INVERTER port map (A => B, Y => S1);
  INV3: INVERTER port map (A => C, Y => S2);
  INV4: INVERTER port map (A => D, Y => S3);
  AND1: AND_2 port map (A => S0, B => S1, Y => S5);
  AND2: AND_2 port map (A => S1, B => S3, Y => S6);
  AND3: AND_2 port map (A => B, B => D, Y => S4);
  AND4: AND_2 port map (A => S2, B => S7, Y => S8);
  OR1: OR_2 port map (A => S6, B => S4, Y => S7);
  OR2: OR_2 port map (A => S5, B => S8, Y => OUTPUT);
end Struct;


