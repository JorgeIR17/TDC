----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12.04.2023 13:45:31
-- Design Name: 
-- Module Name: TOP - Behavioral
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

--AÑADIR COMPONENTES -> CREAR SEÑALES -> CONECTAR

-- AÑADIR EDGE DETECTOR PARA CW_i(6)

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

library Lib_TDC;
use Lib_TDC.COMBINATIONAL_COMPONENTS.EDGE_DETECTOR_00;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity TOP is
    generic(CW_WIDTH: integer:= 10;
            DATA_ROM_WIDTH: positive:= 12);
    Port ( CLK_i: in std_logic;
           RST_i: in std_logic;
           CW_i: in std_logic_vector(CW_WIDTH-1 downto 0);
           CATHODE_o: out std_logic_vector(6 downto 0);
           ANODE_o: out std_logic_vector(7 downto 0);
           FZ_o : out STD_LOGIC;
           INST_o: out std_logic_vector(DATA_ROM_WIDTH-1 downto 0)
           );
end TOP;



architecture Behavioral of TOP is

------------------COMPONENTES---------------------

component DATAPATH_0 is
    generic(DATA_WIDTH: integer:= 4;
           N_ALU: integer:= 2;
           CW_WIDTH: integer:= 10;
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
           DATABUS_o : out std_logic_vector (DATA_WIDTH-1 downto 0);
           ADDR_RAM_o : out std_logic_vector (ADDR_WIDTH-1 downto 0);
           INST_o : out std_logic_vector (DATA_ROM_WIDTH-1 downto 0);
           PC_o : out std_logic_vector(ADD_ROM_WIDTH-1 downto 0));
end component;

component DISP7SEG_8ON is
    Port ( CLK_i : in STD_LOGIC;
           RST_i : in STD_LOGIC;
           DATA0_i : in STD_LOGIC_VECTOR (3 downto 0);
           DATA1_i : in STD_LOGIC_VECTOR (3 downto 0);
           DATA2_i : in STD_LOGIC_VECTOR (3 downto 0);
           DATA3_i : in STD_LOGIC_VECTOR (3 downto 0);
           DATA4_i : in STD_LOGIC_VECTOR (3 downto 0);
           DATA5_i : in STD_LOGIC_VECTOR (3 downto 0);
           DATA6_i : in STD_LOGIC_VECTOR (3 downto 0);
           DATA7_i : in STD_LOGIC_VECTOR (3 downto 0);
           ANODE_o : out STD_LOGIC_VECTOR (7 downto 0);
           CATHODE_o : out STD_LOGIC_VECTOR (6 downto 0));
end component;


-------------------SEÑALES-----------------------

signal DATA0, DATA1, DATA2, DATA3, DATA4, DATA5: std_logic_vector(3 downto 0);
signal CW: std_logic_vector(CW_WIDTH-1 downto 0);

begin

DATAPATH_1: DATAPATH_0
    generic map (CW_WIDTH => CW_WIDTH)
    port map(
        RST_i => RST_i,
        CLK_i => CLK_i,
        CW_i => CW,
        ALU_o => DATA0,
        REG_A_o => DATA2,
        REG_B_o => DATA1,
        FZ_o => FZ_o,
        DATABUS_o => DATA3,
        ADDR_RAM_o => DATA4,
        INST_o => INST_o,
        PC_o => DATA5
    );
    
DISP7SEG_8ON_0: DISP7SEG_8ON
    port map(
        CLK_i => CLK_i,
        RST_i => RST_i,
        DATA0_i => DATA0,
        DATA1_i => DATA1,
        DATA2_i => DATA2,
        DATA3_i => DATA3,
        DATA4_i => DATA4,
        DATA5_i => DATA5,
        DATA6_i => "0000",
        DATA7_i => "0000",
        ANODE_o => ANODE_o,
        CATHODE_o => CATHODE_o
    );

EDGE_DETECTOR_00_0: EDGE_DETECTOR_00
    port map(
        RST_i => RST_i,
        PUSH_i => CW_i(6),
        CLK_i => CLK_i,
        PULSE_o => CW(6)
    );

CW <= CW_i(CW_WIDTH-1 downto 7) & CW(6) & CW_i(5 downto 0);

end Behavioral;
