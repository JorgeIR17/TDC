library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity FSM_BOTTLE_TB is
end;

architecture bench of FSM_BOTTLE_TB is

  component FSM_BOTTLE
      Port ( CLK_i : in std_logic;
             RST_i : in std_logic; 
             EURO_i : in STD_LOGIC;
             CENT_i : in STD_LOGIC;
             DISPENSAR_o : out STD_LOGIC;
             CAMBIO_o : out STD_LOGIC
             );
  end component;

  signal CLK_i: std_logic;
  signal RST_i: std_logic;
  signal EURO_i: STD_LOGIC;
  signal CENT_i: STD_LOGIC;
  signal DISPENSAR_o: STD_LOGIC;
  signal CAMBIO_o: STD_LOGIC ;

  constant clock_period: time := 10 ns;
  signal stop_the_clock: boolean;

begin

  uut: FSM_BOTTLE port map ( CLK_i       => CLK_i,
                             RST_i       => RST_i,
                             EURO_i      => EURO_i,
                             CENT_i      => CENT_i,
                             DISPENSAR_o => DISPENSAR_o,
                             CAMBIO_o    => CAMBIO_o );

  stimulus: process
  begin
  
    -- Put initialisation code here

    RST_i <= '1';
    wait for 5 ns;
    RST_i <= '0';
    wait for 5 ns;

    -- Put test bench stimulus code here

    --EURO
    
    EURO_i <= '1';
    wait for 10ns;
    EURO_i <= '0';
    wait for 40ns;
    
    --CENT
    
    CENT_i <= '1';
    wait for 10ns;
    CENT_i <= '0';
    wait for 10ns;
    CENT_i <= '1';
    wait for 10ns;
    CENT_i <= '0';
    wait for 10ns;
    CENT_i <= '1';
    wait for 10ns;
    CENT_i <= '0';
    wait for 40ns;
    
    --CENT y EURO
    
    CENT_i <= '1';
    wait for 10ns;
    CENT_i <= '0';
    wait for 10ns;
    CENT_i <= '1';
    wait for 10ns;
    CENT_i <= '0';
    EURO_i <= '1';
    wait for 10ns;
    EURO_i <= '0';
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