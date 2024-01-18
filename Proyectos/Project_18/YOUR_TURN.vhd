----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 14.03.2023 14:34:16
-- Design Name: 
-- Module Name: YOUT_TURN - Behavioral
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

library Lib_TDC;
use Lib_TDC.COMBINATIONAL_COMPONENTS.all;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity YOUT_TURN is
    generic(WIDTH: natural:=4);
    Port ( CLK_i : in STD_LOGIC;
           RST_i : in STD_LOGIC;
           INC_i : in STD_LOGIC;
           ANODE_o : out STD_LOGIC_VECTOR (7 downto 0);
           CATHODE_o : out STD_LOGIC_VECTOR (6 downto 0));
end YOUT_TURN;

architecture Behavioral of YOUT_TURN is

signal PULSE :  std_logic;  --ENA_i
signal COUNTER : unsigned(WIDTH-1 downto 0);


begin

DISP7SEG_0: DISP7SEG
    port map(
           BINARY_i => std_logic_vector(COUNTER),
           DISPLAY_i => "000",
           CATHODE_o => CATHODE_o,
           ANODE_o => ANODE_o
    );

EDGE_DETECTOR_0: EDGE_DETECTOR_00
    port map(
           RST_i => RST_i,
           PUSH_i => INC_i,
           CLK_i => CLK_i,
           PULSE_o => PULSE
    );
    
    process (CLK_i, RST_i)
    begin
        if RST_i = '1' then
            COUNTER <= (others=>'0');
        elsif rising_edge(CLK_i) then
            if PULSE = '1' then
                COUNTER <= COUNTER + 1;
                if COUNTER = 9 then
                    COUNTER <= "0000";
                end if;
            end if;
        end if;
    end process;


end Behavioral;
