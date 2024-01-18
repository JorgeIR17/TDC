----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 19.04.2023 13:21:08
-- Design Name: 
-- Module Name: FSM_EDGE_DETECTOR - Behavioral
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

entity FSM_EDGE_DETECTOR is

    Port ( RST_i,CLK_i,PUSH_i: in STD_LOGIC;
           PULSE_o           : out STD_LOGIC);

end FSM_EDGE_DETECTOR;

architecture Behavioral of FSM_EDGE_DETECTOR is
----------------------------------------------
-- 1. USER ENUMERATED TYPE FOR FSM
----------------------------------------------
type EdgeDetector_States is (inic,S0,S01);
signal State: EdgeDetector_States ;
signal PUSH: std_logic;

begin

----------------------------------------------
-- 2. INPUTs synchronisation
----------------------------------------------
SYNC_INPUT: Process (RST_i, CLK_i)
begin
    if RST_i = '1' then PUSH <= '0';
    -- INICIO CON RESET
    elsif rising_edge(CLK_i) then
        PUSH <= PUSH_i;
    end if;
end process SYNC_INPUT;

Process (RST_i, CLK_i)
begin
    if RST_i = '1' then
        STATE <= inic; -- INICIO CON RESET
    elsif rising_edge(CLK_i) then
        case STATE is
            when inic => if PUSH = '0' then
                STATE <= S0; --llega "0-"
                         end if;
            when S0 => if PUSH = '1' then
                STATE <= S01; --llega "01"
                       end if;
            when S01 => if PUSH = '0' then
                STATE <= S0; --"0" para "0-"
                        else
                STATE <= inic; --llega un "1",
                        end if;
            when others => STATE <= inic;
        end case;
    end if;
end process;

--------------------------------------------------
-- TWO PROCESS: CONCURRENTS ASSIGNMENTS TO DECODE OUTPUTS
----------------------------------------- ---------
process (STATE)
begin
    case STATE is
        when inic => PULSE_o <= '0';
        when S0 => PULSE_o <= '0';
        when S01 => PULSE_o <= '1';
        when others => PULSE_o <= '0';
    end case;
end process;



end Behavioral;
