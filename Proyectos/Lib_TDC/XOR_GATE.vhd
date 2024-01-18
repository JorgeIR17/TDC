----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08.02.2023 13:20:55
-- Design Name: 
-- Module Name: XOR_GATE - Behavioral
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

entity XOR_GATE is
    generic (WIDTH: integer:= 2);
    Port ( A_i : in STD_LOGIC_VECTOR (WIDTH-1 downto 0);
           B_i : in STD_LOGIC_VECTOR (WIDTH-1 downto 0);
           Z_o : out STD_LOGIC_VECTOR (WIDTH-1 downto 0));
end XOR_GATE;

architecture Behavioral of XOR_GATE is

begin
    Z_o <= A_i xor B_i;

end Behavioral;
