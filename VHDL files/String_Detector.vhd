library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity word_detection is
port(inp:in std_logic_vector(4 downto 0);
     reset,clock:in std_logic;
     outp: out std_logic);
end word_detection;

architecture bhv of word_detection is

---------------Define state type here-----------------------------
type state1 is (rst1,s1,s2,s3);
type state2 is (rst2,s4,s5);
type state3 is (rst3,s6,s7,s8);
---------------Define signals of state type-----------------------
signal y_present1,y_next1: state1:=rst1;
signal y_present2,y_next2: state2:=rst2;
signal y_present3,y_next3: state3:=rst3;
signal outp1, outp2, outp3: std_logic;

begin
clock_proc:process(clock,reset)
begin
    if(clock='1' and clock' event) then
          if(reset='1') then
                 y_present1<=rst1;
					  y_present2<=rst2;
					  y_present3<=rst3;
          else
                 y_present1<=y_next1;
					  y_present2<=y_next2;
					  y_present3<=y_next3;
          end if;
       end if;
end process;

state_transition_proc1:process(inp,y_present1)
begin
     case y_present1 is
           when rst1=>
                   if(unsigned(inp)=2) then --b has been detected
                           y_next1<=s1;
                   else
						         y_next1<=y_present1;
						 end if;
			 when s1=>
		             if(unsigned(inp)=15) then
					             y_next1<=s2;
						 else
						          y_next1<=y_present1;									 
						 end if;	 
			 when s2=>
		             if(unsigned(inp)=13) then
					             y_next1<=s3;
						 else
						          y_next1<=y_present1;									 
						 end if;							 
			 when s3=>
		             if(unsigned(inp)=2) then
					             y_next1<=rst1;
						 else
						          y_next1<=y_present1;		 
						 end if;						 
end case;
end process;


state_transition_proc2:process(inp,y_present2)
begin
     case y_present2 is
           when rst2=>
                   if(unsigned(inp)=7) then --g has been detected
                           y_next2<=s4;
                   else
						         y_next2<=y_present2;
						 end if;
			 when s4=>
		             if(unsigned(inp)=21) then
					             y_next2<=s5;
						 else
						          y_next2<=y_present2;					 
						 end if;	 
			 when s5=>
		             if(unsigned(inp)=14) then
					             y_next2<=rst2;
						 else
						          y_next2<=y_present2;									 
						 end if;							 					 
end case;
end process;					 
						 
						 
state_transition_proc3:process(inp,y_present3)
begin
     case y_present3 is
           when rst3=>
                   if(unsigned(inp)=18) then --r has been detected
                           y_next3<=s6;
                   else
						         y_next3<=y_present3;
						 end if;
			 when s6=>
		             if(unsigned(inp)=15) then
					             y_next3<=s7;
						 else
						          y_next3<=y_present3;					 
						 end if;	 
			 when s7=>
		             if(unsigned(inp)=1) then
					             y_next3<=s8;
            		 else
						          y_next3<=y_present3;									 
						 end if;							 
			 when s8=>
		             if(unsigned(inp)=13) then
					             y_next3<=rst3;
						 else
						          y_next3<=y_present3;	 
						 end if;							 
end case;
end process;

						 
output_proc1:process(y_present1, inp)
begin
    case y_present1 is
              when rst1=>
                     outp1<='0';
				  when s1=>
		               outp1<='0';
			     when s2=>
		               outp1<='0';
			     when s3=>
				      if(unsigned(inp)=2) then
		                outp1<='1';
						else
						    outp1<='0';
						end if;
end case;
end process;

output_proc2:process(y_present2, inp)
begin
    case y_present2 is
              when rst2=>
                     outp2<='0';
				  when s4=>
		               outp2<='0';
			     when s5=>
				      if(unsigned(inp)=14) then
		                outp2<='1';
						else
						    outp2<='0';
						end if;
end case;
end process;

output_proc3:process(y_present3, inp)
begin
    case y_present3 is
              when rst3=>
                     outp3<='0';
				  when s6=>
		               outp3<='0';	
				  when s7=>
		               outp3<='0';	
			     when s8=>
				      if(unsigned(inp)=13) then
		                outp3<='1';
						else
						    outp3<='0';
					   end if;
end case;
end process;			

outp<=outp1 or outp2 or outp3;  
end bhv;