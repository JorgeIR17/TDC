----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 26.04.2023 12:10:23
-- Design Name: 
-- Module Name: FSM_DEBOUNCE_TIMER_TB - Behavioral
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
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity FSM_DEBOUNCE_TIMER_TB is
end;

architecture bench of FSM_DEBOUNCE_TIMER_TB is

  component FSM_DEBOUNCE_TIMER
      Port ( RST_i,CLK_i,PUSH_i: in STD_LOGIC;
             PULSE_o           : out STD_LOGIC);
  end component;

  signal RST_i,CLK_i,PUSH_i: STD_LOGIC;
  signal PULSE_o: STD_LOGIC;

  constant clock_period: time := 10 ns;
  signal stop_the_clock: boolean;

begin

  uut: FSM_DEBOUNCE_TIMER port map ( RST_i   => RST_i,
                                     CLK_i   => CLK_i,
                                     PUSH_i  => PUSH_i,
                                     PULSE_o => PULSE_o );

  stimulus: process
  begin
  
    -- Put initialisation code here

    RST_i <= '1';
    wait for 5 ns;
    RST_i <= '0';
    wait for 5 ns;

    -- Put test bench stimulus code here

    PUSH_i <= '1';
    wait for 20ns;
    PUSH_i <= '0';
    wait for 30ns;
    PUSH_i <= '1';
    wait for 60ns;
    PUSH_i <= '0';
    wait for 40ns;
    PUSH_i <= '1';
    wait for 20ns;
    PUSH_i <= '0';
    wait for 30ns;
    PUSH_i <= '1';
    wait for 60ns;
    PUSH_i <= '0';
    wait for 40ns;
    PUSH_i <= '1';
    wait for 20ns;
    PUSH_i <= '0';
    wait for 30ns;
    PUSH_i <= '1';
    wait for 60ns;
    PUSH_i <= '0';
    wait for 40ns;
    PUSH_i <= '1';
    wait for 20ns;
    PUSH_i <= '0';
    wait for 30ns;
    PUSH_i <= '1';
    wait for 60ns;
    PUSH_i <= '0';
    wait for 40ns;

    stop_the_clock <= true;
    wait;
  end process;

  clocking: process
  begin
    while not stop_the_clock loop
      CLK_i <= '0', '1' after clock_period / 2;
      wait for clock_period;
    end loop;
    wait;
  end process;

end;
