----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10.05.2023 11:35:42
-- Design Name: 
-- Module Name: DEC_N_BITS - Behavioral
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

entity DEC_N_BITS is
    generic(N: integer:= 4);
    Port ( A_i : in STD_LOGIC_VECTOR (N-1 downto 0);
           ENA_i : in STD_LOGIC;
           Z_o : out STD_LOGIC_VECTOR (2**N-1 downto 0));
end DEC_N_BITS;

architecture Behavioral of DEC_N_BITS is

signal output: STD_LOGIC_VECTOR (2**N-1 downto 0);

begin

    process(A_i, ENA_i)
    begin
        if ENA_i = '1' then
            output <= (others => '0');
            output(to_integer(unsigned(A_i))) <= '1';
        else 
            output <= (others => '0');
        end if;
    end process;
    
    Z_o <= output;
    
end Behavioral;
