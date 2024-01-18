----------------------------------------------------------------------------------
library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity ControlUnit_0_TB is
end;

architecture bench of ControlUnit_0_TB is

  component ControlUnit_0
      generic (CW_WIDTH: positive:= 10);
      Port ( COP_i : in STD_LOGIC_VECTOR (3 downto 0);
             FZ_i : in STD_LOGIC;
             CW_o : out STD_LOGIC_VECTOR (CW_WIDTH-1 downto 0);
             CLK_i : in STD_LOGIC;
             RST_i : in STD_LOGIC);
  end component;

  constant CW_WIDTH: positive:= 10;
  signal COP_i: STD_LOGIC_VECTOR (3 downto 0);
  signal FZ_i: STD_LOGIC;
  signal CW_o: STD_LOGIC_VECTOR (CW_WIDTH-1 downto 0);
  signal CLK_i: STD_LOGIC;
  signal RST_i: STD_LOGIC;

  constant clock_period: time := 10 ns;
  signal stop_the_clock: boolean;

begin

  -- Insert values for generic parameters !!
  uut: ControlUnit_0 generic map ( CW_WIDTH =>  CW_WIDTH)
                        port map ( COP_i    => COP_i,
                                   FZ_i     => FZ_i,
                                   CW_o     => CW_o,
                                   CLK_i    => CLK_i,
                                   RST_i    => RST_i );

  stimulus: process
  begin
  
    -- Put initialisation code here

    RST_i <= '1';
    wait for 5 ns;
    RST_i <= '0';
    wait for 5 ns;

    -- Put test bench stimulus code here

    COP_i <= "0000"; --MOV
    FZ_i <= '0';
    wait for 40ns;
    COP_i <= "0001"; --INC 
    wait for 40ns;
    COP_i <= "0010"; --ADD 
    wait for 40ns;
    COP_i <= "0011"; --SUB
    wait for 40ns;
    COP_i <= "0100"; 
    wait for 40ns;
    FZ_i <= '1'; -- BEZ
    
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