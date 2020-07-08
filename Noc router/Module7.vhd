library ieee;
use ieee.std_logic_1164.all;

entity M7 is 
port(
reset,rclk,wclk,rreq,wreq: in std_logic;
datain : in std_logic_vector(7 downto 0); 
dataout : out std_logic_vector(7 downto 0);
full2,empty2: out std_logic);
end M7;

architecture behavioural of M7 is

-- M3
component block1 is
port ( clk_wr,clk_rd,write_enable,read_enable: IN std_logic;
Dinput: IN std_logic_vector ( 7 downto 0);
Doutput: OUT std_logic_vector ( 7 downto 0);
Address_write,Address_read: In std_logic_vector ( 2 downto 0):="000");
end component block1;


-- M6
component FIFO_CONTROLLER IS
PORT (reset,r_clk,w_clk,r_req,w_req: IN STD_LOGIC;
w_valid, r_valid, empty, full: OUT STD_LOGIC;
w_ptr, r_ptr: OUT STD_LOGIC_VECTOR (2 downto 0):="000");
END component FIFO_CONTROLLER;

signal wenable,renable: STD_LOGIC;
signal write_address,read_address: STD_LOGIC_VECTOR (2 downto 0):="000";

begin
-- port map
controller : FIFO_CONTROLLER port map(reset,rclk,wclk,rreq,wreq,wenable,renable,empty2,full2,write_address,read_address);
ram : block1 port map(wclk,rclk,wenable,renable,datain,dataout,write_address,read_address);

end behavioural;--