----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/18/2020 01:47:28 PM
-- Design Name: 
-- Module Name: Counters - Behavioral
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
use ieee.numeric_std.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Counters is
    Generic(Fin: Integer:= 100000000;
            Fout: Integer:= 1);
--  Port ( );
    Port(Clk: in std_logic;
        Reset: in std_logic;
        Up: in std_logic;
        Down: in std_logic;
        RW: in std_logic;
        Condition: in std_logic_vector(1 downto 0);
        Hours: out std_logic_vector(4 downto 0);
        Minutes: out std_logic_vector(5 downto 0);   
        Seconds: out std_logic_vector(5 downto 0));
end Counters;

architecture Behavioral of Counters is
Signal clk_cycles , HoursInt, MinutesInt, SecondsInt: integer;
begin
    process(Clk) is
        begin
            if RW = '0' then
                if Reset='1' then
                    clk_cycles <= 0;
                    Seconds <= "000000";
                    Minutes <= "000000";
                    Hours <= "00000";
                else
                    if clk_cycles = (Fin-1) then
                        clk_cycles <= 0;
                         if SecondsInt = 59 then
                            Seconds <= "000000";
                            SecondsInt <= 0;
                            if MinutesInt = 59 then
                                Minutes <= "000000";
                                MinutesInt <= 0;
                                if HoursInt = 23 then 
                                    Hours <= "00000";
                                    HoursInt <= 0;
                                else
                                    HoursInt <= HoursInt +1; 
                                    Hours <= std_logic_vector(to_unsigned(HoursInt,5));    
                                end if;
                            else 
                                MinutesInt <= MinutesInt +1; 
                                Minutes <= std_logic_vector(to_unsigned(MinutesInt,6));
                                
                            end if;
                        else                      
                           SecondsInt <= SecondsInt +1; 
                           Seconds <= std_logic_vector(to_unsigned(SecondsInt,6)); 
                        end if;                    
                    else
                        clk_cycles <= clk_cycles + 1;
                    end if;
                end if;
            else
            end if;
        end process;
end Behavioral;
