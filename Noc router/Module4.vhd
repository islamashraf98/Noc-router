library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

ENTITY COUNTER IS
PORT (clk,enable,reset: IN std_logic;
count: OUT std_logic_vector(3 downto 0) := "0000");
END ENTITY COUNTER;

ARCHITECTURE behav OF COUNTER IS
SIGNAL temp: std_logic_vector(3 downto 0):="0000";

BEGIN
p1: PROCESS (reset,enable,clk) IS
BEGIN



IF (reset='1') THEN
temp<="0000";

ELSIF (rising_edge(clk) AND enable='1') THEN
temp<=temp+1;

ELSE NULL;
END IF;

END PROCESS p1;

count(3)<=temp(3);
count(2)<=temp(3) XOR temp(2);
count(1)<=temp(2) XOR temp(1);
count(0)<=temp(1) XOR temp(0);

END ARCHITECTURE behav;