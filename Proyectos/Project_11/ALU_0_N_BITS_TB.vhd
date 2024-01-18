library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity ALU_0_N_BITS_TB is
end;

architecture bench of ALU_0_N_BITS_TB is

  component ALU_0_N_BITS
      generic(WIDTH: positive:=4);
      Port ( A_i : in STD_LOGIC_VECTOR (WIDTH-1 downto 0);
             B_i : in STD_LOGIC_VECTOR (WIDTH-1 downto 0);
             OP_i : in STD_LOGIC_VECTOR (1 downto 0);
             RESULT_o : out STD_LOGIC_VECTOR (WIDTH-1 downto 0);
             ZERO_F_o : out STD_LOGIC);
  end component;

  constant WIDTH: positive:=4;
  signal A_i: STD_LOGIC_VECTOR (WIDTH-1 downto 0);
  signal B_i: STD_LOGIC_VECTOR (WIDTH-1 downto 0);
  signal OP_i: STD_LOGIC_VECTOR (1 downto 0);
  signal RESULT_o: STD_LOGIC_VECTOR (WIDTH-1 downto 0);
  signal ZERO_F_o: STD_LOGIC;

begin

  -- Insert values for generic parameters !!
  uut: ALU_0_N_BITS generic map ( WIDTH    =>  WIDTH)
                       port map ( A_i      => A_i,
                                  B_i      => B_i,
                                  OP_i     => OP_i,
                                  RESULT_o => RESULT_o,
                                  ZERO_F_o => ZERO_F_o );

  stimulus: process
  begin
  
    -- Put initialisation code here
    A_i <= "0000";
    B_i <= "0111";
    OP_i <= "00";
    wait for 20ns;
    
    OP_i <= "01";
    wait for 20ns;
    
    OP_i <= "10";
    wait for 20ns;
    
    OP_i <= "11";
    wait for 20ns;

    -- Put test bench stimulus code here

    wait;
  end process;


end;