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
           CW_WIDTH: integer:= 10;
           ADDR_WIDTH: positive:= 4;
           ADD_ROM_WIDTH: positive:= 4;
           DATA_ROM_WIDTH: positive:= 12); 
     
    Port ( RST_i : in STD_LOGIC;
           CLK_i : in STD_LOGIC;
           CW_i : in STD_LOGIC_VECTOR (CW_WIDTH-1 downto 0);
           ALU_o : out STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
           REG_A_o : out STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
           REG_B_o : out STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
           FZ_o : out STD_LOGIC;
           ADDR_RAM_o : out std_logic_vector (ADDR_WIDTH-1 downto 0);
           INST_o : out std_logic_vector (DATA_ROM_WIDTH-1 downto 0);
           PC_o : out std_logic_vector(ADD_ROM_WIDTH-1 downto 0));
end DATAPATH_0;

architecture Behavioral of DATAPATH_0 is


type RAM_TYPE is array(0 to 2**ADDR_WIDTH-1) of
                     std_logic_vector(DATA_WIDTH-1 downto 0);
    signal RAM :RAM_TYPE:=
    ( "0101", "1111", "1110", "1110", "1110", "0000", "0001", "0010", 
    "0101", "1111", "0000", "0000", "0000", "0000", "0000", "0000");
    
type ROM_TYPE is array(2**ADD_ROM_WIDTH-1 downto 0) of
                    std_logic_vector(DATA_ROM_WIDTH-1 downto 0);
    signal ROM :ROM_TYPE:=
    (X"000", X"000", X"000", X"000", X"000", X"000", X"000", X"104",
     X"212", X"212", X"040", X"437", X"311", X"109", X"014", X"283");
      
signal REG_A, REG_B : unsigned(DATA_WIDTH-1 downto 0);
signal FZ           : std_logic;
signal ALU          : std_logic_vector(DATA_WIDTH-1 downto 0);
signal DATA_BUS     : std_logic_vector(DATA_WIDTH-1 downto 0);
signal DATA_ROM     : std_logic_vector(DATA_ROM_WIDTH-1 downto 0);
signal REG_INST     : std_logic_vector(DATA_ROM_WIDTH-1 downto 0);
signal ADDR_RAM     : std_logic_vector(ADDR_WIDTH-1 downto 0);
signal ADDR_ROM     : std_logic_vector(ADD_ROM_WIDTH-1 downto 0);
signal REG_PC       : std_logic_vector(ADD_ROM_WIDTH-1 downto 0);
constant ZERO       : std_logic_vector(DATA_WIDTH-1 downto 0):=(others=>'0');


begin

REG_A_0: process (CLK_i, RST_i)
    begin
        if RST_i = '1' then
                REG_A <= unsigned(ZERO);
            elsif rising_edge(CLK_i) then
                if CW_i(2) = '1' then
                REG_A <= unsigned(DATA_BUS);
                end if;
            end if;
    end process;

REG_B_0: process (CLK_i, RST_i)
    begin
        if RST_i = '1' then
                REG_B <= unsigned(ZERO);
            elsif rising_edge(CLK_i) then
                if CW_i(1) = '1' then
                REG_B <= unsigned(DATA_BUS);
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
    
    
RAM_0:process (CLK_i)
    begin
    
    if rising_edge(CLK_i) then
        -- LECTURA/ESCRITURA s�ncrona
        if CW_i(3) = '1' then
            RAM(to_integer(unsigned(ADDR_RAM))) <= ALU;
            --El dato que se lee es el mismo que se escribe
            DATA_BUS <= ALU;
        else
        -- LECTURA s�ncrona    
            DATA_BUS <= RAM(to_integer(unsigned(ADDR_RAM)));
        end if;
    end if;
    
end process;

ROM_0:process (CLK_i)
    begin
    if rising_edge(CLK_i) then
        DATA_ROM <= ROM(to_integer(unsigned(REG_PC)));
    end if;
    
end process;

REG_INST_0:process (CLK_i, RST_i)
    begin
    if RST_i = '1' then
        REG_INST <= "000000000000";
    elsif rising_edge (CLK_i) then
        if CW_i(4) = '1' then
            REG_INST <= DATA_ROM;
        end if;
    end if;
end process; 
    
REG_PC_0:process (CLK_i, RST_i)
    begin
    if RST_i = '1' then
        REG_PC <= (others => '0');
    elsif rising_edge(CLK_i) then
        if CW_i(6) = '1' then
            REG_PC <= ADDR_ROM;
        end if;
    end if;
end process;
    
    with CW_i(7) select
        ADDR_ROM <= std_logic_vector(unsigned(REG_PC) + 1) when '0',
                    REG_INST(ADD_ROM_WIDTH-1 downto 0) when '1',
                    ZERO when others;

    
    with CW_i(5) select
        ADDR_RAM <= REG_INST(DATA_ROM_WIDTH-ADDR_WIDTH-1 downto DATA_ROM_WIDTH-(2*ADDR_WIDTH)) when '0',
                    REG_INST(DATA_ROM_WIDTH-(2*ADDR_WIDTH)-1 downto 0) when '1',
                    ZERO when others;
    
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
    INST_o <= REG_INST;
    ADDR_RAM_o <= ADDR_RAM;
    PC_o <= REG_PC;
    
end Behavioral;
