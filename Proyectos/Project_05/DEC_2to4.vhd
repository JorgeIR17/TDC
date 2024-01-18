----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 15.02.2023 12:45:36
-- Design Name: 
-- Module Name: DEC_2to4 - Behavioral
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

entity DEC_2to4 is
    Port ( A_i : in STD_LOGIC_VECTOR (1 downto 0);
           ENA_i : in STD_LOGIC;
           Z_o : out STD_LOGIC_VECTOR (3 downto 0));
end DEC_2to4;

architecture Behavioral of DEC_2to4 is

begin

    Z_o <= "0000" when ENA_i = '0' 
        else "0001" when A_i = "00" 
        else "0010" when A_i = "01" 
        else "0100" when A_i = "10" 
        else "1000" when A_i = "11"
        else "0000";
    
end Behavioral;
