----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01.03.2023 12:24:01
-- Design Name: 
-- Module Name: ALU_0_N_BITS - Behavioral
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

entity ALU_0_N_BITS is
    generic(WIDTH: positive:=4);
    Port ( A_i : in STD_LOGIC_VECTOR (WIDTH-1 downto 0);
           B_i : in STD_LOGIC_VECTOR (WIDTH-1 downto 0);
           OP_i : in STD_LOGIC_VECTOR (1 downto 0);
           RESULT_o : out STD_LOGIC_VECTOR (WIDTH-1 downto 0);
           ZERO_F_o : out STD_LOGIC);
end ALU_0_N_BITS;

architecture Behavioral of ALU_0_N_BITS is

    signal A, B     :   unsigned(WIDTH-1 downto 0);
    signal RESULT   :   unsigned(WIDTH-1 downto 0);
    
    constant ZERO   :   unsigned(WIDTH-1 downto 0):=(others=>'0');

begin

    A <= unsigned(A_i);
    B <= unsigned(B_i);
    
    with OP_i select
        RESULT <= A             when "00", -- MOV A
                  A + 1         when "01", -- INC A 
                  A + B         when "10", -- ADD A ,B
                  A - B         when "11", -- SUB A, B
               --(others=>'0')  when others; Otra opcion
                  ZERO          when others;

    ZERO_F_o <= '1' when RESULT = ZERO else '0';
        
    RESULT_o <= std_logic_vector(RESULT);    

end Behavioral;
