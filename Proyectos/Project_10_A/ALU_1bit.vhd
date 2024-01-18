----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 22.02.2023 12:48:07
-- Design Name: 
-- Module Name: ALU_1bit - Behavioral
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

use work.COMBINATIONAL_COMPONENTS.all;

entity ALU_1bit is
    Port ( A_i : in STD_LOGIC;
           B_i : in STD_LOGIC;
           CARRY_i : in STD_LOGIC;
           OP_i : in STD_LOGIC_VECTOR (1 downto 0);
           CARRY_o : out STD_LOGIC;
           RESULT_o : out STD_LOGIC);
end ALU_1bit;

architecture Behavioral of ALU_1bit is

signal DATA_AND, DATA_XOR, DATA_FULL_ADDER: std_logic;

begin

AND_0 : AND_GATE
    port map (
              A_i => A_i,
              B_i => B_i,
              Z_o => DATA_AND
    );
    
XOR_0 : XOR_GATE
    generic map (WIDTH => 1)
    port map (
              A_i(0) => A_i,
              B_i(0) => B_i,
              Z_o(0) => DATA_XOR
    );
    
FULL_ADDER_0 : FULL_ADDER
    port map (
              A_i => A_i,
              B_i => B_i,
              CARRY_i => CARRY_i,
              CARRY_o => CARRY_o,
              SUM_o => DATA_FULL_ADDER
    );
    
MUX4_0 : MUX4
    generic map (width => 1)
    port map (
              A_i(0) => DATA_AND,
              B_i(0) => DATA_XOR,
              C_i(0) => DATA_FULL_ADDER,
              D_i(0) => A_i,
              SEL_i => OP_i,
              Z_o(0) => RESULT_o
    );
    
end Behavioral;
