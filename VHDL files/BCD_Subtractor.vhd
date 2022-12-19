library ieee;
use ieee.std_logic_1164.all;

library work;
use work.Gates.all;

entity HA is 
 port (A, B: in std_logic; S, C: out std_logic);
end entity HA;

architecture Simple of HA is 
signal T: std_logic;
	
	for all: XOR_2
	use entity work.XOR_2(Equations);
	
begin
 XOR1: XOR_2 port map (A => A, B => B, Y => S);
 NAND1: NAND_2 port map (A => A, B => B, Y => T);
 NAND2: NAND_2 port map (A => T, B => T, Y => C);
end Simple;

-----------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

library Work;
use work.Gates.all;

entity FA is
 port (A, B, C1: in std_logic; Sum, C2: out std_logic);
end entity FA;

architecture Easy of FA is
signal T1, T2, T3: std_logic;

   component HA is
	port (A, B: in std_logic; S, C: out std_logic);
	end component HA;

   for all: HA
   use entity work.HA(Simple);
	 	
	for all: OR_2
	use entity work.OR_2(Equations);
	
begin
 HA1: HA port map (A => A, B => B, S => T1, C => T2);
 HA2: HA port map (A => T1, B => C1, S => Sum, C => T3);
 OR1: OR_2 port map (A => T3, B => T2, Y => C2);
end Easy;  

----------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

library Work;
use work.Gates.all;

entity Ripple_Adder is
 port(A3, A2, A1, A0, B3, B2, B1, B0, M: in std_logic; S3, S2, S1, S0, Cout: out std_logic);
end entity Ripple_Adder;

architecture Complex of Ripple_Adder is
signal P2, P1, P0, Q3, Q2, Q1, Q0: std_logic;

   component FA is
	port (A, B, C1: in std_logic; Sum, C2: out std_logic);
	end component FA;

   for all: FA
	use entity work.FA(Easy);
	
	for all: XOR_2
	use entity work.XOR_2(Equations);
	
begin
 FA1: FA port map (A => A0, B => Q0, C1 => M, Sum => S0, C2 => P0);
 FA2: FA port map (A => A1, B => Q1, C1 => P0, Sum => S1, C2 => P1);
 FA3: FA port map (A => A2, B => Q2, C1 => P1, Sum => S2, C2 => P2);
 FA4: FA port map (A => A3, B => Q3, C1 => P2, Sum => S3, C2 => Cout);
 XOR1: XOR_2 port map(A => M, B => B0, Y => Q0);
 XOR2: XOR_2 port map(A => M, B => B1, Y => Q1);
 XOR3: XOR_2 port map(A => M, B => B2, Y => Q2);
 XOR4: XOR_2 port map(A => M, B => B3, Y => Q3);
end Complex;
 
--------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

library Work;
use work.Gates.all;

entity BCD_Subtractor is 
 port(A3, A2, A1, A0, B3, B2, B1, B0: in std_logic; Y4, Y3, Y2, Y1, Y0: out std_logic);
end entity BCD_Subtractor;

architecture Devil of BCD_Subtractor is
signal S3, S2, S1, S0, P3, P2, P1, P0, U3, U2, U1, U0, R1, R2, Q, S, T, Cout1, Cout2, Cout3, Cout4: std_logic;  

 component Ripple_Adder is 
 port (A3, A2, A1, A0, B3, B2, B1, B0, M: in std_logic; S3, S2, S1, S0, Cout: out std_logic);
 end component Ripple_Adder;
 
 for all: Ripple_Adder
 use entity work.Ripple_Adder;

 for all: OR_2
 use entity work.OR_2(Equations); 
 
 for all: AND_2
 use entity work.AND_2(Equations);
 
 for all: INVERTER
 use entity work.INVERTER(Equations);
 
 for all: XOR_2
 use entity work.XOR_2(Equations);
 
begin 
 RA1: Ripple_Adder port map (A3 =>'1', A2 => '0', A1 => '1', A0 => '0', B3 => B3, B2 => B2, B1 => B1, B0 => B0, M => '1', S3 => S3, S2 => S2, S1 => S1, S0 => S0, Cout => Cout1);
 RA2: Ripple_Adder port map (A3 => A3, A2 => A2, A1 => A1, A0 => A0, B3 => S3, B2 => S2, B1 => S1, B0 => S0, M => '0', S3 => P3, S2 => P2, S1 => P1, S0 => P0, Cout => Cout2);
 RA3: Ripple_Adder port map (A3 => '0', A2 => Q, A1 => Q, A0 => '0', B3 => P3, B2 => P2, B1 => P1, B0 => P0, M => '0', S3 => U3, S2 => U2, S1 => U1, S0 => U0, Cout => Cout3);
 RA4: Ripple_Adder port map (A3 => T, A2 => '0', A1 => T, A0 => '0', B3 => U3, B2 => U2, B1 => U1, B0 => U0, M => T, S3 => Y3, S2 => Y2, S1 => Y1, S0 => Y0, Cout => Cout4);
 AND1: AND_2 port map (A => P3, B => P2, Y => R1);
 AND2: AND_2 port map (A => P1, B => P3, Y => R2);
 OR1: OR_2 port map (A => R1, B => R2, Y => S);
 OR2: OR_2 port map (A => S, B => Cout2, Y => Q);
 INV1: INVERTER port map (A => Q, Y => T);
 Y4 <= T;
end Devil;