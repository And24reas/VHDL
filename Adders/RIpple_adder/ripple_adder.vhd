library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ripple_adder is
 generic(WIDTH : positive := 8;
         CZero:  std_logic := '0');

 port(A, B: in std_logic_vector(WIDTH-1 downto 0);
    SUM: out std_logic_vector(WIDTH-1 downto 0);
    COUT: out std_logic);
end ripple_adder;
architecture structural of ripple_adder is

signal C : std_logic_vector(8 downto 0);

component full_adder
port(A, B, CIN: in std_logic;
      SUM, COUT: out std_logic);     
end component;

begin
 reg: for i in WIDTH-1 downto 0 generate

 reg_begin : if i = 0 generate
    FA: full_adder port map (A => A(i),B => B(i) ,CIN => CZero, SUM => SUM(i), COUT => C(i));
 end generate;
 
 reg_continue: if i > 0 generate          
     FA: full_adder port map (A => A(i),B => B(i) ,CIN => C(i-1), SUM => SUM(i), COUT => C(i));
 end generate;
 end generate;
    
    COUT <= C(7);
end structural;