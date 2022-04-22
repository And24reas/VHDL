library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;
use work.functions.all;

entity EDF is
	generic (
    ARBITER_W        : natural := 256;
    Acc_Periods      : acc_periods;
    Acc_Lengths      : acc_lengths
    );
Port (
    clk :    in std_logic;
    rst :    in std_logic;   
    -- Inputs
    req_tvalid :    in std_logic_vector (ARBITER_W-1 downto 0);
    req_tlast :    in std_logic_vector (ARBITER_W-1 downto 0);
    -- Outputs
    gnt :    out std_logic_vector (ARBITER_W-1 downto 0)
    );
end EDF;

architecture Behavioral of EDF is

    -- Types
    type t_priorities is array(ARBITER_W-1 downto 0) of std_logic_vector(31 downto 0);
    type t_states is (Init, WaitingRequests, FindMin, FindMinIndex, SetGnt, WaitTlast, UpdatePriorities);
    type t_deadlines is array (3 downto 0) of integer;

     
    -- Functions
    
--    function initDeadlines return t_deadlines is
--        variable deadlines : t_deadlines;
--    begin
--        for i in 0 to Acc_Periods'length loop
--            deadlines(i) := acc_periods(i) + acc_lengths(i);
--        end loop;
--        return deadlines;
--   end function;
    
    function initPriorities return t_priorities is
        variable priorities : t_priorities ;
    begin
        for i in 0 to ARBITER_W-1 loop
            priorities(i) := std_logic_vector(to_signed(acc_periods(i) + acc_lengths(i), 32));
           -- deadlines(i) := acc_periods(i) + acc_lengths(i);
        end loop;
        return priorities;
    end function;
        
    function findMin(requests : std_logic_vector(ARBITER_W-1 downto 0); priorities : t_priorities) return integer is
        variable min : integer;
        variable minSet : std_logic := '0';
    begin
        for i in 0 to ARBITER_W-1 loop
            if(requests(i) = '1') then
                if(minSet = '0') then
                    min := to_integer(unsigned(priorities(i)));
                    minSet := '1';
                end if;
                if(to_integer(unsigned(priorities(i)))<min) then
                    min := to_integer(unsigned(priorities(i)));
                end if;
            end if;
        end loop;
        return min;
    end function;    
    
    function findMinIndex(min : std_logic_vector(31 downto 0); priorities : t_priorities) return integer is
        variable minIndex : integer;
        variable minSet : std_logic := '0';
    begin
        for i in 0 to ARBITER_W-1 loop
            if(priorities(i) = min) then
                minIndex := i;
            end if;
        end loop;
        return minIndex;
    end function;  
    
    function assignGnt(minIndex : std_logic_vector(31 downto 0)) return std_logic_vector is
        variable gnt : std_logic_vector (ARBITER_W-1 downto 0) := (others=>'0');
    begin
        for i in 0 to ARBITER_W-1 loop
            if(i=minIndex) then
                gnt(i) := '1';
            else
                gnt(i) := '0';
            end if;
        end loop;
        return gnt;
    end function;
        
    function CountMisses(oldMisses : t_priorities; minIndex : std_logic_vector(31 downto 0); req : std_logic_vector (ARBITER_W-1 downto 0)) return t_priorities is
        variable newMisses : t_priorities := (others=>(others=>'0'));
    begin
        for i in 0 to ARBITER_W-1 loop
            if(minIndex/=i and req(i)='1') then
                newMisses(i) := oldMisses(i) + '1';
            else
                newMisses(i) := (others=>'0');
            end if;
        end loop;
        return newMisses;
    end function;    
    
    function updatePriorities(minIndex : std_logic_vector(31 downto 0); oldPriorities : t_priorities) return t_priorities is
        variable newPriorities : t_priorities := (others=>(others=>'0'));
    begin
        for i in 0 to ARBITER_W-1 loop
            newPriorities(i) := oldPriorities(i);
            if(i=minIndex) then
                newPriorities(i) := std_logic_vector(to_unsigned(ARBITER_W-1, 32));
            else
                if(newPriorities(i) > 0) then
                    newPriorities(i) := newPriorities(i) - '1';
                end if;
            end if;
        end loop;
        return newPriorities;
    end function;
    
    -- Signals
    signal s_priorities : t_priorities := (others => (others=>'0'));
    signal s_state : t_states := Init;    
    signal s_min, s_minIndex: std_logic_vector(31 downto 0) := (others=>'0');
    signal s_gnt : std_logic_vector (ARBITER_W-1 downto 0) := (others=>'0');
    signal s_counterMisses : t_priorities := (others => (others=>'0'));
    
begin

    newState: process(clk, rst)
    begin
        if(rst='0') then
            s_state <= Init;
        elsif(rising_edge(clk)) then
            case s_state is
                when Init =>
                    s_state <= WaitingRequests;
                    s_priorities <= initPriorities;
                    s_gnt <= (others=>'0');                    
                when WaitingRequests =>
                    s_gnt <= (others=>'0');
                    if(req_tvalid/=0) then
                        s_state <=FindMin;
                    end if;
                when FindMin =>
                    s_min <= std_logic_vector(to_unsigned(findMin(req_tvalid, s_priorities), s_min'length));
                    s_gnt <= (others=>'0');
                    s_state <= FindMinIndex;
                when FindMinIndex =>
                    s_minIndex <= std_logic_vector(to_unsigned(findMinIndex(s_min, s_priorities), s_minIndex'length));
                    s_gnt <= (others=>'0');                     
                    s_state <= SetGnt;
                when SetGnt =>
                    s_gnt <= assignGnt(s_minIndex);
                    s_counterMisses <= CountMisses(s_counterMisses, s_minIndex, req_tvalid);                    
                    s_state <= WaitTlast;
                when WaitTlast =>
                    s_gnt <= assignGnt(s_minIndex);
                    if(req_tlast/=0) then
                        s_gnt <= (others=>'0');
                        s_state <= UpdatePriorities; 
                    end if;
                when UpdatePriorities =>
                    s_priorities <= updatePriorities(s_minIndex, s_priorities);
                    s_gnt <= (others=>'0');                    
                    s_state <= WaitingRequests;
                when others =>
                    s_state <= s_state;
                    s_gnt <= (others=>'0');
            end case;
        end if;
    end process;
    
    gnt <= s_gnt;

end Behavioral;