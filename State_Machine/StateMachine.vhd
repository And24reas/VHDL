----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/08/2020 02:19:42 PM
-- Design Name: 
-- Module Name: StateMachine - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity StateMachine is
--  Port ( );
Port ( Clk : in STD_LOGIC;
 Reset : in STD_LOGIC;
 PB_Left : in STD_LOGIC;
 PB_Right : in STD_LOGIC;
 PB_Center : in STD_LOGIC;
 RW : out STD_LOGIC;
 Condition : out STD_LOGIC_VECTOR (1 downto 0));
 type state_type IS(Read,WriteH,WriteM,WriteS);
end StateMachine;

architecture Behavioral of StateMachine is
    Signal next_state, state: state_type;
    Signal s_RW: std_logic;
begin
SYNC_PROC: process(Clk)
    begin
        if clk'event and clk = '1' then
            if reset = '1' then
                state <= Read;
                
                Condition <= "00";
            else
                state <= next_state;
            end if;
        end if;
    end process;

NEXT_STATE_DECODE: process (state,PB_Left,PB_Right,PB_Center)
begin
    if PB_Left='1' then
        case (state) is
            when Read =>
                RW <= '0';
                Condition <= "00";
            when WriteH =>
                next_state <= WriteS;
                Condition <= "11";
            When WriteM =>
                next_state <= WriteH;
                Condition <= "01";
            When WriteS =>
                next_state <= WriteM;
                Condition <= "10";
        end case;
    end if;
    if PB_Right='1' then
        case (state) is
            when Read =>
                RW <= '0';
                Condition <= "00";
            when WriteH =>
                next_state <= WriteM;
                Condition <= "10";
            When WriteM =>
                next_state <= WriteS;
                Condition <= "11";
            When WriteS =>
                next_state <= WriteH;
                Condition <= "01";
        end case;
    end if;
    if PB_Center='1' then
        case (state) is
            when Read =>
                RW <= '1';
                next_state <= WriteH;
                Condition <= "01";
            when WriteH =>
                RW <= '0';
                next_state <= Read;
                Condition <= "00";
            When WriteM =>
                RW <= '0';
                next_state <= Read;
                Condition <= "00";
            When WriteS =>
                RW <= '0';
                next_state <= Read;
                Condition <= "00";
        end case;
    end if;
end process;

end Behavioral;
