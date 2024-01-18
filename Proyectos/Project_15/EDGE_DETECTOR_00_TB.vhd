library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity EDGE_DETECTOR_00_TB is
end;

architecture bench of EDGE_DETECTOR_00_TB is

  component EDGE_DETECTOR_00
      Port ( RST_i : in STD_LOGIC;
             PUSH_i : in STD_LOGIC;
             CLK_i : in STD_LOGIC;
             PULSE_o : out STD_LOGIC);
  end component;

  signal RST_i: STD_LOGIC;
  signal PUSH_i: STD_LOGIC;
  signal CLK_i: STD_LOGIC;
  signal PULSE_o: STD_LOGIC;

  constant clock_period: time := 10 ns;
  signal stop_the_clock: boolean;

begin

  uut: EDGE_DETECTOR_00 port map ( RST_i   => RST_i,
                                   PUSH_i  => PUSH_i,
                                   CLK_i   => CLK_i,
                                   PULSE_o => PULSE_o );

  stimulus: process
  begin
  
    -- Put initialisation code here

    RST_i <= '1';
    wait for 5 ns;
    RST_i <= '0';
    wait for 5 ns;

    -- Put test bench stimulus code here
    
    PUSH_i <= '0';
    wait for 40ns;
    PUSH_i <= '1';
    wait for 40ns;
    PUSH_i <= '0';
    wait for 40ns;
    PUSH_i <= '1';

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