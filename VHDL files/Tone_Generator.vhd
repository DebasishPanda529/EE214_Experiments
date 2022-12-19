library ieee;
use ieee.std_logic_1164.all;

entity tone_generator is
port(clk_out : out std_logic;
     led : out std_logic_vector(7 downto 0);
	  switch : in std_logic_vector(7 downto 0);
	  clk_50 : in std_logic);
end entity tone_generator;

architecture Struct of tone_generator is 

 signal i0, i1, i2, i3, i4, i5, i6, i7: integer := 0;
 signal outp: std_logic_vector(7 downto 0) := "11111111";
 signal clock: std_logic_vector(7 downto 0) := "11111111";
 
begin
clock_proc0: process(clk_50)
begin
		if(clk_50='1' and clk_50'event) then
			if(i0=104168) then
				outp(0) <= not outp(0);
				i0 <= 1;
			else
				i0 <= i0+1;
			end if;
		end if;
clock(0) <= outp(0);		
end process;


clock_proc1: process(clk_50)
begin
		if(clk_50='1' and clk_50'event) then
			if(i1=92593) then
				outp(1) <= not outp(1);
				i1 <= 1;
			else
				i1 <= i1+1;
			end if;
		end if;
clock(1) <= outp(1);		
end process;


clock_proc2: process(clk_50)
begin
		if(clk_50='1' and clk_50'event) then
			if(i2=83333) then
				outp(2) <= not outp(2);
				i2 <= 1;
			else
				i2 <= i2+1;
			end if;
		end if;
clock(2) <= outp(2);		
end process;


clock_proc3: process(clk_50)
begin
		if(clk_50='1' and clk_50'event) then
			if(i3=78125) then
				outp(3) <= not outp(3);
				i3 <= 1;
			else
				i3 <= i3+1;
			end if;
		end if;
clock(3) <= outp(3);		
end process;


clock_proc4: process(clk_50)
begin
		if(clk_50='1' and clk_50'event) then
			if(i4=69444) then
				outp(4) <= not outp(4);
				i4 <= 1;
			else
				i4 <= i4+1;
			end if;
		end if;
clock(4) <= outp(4);		
end process;


clock_proc5: process(clk_50)
begin
		if(clk_50='1' and clk_50'event) then
			if(i5=62500) then
				outp(5) <= not outp(5);
				i5 <= 1;
			else
				i5 <= i5+1;
			end if;
		end if;
clock(5) <= outp(5);		
end process;


clock_proc6: process(clk_50)
begin
		if(clk_50='1' and clk_50'event) then
			if(i6=55556) then
				outp(6) <= not outp(6);
				i6 <= 1;
			else
				i6 <= i6+1;
			end if;
		end if;
clock(6) <= outp(6);		
end process;


clock_proc7: process(clk_50)
begin
		if(clk_50='1' and clk_50'event) then
			if(i7=52083) then
				outp(7) <= not outp(7);
				i7 <= 1;
			else
				i7 <= i7+1;
			end if;
		end if;
clock(7) <= outp(7);		
end process;


final: process(switch)
begin
if switch = "00000001" then
 clk_out <= clock(0);
 led <= "00000001"; 
elsif switch = "00000011" then
 clk_out <= clock(1);
 led <= "00000010"; 
elsif switch = "00000111" then
 clk_out <= clock(2);
 led <= "00000100"; 
elsif switch = "00001111" then
 clk_out <= clock(3);
 led <= "00001000"; 
elsif switch = "00011111" then
 clk_out <= clock(4);
 led <= "00010000"; 
elsif switch = "00111111" then
 clk_out <= clock(5);
 led <= "00100000"; 
elsif switch = "01111111" then
 clk_out <= clock(6);
 led <= "01000000"; 
elsif switch = "11111111" then
 clk_out <= clock(7);
 led <= "10000000"; 
end if;
end process;


end Struct;