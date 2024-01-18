library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity ALU_1bit_TB is
end;

architecture bench of ALU_1bit_TB is

  component ALU_1bit
      Port ( A_i : in STD_LOGIC;
             B_i : in STD_LOGIC;
             CARRY_i : in STD_LOGIC;
             OP_i : in STD_LOGIC_VECTOR (1 downto 0);
             CARRY_o : out STD_LOGIC;
             RESULT_o : out STD_LOGIC);
  end component;

  signal A_i: STD_LOGIC;
  signal B_i: STD_LOGIC;
  signal CARRY_i: STD_LOGIC;
  signal OP_i: STD_LOGIC_VECTOR (1 downto 0);
  signal CARRY_o: STD_LOGIC;
  signal RESULT_o: STD_LOGIC;

begin

  uut: ALU_1bit port map ( A_i      => A_i,
                           B_i      => B_i,
                           CARRY_i  => CARRY_i,
                           OP_i     => OP_i,
                           CARRY_o  => CARRY_o,
                           RESULT_o => RESULT_o );

  stimulus: process
  begin
  
    -- Put initialisation code here

    A_i <= '0';
    B_i <= '0';
    CARRY_i <= '0';
    OP_i <= "00";
    wait for 40ns;
    
    OP_i <= "01";
    wait for 40ns;
    
    OP_i <= "10";
    wait for 40ns;
    
    OP_i <= "11";
    wait for 40ns; 
    
    A_i <= '1';
    B_i <= '0';
    CARRY_i <= '0';
    OP_i <= "00";
    wait for 40ns;
    
    OP_i <= "01";
    wait for 40ns;
    
    OP_i <= "10";
    wait for 40ns;
    
    OP_i <= "11";
    wait for 40ns; 

    A_i <= '0';
    B_i <= '1';
    CARRY_i <= '0';
    OP_i <= "00";
    wait for 40ns;
    
    OP_i <= "01";
    wait for 40ns;
    
    OP_i <= "10";
    wait for 40ns;
    
    OP_i <= "11";
    wait for 40ns; 
    
    A_i <= '1';
    B_i <= '1';
    CARRY_i <= '0';
    OP_i <= "00";
    wait for 40ns;
    
    OP_i <= "01";
    wait for 40ns;
    
    OP_i <= "10";
    wait for 40ns;
    
    OP_i <= "11";
    wait for 40ns; 

    -- Put test bench stimulus code here

    wait;
  end process;


end;