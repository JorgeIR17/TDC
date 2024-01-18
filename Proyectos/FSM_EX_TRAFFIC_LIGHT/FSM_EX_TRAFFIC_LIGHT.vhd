----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 26.04.2023 12:28:37
-- Design Name: 
-- Module Name: FSM_EX_TRAFFIC_LIGHT - Behavioral
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

entity FSM_EX_TRAFFIC_LIGHT is
    Port ( CLK_i: in std_logic;
           RST_i: in std_logic;
           SENSOR_i : in STD_LOGIC;
           SOUTH_RED_o : out STD_LOGIC;
           SOUTH_AMBER_o : out STD_LOGIC;
           SOUTH_GREEN_o : out STD_LOGIC;
           WEST_RED_o : out STD_LOGIC;
           WEST_AMBER_o : out STD_LOGIC;
           WEST_GREEN_o : out STD_LOGIC);
end FSM_EX_TRAFFIC_LIGHT;

architecture Behavioral of FSM_EX_TRAFFIC_LIGHT is

type TrafficLights_States is (SG_WR,SA_WR,SR_WG, SR_WA);
signal STATE: TrafficLights_States;
signal SENSOR: std_logic;
signal COUNTER: integer range 0 to 200000000;
signal SOUTH_RED, SOUTH_AMBER, SOUTH_GREEN, WEST_RED, WEST_AMBER, WEST_GREEN: std_logic;

begin

SYNC_INPUT: Process (RST_i, CLK_i)
begin
    if RST_i = '1' then 
    SENSOR <= '0';
    SOUTH_RED <= '0';
    SOUTH_AMBER <= '0';
    SOUTH_GREEN <= '1';
    WEST_RED <= '1'; 
    WEST_AMBER <= '0';
    WEST_GREEN <= '0';
    -- INICIO CON RESET
    elsif rising_edge(CLK_i) then
        SENSOR <= SENSOR_i;
    end if;
end process SYNC_INPUT;

Process (RST_i, CLK_i)
begin
    if RST_i = '1' then
        STATE <= SG_WR; -- INICIO CON RESET
    elsif rising_edge(CLK_i) then
        case STATE is
            when SG_WR => if SENSOR = '1' then
                STATE <= SA_WR; --llega "0-"
                         end if;
            when SA_WR => if COUNTER = 200000000 then
                STATE <= SR_WG; --llega "01"
                COUNTER <= 0;
                          else
                            COUNTER <= COUNTER + 1;
                       end if;
            when SR_WG => if COUNTER = 200000000 then
                STATE <= SR_WA; --llega "01"
                COUNTER <= 0;
                          else
                            COUNTER <= COUNTER + 1;
                       end if;
            when SR_WA =>
                    if COUNTER = 200000000 then
                        STATE <= SG_WR; --llega "01"
                        COUNTER <= 0;
                                  else
                                    COUNTER <= COUNTER + 1;
                               end if;
            when others => STATE <= SG_WR;
        end case;
    end if;
end process;

process (STATE)
begin
    case STATE is
        when SG_WR => SOUTH_RED_o <= '0';
                      SOUTH_AMBER_o <= '0';
                      SOUTH_GREEN_o <= '1';
                      WEST_RED_o <= '1';
                      WEST_AMBER_o <= '0';
                      WEST_GREEN_o <= '0';
        
        when SA_WR => SOUTH_RED_o <= '0';
                      SOUTH_AMBER_o <= '1';
                      SOUTH_GREEN_o <= '0';
                      WEST_RED_o <= '1';
                      WEST_AMBER_o <= '0';
                      WEST_GREEN_o <= '0';
                      
        when SR_WG => SOUTH_RED_o <= '1';
                      SOUTH_AMBER_o <= '0';
                      SOUTH_GREEN_o <= '0';
                      WEST_RED_o <= '0';
                      WEST_AMBER_o <= '0';
                      WEST_GREEN_o <= '1';
                      
        when SR_WA => SOUTH_RED_o <= '1';
                      SOUTH_AMBER_o <= '0';
                      SOUTH_GREEN_o <= '0';
                      WEST_RED_o <= '0';
                      WEST_AMBER_o <= '1';
                      WEST_GREEN_o <= '0';
                      
       when others => SOUTH_RED_o <= '0';
                      SOUTH_AMBER_o <= '0';
                      SOUTH_GREEN_o <= '1';
                      WEST_RED_o <= '1';
                      WEST_AMBER_o <= '0';
                      WEST_GREEN_o <= '0';
    end case;
end process;


end Behavioral;
