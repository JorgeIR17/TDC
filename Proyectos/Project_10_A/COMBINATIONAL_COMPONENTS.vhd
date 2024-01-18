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
    
end package;