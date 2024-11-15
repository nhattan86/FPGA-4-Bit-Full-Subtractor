library ieee;
use ieee.std_logic_1164.all;
entity BIT4 is
 port (A,B: in std_logic_vector (3 downto 0);
		CIN: in std_logic;
		S: out std_logic_vector (3 downto 0);
		COUT: out std_logic);
end BIT4;
Architecture H of BIT4 is
component BIT1 is
  port (A,B,CIN: in std_logic;
		  S,COUT: out std_logic);
end component; 
  signal t1,t2,t3: std_logic;
 begin
  m1: BIT1 port map (A(0),B(0),CIN,S(0),t1);
  m2: BIT1 port map (A(1),B(1),t1,S(1),t2);
  m3: BIT1 port map (A(2),B(2),t2,S(2),t3);
  m4: BIT1 port map (A(3),B(3),t3,S(3),COUT);
end H;
    
library ieee;
use ieee.std_logic_1164.all;
entity BIT1 is
  port (A,B,CIN: in std_logic;
  		S,COUT: out std_logic);
end BIT1;
Architecture T of BIT1 is
begin
	S <= A XOR B XOR CIN;
	COUT <= (((not A) AND B) OR (B AND CIN) OR(CIN AND (not A)));
end T;
