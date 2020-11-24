----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Andreas Andreou
-- 
-- Create Date: 11/17/2020 05:38:31 PM
-- Design Name: D-Flip Flop
-- Module Name: simple_DFF - Behavioral
-- Project Name: Hardware Simulation and Design
-- Target Devices: PYNQ-Z1
-- Tool Versions: 
-- Description: Will eventually be part of a bigger project
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

entity DFlipFlop is
--rst can be added to use the reset implementations
port(
    clk, input: in std_logic;
    output: out std_logic);
end DFlipFlop;

architecture Behavioral of DFlipFlop is
begin
    --first version of D-FF implementation
    process(clk)
        begin
           if(clk'event and clk='1') then
                output <= input;
            end if;
     end process;
     -- second version of D-FF implementation with asynchronous reset
     --process(clk)
            --begin
                --if(clk'event and clk='1') then
                    --if(rst='0') then
                        --output <= input;
                    --else
                    --  output <= '0';
                    --end if;
          --     end if;
     -- end process;
        -- third version of D-FF implementation with synchronous reset
        --process(clk)
        --begin
            --if(rst='0') then 
                --if(clk='1') then
                    --output <= input;
                --end if;
            --else
                --output <= '0';
            --end if;
         --end process;
end Behavioral;
