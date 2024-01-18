library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

package COMBINATIONAL_COMPONENTS is

    component AND_GATE is
        Port ( A_i : in STD_LOGIC;
               B_i : in STD_LOGIC;
               Z_o : out STD_LOGIC);
    end component;

    component XOR_GATE is
        generic (WIDTH: integer:= 2);
        Port ( A_i : in STD_LOGIC_VECTOR (WIDTH-1 downto 0);
               B_i : in STD_LOGIC_VECTOR (WIDTH-1 downto 0);
               Z_o : out STD_LOGIC_VECTOR (WIDTH-1 downto 0));
    end component;

    component FULL_ADDER is
        Port ( A_i : in STD_LOGIC;
               B_i : in STD_LOGIC;
               CARRY_i : in STD_LOGIC;
               CARRY_o : out STD_LOGIC;
               SUM_o : out STD_LOGIC);
    end component;
    
    component MUX4 is
    generic(width: integer:=4); 
    Port ( A_i : in STD_LOGIC_VECTOR (width-1 downto 0);
           B_i : in STD_LOGIC_VECTOR (width-1 downto 0);
           C_i : in STD_LOGIC_VECTOR (width-1 downto 0);
           D_i : in STD_LOGIC_VECTOR (width-1 downto 0);
           SEL_i : in STD_LOGIC_VECTOR (1 downto 0);
           Z_o : out STD_LOGIC_VECTOR (width-1 downto 0));
end component;

    component DISP7SEG is 
    Port ( BINARY_i : in STD_LOGIC_VECTOR (3 downto 0);
           DISPLAY_i : in STD_LOGIC_VECTOR (2 downto 0);
           CATHODE_o : out STD_LOGIC_VECTOR (6 downto 0);
           ANODE_o : out STD_LOGIC_VECTOR (7 downto 0));
end component;

    component EDGE_DETECTOR_00 is 
    Port ( RST_i : in STD_LOGIC;
           PUSH_i : in STD_LOGIC;
           CLK_i : in STD_LOGIC;
           PULSE_o : out STD_LOGIC);
end component;

    component COUNTER_N_bits is
    generic(WIDTH: natural:=4);
    Port ( CLK_i : in STD_LOGIC;
           RST_i : in STD_LOGIC;
           ENA_i : in STD_LOGIC;
           Q_o : out STD_LOGIC_VECTOR (WIDTH-1 downto 0));
end component;
    
    component CE_N_Hz is
    generic(F_Hz: integer:= 100000);
    Port ( CLK_i : in STD_LOGIC;
           RST_i : in STD_LOGIC;
           CLK_N_Hz_o : out STD_LOGIC);
end component;

end package;