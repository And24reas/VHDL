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