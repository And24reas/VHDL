library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity ROM_asynch is
    port (
        address : std_logic_vector (1 downto 0);
        data    : std_logic_vector (3 downto 0)
    );

end entity

architecture Behavioral of ROM_asynch is
    type ROM_type is array (0 to 3) of std_logic_vector(3 downto 0);
    constant ROM_arr: ROM_type := ( 0 => "1110", 
                           1 => "0010",
                           2 => "1111", 
                           3 => "0100");
    begin
        data_out <= ROM_arr(to_integer(unsigned(address)) );
end architecture;