library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity rw_synch_tb is
end rw_synch_tb;


architecture rw_synch_tb_arch of rw_synch_tb is
signal clk_tb : std_logic;
signal address_tb : std_logic_vector(1 downto 0);
signal data_in_tb : std_logic_vector(3 downto 0);
signal WE_tb : std_logic;
signal data_out_tb : std_logic_vector(3 downto 0);

component rw_synch
     Port ( 
        clk      : in std_logic;
        address  : in std_logic_vector(1 downto 0);
        data_in  : in std_logic_vector(3 downto 0);
        WE       : in std_logic;
        data_out : out std_logic_vector(3 downto 0)
  );
end component;

begin

DUT: rw_synch port map(clk_tb, address_tb, data_in_tb, WE_tb, data_out_tb);

clock_stimuli: process
    begin
        clk_tb <= '0'; wait for 10 ns;
        clk_tb <= '1'; wait for 10 ns;
    end process;
    
address_stimuli: process
    begin
        address_tb <= "00"; wait for 20 ns;
        address_tb <= "01"; wait for 20 ns;
        address_tb <= "10"; wait for 20 ns;
        address_tb <= "11"; wait for 20 ns;
     end process;
 
write_stimuli: process
    begin
        wait for 80 ns;
        WE_tb <= '1';
        data_in_tb <= "1110"; wait for 20 ns;
        data_in_tb <= "0010"; wait for 20 ns;
        data_in_tb <= "1111"; wait for 20 ns;
        data_in_tb <= "0000"; wait for 20 ns;
--        1110,0010,1111,0100,0000
        WE_tb <= '0';
        
    end process;
end rw_synch_tb_arch;
