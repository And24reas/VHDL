library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity TPG is
    Generic(Data_Width: integer:= 16);
    Port (
        clk: in std_logic;
        rst: in std_logic;
        hSynch: out std_logic;
        vSynch: out std_logic; 
        data: out std_logic_vector(Data_Width-1 downto 0);
        dataEnable: out std_logic);
       
end TPG;

architecture Behavioral of TPG is

type vertical_State is (Init, V_Synch, V_Frame, V_FrontPorch, V_BackPorch);
type horizontal_State is (H_Synch, H_FrontPorch, H_Line, H_BackPorch);
------- Signal Declarations -------------------------------------------
signal v_state: vertical_state;
signal h_state: horizontal_state;
signal data_flag: std_logic:= '0';
signal s_hSynch : std_logic;
signal s_vSynch : std_logic;
signal s_dataEnable: std_logic;
signal n_lines: unsigned(Data_Width-1 downto 0):= to_unsigned(8, Data_Width);

-------- Horizontal Timing Constraints --------------------------------
--signal h_Total: unsigned(Data_Width-1 downto 0):=to_unsigned(880, Data_Width);
signal h_Front_Porch: unsigned(Data_Width-1 downto 0):= to_unsigned(8, Data_Width);
signal h_Back_Porch: unsigned(Data_Width-1 downto 0):= to_unsigned(40, Data_Width);
signal h_Synch_count: unsigned(Data_Width-1 downto 0):= to_unsigned(32, Data_Width);
signal h_Active: unsigned(Data_Width-1 downto 0):= to_unsigned(800, Data_Width);

-------- Vertical Timing Constraints ----------------------------------
--signal v_Total: unsigned(Data_Width-1 downto 0):= to_unsigned(618, Data_Width);
signal v_Front_Porch: unsigned(Data_Width-1 downto 0):= to_unsigned(4, Data_Width);
signal v_Back_Porch: unsigned(Data_Width-1 downto 0):= to_unsigned(6, Data_width);
signal v_Synch_count: unsigned(Data_Width-1 downto 0):= to_unsigned(8, Data_Width); --
signal v_Active: unsigned(Data_Width-1 downto 0):= to_unsigned(600, Data_Width);  

-------- Test Pattern YCbCr -------------------------------------------
constant data_out: std_logic_vector(Data_Width-1 downto 0):= "1111111110000000";
--constant s_data_luma: std_logic_vector(7 downto 0) := "11111111";
--constant s_data_chroma: std_logic_vector(7 downto 0):= "10000000";

begin
state_machine: process(clk) is
    begin
        if rising_edge(clk) then
            case v_state is
                when Init => 
                    s_hSynch <= '1';
                    s_vSynch <= '1';
                    h_Synch_count <= h_Synch_count - 1;
                    s_dataEnable <= '0';
                    v_state <= V_Synch;
                    h_state <= h_Synch;
                when V_Synch =>
                    case h_state is
                        when h_Synch =>
                            if h_Synch_count-1 = 0 then
                                h_Synch_count <= to_unsigned(32, Data_Width);
                                s_hSynch <= '0';
                                h_state <= H_FrontPorch;
                            else 
                                h_Synch_count <= h_Synch_count - 1;
                            end if;
                        when h_FrontPorch =>
                            if h_Front_Porch-1 = 0 then
                                h_Front_Porch <= to_unsigned(8, Data_Width);
                                h_state <= h_Line;
                            else 
                                h_Front_Porch <= h_Front_Porch - 1;
                            end if;
                        when h_Line =>
                            if h_active-1 = 0 then
                                h_active <= to_unsigned(800, Data_Width);
                                h_state <= H_BackPorch;
                            else 
                                h_active <= h_active - 1;
                            end if;
                        when h_BackPorch =>
                            if h_Back_Porch-1 = 0 then
                                h_Back_Porch <= to_unsigned(40, Data_Width);
                                s_hSynch <= '1';
                                h_state <= H_Synch;
                                v_synch_count <= v_synch_count - 1;
                                
                                if v_synch_count-1 = 0 then
                                    v_Synch_count <= to_unsigned(8, Data_Width);
                                    v_state <= V_FrontPorch;
                                    s_vSynch <= '0';
                                end if;
                            else 
                                h_Back_Porch <= h_Back_Porch - 1;
                            end if;
                        end case;
                when V_FrontPorch =>
                    case h_state is
                        when h_Synch =>
                            if h_Synch_count-1 = 0 then
                                h_Synch_count <= to_unsigned(32, Data_Width);
                                s_hSynch <= '0';
                                h_state <= H_FrontPorch;
                            else 
                                h_Synch_count <= h_Synch_count - 1;
                            end if;
                        when h_FrontPorch =>
                            if h_Front_Porch-1 = 0 then
                                h_Front_Porch <= to_unsigned(8, Data_Width);
                                h_state <= h_Line;
                            else 
                                h_Front_Porch <= h_Front_Porch - 1;
                            end if;
                        when h_Line =>
                            if h_active-1 = 0 then
                                h_active <= to_unsigned(800, Data_Width);
                                h_state <= H_BackPorch;
                            else 
                                h_active <= h_active - 1;
                            end if;
                        when h_BackPorch =>
                            if h_Back_Porch-1 = 0 then
                                h_Back_Porch <= to_unsigned(40, Data_Width);
                                s_hSynch <= '1';
                                h_state <= H_Synch;
                                v_Front_Porch <= v_Front_Porch - 1;
                                
                                if v_Front_Porch-1 = 0 then
                                    v_Front_Porch <= to_unsigned(4, Data_Width);
                                    v_state <= V_Frame;
                                end if;
                            else 
                                h_Back_Porch <= h_Back_Porch - 1;
                            end if;
                    end case;
                when V_Frame =>                
                    case h_state is
                        when h_Synch =>
                            if h_Synch_count-1 = 0 then
                                h_Synch_count <= to_unsigned(32, Data_Width);
                                s_hSynch <= '0';
                                h_state <= H_FrontPorch;
                            else 
                                h_Synch_count <= h_Synch_count - 1;
                            end if;
                        when h_FrontPorch =>
                            if h_Front_Porch-1 = 0 then
                                h_Front_Porch <= to_unsigned(8, Data_Width);
                                h_state <= h_Line;
                                s_dataEnable <= '1';
                            else 
                                h_Front_Porch <= h_Front_Porch - 1;
                            end if;
                        when h_Line =>
                            if h_active-1 = 0 then
                                h_active <= to_unsigned(800, Data_Width);
                                h_state <= H_BackPorch;
                                s_dataEnable <= '0';
                            else 
                                h_active <= h_active - 1;
                            end if;
                        when h_BackPorch =>
                            if h_Back_Porch-1 = 0 then
                                h_Back_Porch <= to_unsigned(40, Data_Width);
                                s_hSynch <= '1';
                                h_state <= H_Synch;
                                v_Active <= v_Active - 1;
                                if v_Active-1 = 0 then
                                    v_Active <= to_unsigned(600, Data_Width);
                                    v_state <= V_BackPorch;
                                end if;
                            else 
                                h_Back_Porch <= h_Back_Porch - 1;
                            end if;
                    end case;
                when V_BackPorch =>
                    case h_state is
                        when h_Synch =>
                            if h_Synch_count-1 = 0 then
                                h_Synch_count <= to_unsigned(32, Data_Width);
                                s_hSynch <= '0';
                                h_state <= H_FrontPorch;
                            else 
                                h_Synch_count <= h_Synch_count - 1;
                            end if;
                        when h_FrontPorch =>
                            if h_Front_Porch-1 = 0 then
                                h_Front_Porch <= to_unsigned(8, Data_Width);
                                h_state <= h_Line;
                            else 
                                h_Front_Porch <= h_Front_Porch - 1;
                            end if;
                        when h_Line =>
                            if h_active-1 = 0 then
                                h_active <= to_unsigned(800, Data_Width);
                                h_state <= H_BackPorch;
                            else 
                                h_active <= h_active - 1;
                            end if;
                        when h_BackPorch =>
                            if h_Back_Porch-1 = 0 then
                                h_Back_Porch <= to_unsigned(40, Data_Width);
                                s_hSynch <= '1';
                                h_state <= H_Synch;
                                v_Back_Porch <= v_Back_Porch - 1;
                                if v_Back_Porch = 0 then
                                    v_Back_Porch <= to_unsigned(6, Data_Width);
                                    s_vSynch <= '1';
                                    v_state <= V_Synch;
                                end if;
                            else 
                                h_Back_Porch <= h_Back_Porch - 1;
                            end if;
                    end case;
            end case;
        end if;
    end process;

vSynch <= s_vSynch;
hSynch <= s_hSynch;
dataEnable <= s_dataEnable;
data <= data_out;
end Behavioral;
