library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

ENTITY FIFO_CONTROLLER IS
PORT (reset,r_clk,w_clk,r_req,w_req: IN STD_LOGIC;
w_valid, r_valid, empty, full: OUT STD_LOGIC;
w_ptr, r_ptr: OUT STD_LOGIC_VECTOR (2 downto 0):="000");
END ENTITY FIFO_CONTROLLER;


ARCHITECTURE beha OF FIFO_CONTROLLER IS

signal empty2,w_valid2: STD_LOGIC:='1';
signal full2,r_valid2: STD_LOGIC:='0';

--For Components
--For the read
SIGNAL enable_read_counter,reset_read_counter,clk_read_counter: STD_LOGIC;
SIGNAL binary_read,count_read: STD_LOGIC_VECTOR(3 downto 0):= "0000";

--For the write
SIGNAL enable_write_counter,reset_write_counter,clk_write_counter: STD_LOGIC;
SIGNAL binary_write,count_write: STD_LOGIC_VECTOR(3 downto 0):="0000";

--Counter and converter decleration
COMPONENT COUNTER
PORT (clk,enable,reset: IN std_logic;
count: OUT std_logic_vector(3 downto 0));
END COMPONENT;

COMPONENT grayconverter
port( gray : IN std_logic_vector (3 downto 0);
 Binary : out std_logic_vector (3 downto 0 ) );
END COMPONENT;

BEGIN

--Creating 2 instances of counter and converter for the 2 operations (read/write)
read_count: COUNTER PORT MAP (clk_read_counter,r_valid2,reset_read_counter,count_read);
read_covert: grayconverter PORT MAP (count_read,binary_read);

write_count: COUNTER PORT MAP (clk_write_counter,w_valid2,reset_write_counter,count_write);
write_covert: grayconverter PORT MAP (count_write,binary_write);

--detect clock and reset for the controller
p1: PROCESS (r_clk,w_clk,reset,binary_read,binary_write) IS
BEGIN

clk_read_counter<=r_clk;
clk_write_counter<=w_clk;
r_ptr <= binary_read (2 downto 0);	
w_ptr <= binary_write(2 downto 0);

--IF (r_clk='1' AND r_valid2 = '1') THEN
--enable_read_counter<='1';
--ELSE enable_read_counter<='0';
--END IF;

--IF (w_clk='1' AND w_valid2 = '1') THEN
--enable_write_counter<='1';
--ELSE enable_write_counter<='0';
--END IF;

IF reset='1' THEN
w_ptr <= "000";
r_ptr <= "000";
reset_read_counter<='1';
reset_write_counter<='1';
ELSE
reset_read_counter<='0';
reset_write_counter<='0';
END IF;

END PROCESS p1;


validity: PROCESS (r_req,w_req,empty2,full2) IS
BEGIN

IF (empty2 = '1') THEN
r_valid2<='0'; r_valid <= '0';
ELSIF (r_req = '1') THEN
r_valid2<='1'; r_valid <= '1';
ELSE r_valid2 <= '0'; r_valid <='0';
END IF;

IF (full2 = '1') THEN
w_valid2<='0'; w_valid <= '0';
ELSIF (w_req = '1') THEN
w_valid2<='1'; w_valid <= '1';
ELSE w_valid2 <= '0'; w_valid <='0';
END IF;

END PROCESS validity;



empty_full_detect: PROCESS(count_write,count_read) IS
BEGIN
IF ( count_write(3) /= count_read(3) AND count_write(2) /= count_read(2) AND count_write(1) = count_read(1) AND count_write(0) = count_read(0) ) THEN
full2<='1';full <= '1';
empty2 <= '0'; empty<='0';

ELSIF (count_read = count_write) THEN
empty2 <= '1'; empty<='1';
full2<='0';full <= '0';

ELSE
full2<='0'; full<='0'; 
empty2<='0'; empty<='0'; 
END IF;
END PROCESS empty_full_detect;


END ARCHITECTURE beha;