----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 28.03.2023 13:58:44
-- Design Name: 
-- Module Name: DATAPATH_0_TB - Behavioral
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

entity DATAPATH_0_TB is
end;

architecture bench of DATAPATH_0_TB is

  component DATAPATH_0
      generic(DATA_WIDTH: integer:= 4;
             N_ALU: integer:= 2;
             CW_WIDTH: integer:= 5);
      Port ( DATA_BUS_i : in STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
             RST_i : in STD_LOGIC;
             CLK_i : in STD_LOGIC;
             CW_i : in STD_LOGIC_VECTOR (CW_WIDTH-1 downto 0);
             ALU_o : out STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
             REG_A_o : out STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
             REG_B_o : out STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
             FZ_o : out STD_LOGIC);
  end component;

  constant DATA_WIDTH: integer:=4;
  constant CW_WIDTH: integer:=5;
  signal DATA_BUS_i: STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
  signal RST_i: STD_LOGIC;
  signal CLK_i: STD_LOGIC;
  signal CW_i: STD_LOGIC_VECTOR (CW_WIDTH-1 downto 0);
  signal ALU_o: STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
  signal REG_A_o: STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
  signal REG_B_o: STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
  signal FZ_o: STD_LOGIC;

  constant clock_period: time := 10 ns;
  signal stop_the_clock: boolean;

begin

  -- Insert values for generic parameters !!
  uut: DATAPATH_0 generic map ( DATA_WIDTH => 4,
                                N_ALU      => 2,
                                CW_WIDTH   =>  5)
                     port map ( DATA_BUS_i => DATA_BUS_i,
                                RST_i      => RST_i,
                                CLK_i      => CLK_i,
                                CW_i       => CW_i,
                                ALU_o      => ALU_o,
                                REG_A_o    => REG_A_o,
                                REG_B_o    => REG_B_o,
                                FZ_o       => FZ_o );

  stimulus: process
  begin
  
    -- Put initialisation code here

    RST_i <= '1';
    wait for 5 ns;
    RST_i <= '0';
    wait for 5 ns;

    -- Put test bench stimulus code here


--MOV A
    DATA_BUS_i <= "0011";
    CW_i <= "00100";
    wait for 10 ns;
    CW_i <= "00001";
    wait for 10 ns;
    
--INC A   

    DATA_BUS_i <= "0101";
    CW_i <= "00100";
    wait for 10 ns;
    CW_i <= "01001";
    wait for 10 ns; 
    
--A+B

    DATA_BUS_i <= "0001";--A
    CW_i <= "00100";
    wait for 10 ns;
    DATA_BUS_i <= "0010";--B
    CW_i <= "00010";
    wait for 10 ns;
    CW_i <= "10001";
    wait for 10 ns;
    
--A-B

    DATA_BUS_i <= "1010";--A
    CW_i <= "00100";
    wait for 10 ns;
    DATA_BUS_i <= "1010";--B
    CW_i <= "00010";
    wait for 10 ns;
    CW_i <= "11001";
    wait for 10 ns;

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