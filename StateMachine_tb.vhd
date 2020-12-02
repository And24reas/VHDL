library ieee;
use ieee.std_logic_1164.all;

entity StateMachine_tb is
end StateMachine_tb;

architecture tb of StateMachine_tb is

    component StateMachine
        Port ( Clk : in STD_LOGIC;
               Reset : in STD_LOGIC;
               PB_Left : in STD_LOGIC;
               PB_Right : in STD_LOGIC;
               PB_Center : in STD_LOGIC;
               RW : out STD_LOGIC;
               Condition : out STD_LOGIC_VECTOR (1 downto 0));
    end component;
    
    signal Clk : STD_LOGIC;
    signal Reset : STD_LOGIC;
    signal PB_Left : STD_LOGIC;
    signal PB_Right : STD_LOGIC;
    signal PB_Center : STD_LOGIC;
    signal RW : STD_LOGIC;
    signal Condition : STD_LOGIC_VECTOR (1 downto 0);
    
    constant clock_period: time := 10 ns;
    signal stop_the_clock: boolean;
    
begin

    dut : StateMachine
        Port map ( 
           Clk => Clk,
           Reset => Reset,
           PB_Left => PB_Left,
           PB_Right => PB_Right,
           PB_Center => PB_Center,
           RW => RW,
           Condition => Condition
           );

    stimuli : process
    begin
        Reset <= '0';
        PB_Left <= '0';
        PB_Right <= '0';
        PB_Center <= '0';   

        wait for clock_period;
        if(RW/='0' and Condition/="00") then
            assert false report "State should be Read, RW=0 and Condition=00" severity error;
        end if;
        
        wait for clock_period;
        PB_Right <= '1';
        wait for clock_period;
        PB_Right <= '0';        
        wait for clock_period;
        if(RW/='0' and Condition/="00") then
            assert false report "State should be Read, RW=0 and Condition=00" severity error;
        end if;

        wait for clock_period;
        PB_Left <= '1';
        wait for clock_period;
        PB_Left <= '0';        
        wait for clock_period;
        if(RW/='0' and Condition/="00") then
            assert false report "State should be Read, RW=0 and Condition=00" severity error;
        end if;
        
        wait for clock_period;
        PB_Center <= '1';
        wait for clock_period;
        PB_Center <= '0';        
        wait for clock_period;
        if(RW/='1' and Condition/="01") then
            assert false report "State should be Write_H, RW=1 and Condition=01" severity error;
        end if; 
        
        wait for clock_period;
        PB_Right <= '1';
        wait for clock_period;
        PB_Right <= '0';        
        wait for clock_period;
        if(RW/='1' and Condition/="10") then
            assert false report "State should be Write_M, RW=1 and Condition=10" severity error;
        end if;    
        
        wait for clock_period;
        PB_Right <= '1';
        wait for clock_period;
        PB_Right <= '0';        
        wait for clock_period;
        if(RW/='1' and Condition/="11") then
            assert false report "State should be Write_S, RW=1 and Condition=11" severity error;
        end if;   
        
        wait for clock_period;
        PB_Right <= '1';
        wait for clock_period;
        PB_Right <= '0';        
        wait for clock_period;
        if(RW/='1' and Condition/="01") then
            assert false report "State should be Write_H, RW=1 and Condition=01" severity error;
        end if;               
        
        wait for clock_period;
        PB_Left <= '1';
        wait for clock_period;
        PB_Left <= '0';        
        wait for clock_period;
        if(RW/='1' and Condition/="11") then
            assert false report "State should be Write_S, RW=1 and Condition=11" severity error;
        end if;   
        
        wait for clock_period;
        PB_Left <= '1';
        wait for clock_period;
        PB_Left <= '0';        
        wait for clock_period;
        if(RW/='1' and Condition/="10") then
            assert false report "State should be Write_M, RW=1 and Condition=10" severity error;
        end if;               
        
        wait for clock_period;
        PB_Left <= '1';
        wait for clock_period;
        PB_Left <= '0';        
        wait for clock_period;
        if(RW/='1' and Condition/="01") then
            assert false report "State should be Write_H, RW=1 and Condition=01" severity error;
        end if;                    
        
        wait for clock_period;
        PB_Center <= '1';
        wait for clock_period;
        PB_Center <= '0';        
        wait for clock_period;
        if(RW/='0' and Condition/="00") then
            assert false report "State should be Read, RW=1 and Condition=10" severity error;
        end if;            
       
        wait;
    end process;
    
  clocking: process
      begin
        while not stop_the_clock loop
          clk <= '1', '0' after clock_period / 2;
          wait for clock_period;
        end loop;
        wait;
      end process;  
          
end tb;