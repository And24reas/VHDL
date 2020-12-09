----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/09/2020 09:51:25 PM
-- Design Name: 
-- Module Name: carry_save_adder - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity carry_save_adder is
generic(WIDTH : positive := 8;
         CZero:  std_logic := '0');

 port(A, B, C: in std_logic_vector(WIDTH-1 downto 0);
    SUM: out std_logic_vector(WIDTH-1 downto 0);
    COUT: out std_logic );
end carry_save_adder;



architecture structural of carry_save_adder is
signal SUM1,COUT1: std_logic_vector(8 downto 0);

component full_adder
port(A, B, CIN: in std_logic;
      SUM, COUT: out std_logic);     
end component;

component ripple_adder
port(A, B: in std_logic_vector(WIDTH-1 downto 0);
    SUM: out std_logic_vector(WIDTH-1 downto 0);
    COUT: out std_logic);
end component;

begin
 reg: for i in WIDTH-1 downto 0 generate

 reg_begin : if i < WIDTH generate
    FA: full_adder port map (A => A(i),B => B(i) ,CIN => C(i), SUM => SUM1(i), COUT => COUT1(i));
 end generate;
 
 end generate;

 RA: ripple_adder port map (A => SUM1, B => COUT1, SUM => SUM, COUT => COUT);



end structural;
