
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity xor2 is
--  Port ( );
port (in1,in2: in std_logic;
 and_out: out std_logic);
end xor2;

architecture behavioral of xor2 is


begin
 and_out <= in1 xor in2;


end behavioral;
