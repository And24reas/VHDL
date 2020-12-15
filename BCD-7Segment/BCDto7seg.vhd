library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity BCDto7Seg is

port(
    BCD: in std_logic_vector(3 downto 0);
    Segments: out std_logic_vector(6 downto 0)
);
end BCDto7Seg;

architecture Behavioral of BCDto7Seg is

begin
    with BCD select
        Segments <= "1111110" when "0000",
                    "1100000" when "0001",
                    "0011011" when "0010",
                    "1110010" when "0011",
                    "1100101" when "0100",
                    "0110110" when "0101",
                    "0111110" when "0110",
                    "1100011" when "0111",
                    "1111111" when "1000",
                    "1100111" when "1001",
                    "1111110" when others; 


end Behavioral;