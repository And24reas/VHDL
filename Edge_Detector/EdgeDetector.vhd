----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Andreas Andreou
-- 
-- Create Date: 11/17/2020 08:59:45 PM
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

entity EdgeDetector is
Port(clk: in std_logic;
    inputSignal: in std_logic;
    edge: out std_logic
);
end EdgeDetector;

architecture structural of EdgeDetector is
Signal q1, q2 : std_logic;

component DFlipFlop
port(clk, input: in std_logic;
    output: out std_logic);
end component;

begin
FF1: DFlipFlop port map (clk => clk, input => inputSignal, output => q1);
FF2: DFlipFlop port map (clk => clk, input => q1, output => q2);

edge <= not q2 and q1;

end structural;
