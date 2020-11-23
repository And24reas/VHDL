
library ieee;
use ieee.std_logic_1164.all;

entity Mux_Leds_tb is
end Mux_Leds_tb;

architecture tb of Mux_Leds_tb is

    component Mux_Leds
        port (A         : in std_logic_vector (3 downto 0);
              B         : in std_logic_vector (3 downto 0);
              C         : in std_logic_vector (3 downto 0);
              D         : in std_logic_vector (3 downto 0);
              E         : in std_logic_vector (3 downto 0);
              F         : in std_logic_vector (3 downto 0);
              Sel       : in std_logic_vector (1 downto 0);
              State     : in std_logic;
              Condition : in std_logic_vector (1 downto 0);
              Leds      : out std_logic_vector (7 downto 0));
    end component;

    signal A         : std_logic_vector (3 downto 0);
    signal B         : std_logic_vector (3 downto 0);
    signal C         : std_logic_vector (3 downto 0);
    signal D         : std_logic_vector (3 downto 0);
    signal E         : std_logic_vector (3 downto 0);
    signal F         : std_logic_vector (3 downto 0);
    signal Sel       : std_logic_vector (1 downto 0);
    signal State     : std_logic;
    signal Condition : std_logic_vector (1 downto 0);
    signal Leds      : std_logic_vector (7 downto 0);

begin

    dut : Mux_Leds
    port map (A         => A,
              B         => B,
              C         => C,
              D         => D,
              E         => E,
              F         => F,
              Sel       => Sel,
              State     => State,
              Condition => Condition,
              Leds      => Leds);

    stimuli : process
    begin
        -- EDIT Adapt initialization as needed
        -- 21:37:42 = HH:MM:SS
        A <= "0010";    -- 2
        B <= "0001";    -- 1
        C <= "0011";    -- 3
        D <= "0111";    -- 7
        E <= "0100";    -- 4
        F <= "0010";    -- 2
        Condition <= (others => '0');

        State <= '0';
        Sel <= "10";        
        wait for 100ns;
        if(Leds/="00100001") then
            assert false report "Leds should be 00100001 for State=0 and Sel=10" severity error;
        end if;

        Sel <= "01";        
        wait for 100ns;
        if(Leds/="00110111") then
            assert false report "Leds should be 00110111 for State=0 and Sel=01" severity error;
        end if;        

        Sel <= "00";        
        wait for 100ns;
        if(Leds/="01000010") then
            assert false report "Leds should be 01000010 for State=0 and Sel=00" severity error;
        end if;                

        State <= '1';
        Condition <= "00";        
        wait for 100ns;
        if(Leds/="00100001") then
            assert false report "Leds should be 00100001 for State=1 and Condition=01" severity error;
        end if; 
        
        Condition <= "01";        
        wait for 100ns;
        if(Leds/="00110111") then
            assert false report "Leds should be 00110111 for State=0 and Condition=01" severity error;
        end if;        

        Condition <= "10";        
        wait for 100ns;
        if(Leds/="01000010") then
            assert false report "Leds should be 01000010 for State=0 and Condition=10" severity error;
        end if;           
        -- EDIT Add stimuli here

        wait;
    end process;

end tb;