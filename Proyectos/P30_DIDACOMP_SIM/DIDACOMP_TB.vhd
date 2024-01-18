----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 15.05.2023 12:29:56
-- Design Name: 
-- Module Name: DIDACOMP_TB - Behavioral
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

entity DIDACOMP_TB is
end;

architecture bench of DIDACOMP_TB is

  component DIDACOMP
      generic(DATA_WIDTH: integer:= 4;
             N_ALU: integer:= 2;
             CW_WIDTH: integer:= 10;
             ADDR_WIDTH: positive:= 4;
             ADD_ROM_WIDTH: positive:= 4;
             DATA_ROM_WIDTH: positive:= 12);
      Port ( CLK_i : in STD_LOGIC;
             RST_i : in STD_LOGIC;
             ADDR_RAM_o : out std_logic_vector (ADDR_WIDTH-1 downto 0);
             REG_A_o : out STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
             REG_B_o : out STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
             INST_o : out std_logic_vector (DATA_ROM_WIDTH-1 downto 0);
             PC_o : out std_logic_vector(ADD_ROM_WIDTH-1 downto 0);
             DATABUS_o : out std_logic_vector (DATA_WIDTH-1 downto 0);
             ALU_o : out STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
             FZ_o : out STD_LOGIC);
  end component;

  constant DATA_WIDTH: integer:= 4;
  constant N_ALU: integer:= 2;
  constant CW_WIDTH: integer:= 10;
  constant ADDR_WIDTH: positive:= 4;
  constant ADD_ROM_WIDTH: positive:= 4;
  constant DATA_ROM_WIDTH: positive:= 12;

  signal CLK_i: STD_LOGIC;
  signal RST_i: STD_LOGIC;
  signal ADDR_RAM_o: std_logic_vector (ADDR_WIDTH-1 downto 0);
  signal REG_A_o: STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
  signal REG_B_o: STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
  signal INST_o: std_logic_vector (DATA_ROM_WIDTH-1 downto 0);
  signal PC_o: std_logic_vector(ADD_ROM_WIDTH-1 downto 0);
  signal DATABUS_o: std_logic_vector (DATA_WIDTH-1 downto 0);
  signal ALU_o: STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
  signal FZ_o: STD_LOGIC;

  constant clock_period: time := 10 ns;
  signal stop_the_clock: boolean;

begin

  -- Insert values for generic parameters !!
  uut: DIDACOMP generic map ( DATA_WIDTH     => DATA_WIDTH,
                              N_ALU          => N_ALU,
                              CW_WIDTH       => CW_WIDTH,
                              ADDR_WIDTH     => ADDR_WIDTH,
                              ADD_ROM_WIDTH  => ADD_ROM_WIDTH   ,
                              DATA_ROM_WIDTH =>  DATA_ROM_WIDTH)
                   port map ( CLK_i          => CLK_i,
                              RST_i          => RST_i,
                              ADDR_RAM_o     => ADDR_RAM_o,
                              REG_A_o        => REG_A_o,
                              REG_B_o        => REG_B_o,
                              INST_o         => INST_o,
                              PC_o           => PC_o,
                              DATABUS_o      => DATABUS_o,
                              ALU_o          => ALU_o,
                              FZ_o           => FZ_o );

  stimulus: process
  begin
  
    -- Put initialisation code here

    RST_i <= '1';
    wait for 5 ns;
    RST_i <= '0';
    wait for 5 ns;

    -- Put test bench stimulus code here

    wait for 200ns;

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
