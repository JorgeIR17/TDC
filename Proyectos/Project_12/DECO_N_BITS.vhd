----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10.05.2023 08:00:26
-- Design Name: 
-- Module Name: DECO_N_BITS - Behavioral
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

entity DECO_N_BITS is
    generic(N: integer:=3);
    Port ( A_i : in STD_LOGIC_VECTOR (N-1 downto 0);
           Z_o : out STD_LOGIC_VECTOR (2**N-1 downto 0));
end DECO_N_BITS;

architecture Behavioral of DECO_N_BITS is

constant const : std_logic_vector(2**N-1 downto 0) := (2**N-1 => '0', others => '1');
signal output : std_logic_vector(2**N-1 downto 0) := const;

begin

    process(A_i)
    begin
        output <= const;
        output(to_integer(unsigned(A_i))) <= '0';
        Z_o <= output;
    end process;

end Behavioral;
