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
             CW_WIDTH: integer:= 8;
             ADDR_WIDTH: positive:= 4;
             ADD_ROM_WIDTH: positive:= 4;
             DATA_ROM_WIDTH: positive:= 12); 
      Port ( RST_i : in STD_LOGIC;
             CLK_i : in STD_LOGIC;
             CW_i : in STD_LOGIC_VECTOR (CW_WIDTH-1 downto 0);
             ALU_o : out STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
             REG_A_o : out STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
             REG_B_o : out STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
             FZ_o : out STD_LOGIC;
             ADDR_ROM_i : in std_logic_vector (ADD_ROM_WIDTH-1 downto 0);
             ADDR_RAM_o : out std_logic_vector (ADDR_WIDTH-1 downto 0);
             INST_o : out std_logic_vector (DATA_ROM_WIDTH-1 downto 0));
  end component;

  constant DATA_WIDTH: integer:=4;
  constant N_ALU: integer:=2;
  constant CW_WIDTH: integer:=8;
  constant ADDR_WIDTH: integer:=4;
  constant ADD_ROM_WIDTH: integer:=4;
  constant DATA_ROM_WIDTH: integer:=12;
  
  signal RST_i: STD_LOGIC;
  signal CLK_i: STD_LOGIC;
  signal CW_i: STD_LOGIC_VECTOR (CW_WIDTH-1 downto 0);
  signal ALU_o: STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
  signal REG_A_o: STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
  signal REG_B_o: STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
  signal FZ_o: STD_LOGIC;
  signal ADDR_ROM_i: std_logic_vector (ADD_ROM_WIDTH-1 downto 0);
  signal ADDR_RAM_o: std_logic_vector (ADDR_WIDTH-1 downto 0);
  signal INST_o: std_logic_vector (DATA_ROM_WIDTH-1 downto 0);

  constant clock_period: time := 10 ns;
  signal stop_the_clock: boolean;

begin

  -- Insert values for generic parameters !!
  uut: DATAPATH_0 generic map ( DATA_WIDTH     => DATA_WIDTH,
                                N_ALU          => N_ALU,
                                CW_WIDTH       => CW_WIDTH,
                                ADDR_WIDTH     => ADDR_WIDTH,
                                ADD_ROM_WIDTH  => ADD_ROM_WIDTH,
                                DATA_ROM_WIDTH =>  DATA_ROM_WIDTH)
                     port map ( RST_i          => RST_i,
                                CLK_i          => CLK_i,
                                CW_i           => CW_i,
                                ALU_o          => ALU_o,
                                REG_A_o        => REG_A_o,
                                REG_B_o        => REG_B_o,
                                FZ_o           => FZ_o,
                                ADDR_ROM_i     => ADDR_ROM_i,
                                ADDR_RAM_o     => ADDR_RAM_o,
                                INST_o         => INST_o );

  stimulus: process
  begin
  
    -- Put initialisation code here

    RST_i <= '1';
    wait for 5 ns;
    RST_i <= '0';
    wait for 5 ns;

    -- Put test bench stimulus code here

    --LEER ROM
    ADDR_ROM_i <= "0011";
    wait for 10 ns;
    CW_i <= "00010000";
    wait for 10 ns;
    --SELECCIONAR OPE A
    CW_i <= "00000000";
    wait for 10 ns;
    --GUARDAR OPE A EN REG A
    CW_i <= "00000100";
    wait for 10 ns;
    --SELECCIONAR OPE B
    CW_i <= "00100000";
    wait for 10 ns;
    --GUARDAR OPE B EN REG B
    CW_i <= "00100010";
    wait for 10 ns;
    --SUB A, B
    CW_i <= "11101001";
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