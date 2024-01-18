----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01.03.2023 13:30:33
-- Design Name: 
-- Module Name: ALU_1_N_BITS - Behavioral
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

entity ALU_1_N_BITS is
    generic(WIDTH: positive:=4);
    Port ( A_i : in STD_LOGIC_VECTOR (WIDTH-1 downto 0);
           B_i : in STD_LOGIC_VECTOR (WIDTH-1 downto 0);
           OP_i : in STD_LOGIC_VECTOR (2 downto 0);
           RESULT_o : out STD_LOGIC_VECTOR (WIDTH-1 downto 0);
           ZERO_F_o : out STD_LOGIC;
           CARRY_F_o : out STD_LOGIC);
end ALU_1_N_BITS;

architecture Behavioral of ALU_1_N_BITS is

    signal A, B     :   unsigned(WIDTH downto 0);
    signal RESULT   :   unsigned(WIDTH downto 0);
    
    constant ZERO   :   unsigned(WIDTH-1 downto 0):=(others=>'0');

begin

    A <= '0' & unsigned(A_i);
    B <= '0' & unsigned(B_i);

ALU: process(A_i, B_i, OP_i)
    begin
    
    case(OP_i) is
    
        when "000" => RESULT <= A + 1; --INC A
        when "001" => RESULT <= B + 1; --INC B
        when "010" => RESULT <= A SRL 1; --SRL A 1 bit
        when "011" => RESULT <= A SLL 1; -- SLL A 1 bit
        when "100" => RESULT <= A + B; --ADD A, B
        when "101" => RESULT <= A - B; --SUB A, B   
        when "110" =>  RESULT <= A; --MOV A
        when "111" => RESULT <= B; --MOV B
        when others => RESULT <= ZERO;
    end case;
    
    
    end process ALU;

    ZERO_F_o <= '1' when RESULT = ZERO else '0';
    CARRY_F_o <= RESULT(4);
    RESULT_o <= std_logic_vector(RESULT (WIDTH-1 downto 0));

end Behavioral;
