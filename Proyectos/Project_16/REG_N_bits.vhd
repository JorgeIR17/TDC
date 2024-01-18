----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 14.03.2023 13:48:21
-- Design Name: 
-- Module Name: REG_N_bits - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity REG_N_bits is
    generic(WIDTH: integer:=5);
    Port ( RST_i : in STD_LOGIC;
           CLK_i : in STD_LOGIC;
           ENA_i : in STD_LOGIC;
           DATA_IN_i : in STD_LOGIC_VECTOR (WIDTH-1 downto 0);
           DATA_OUT_o : out STD_LOGIC_VECTOR (WIDTH-1 downto 0));
end REG_N_bits;

architecture Behavioral of REG_N_bits is

    constant ZERO   :   std_logic_vector(WIDTH-1 downto 0):=(others=>'0');

begin
    process(CLK_i, RST_i)
        begin
            if RST_i = '1' then
                DATA_OUT_o <= ZERO;
            elsif rising_edge(CLK_i) then
                if ENA_i = '1' then
                DATA_OUT_o <= DATA_IN_i;
                end if;
            end if;
        end process;
        
        
end Behavioral;
