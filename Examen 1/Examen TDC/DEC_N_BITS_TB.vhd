library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity DEC_N_BITS_TB is
end;

architecture bench of DEC_N_BITS_TB is

  component DEC_N_BITS
      generic(N: integer:= 4);
      Port ( A_i : in STD_LOGIC_VECTOR (N-1 downto 0);
             ENA_i : in STD_LOGIC;
             Z_o : out STD_LOGIC_VECTOR (2**N-1 downto 0));
  end component;

  constant N : integer:= 4;
  signal A_i: STD_LOGIC_VECTOR (N-1 downto 0);
  signal ENA_i: STD_LOGIC;
  signal Z_o: STD_LOGIC_VECTOR (2**N-1 downto 0);

begin

  -- Insert values for generic parameters !!
  uut: DEC_N_BITS generic map ( N     =>  N)
                     port map ( A_i   => A_i,
                                ENA_i => ENA_i,
                                Z_o   => Z_o );

  stimulus: process
  begin
  
    -- Put initialisation code here
    ENA_i <= '1';
    A_i <= "0000";
    wait for 40ns;
    A_i <= "0001";
    wait for 40ns;
    A_i <= "0010";
    wait for 40ns;
    A_i <= "0011";
    wait for 40ns;
    A_i <= "0100";
    wait for 40ns;
    A_i <= "0101";
    wait for 40ns;
    A_i <= "0110";
    wait for 40ns;
    A_i <= "0111";
    wait for 40ns;
    A_i <= "1000";
    wait for 40ns;
    A_i <= "1001";
    wait for 40ns;
    A_i <= "1010";
    wait for 40ns;
    A_i <= "1011";
    wait for 40ns;
    A_i <= "1100";
    wait for 40ns;
    A_i <= "1101";
    wait for 40ns;
    A_i <= "1110";
    wait for 40ns;
    A_i <= "1111";
    wait for 40ns;
    ENA_i <= '0';
    -- Put test bench stimulus code here

    wait;
  end process;


end;
