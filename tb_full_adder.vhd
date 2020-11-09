library ieee;
use ieee.std_logic_1164.all;

entity tb_full_adder is
end tb_full_adder;

architecture tb of tb_full_adder is

    component full_adder
        port (A     : in std_logic;
              B     : in std_logic;
              CIN   : in std_logic;
              SUM   : out std_logic;
              COUT : out std_logic);
    end component;

    signal A     : std_logic;
    signal B     : std_logic;
    signal SUM   : std_logic;
    signal CIN   : std_logic;
    signal COUT : std_logic;

begin

    dut : full_adder
    port map (A     => A,
              B     => B,
              CIN   => CIN,
              SUM   => SUM,
              COUT => COUT);

    stimuli : process
    begin
    
        A <= '0';
        B <= '0';
        CIN <= '0';
        wait for 100ns;
        if(SUM/='0') then
            assert false report "SUM should be 0 for A=0 and B=0" severity error;
        end if;
        if(COUT/='0') then
            assert false report "CARRY should be 0 for A=0 and B=0" severity error;
        end if;
        
        A <= '0';
        B <= '0';
        CIN <= '1';
        wait for 100ns;
        if(SUM/='1') then
            assert false report "SUM should be 1 for A=0 and B=0 and CIN=1" severity error;
        end if;
        if(COUT/='1') then
            assert false report "CARRY should be 1 for A=0 and B=0 and CIN=1" severity error;
        end if;

        A <= '0';
        B <= '1';
        CIN <= '0';
        wait for 100ns;
        if(SUM/='1') then
            assert false report "CARRY should be 1 for A=0 and B=1 and CIN=0" severity error;
        end if;
        if(COUT/='0') then
            assert false report "CARRY should be 1 for A=0 and B=1 and CIN=0" severity error;
        end if;
        
        A <= '0';
        B <= '1';
        CIN <= '1';
        wait for 100ns;
        if(SUM/='0') then
            assert false report "SUM should be 1 for A=0 and B=1 and CIN=1" severity error;
        end if;
        if(COUT/='1') then
            assert false report "CARRY should be 0 for A=0 and B=1 and CIN=1" severity error;
        end if;
        
        A <= '1';
        B <= '0';
        CIN <= '0';
        wait for 100ns;
        if(SUM/='1') then
            assert false report "SUM should be 1 for A=1 and B=0 and CIN=0" severity error;
        end if;
        if(COUT/='0') then
            assert false report "CARRY should be 0 for A=1 and B=0 and CIN=0" severity error;
        end if;
        
        A <= '1';
        B <= '0';
        CIN <= '1';
        wait for 100ns;
        if(SUM/='0') then
            assert false report "SUM should be 1 for A=1 and B=0 and CIN=1" severity error;
        end if;
        if(COUT/='1') then
            assert false report "CARRY should be 0 for A=1 and B=0 and CIN=1" severity error;
        end if;
        
        A <= '1';
        B <= '1';
        CIN <= '0';
        wait for 100ns;
        if(SUM/='0') then
            assert false report "SUM should be 0 for A=1 and B=1 and CIN=0" severity warning;
        end if;
        if(COUT/='1') then
            assert false report "CARRY should be 1 for A=1 and B=1 and CIN=0" severity warning;
       end if;
       
        A <= '1';
        B <= '1';
        CIN <= '1';
        wait for 100ns;
        if(SUM/='1') then
            assert false report "SUM should be 0 for A=1 and B=1 and CIN=1" severity warning;
        end if;
        if(COUT/='1') then
            assert false report "CARRY should be 1 for A=1 and B=1 and CIN=1" severity warning;
       end if;

        A <= '0';
        B <= '0';
        CIN <= '0';                     
        wait;
    end process;

end tb;