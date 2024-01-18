----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05.11.2018 19:45:47
-- Design Name: 
-- Module Name: DISP7SEG_8ON - Behavioral
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
use IEEE.NUMERIC_STD.ALL;
library Lib_TDC;
use Lib_TDC.Sequential_Components.all;

entity DISP7SEG_8ON is
    Port ( DATA0_i : in STD_LOGIC_VECTOR (3 downto 0);
           DATA1_i : in STD_LOGIC_VECTOR (3 downto 0);
           DATA2_i : in STD_LOGIC_VECTOR (3 downto 0);
           DATA3_i : in STD_LOGIC_VECTOR (3 downto 0);
           DATA4_i : in STD_LOGIC_VECTOR (3 downto 0);
           DATA5_i : in STD_LOGIC_VECTOR (3 downto 0);
           DATA6_i : in STD_LOGIC_VECTOR (3 downto 0);
           DATA7_i : in STD_LOGIC_VECTOR (3 downto 0);
           CLK_i : in STD_LOGIC;
           RST_i : in STD_LOGIC;
           ANODE_o : out STD_LOGIC_VECTOR (7 downto 0);
           CATHODE_o : out STD_LOGIC_VECTOR (6 downto 0));
end DISP7SEG_8ON;

architecture Behavioral of DISP7SEG_8ON is

------------------- SIGNALS -------------------------------
-- Connect the CE to the counter
signal CLK_N_Hz : std_logic;
-- Output from Counter and is used to select the DATA and
-- tha display
signal Q        : std_logic_vector(2 downto 0);
-- Output from de MUX which select among the DATA
signal DATA     : std_logic_vector(3 downto 0);
------------------------------------------------------------
begin

DISP : DISP7SEG
port map (
   BINARY_i  => DATA,
   DISPLAY_I => Q,               
   CATHODE_O => CATHODE_O,  
   ANODE_O  => ANODE_O);


COUNT : COUNTER_N_bits
generic map (
   DATA_WIDTH => 3)
port map (
    CLK_i => CLK_i,
    RST_i => RST_i,
    ENA_i => CLK_N_Hz,
    Q_o   => Q
);

CE : CE_N_Hz
generic map (
   N_Hz => 100000
)
port map (
    CLK_i => CLK_i,
    RST_i => RST_i ,
    CLK_N_Hz_o => CLK_N_Hz
);

--- MUX Declaration to select the DATA to show in each display every 1 ms -----
with Q select 
   DATA <=  DATA0_i when "000",
            DATA1_i when "001", 
            DATA2_i when "010", 
            DATA3_i when "011", 
            DATA4_i when "100", 
            DATA5_i when "101", 
            DATA6_i when "110", 
            DATA7_i when "111", 
            DATA0_i when others;


end Behavioral;
