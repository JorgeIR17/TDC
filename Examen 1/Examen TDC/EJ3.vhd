----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10.05.2023 12:39:51
-- Design Name: 
-- Module Name: EJ3 - Behavioral
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

library Lib_TDC;
use Lib_TDC.COMBINATIONAL_COMPONENTS.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity EJ3 is
    Port ( CLK_i : in std_logic;
           RST_i : in std_logic;
           INPUT_i : in STD_LOGIC_VECTOR (3 downto 0);
           ANODE_o : out STD_LOGIC_VECTOR (7 downto 0);
           CATHODE_o : out STD_LOGIC_VECTOR (6 downto 0));
end EJ3;

architecture Behavioral of EJ3 is

signal input: STD_LOGIC_VECTOR (3 downto 0);
signal value: unsigned(3 downto 0);

begin

DISP7SEG_0: DISP7SEG
    port map(
        BINARY_i => std_logic_vector(value),
        DISPLAY_i => "000",
        CATHODE_o => CATHODE_o,
        ANODE_o => ANODE_o
    );
    
    
    process(CLK_i, RST_i)
    begin
        if RST_i = '1' then
            value <= "0000";
        elsif rising_edge(CLK_i) then
            input <= INPUT_i;
            if input = "0001" then
                value <= "0001";
            elsif input = "0010" then
                value <= "0010";
            elsif input = "0100" then
                value <= "0011";
            elsif input = "1000" then
                value <= "0100";
            end if;
        end if;
        
    end process;
    
end Behavioral;
