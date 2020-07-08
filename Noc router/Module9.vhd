LIBRARY ieee;
USE ieee.std_logic_1164.ALL;


entity router is 
port ( datai1,datai2,datai3,datai4: in std_logic_vector (7 downto 0);
	wr1,wr2,wr3,wr4: in std_logic;
	wclk,rclk,rst:in std_logic;
	datao1,datao2,datao3,datao4:out std_logic_vector (7 downto 0));
end entity ;

architecture beh_router of router is 

Component Register_8_Bit IS
PORT(
bus_in: IN std_logic_vector (7 DOWNTO 0);
clk: IN std_logic;
reset: IN std_logic;
en: IN std_logic;
bus_out: OUT std_logic_vector (7 DOWNTO 0));
END Component Register_8_Bit;

Component demux8 IS
	PORT( d_in: IN std_logic_vector (7 DOWNTO 0);
		En : IN std_logic ;
		Sel: IN std_logic_vector (1 DOWNTO 0);
		d_out1,d_out2,d_out3,d_out4 : OUT std_logic_vector (7 DOWNTO 0);
		wrr1,wrr2,wrr3,wrr4 : OUT std_logic);
END Component demux8;

Component M7 is 
port(
reset,rclk,wclk,rreq,wreq: in std_logic;
datain : in std_logic_vector(7 downto 0); 
dataout : out std_logic_vector(7 downto 0);
full2,empty2: out std_logic);
end Component M7;

Component R_R is
port(
clk: in std_logic;
din1: in std_logic_vector(7 downto 0);
din2: in std_logic_vector(7 downto 0);
din3: in std_logic_vector(7 downto 0);
din4: in std_logic_vector(7 downto 0);
dout: out std_logic_vector(7 downto 0);
rrd1,rrd2,rrd3,rrd4: out std_logic);
end Component R_R;

signal temp_out_register1 : std_logic_vector (7 downto 0);
signal temp_demux_out11,temp_demux_out12,temp_demux_out13,temp_demux_out14 : std_logic_vector (7 DOWNTO 0);
signal wrr11,wrr12,wrr13,wrr14 : std_logic;
signal temp_out_m7_11,temp_out_m7_12,temp_out_m7_13,temp_out_m7_14 : std_logic_vector (7 downto 0);
signal full_11,empty_11,full_12,empty_12,full_13,empty_13,full_14,empty_14 : std_logic;
signal rrd11,rrd12,rrd13,rrd14 : std_logic;

signal temp_out_register2 : std_logic_vector (7 downto 0);
signal temp_demux_out21,temp_demux_out22,temp_demux_out23,temp_demux_out24 : std_logic_vector (7 DOWNTO 0);
signal wrr21,wrr22,wrr23,wrr24 : std_logic;
signal temp_out_m7_21,temp_out_m7_22,temp_out_m7_23,temp_out_m7_24 : std_logic_vector (7 downto 0);
signal full_21,empty_21,full_22,empty_22,full_23,empty_23,full_24,empty_24 : std_logic;
signal rrd21,rrd22,rrd23,rrd24 : std_logic;

signal temp_out_register3 : std_logic_vector (7 downto 0);
signal temp_demux_out31,temp_demux_out32,temp_demux_out33,temp_demux_out34 : std_logic_vector (7 DOWNTO 0);
signal wrr31,wrr32,wrr33,wrr34 : std_logic;
signal temp_out_m7_31,temp_out_m7_32,temp_out_m7_33,temp_out_m7_34 : std_logic_vector (7 downto 0);
signal full_31,empty_31,full_32,empty_32,full_33,empty_33,full_34,empty_34 : std_logic;
signal rrd31,rrd32,rrd33,rrd34 : std_logic;

signal temp_out_register4 : std_logic_vector (7 downto 0);
signal temp_demux_out41,temp_demux_out42,temp_demux_out43,temp_demux_out44 : std_logic_vector (7 DOWNTO 0);
signal wrr41,wrr42,wrr43,wrr44 : std_logic;
signal temp_out_m7_41,temp_out_m7_42,temp_out_m7_43,temp_out_m7_44 : std_logic_vector (7 downto 0);
signal full_41,empty_41,full_42,empty_42,full_43,empty_43,full_44,empty_44 : std_logic;
signal rrd41,rrd42,rrd43,rrd44 : std_logic;

begin 
--registers 
register1 : Register_8_Bit port map (datai1,wclk,rst,wr1,temp_out_register1);
register2 : Register_8_Bit port map (datai2,wclk,rst,wr2,temp_out_register2);
register3 : Register_8_Bit port map (datai3,wclk,rst,wr1,temp_out_register3);
register4 : Register_8_Bit port map (datai4,wclk,rst,wr4,temp_out_register4);
--demuxs
demux1 : demux8 port map (temp_out_register1,wr1,temp_out_register1(1 downto 0),temp_demux_out11,temp_demux_out12,temp_demux_out13,temp_demux_out14,wrr11,wrr12,wrr13,wrr14);
demux2 : demux8 port map (temp_out_register2,wr2,temp_out_register2(1 downto 0),temp_demux_out21,temp_demux_out22,temp_demux_out23,temp_demux_out24,wrr21,wrr22,wrr23,wrr24);
demux3 : demux8 port map (temp_out_register3,wr3,temp_out_register3(1 downto 0),temp_demux_out31,temp_demux_out32,temp_demux_out33,temp_demux_out34,wrr31,wrr32,wrr33,wrr34);
demux4 : demux8 port map (temp_out_register4,wr4,temp_out_register4(1 downto 0),temp_demux_out41,temp_demux_out42,temp_demux_out43,temp_demux_out44,wrr41,wrr42,wrr43,wrr44);
--fifos
m7_11 : M7 port map (rst,rclk,wclk,rrd11,wrr11,temp_demux_out11,temp_out_m7_11,full_11,empty_11);
m7_12 : M7 port map (rst,rclk,wclk,rrd12,wrr12,temp_demux_out12,temp_out_m7_12,full_12,empty_12);
m7_13 : M7 port map (rst,rclk,wclk,rrd13,wrr13,temp_demux_out13,temp_out_m7_13,full_13,empty_13);
m7_14 : M7 port map (rst,rclk,wclk,rrd14,wrr14,temp_demux_out14,temp_out_m7_14,full_14,empty_14);

m7_21 : M7 port map (rst,rclk,wclk,rrd21,wrr21,temp_demux_out21,temp_out_m7_21,full_21,empty_21);
m7_22 : M7 port map (rst,rclk,wclk,rrd22,wrr22,temp_demux_out22,temp_out_m7_22,full_22,empty_22);
m7_23 : M7 port map (rst,rclk,wclk,rrd23,wrr23,temp_demux_out23,temp_out_m7_23,full_23,empty_23);
m7_24 : M7 port map (rst,rclk,wclk,rrd24,wrr24,temp_demux_out24,temp_out_m7_24,full_24,empty_24);

m7_31 : M7 port map (rst,rclk,wclk,rrd31,wrr31,temp_demux_out31,temp_out_m7_31,full_31,empty_31);
m7_32 : M7 port map (rst,rclk,wclk,rrd32,wrr32,temp_demux_out32,temp_out_m7_32,full_32,empty_32);
m7_33 : M7 port map (rst,rclk,wclk,rrd33,wrr33,temp_demux_out33,temp_out_m7_33,full_33,empty_33);
m7_34 : M7 port map (rst,rclk,wclk,rrd34,wrr34,temp_demux_out34,temp_out_m7_34,full_34,empty_34);

m7_41 : M7 port map (rst,rclk,wclk,rrd41,wrr41,temp_demux_out41,temp_out_m7_41,full_41,empty_41);
m7_42 : M7 port map (rst,rclk,wclk,rrd42,wrr42,temp_demux_out42,temp_out_m7_42,full_42,empty_42);
m7_43 : M7 port map (rst,rclk,wclk,rrd43,wrr43,temp_demux_out43,temp_out_m7_43,full_43,empty_43);
m7_44 : M7 port map (rst,rclk,wclk,rrd44,wrr44,temp_demux_out44,temp_out_m7_44,full_44,empty_44);
--schedulers
R_R_1 : R_R port map (rclk,temp_out_m7_11,temp_out_m7_21,temp_out_m7_31,temp_out_m7_41,datao1,rrd11,rrd12,rrd13,rrd14);
R_R_2 : R_R port map (rclk,temp_out_m7_12,temp_out_m7_22,temp_out_m7_32,temp_out_m7_42,datao2,rrd21,rrd22,rrd23,rrd24);
R_R_3 : R_R port map (rclk,temp_out_m7_13,temp_out_m7_23,temp_out_m7_33,temp_out_m7_43,datao3,rrd31,rrd32,rrd33,rrd34);
R_R_4 : R_R port map (rclk,temp_out_m7_14,temp_out_m7_24,temp_out_m7_34,temp_out_m7_44,datao4,rrd41,rrd42,rrd43,rrd44);



end architecture;





