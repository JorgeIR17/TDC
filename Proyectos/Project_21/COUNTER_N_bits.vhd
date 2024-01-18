----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 31.10.2018 13:15:26
-- Design Name: 
-- Module Name: COUNTER_N_bits - Behavioral
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
use IEEE.numeric_std.all;

entity COUNTER_N_bits is
    generic (DATA_WIDTH: natural:=4);
     Port ( CLK_i : in  STD_LOGIC;
           RST_i : in  STD_LOGIC;
           ENA_i : in  STD_LOGIC;
           Q_o : out  STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0));
end COUNTER_N_bits ;

architecture Behavioral of COUNTER_N_bits is
-- Señal donde se acumula la cuenta
   signal COUNTER: unsigned (DATA_WIDTH-1 downto 0);
---------------------------------------------------- 
begin
	process (CLK_i, RST_i)
	begin
		if RST_i ='1' then -- reset asíncrono
			COUNTER <= (others=>'0');
		elsif rising_edge(CLK_i) then
			if ENA_i ='1' then
				COUNTER <= COUNTER +1;
			end if;
		end if;
	end process;
----------------------------------------------------	
Q_o <= std_logic_vector(COUNTER); -- asigna al puerto de salida el 				  	    
                                  -- valor de la señal COUNT.
end Behavioral;

