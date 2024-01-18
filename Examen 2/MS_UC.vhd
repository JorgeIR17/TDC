----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 16.05.2023 17:58:55
-- Design Name: 
-- Module Name: MS_UC - Behavioral
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

entity MS_UC is
    generic (CW_WIDTH: positive:= 10);
    Port ( COP_i : in STD_LOGIC_VECTOR (1 downto 0);
           FZ_i : in STD_LOGIC;
           CW_o : out STD_LOGIC_VECTOR (CW_WIDTH-1 downto 0);
           CLK_i : in STD_LOGIC;
           RST_i : in STD_LOGIC);
end MS_UC;

architecture Behavioral of MS_UC is

------------------------------------------------------
-- DEFINITION of STATES
-------------------------------------------------------
type STATES_FSM is (IDLE,LOAD, DECO,OPE_A,ADDR_B, OPE_B, BRANCH,
BR_INST, MOV_A, A_CMP_B, A_ADD_B);
signal NEXT_STATE: STATES_FSM;
------------------------------------------------------
-- DEFINITION of the OUTPUTS for each STATE
-------------------------------------------------------
constant OUTPUT_IDLE: std_logic_Vector(CW_WIDTH-1 downto 0):="0000000000";
constant OUTPUT_LOAD: std_logic_Vector(CW_WIDTH-1 downto 0):="0010010000"; 
constant OUTPUT_DECO: std_logic_Vector(CW_WIDTH-1 downto 0):="0000000000"; 
constant OUTPUT_OPE_A: std_logic_Vector(CW_WIDTH-1 downto 0):="0000000100"; 
constant OUTPUT_ADDR_B: std_logic_Vector(CW_WIDTH-1 downto 0):="0001100000"; 
constant OUTPUT_OPE_B: std_logic_Vector(CW_WIDTH-1 downto 0):="0001100010"; 
constant OUTPUT_MOV_A: std_logic_Vector(CW_WIDTH-1 downto 0):="0101101001"; 
constant OUTPUT_A_CMP_B: std_logic_Vector(CW_WIDTH-1 downto 0):="1000101001"; 
constant OUTPUT_A_ADD_B:std_logic_Vector(CW_WIDTH-1 downto 0):="0000101001";
constant OUTPUT_BRANCH: std_logic_Vector(CW_WIDTH-1 downto 0):="1110000000";
constant OUTPUT_BR_INST:std_logic_Vector(CW_WIDTH-1 downto 0):="1110000000";


begin

process(CLK_i, RST_i)

begin

    if RST_i = '1' then
        NEXT_STATE <= IDLE;
    elsif rising_edge(CLK_i) then
        case NEXT_STATE is
            -- State "IDLE"
            when IDLE =>
                NEXT_STATE <= LOAD;
            -- State "LOAD"
            when LOAD =>
                NEXT_STATE <= DECO;
            -- State "DECO"
            when DECO =>
                case(COP_i) is
                -- ADD, MOV or CMP instructions
                    when "00" | "01"| "10" =>
                        -- State "OPE_A"
                        NEXT_STATE <= OPE_A;
                    when "11" =>
                        if FZ_i = '0' then
                            NEXT_STATE <= LOAD;
                        elsif FZ_i = '1' then
                            NEXT_STATE <= BRANCH;
                        else
                            NEXT_STATE <= IDLE;
                        end if;
                    when others =>
                        NEXT_STATE <= IDLE;
                    end case;
            -- State "BRANCH"
            when BRANCH =>
                NEXT_STATE <= BR_INST;
            -- State "BR_INST"
            when BR_INST =>
                NEXT_STATE <= LOAD;
            -- State "OPE_A"
            when OPE_A =>
                case(COP_i) is
                    when "00" =>
                        NEXT_STATE <= ADDR_B;
                    when "01" =>
                        NEXT_STATE <= MOV_A;
                    when "10" =>
                        NEXT_STATE <= ADDR_B;
                    when others =>
                        NEXT_STATE <= IDLE;
                end case;
            -- State "ADDR_B"
            when ADDR_B =>
                NEXT_STATE <= OPE_B;
            -- State "OPE_B"
            when OPE_B =>
                if COP_i = "00" then
                    NEXT_STATE <= A_ADD_B;
                elsif COP_i = "10" then
                    NEXT_STATE <= A_CMP_B;
                else
                    NEXT_STATE <= IDLE;
                end if;
            -- State "MOV_A"
            when MOV_A =>
                NEXT_STATE <= IDLE;
            -- State "A_ADD_B"
            when A_ADD_B =>
                NEXT_STATE <= LOAD;
            -- State "A_CMP_B"
            when A_CMP_B =>
                NEXT_STATE <= LOAD;
            when others =>
                NEXT_STATE <= LOAD;
        end case;
    end if;
end process;
-----------------------------------------------------------
    with NEXT_STATE select
        CW_o <= OUTPUT_IDLE when IDLE,
        OUTPUT_LOAD when LOAD,
        OUTPUT_DECO when DECO,
        OUTPUT_OPE_A when OPE_A,
        OUTPUT_ADDR_B when ADDR_B,
        OUTPUT_OPE_B when OPE_B,
        OUTPUT_MOV_A when MOV_A,
        OUTPUT_A_ADD_B when A_ADD_B,
        OUTPUT_A_CMP_B when A_CMP_B,
        OUTPUT_BRANCH when BRANCH,
        OUTPUT_BR_INST when BR_INST,
        OUTPUT_IDLE when others;



end Behavioral;
