----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 26.04.2023 13:14:06
-- Design Name: 
-- Module Name: FSM_EX_KNIGHT_RIDER - Behavioral
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

entity FSM_EX_KNIGHT_RIDER is
    Port ( CLK_i : in STD_LOGIC;
           RST_i: in STD_LOGIC;
           LED_o: out std_logic_vector(15 downto 0));
end FSM_EX_KNIGHT_RIDER;

architecture Behavioral of FSM_EX_KNIGHT_RIDER is

type Led_States is (LEFT, RIGHT);
signal STATE: Led_States;
signal LED: std_logic_vector(15 downto 0);
signal COUNTER: integer range 0 to 10000000;

begin

Process (RST_i, CLK_i)
begin
    if RST_i = '1' then
        LED <= "0000000000000001";
        STATE <= LEFT; -- INICIO CON RESET
    elsif rising_edge(CLK_i) then
        case STATE is
            when LEFT => if LED = "1000000000000000" then
                STATE <= RIGHT; --llega "0-"
                         else
                            if COUNTER = 10000000 then
                                LED <= std_logic_vector(unsigned(LED) sll 1);
                                COUNTER <= 0;
                            else
                                COUNTER <= COUNTER + 1;
                            end if;
                         end if;
            when RIGHT => if LED = "0000000000000001" then
                STATE <= LEFT; --llega "01"
                          else
                                if COUNTER = 10000000 then
                                LED <= std_logic_vector(unsigned(LED) srl 1);
                                COUNTER <= 0;
                                else
                                COUNTER <= COUNTER + 1;
                            end if;
                       end if;
            
            when others => STATE <= LEFT;
        end case;
    end if;
end process;

           LED_o <= LED;

end Behavioral;
