----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 18.01.2024 10:56:16
-- Design Name: 
-- Module Name: TOGGLE_00 - Behavioral
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

entity TOGGLE_00 is
    Port(      RST_i : in STD_LOGIC;
               ENA_i : in STD_LOGIC;
               CLK_i : in STD_LOGIC;
               Q_o : out STD_LOGIC);
end TOGGLE_00;

architecture Behavioral of TOGGLE_00 is

    signal Q: std_logic; -- Dummy signal to read Q
    begin
        process (CLK_i,RST_i)
        begin
            if RST_i='1' then
                Q <= '0';
            elsif rising_edge(CLK_i) then
                if ENA_i='1' then
                    Q <= not Q; -- Read the output "Q"
                end if; -- If '0' keeps the previous value
            end if;
        end process;
        Q_o <= Q;
    end Behavioral;

