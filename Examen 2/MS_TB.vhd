----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 17.05.2023 12:34:07
-- Design Name: 
-- Module Name: MS_TB - Behavioral
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

entity MS_TB is
end;

architecture bench of MS_TB is

  component MS
      generic(DATA_WIDTH: integer:= 4;
             N_ALU: integer:= 2;
             CW_WIDTH: integer:= 10;
             DATA_RAM_WIDTH: integer:= 10;
             ADDR_WIDTH: positive:= 4);
      Port ( CLK_i : in STD_LOGIC;
             RST_i : in STD_LOGIC;
             FZ_o : out STD_LOGIC);
  end component;
  
  constant DATA_WIDTH: integer:= 4;
  constant N_ALU: integer:= 2;
  constant CW_WIDTH: integer:= 10;
  constant DATA_RAM_WIDTH: integer:= 10;
  constant ADDR_WIDTH: positive:= 4;

  signal CLK_i: STD_LOGIC;
  signal RST_i: STD_LOGIC;
  signal FZ_o: STD_LOGIC;
  
  constant clock_period: time := 10 ns;
  signal stop_the_clock: boolean;

begin

  -- Insert values for generic parameters !!
  uut: MS generic map ( DATA_WIDTH     => DATA_WIDTH,
                        N_ALU          => N_ALU,
                        CW_WIDTH       => CW_WIDTH,
                        DATA_RAM_WIDTH => DATA_RAM_WIDTH,
                        ADDR_WIDTH     =>  ADDR_WIDTH)
             port map ( CLK_i          => CLK_i,
                        RST_i          => RST_i,
                        FZ_o           => FZ_o );

  stimulus: process
  begin
  
    -- Put initialisation code here

    RST_i <= '1';
    wait for 5 ns;
    RST_i <= '0';
    wait for 5 ns;

    -- Put test bench stimulus code here

    wait for 200000ns;

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
