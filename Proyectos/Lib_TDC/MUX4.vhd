----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 15.02.2023 13:35:30
-- Design Name: 
-- Module Name: MUX4 - Behavioral
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

entity MUX4 is
    generic(width: integer:=4); 
    Port ( A_i : in STD_LOGIC_VECTOR (width-1 downto 0);
           B_i : in STD_LOGIC_VECTOR (width-1 downto 0);
           C_i : in STD_LOGIC_VECTOR (width-1 downto 0);
           D_i : in STD_LOGIC_VECTOR (width-1 downto 0);
           SEL_i : in STD_LOGIC_VECTOR (1 downto 0);
           Z_o : out STD_LOGIC_VECTOR (width-1 downto 0));
end MUX4;

architecture Behavioral of MUX4 is

begin

    with SEL_i select
        Z_o <= A_i when "00",
               B_i when "01",
               C_i when "10",
               D_i when "11",
               "0000" when others;

end Behavioral;
