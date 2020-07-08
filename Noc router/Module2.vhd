LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY demux8 IS
	PORT( d_in: IN std_logic_vector (7 DOWNTO 0);
		En : IN std_logic ;
		Sel: IN std_logic_vector (1 DOWNTO 0);
		d_out1,d_out2,d_out3,d_out4 : OUT std_logic_vector (7 DOWNTO 0);
		wrr1,wrr2,wrr3,wrr4 : OUT std_logic);
END ENTITY demux8;

ARCHITECTURE behav OF demux8 IS BEGIN
	pdemux: PROCESS (En, Sel,d_in) IS BEGIN
		IF (En = '1') THEN
			CASE Sel IS
				WHEN "00" => d_out1 <= d_in ; 
					wrr1 <= '1'; wrr2 <= '0'; wrr3 <= '0'; wrr4 <= '0';
				WHEN "01" => d_out2 <= d_in ; 
					wrr1 <= '0'; wrr2 <= '1'; wrr3 <= '0'; wrr4 <= '0';
				WHEN "10" => d_out3 <= d_in ; 
					wrr1 <= '0'; wrr2 <= '0'; wrr3 <= '1'; wrr4 <= '0'; 
				WHEN "11" => d_out4 <= d_in ;
					wrr1 <= '0'; wrr2 <= '0'; wrr3 <= '0'; wrr4 <= '1';
				WHEN OTHERS => d_out1 <= "00000000" ; d_out2 <= "00000000" ; d_out3 <= "00000000" ; d_out4 <= "00000000" ;
			END CASE;
		ELSE
			NULL;			
		END IF;

	END PROCESS pdemux;
END ARCHITECTURE behav;