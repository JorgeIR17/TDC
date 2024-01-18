----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 29.03.2023 12:40:18
-- Design Name: 
-- Module Name: ROM_16x4 - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ROM_16x4 is
    Port ( CLK_i : in STD_LOGIC;
           ENA_i : in STD_LOGIC;
           ADDR_BUS_i : in STD_LOGIC_VECTOR (3 downto 0);
           DATA_BUS_o : out STD_LOGIC_VECTOR (3 downto 0));
end ROM_16x4;

architecture Behavioral of ROM_16x4 is
    type ROM_TYPE is array (15 downto 0) of std_logic_vector(3 downto 0);
    signal ROM : ROM_TYPE :=(X"1",X"2",X"3",X"4",X"5",
X"6",X"7",X"8",X"9",X"A",X"B",X"C",X"D",X"E",X"F",X"1");
begin

process(CLK_i)
begin
    if rising_edge(CLK_i) then
        if ENA_i = '1' then
            DATA_BUS_o <= ROM(to_integer(unsigned(ADDR_BUS_i)));
        end if;
    end if;
end process;

end Behavioral;
