library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

entity rw_synch is
  Port ( 
        clk      : in std_logic;
        address  : in std_logic_vector(1 downto 0);
        data_in  : in std_logic_vector(3 downto 0);
        WE       : in std_logic;
        data_out : out std_logic_vector(3 downto 0)
  );
end rw_synch;

architecture Behavioral of rw_synch is

type RW_type is array(0 to 3) of std_logic_vector(3 downto 0);
signal RW : RW_type;

begin
    process (clk)
        begin
            if(rising_edge(clk)) then
                if(WE = '1') then
                    RW(to_integer(unsigned(address))) <= data_in;
                else
                    data_out <= RW(to_integer(unsigned(address)));
                end if;
            end if;
    end process;


end Behavioral;
