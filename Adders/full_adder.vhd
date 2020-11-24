----------------------------------------------------------------------------------
-- Company: No Company
-- Engineer: And24reas
-- 
-- Create Date: 11/03/2020 04:03:55 PM
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

entity full_adder is
 port(A, B, CIN: in std_logic;
      SUM, COUT: out std_logic);
end full_adder;
architecture structural of full_adder is
signal SIG1, SIG2, SIG3: std_logic;
component half_adder
port(A : in std_logic;
     B : in std_logic;
     SUM : out std_logic;
     CARRY : out std_logic);
     
end component;


begin
U1: half_adder port map (A => A, B => B, SUM => SIG1, CARRY => SIG2);
U2: half_adder port map (A => SIG1, B => CIN , SUM => SUM, CARRY => SIG3);
COUT <= SIG3 or SIG2;
end structural;

