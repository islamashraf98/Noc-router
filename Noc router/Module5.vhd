library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity grayconverter IS
port( gray : IN std_logic_vector (3 downto 0);
 Binary : out std_logic_vector (3 downto 0 ) );
End entity grayconverter;

ARCHITECTURE conv OF grayconverter IS
--Signal bin_var: std_logic_vector (3 downto 0);
BEGIN
p1: process (gray) is
begin
--bin_var(3) <= gray (3);
--bin_var(2) <= bin_var(3) xor gray(2); 
--bin_var(1) <= bin_var(2) xor gray(1);
--bin_var(0) <= bin_var(1) xor gray(0);
binary(3) <= gray (3);
binary(2) <= gray(3) xor gray(2);
binary(1) <= gray (3) xor gray(2) xor gray(1);
binary(0) <= gray (3) xor gray(2) xor gray(1) xor gray(0);
--binary<= bin_var;
End process p1;
End ARCHITECTURE conv;