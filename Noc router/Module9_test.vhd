LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

entity module9_test is 
end entity; 

architecture arch_test of module9_test is

Component router is 
port ( datai1,datai2,datai3,datai4: in std_logic_vector (7 downto 0);
	wr1,wr2,wr3,wr4: in std_logic;
	wclk,rclk,rst:in std_logic;
	datao1,datao2,datao3,datao4:out std_logic_vector (7 downto 0));
end component ;

signal datai1,datai2,datai3,datai4: std_logic_vector (7 downto 0);
signal wr1,wr2,wr3,wr4: std_logic;
signal wclk,rclk,rst: std_logic;
signal datao1,datao2,datao3,datao4: std_logic_vector (7 downto 0);

begin 

test_router : router port map (datai1,datai2,datai3,datai4,wr1,wr2,wr3,wr4,wclk,rclk,rst,datao1,datao2,datao3,datao4);

process
begin 

wr1<='0';wr2<='0';wr3<='0';wr4<='0';
wclk<='0';rclk<='0';rst<='0';datai1<="11001111";Datai2<="00001100";datai3<="00111100";datai4<="01000100";
wait for 50 ns;

wr1<='1';wr2<='1';wr3<='1';wr4<='1';
wclk<='1';rclk<='1';
wait for 50 ns;

datai1<="00110001";datai2<="11110001";datai3<="11000001";datai4<="00111101";
wclk<='0';rclk<='0';rst<='0';
wait for 50 ns;

wclk<='1';rclk<='1';
wait for 50 ns;

Datai1<="00110010";Datai2<="11110010";Datai3<="11000010";Datai4<="00111110";
wclk<='0';rclk<='0';rst<='0';
wait for 50 ns;

wclk<='1';rclk<='1';
wait for 50 ns;

Datai1<="00110000";Datai2<="11110011";Datai3<="11000011";Datai4<="00111111";
wclk<='0';rclk<='0';rst<='0';
wait for 50 ns;

wclk<='1';rclk<='1';
wait for 50 ns;

datai1<="00110000";datai2<="00110000";datai3<="00110000";datai4<="00110000";
wclk<='0';rclk<='0';
wait for 50 ns;

wclk<='1';rclk<='1';
wait for 50 ns;

datai1<="11111101";datai2<="11111101";datai3<="11111101";datai4<="11111101";
wclk<='0';rclk<='0';
wait for 50 ns;

wclk<='1';rclk<='1';
wait for 50 ns;

end process ;
end architecture; 




