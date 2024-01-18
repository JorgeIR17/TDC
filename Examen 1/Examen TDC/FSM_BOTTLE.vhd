library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

library Lib_TDC;
use Lib_TDC.COMBINATIONAL_COMPONENTS.all;

entity FSM_BOTTLE is
    Port ( CLK_i : in std_logic;
           RST_i : in std_logic; 
           EURO_i : in STD_LOGIC;
           CENT_i : in STD_LOGIC;
           DISPENSAR_o : out STD_LOGIC;
           CAMBIO_o : out STD_LOGIC
           );
end FSM_BOTTLE;

architecture Behavioral of FSM_BOTTLE is

type tipo_moneda is (INICIO, EURO, CENT);
signal moneda: tipo_moneda;
signal counter: integer range 0 to 3;
signal timer: integer range 0 to 100000000;
signal disp: std_logic;
signal cambio: std_logic;
signal centimo: std_logic;

begin

EDGE_DETECTOR_00_0: EDGE_DETECTOR_00
    port map(
        RST_i => RST_i,
        CLK_i => CLK_i,
        PUSH_i => CENT_i,
        PULSE_o => centimo
        );
        

process(CLK_i, RST_i)
begin
    if RST_i = '1' then
        moneda <= INICIO;
        timer <= 0;
        counter <= 0;
    elsif rising_edge(CLK_i) then
        case moneda is
            when INICIO =>
                if EURO_i = '1' then
                    moneda <= EURO;
                elsif centimo = '1' then
                    moneda <= CENT;
                else
                disp <= '0';
                cambio <= '0'; 
                end if;
            when EURO =>
                disp <= '1';
                cambio <= '1';
                if timer = 100000000 then 
                        moneda <= INICIO;
                        timer <= 0;
                    else
                        timer <= timer + 1;
                    end if;
            when CENT =>
                if centimo = '1' then
                    counter <= counter + 1;
                    if counter = 3 then
                        disp <= '1';
                        cambio <= '0';
                        counter <= 0;
                        if timer = 100000000 then
                            moneda <= INICIO;
                            timer <= 0;
                        else
                            timer <= timer + 1;
                        end if;
                    end if;
                elsif EURO_i = '1' then
                        counter <= 0;
                        moneda <= EURO;
                end if;
            end case;
    end if; 
end process;    

DISPENSAR_o <= disp;
CAMBIO_o <= cambio; 
   
end Behavioral;