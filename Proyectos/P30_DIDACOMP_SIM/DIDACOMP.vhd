----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 15.05.2023 12:05:14
-- Design Name: 
-- Module Name: DIDACOMP - Behavioral
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
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity DIDACOMP is
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
end DIDACOMP;

architecture Behavioral of DIDACOMP is

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

component ControlUnit_0 is
    generic (CW_WIDTH: positive:= 10);
    Port ( COP_i : in STD_LOGIC_VECTOR (3 downto 0);
           FZ_i : in STD_LOGIC;
           CW_o : out STD_LOGIC_VECTOR (CW_WIDTH-1 downto 0);
           CLK_i : in STD_LOGIC;
           RST_i : in STD_LOGIC);
end component;

signal CW: STD_LOGIC_VECTOR (CW_WIDTH-1 downto 0);
signal INST: std_logic_vector (DATA_ROM_WIDTH-1 downto 0);
signal COP: std_logic_vector (DATA_ROM_WIDTH-1 downto DATA_ROM_WIDTH-4);
signal FZ: std_logic;

begin

CU_0:ControlUnit_0
    generic map(CW_WIDTH => CW_WIDTH)
    port map(
        CLK_i => CLK_i,
        RST_i => RST_i,
        CW_o => CW,
        COP_i => COP,
        FZ_i => FZ);
        
DATAPATH_1: DATAPATH_0
    generic map (CW_WIDTH => CW_WIDTH)
    port map(
        RST_i => RST_i,
        CLK_i => CLK_i,
        CW_i => CW,
        ALU_o => ALU_o,
        REG_A_o => REG_A_o,
        REG_B_o => REG_B_o,
        FZ_o => FZ,
        DATABUS_o => DATABUS_o,
        ADDR_RAM_o => ADDR_RAM_o,
        INST_o => INST,
        PC_o => PC_o
    );    

FZ_o <= FZ;
COP <= INST(DATA_ROM_WIDTH-1 downto DATA_ROM_WIDTH-4);
INST_o <= INST;

end Behavioral;
