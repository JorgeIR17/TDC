----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03.07.2018 14:03:04
-- Design Name: 
-- Module Name: DISP7SEG - Behavioral
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

entity DISP7SEG is
    Port ( BINARY_i : in STD_LOGIC_VECTOR (3 downto 0);
           DISPLAY_I : in STD_LOGIC_VECTOR (2 downto 0);
           CATHODE_O : out STD_LOGIC_VECTOR (6 downto 0);
           ANODE_O : out STD_LOGIC_VECTOR (7 downto 0));
end DISP7SEG;

architecture Behavioral of DISP7SEG is

begin
-- Two independent circuits are working


--HEX-to-seven-segment decoder
--   HEX:   in    STD_LOGIC_VECTOR (3 downto 0);
--   LED:   out   STD_LOGIC_VECTOR (6 downto 0);
--
-- segment encoinputg
--      0
--     ---
--  5 |   | 1
--     ---   <- 6
--  4 |   | 2
--     ---
--      3

with BINARY_i SELect
   CATHODE_O <=  "1111001" when "0001",   --1
                 "0100100" when "0010",   --2
                 "0110000" when "0011",   --3
                 "0011001" when "0100",   --4
                 "0010010" when "0101",   --5
                 "0000010" when "0110",   --6
                 "1111000" when "0111",   --7
                 "0000000" when "1000",   --8
                 "0010000" when "1001",   --9
                 "0001000" when "1010",   --A
                 "0000011" when "1011",   --b
                 "1000110" when "1100",   --C
                 "0100001" when "1101",   --d
                 "0000110" when "1110",   --E
                 "0001110" when "1111",   --F
                 "1000000" when others;   --0
                 
 with DISPLAY_I select
    ANODE_O <=  "11111110" when "000", -- Display LSB
                "11111101" when "001",
                "11111011" when "010",
                "11110111" when "011",
                "11101111" when "100",
                "11011111" when "101",
                "10111111" when "110",
                "01111111" when "111",
                "11111111" when others;
 
 
end Behavioral;
