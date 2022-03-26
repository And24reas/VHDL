library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity ROM_asynch_tb is
end entity;

architecture ROM_asynch_tb_arch of ROM_asynch_tb is
    signal address_tb   : std_logic_vector (1 downto 0);
    signal data_out_tb : std_logic_vector (3 down to 0);

    component ROM_asynch
        port (address : in std_logic_vector(1 downto 0);
                data: out std_logic_vector (3 downto 0));
    end component;

begin
    DUT: ROM_asynch port map (address_tb, data_out_tb);

    adress stimulation: process
    begin
        address_tb <= "00"; wait for 25 ns;
        address_tb <= "01"; wait for 25 ns;
        address_tb <= "10"; wait for 25 ns;
        address_tb <= "11"; wait for 25 ns;
        
    end process;

end architecture;