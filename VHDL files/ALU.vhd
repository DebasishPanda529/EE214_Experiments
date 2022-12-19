library ieee;
use ieee.std_logic_1164.all;

entity alu_beh is
 generic(
   operand_width : integer:=4);
 port (
   A: in std_logic_vector(operand_width-1 downto 0);
   B: in std_logic_vector(operand_width-1 downto 0);
   op: out std_logic_vector(operand_width+1 downto 0)) ;
end alu_beh;

architecture a1 of alu_beh is

 function add(A: in std_logic_vector(operand_width-1 downto 0);
  B: in std_logic_vector(operand_width-1 downto 0))
    return std_logic_vector is

    variable sum : std_logic_vector(operand_width-1 downto 0) := (others => '0');
	 variable carry : std_logic_vector(operand_width-1 downto 0) := (others => '0');
	 
   begin
     		for i in 0 to (operand_width-1) loop 
			if i=0 then
				sum(i) :=  A(i) xor B(i);
				carry(i) := A(i) and B(i) ;
			else
			   sum(i) :=  A(i) xor B(i) xor carry(i-1);
				carry(i) := (A(i) and B(i)) or (carry(i-1) and (A(i) xor B(i))) ;
			end if;
		end loop;
    
    return carry(operand_width-1) & sum; 
 end add;

begin
  alu : process(A, B)
  variable dummy : std_logic_vector(operand_width downto 0); 
  variable sum_1 : std_logic_vector(operand_width downto 0);
  variable carry_1: std_logic;
  variable carry_2: std_logic;
  variable temp: std_logic_vector(operand_width-1 downto 0);
  begin
  
		  
	  if A(3)='1' and B(3)='1' then
		   temp:=A xor B;
		  if temp="0000" then
			op<= "00"&A;
		  else
			op<="000000";
		  end if;
		
     elsif A(3)='0' and B(3)='0' then
		     if A > B then
			    op<= "00"&A;
		     elsif B > A then
			    op<= "00"&B;
			  else
			    op<= "000000";
		     end if;
		 
	  elsif A(3)='0' and B(3)='1' then
				op<= "00"&(A and B);

		
	  else
		    dummy := add(A, A);
			 sum_1 := add(dummy(3 downto 0),A); 
			 carry_1 := dummy(4) xor sum_1(4);
			 carry_2 := dummy(4) and sum_1(4);
	       op <= carry_2 & carry_1 & sum_1(3 downto 0);	
	  end if;	 
     

end process ; 
end a1 ; -- a1