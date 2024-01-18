----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08.02.2023 12:53:43
-- Design Name: 
-- Module Name: NOR_GATE - Behavioral
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

entity NOR_GATE is
    Port ( A_i : in STD_LOGIC_VECTOR (1 downto 0);
           B_i : in STD_LOGIC_VECTOR (1 downto 0);
           Z_o : out STD_LOGIC_VECTOR (1 downto 0));
end NOR_GATE;

architecture Behavioral of NOR_GATE is

begin
    Z_o <= A_i nor B_i;

end Behavioral;
