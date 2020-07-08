library ieee;
use ieee.std_logic_1164.all;

entity R_R is
--generic(n: integer);


port(
clk: in std_logic;
din1: in std_logic_vector(7 downto 0);
din2: in std_logic_vector(7 downto 0);
din3: in std_logic_vector(7 downto 0);
din4: in std_logic_vector(7 downto 0);
dout: out std_logic_vector(7 downto 0);
rrd1: out std_logic := '0';
rrd2,rrd3,rrd4: out std_logic := '0');



end R_R;

architecture behavioural of R_R is


type state is(d0,d1,d2,d3,d4,d5,d6); 
signal currentstate : state:=d6;
--signal nextstate : state:=d0;
signal DO: std_logic_vector(7 downto 0); -- DO is data out

--signal counter : integer := 1;
--signal quant : integer :=2;
--variable t : 

begin
cs:process(clk)
begin
if rising_edge(clk) then
	
case currentstate is
	when d0 =>
	currentstate <= d1;

	when d1 =>
	currentstate <= d2;

	when d2 =>
	currentstate <= d3;

	when d3 =>
	currentstate <= d4; 

	when d4 =>
	currentstate <= d1;
	
	when d5 =>
	currentstate <= d0;

	when d6 =>
	currentstate <= d5;

	when others => null;
end case;
end if;
end process cs;


rs: process(clk,currentstate,din1,din2,din3,din4)
begin
if rising_edge(clk) then
case currentstate is
	when d0 =>
	rrd1 <= '1';rrd2 <= '0';rrd3 <= '0';rrd4 <= '0';

	when d1 =>
	dout <= din1 ;
	rrd1 <= '0';rrd2 <= '1';rrd3 <= '0';rrd4 <= '0';

	when d2 =>
	dout <= din2 ;
	rrd1 <= '0';rrd2 <= '0';rrd3 <= '1';rrd4 <= '0';

	when d3 =>
	dout <= din3 ; 
	rrd1 <= '0';rrd2 <= '0';rrd3 <= '0';rrd4 <= '1';

	when d4 =>
	dout <= din4 ;
	rrd1 <= '1';rrd2 <= '0';rrd3 <= '0';rrd4 <= '0';

	when others => null;
	
end case;
end if;
end process rs;

end behavioural;