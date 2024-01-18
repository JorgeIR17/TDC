----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 22.02.2023 11:47:08
-- Design Name: 
-- Module Name: SHOW_DATA - Behavioral
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

entity SHOW_DATA is
    generic (WIDTH_TOP: integer:=4);
    Port ( A_i : in STD_LOGIC_VECTOR (WIDTH_TOP-1 downto 0);
           B_i : in STD_LOGIC_VECTOR (WIDTH_TOP-1 downto 0);
           SEL_i : in STD_LOGIC;
           LED_o : out STD_LOGIC_VECTOR (WIDTH_TOP-1 downto 0);
           CATHODE_o : out STD_LOGIC_VECTOR (6 downto 0);
           ANODE_o : out STD_LOGIC_VECTOR (7 downto 0));
end SHOW_DATA;

architecture Behavioral of SHOW_DATA is

component DISP7SEG is
    Port ( BINARY_i : in STD_LOGIC_VECTOR (3 downto 0);
           DISPLAY_i : in STD_LOGIC_VECTOR (2 downto 0);
           CATHODE_o : out STD_LOGIC_VECTOR (6 downto 0);
           ANODE_o : out STD_LOGIC_VECTOR (7 downto 0));
end component;

component MUX2 is
    generic(width: integer);
    Port ( A_i : in STD_LOGIC_VECTOR (width-1 downto 0);
           B_i : in STD_LOGIC_VECTOR (width-1 downto 0);
           SEL_i : in STD_LOGIC;
           Y_o : out STD_LOGIC_VECTOR (width-1 downto 0));
end component;

signal DATA: STD_LOGIC_VECTOR (WIDTH_TOP-1 downto 0);

begin

MUX2_0 : MUX2
    generic map (WIDTH => WIDTH_TOP)
    port map (A_i => A_i,
              B_i => B_i,
              SEL_i => SEL_i,
              Y_o => DATA
    );
DISP7SEG_0 : DISP7SEG
    port map (
              BINARY_i => DATA,
              DISPLAY_i => "000",
              CATHODE_o => CATHODE_o,
              ANODE_o => ANODE_o
    );
    
    LED_o <= DATA;
    
end Behavioral;
