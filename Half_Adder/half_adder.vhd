----------------------------------------------------------------------------------
-- Company: The most 'boring' Company
-- Engineer: And24reas
-- 
-- Create Date: 11/03/2020 03:20:58 PM
-- Design Name: 
-- Module Name: half_adder - Behavioral
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

entity half_adder is
port(A : in std_logic;
     B : in std_logic;
     SUM : out std_logic;
     CARRY : out std_logic);
end half_adder;
architecture structural of half_adder is

component and2
port (in1,in2: in std_logic;
      and_out: out std_logic);
end component;

component xor2
port (in1,in2: in std_logic;
 and_out: out std_logic);
end component;

begin
 U1: and2 port map (in1 => A, in2 => B, and_out => CARRY);
 U2: xor2 port map (in1 => A, in2 => B, and_out => SUM);
 --SUM <= A xor B;
 --CARRY <= A and B;

end structural;

