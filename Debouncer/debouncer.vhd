library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Debouncer is
Generic(clock_cycles: integer:=10);
port(clk: in std_logic;
     button: in std_logic;
     debounced: out std_logic
    );
end Debouncer;

architecture Behavioral of Debouncer is
signal clock_count: integer range 0 to clock_cycles-1;
signal debouncer: std_logic;
begin
  -- Copy internal signal to output
  debounced <= debouncer;
 DEBOUNCE_PROC : process(clk)
  begin
    if clk'event and clk='1' then
        if button/= debouncer then
            clock_count <= clock_count+1;
            if clock_count > clock_cycles -1 then
                debounced <= button;
            end if;
        else
            clock_count <= 0;
        end if; 
    end if;
  end process;
end Behavioral;
