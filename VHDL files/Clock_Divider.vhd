library ieee;
use ieee.std_logic_1164.all;

entity clock_divider is
port(clk_out : out std_logic;
		clk_50, resetn : in std_logic);
end entity clock_divider;

architecture Struct of clock_divider is 

 signal i: integer := 0;
 signal outp: std_logic := '1';
 
begin
clock_proc: process(clk_50, i, resetn)
begin
		if(resetn='1') then
			i <= 0;
			outp <= '0';
		elsif(clk_50='1' and clk_50'event) then
			if(i=5e7) then
				outp <= not outp;
				i <= 0;
			else
				i <= i+1;
			end if;
		end if;
end process;

clk_out <= outp;

end Struct;