LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
use ieee.std_logic_unsigned.all;

entity block1 is
port ( clk_wr,clk_rd,write_enable,read_enable: IN std_logic;
Dinput: IN std_logic_vector ( 7 downto 0);
Doutput: OUT std_logic_vector ( 7 downto 0);
Address_write,Address_read: In std_logic_vector ( 2 downto 0) :="000");
end entity block1;

Architecture Ram of block1 is
type store is array (7 downto 0 ) of std_logic_vector(7 downto 0);
Signal mem: store;
--SIGNAL address_write2,address_read2: INTEGER;
--Signal mem: STD_LOGIC_VECTOR(7 DOWNTO 0);
begin



--writing the data input in the memory of the write address
write_in_memory: PROCESS (clk_wr) IS
BEGIN
--if (rising_edge(clk_wr)) then
if (write_enable ='1') THEN
mem(to_integer(unsigned(address_write)))<=Dinput;
ELSE NULL;
END IF;
--end if;
END PROCESS write_in_memory;



--writing the data input in the memory of the write address
read_in_memory: PROCESS (clk_rd) IS
BEGIN
--if (rising_edge(clk_rd)) then
if (read_enable ='1') THEN
Doutput<=mem(to_integer(unsigned(address_read)));
ELSE NULL;
END IF;
--end if;
END PROCESS read_in_memory;

end architecture ram;