----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 16.05.2023 11:36:37
-- Design Name: 
-- Module Name: MS_DATAPATH - Behavioral
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

entity MS_DATAPATH is
    generic(DATA_WIDTH: integer:= 4;
           N_ALU: integer:= 2;
           CW_WIDTH: integer:= 10;
           DATA_RAM_WIDTH: integer:= 10;
           ADDR_WIDTH: positive:= 4); 
     
    Port ( RST_i : in STD_LOGIC;
           CLK_i : in STD_LOGIC;
           CW_i : in STD_LOGIC_VECTOR (CW_WIDTH-1 downto 0);
           INST_o: out STD_LOGIC_VECTOR (DATA_RAM_WIDTH-1 downto 0);
           FZ_o : out STD_LOGIC);
end MS_DATAPATH;

architecture Behavioral of MS_DATAPATH is

--Senales CW:
--0: FZ
--1: REG_B
--2: REG_A
--3: WRITE RAM
--4: REG_INST
--5,6: MUX 
--7: INC PC
--8,9: ALU


type RAM_TYPE is array(0 to 2**ADDR_WIDTH-1) of
                     std_logic_vector(DATA_RAM_WIDTH-1 downto 0); --tamano 10
    signal RAM :RAM_TYPE:= --modificar  0-7: instrucciones  8-15: datos
    ( "0110001101", "1010001111", "0011001110", "1100001111", "1010001110", "1010001001", "1100001111", "0110001010", 
    "0000000101", "0000001111", "0000000110", "0000001100", "0000001000", "0000000100", "0000000010", "0000000000");
      
signal REG_A, REG_B : unsigned(DATA_WIDTH-1 downto 0);
signal FZ           : std_logic;
signal ALU          : std_logic_vector(DATA_WIDTH-1 downto 0);
signal OUT_MEM      : std_logic_vector(DATA_RAM_WIDTH-1 downto 0);
signal REG_INST     : std_logic_vector(DATA_RAM_WIDTH-1 downto 0);
signal ADDRESS_BUS  : std_logic_vector(ADDR_WIDTH-1 downto 0);
signal REG_PC       : std_logic_vector(ADDR_WIDTH-2 downto 0);
constant ZERO       : std_logic_vector(DATA_WIDTH-1 downto 0):=(others=>'0');


begin

REG_A_0: process (CLK_i, RST_i)
    begin
        if RST_i = '1' then
                REG_A <= unsigned(ZERO);
            elsif rising_edge(CLK_i) then
                if CW_i(2) = '1' then
                REG_A <= unsigned(OUT_MEM(DATA_RAM_WIDTH-N_ALU-1 downto DATA_RAM_WIDTH-N_ALU-DATA_WIDTH));
                end if;
            end if;
    end process;

REG_B_0: process (CLK_i, RST_i)
    begin
        if RST_i = '1' then
                REG_B <= unsigned(ZERO);
            elsif rising_edge(CLK_i) then
                if CW_i(1) = '1' then
                REG_B <= unsigned(OUT_MEM(DATA_RAM_WIDTH-N_ALU-DATA_WIDTH-1 downto 0));
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
        -- LECTURA/ESCRITURA s?ncrona
        if CW_i(3) = '1' then
            RAM(to_integer(unsigned(ADDRESS_BUS)))(DATA_RAM_WIDTH-N_ALU-DATA_WIDTH-1 downto 0) <= ALU;
            --El dato que se lee es el mismo que se escribe
            OUT_MEM(DATA_RAM_WIDTH-N_ALU-DATA_WIDTH-1 downto 0) <= ALU;
        else
        -- LECTURA s?ncrona    
            OUT_MEM <= RAM(to_integer(unsigned(ADDRESS_BUS)));
        end if;
    end if;
    
end process;

REG_INST_0:process (CLK_i, RST_i)
    begin
    if RST_i = '1' then
        REG_INST <= (others => '0');
    elsif rising_edge (CLK_i) then
        if CW_i(4) = '1' then
            REG_INST <= OUT_MEM;
        end if;
    end if;
end process; 
    
REG_PC_0:process (CLK_i, RST_i)
    begin
    if RST_i = '1' then
        REG_PC <= (others => '0');
    elsif rising_edge(CLK_i) then
        if CW_i(7) = '1' then
            if CW_i(6 downto 5) = "00" then
                REG_PC <= std_logic_vector(unsigned(REG_PC) + 1);
            else
                REG_PC <= ADDRESS_BUS(ADDR_WIDTH-2 downto 0);
            end if;
        end if;
    end if;
end process;
    
    
    with CW_i(6 downto 5) select  --MUX
        ADDRESS_BUS <= '0' & REG_PC when "00",
                       REG_INST(DATA_RAM_WIDTH-N_ALU-1 downto DATA_RAM_WIDTH-N_ALU-DATA_WIDTH) when "10", --F
                       REG_INST(DATA_RAM_WIDTH-N_ALU-DATA_WIDTH-1 downto 0) when "11", --D
                       ZERO when others;

    
    with CW_i(CW_WIDTH-1 downto CW_WIDTH - N_ALU) select --OPERACIONES ALU
    
        ALU <=    std_logic_vector(REG_A + REG_B)             when "00", -- ADD A, B
                  std_logic_vector(REG_A)                     when "01", -- MOV A
                  std_logic_vector(REG_A xor REG_B)           when "10", -- CMP A, B
                  std_logic_vector(REG_B)                     when "11", -- BEZ A
               --(others=>'0')  when others; Otra opcion
                  ZERO          when others;
    
    
    FZ <= '1' when ALU = ZERO
    else '0';
    INST_o <= REG_INST;
    
end Behavioral;