----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 15.03.2023 13:23:59
-- Design Name: 
-- Module Name: PRESCALER_1Hz - Behavioral
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

entity PRESCALER_1Hz is
    Port ( CLK_i : in STD_LOGIC;
           RST_i : in STD_LOGIC;
           CLK_1Hz_o : out STD_LOGIC);
end PRESCALER_1Hz;

architecture Behavioral of PRESCALER_1Hz is

    constant PRESCALER_FACTOR: integer :=100000;
    constant PRESCALER_FACTOR_2: integer :=PRESCALER_FACTOR/2;
    signal COUNTER: integer range 0 to PRESCALER_FACTOR_2;
    signal CLK_SIGNAL: std_logic;

begin

    process(CLK_i ,RST_i)
    begin
    
        if RST_i = '1' then
            COUNTER <= 0;
            CLK_SIGNAL <= '0';
        elsif rising_edge(CLK_i) then
            if COUNTER = PRESCALER_FACTOR_2 - 1 then
                COUNTER <= 0;
                CLK_SIGNAL <= not CLK_SIGNAL;
            else
                COUNTER <= COUNTER + 1;
                CLK_SIGNAL <= '0';
            end if;
        end if;
        CLK_1Hz_o <= CLK_SIGNAL;
    end process;

end Behavioral;
