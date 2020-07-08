LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
ENTITY Register_8_Bit IS
PORT(
bus_in: IN std_logic_vector (7 DOWNTO 0);
clk: IN std_logic;
reset: IN std_logic;
en: IN std_logic;
bus_out: OUT std_logic_vector (7 DOWNTO 0));
END ENTITY Register_8_Bit;
ARCHITECTURE Beh_8_Bit OF Register_8_Bit IS BEGIN

PROCESS(clk,reset) is BEGIN
IF reset = '1' THEN bus_out <= "00000000";
ELSIF rising_edge(clk) AND en='1' THEN bus_out <= bus_in;
ELSE NULL;	 
END IF; 
END PROCESS;

END ARCHITECTURE Beh_8_Bit;