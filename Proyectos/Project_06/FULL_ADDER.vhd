----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 15.02.2023 13:18:58
-- Design Name: 
-- Module Name: FULL_ADDER - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity FULL_ADDER is
    Port ( A_i : in STD_LOGIC;
           B_i : in STD_LOGIC;
           CARRY_i : in STD_LOGIC;
           CARRY_o : out STD_LOGIC;
           SUM_o : out STD_LOGIC);
end FULL_ADDER;

architecture Behavioral of FULL_ADDER is

begin

    SUM_o <= (A_i xor B_i) xor CARRY_i;
    CARRY_o <= (A_i and B_i) or (A_i and CARRY_i) or (B_i and CARRY_i);

end Behavioral;
