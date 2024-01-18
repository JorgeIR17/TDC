----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 22.03.2023 13:11:37
-- Design Name: 
-- Module Name: DATAPATH_0 - Behavioral
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

entity DATAPATH_0 is
    generic(DATA_WIDTH: integer:= 4;
           N_ALU: integer:= 2;
           CW_WIDTH: integer:= 5);
           
    Port ( DATA_BUS_i : in STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
           RST_i : in STD_LOGIC;
           CLK_i : in STD_LOGIC;
           CW_i : in STD_LOGIC_VECTOR (CW_WIDTH-1 downto 0);
           ALU_o : out STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
           REG_A_o : out STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
           REG_B_o : out STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
           FZ_o : out STD_LOGIC);
end DATAPATH_0;

architecture Behavioral of DATAPATH_0 is

signal REG_A, REG_B : unsigned(DATA_WIDTH-1 downto 0);
signal FZ           : std_logic;
signal ALU          : std_logic_vector(DATA_WIDTH-1 downto 0);
constant ZERO       : std_logic_vector(DATA_WIDTH-1 downto 0):=(others=>'0');

begin

REG_A_0: process (CLK_i, RST_i)
    begin
        if RST_i = '1' then
                REG_A <= unsigned(ZERO);
            elsif rising_edge(CLK_i) then
                if CW_i(2) = '1' then
                REG_A <= unsigned(DATA_BUS_i);
                end if;
            end if;
    end process;

REG_B_0: process (CLK_i, RST_i)
    begin
        if RST_i = '1' then
                REG_B <= unsigned(ZERO);
            elsif rising_edge(CLK_i) then
                if CW_i(1) = '1' then
                REG_B <= unsigned(DATA_BUS_i);
                end if;
            end if;
    end process;

FZ_0: process (CLK_i, RST_i)
    begin
        if RST_i = '1' then
                FZ_o <= '0';
            elsif rising_edge(CLK_i) then
                if CW_i(0) = '1' then
                FZ_o <= FZ;
                end if;
            end if;
    end process;
    
    
    with CW_i(CW_WIDTH-1 downto CW_WIDTH - N_ALU) select
        ALU <=  std_logic_vector(REG_A)             when "00", -- MOV A
                  std_logic_vector(REG_A + 1)         when "01", -- INC A 
                  std_logic_vector(REG_A + REG_B)     when "10", -- ADD A ,B
                  std_logic_vector(REG_A - REG_B)     when "11", -- SUB A, B
               --(others=>'0')  when others; Otra opcion
                  ZERO          when others;
    
    
    FZ <= '1' when ALU = ZERO
    else '0';
    REG_A_o <= std_logic_vector(REG_A);
    REG_B_o <= std_logic_vector(REG_B);
    ALU_o <= ALU;
    
end Behavioral;
