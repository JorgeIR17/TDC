----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08.03.2023 13:01:13
-- Design Name: 
-- Module Name: EDGE_DETECTOR_00 - Behavioral
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

entity EDGE_DETECTOR_00 is
    Port ( RST_i : in STD_LOGIC;
           PUSH_i : in STD_LOGIC;
           CLK_i : in STD_LOGIC;
           PULSE_o : out STD_LOGIC);
end EDGE_DETECTOR_00;

architecture Behavioral of EDGE_DETECTOR_00 is

    signal PREV_PUSH, REG_PUSH: std_logic;

begin
    SincPush:process (CLK_i, RST_i)
    begin
    
        if RST_i = '1' then
            REG_PUSH <= '0';
        elsif rising_edge(CLK_i) then
            REG_PUSH <= PUSH_i;
        end if;
    end process;

    StorePrevPush:process (CLK_i ,RST_i)
    begin
    
        if RST_i = '1' then
            PREV_PUSH <= '0';
        elsif rising_edge(CLK_i) then
            PREV_PUSH <= REG_PUSH;
        end if;
    end process;

    PULSE_o <= '1' when PREV_PUSH = '0' and REG_PUSH = '1'
    else '0';

end Behavioral;
