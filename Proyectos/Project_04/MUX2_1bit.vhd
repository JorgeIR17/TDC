
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity MUX2_1bit is
    Port ( A_i : in STD_LOGIC;
           B_i : in STD_LOGIC;
           SEL_i : in STD_LOGIC;
           Y_o : out STD_LOGIC);
end MUX2_1bit ;

architecture behavioral of MUX2_1bit is
begin
-- Multiplexer description by means of
-- a conditional concurrent assignment statement

    Y_o <= A_i when SEL_i = '0' else B_i;

end behavioral ;