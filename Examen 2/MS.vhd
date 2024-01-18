----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 17.05.2023 12:11:04
-- Design Name: 
-- Module Name: MS - Behavioral
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

entity MS is
    generic(DATA_WIDTH: integer:= 4;
           N_ALU: integer:= 2;
           CW_WIDTH: integer:= 10;
           DATA_RAM_WIDTH: integer:= 10;
           ADDR_WIDTH: positive:= 4);

    Port ( CLK_i : in STD_LOGIC;
           RST_i : in STD_LOGIC;
           FZ_o : out STD_LOGIC);
end MS;

architecture Behavioral of MS is

component MS_DATAPATH is
    generic(DATA_WIDTH: integer:= 4;
           N_ALU: integer:= 2;
           CW_WIDTH: integer:= 10;
           DATA_RAM_WIDTH: integer:= 10;
           ADDR_WIDTH: positive:= 4); 
     
    Port ( RST_i : in STD_LOGIC;
           CLK_i : in STD_LOGIC;
           CW_i : in STD_LOGIC_VECTOR (CW_WIDTH-1 downto 0);
           INST_o: out STD_LOGIC_VECTOR (DATA_RAM_WIDTH-1 downto 0);
           FZ_o : out STD_LOGIC);
end component;

component MS_UC is
    generic (CW_WIDTH: positive:= 10);
    Port ( COP_i : in STD_LOGIC_VECTOR (1 downto 0);
           FZ_i : in STD_LOGIC;
           CW_o : out STD_LOGIC_VECTOR (CW_WIDTH-1 downto 0);
           CLK_i : in STD_LOGIC;
           RST_i : in STD_LOGIC);
end component;

signal CW: std_logic_vector(CW_WIDTH-1 downto 0);
signal INST: std_logic_vector(DATA_RAM_WIDTH-1 downto 0);
signal COP: std_logic_vector(N_ALU-1 downto 0);
signal FZ: std_logic;

begin

MS_DATAPATH_0: MS_DATAPATH
    generic map(CW_WIDTH => CW_WIDTH)
    port map(
        CLK_i => CLK_i,
        RST_i => RST_i,
        CW_i => CW,
        INST_o => INST,
        FZ_o => FZ
        );
        
MS_UC_0: MS_UC
    generic map(CW_WIDTH => CW_WIDTH)
    port map(
        CLK_i => CLK_i,
        RST_i => RST_i,
        CW_o => CW,
        COP_i => COP,
        FZ_i => FZ
        );
        
FZ_o <= FZ;
COP <= INST(DATA_RAM_WIDTH-1 downto DATA_RAM_WIDTH-N_ALU);

end Behavioral;
