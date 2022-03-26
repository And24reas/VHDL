library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsinged.all;

entity accelerator is
    generic (
        period  : natural;
        length  : natural
    );  

    Port (
        clk : in STD_LOGIC;
        rst : in STD_LOGIC;
        tvalid : out STD_LOGIC;
        tdata : out STD_LOGIC_VECTOR(7 downto 0);
        tlast : out STD_LOGIC;
        tready : in STD_LOGIC
        
    );
end entity;

architecture Behavioral of acceleraor is

end Behavioral;