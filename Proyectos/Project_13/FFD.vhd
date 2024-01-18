----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08.03.2023 12:19:24
-- Design Name: 
-- Module Name: FFD - Behavioral
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

entity FFD is
    Port ( D_i : in STD_LOGIC;
           CLK_i : in STD_LOGIC;
           ENA_i : in STD_LOGIC;
           RST_i : in STD_LOGIC;
           Q_o : out STD_LOGIC);
end FFD;

architecture Behavioral of FFD is

begin
    process(CLK_i, RST_i)
    begin
        if RST_i = '1' then
            Q_o <= '0';
        elsif rising_edge(CLK_i) then
            if ENA_i = '1' then
            Q_o <= D_i;
            end if;
        end if;
    end process;
end Behavioral;
