library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
USE ieee.numeric_std.all;

library xil_defaultlib;
use xil_defaultlib.ripple_adder;

entity ripple_adder_tb is
end ripple_adder_tb;

architecture Behavioral of ripple_adder_tb is

    constant WIDTH : integer := 8;

    -- signals
    signal in1 : std_logic_vector(WIDTH-1 downto 0);
    signal in2 : std_logic_vector(WIDTH-1 downto 0);
    signal sum : std_logic_vector(WIDTH-1 downto 0);
    signal carry : std_logic;

begin

    uut: entity xil_defaultlib.ripple_adder 
    generic map (WIDTH)
    port map (
        A => in1,
        B => in2,
        SUM => sum,
        COUT => carry 
    );

    stim_proc: process
    begin

        in1 <= (others => '0');
        in2 <= (others => '0');
        wait for 10 ns;

        in1 <= std_logic_vector(to_unsigned(2, WIDTH));
        in2 <= std_logic_vector(to_unsigned(3, WIDTH));
        wait for 10 ns;
        
        in1 <= std_logic_vector(to_unsigned(15, WIDTH));
        in2 <= std_logic_vector(to_unsigned(8, WIDTH));
        wait for 10 ns;

        in1 <= std_logic_vector(to_unsigned(200, WIDTH));
        in2 <= std_logic_vector(to_unsigned(100, WIDTH));
        wait for 10 ns;
        
        in1 <= (others => '0');
        in2 <= (others => '0');
        wait;        
 
    end process;


end Behavioral;