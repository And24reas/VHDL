
----------------------------------------------------------------------------------
-- Company: No Company
-- Engineer: And24reas
-- 
-- Create Date: 11/23/2020 10:46:33 PM
-- Design Name: Full_Adder_Simple_Implementation
-- Module Name: full_adder - structural
-- Project Name: Learning VHDL
-- Target Devices: PYNQ
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

entity Mux_LEDs is
--  Port ( );
port(
    A: in std_logic_vector(3 downto 0);
    B: in std_logic_vector(3 downto 0);
    C: in std_logic_vector(3 downto 0);
    D: in std_logic_vector(3 downto 0);
    E: in std_logic_vector(3 downto 0);
    F: in std_logic_vector(3 downto 0);
    Sel: in std_logic_vector(1 downto 0);
    State: in std_logic;
    Condition: in std_logic_vector(1 downto 0);
    Leds: out std_logic_vector(7 downto 0)
);
end Mux_LEDs;

architecture Behavioral of Mux_LEDs is
begin
process(A,B,C,D,E,F,Sel,State,Condition) 
    begin
        if (State = '0') then
            case Sel is
                when "00" => Leds <= E&F;
                when "01" => Leds <= C&D;
                when "10" => Leds <= A&B;
                when others => Leds <= "00000000";
             end case;  
        else
            case Condition is
                when "00" => Leds <= A&B ;
                when "01" => Leds <= C&D;
                when "10" => Leds <= E&F;
                when others => Leds <= "00000000";
            end case;
        end if;                       
    end process;
end Behavioral;
