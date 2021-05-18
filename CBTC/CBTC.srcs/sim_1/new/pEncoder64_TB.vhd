----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/13/2021 02:10:31 AM
-- Design Name: 
-- Module Name: pEncoder64_TB - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity pEncoder64_TB is
--  Port ( );
end pEncoder64_TB;

architecture Behavioral of pEncoder64_TB is

component pEncoder64 is
    Port ( x : in UNSIGNED (63 downto 0);
           y : out UNSIGNED (5 downto 0);
           valid : out STD_LOGIC);
end component;

signal x : UNSIGNED (63 downto 0);
signal y : UNSIGNED (5 downto 0);
signal valid : STD_LOGIC;

begin

UUT : pEncoder64 port map(x=> x, y=> y, valid=> valid);

process is
    constant period: time := 20 ns;
begin
    report "Testing pEncoder64...";
    
    x <= "0000000000000000000000000000000000000000000000000000000000000000";
    wait for period;
    assert (y = "000000" AND valid='0') report "test failed for input combination 0000000000000000000000000000000000000000000000000000000000000000" severity error;
    
    x <= "0000000000000000000000000000000000000000000000000000000000000001";
    wait for period;
    assert (y = "000000" AND valid='1') report "test failed for input combination 0000000000000000000000000000000000000000000000000000000000000001" severity error;
    
    x <= "0000000000000000000000000000000000000000000000000000000100010001";
    wait for period;
    assert (y = "001000" AND valid='1') report "test failed for input combination 0000000000000000000000000000000000000000000000000000000100010001" severity error;
    
    x <= "0000000000000000000000000000000000000000010000000000000000000000";
    wait for period;
    assert (y = "010110" AND valid='1') report "test failed for input combination 0000000000000000000000000000000000000000010000000000000000000000" severity error;
    
    x <= "0000000000000000000000000000000010100000010000000000000000100000";
    wait for period;
    assert (y = "011111" AND valid='1') report "test failed for input combination 0000000000000000000000000000000010100000010000000000000000100000" severity error;
    
    x <= "0000000000000000000000000000000010000000000000000000000000000000";
    wait for period;
    assert (y = "011111" AND valid='1') report "test failed for input combination 0000000000000000000000000000000010000000000000000000000000000000" severity error;
        
    x <= "0000000000000000000000000000000100000000000000000000000000000000";
    wait for period;
    assert (y = "100000" AND valid='1') report "test failed for input combination 0000000000000000000000000000000100000000000000000000000000000000" severity error;
    
    x <= "0000000000000000001010000000000000001000000000000000000011000000";
    wait for period;
    assert (y = "101101" AND valid='1') report "test failed for input combination 0000000000000000001010000000000000001000000000000000000011000000" severity error;
    
    x <= "0100000000000000001010000000000000001000000000000000000011000000";
    wait for period;
    assert (y = "111110" AND valid='1') report "test failed for input combination 0100000000000000001010000000000000001000000000000000000011000000" severity error;
    
    x <= "1100000000000000001010000000000000001000000000000000000011000000";
    wait for period;
    assert (y = "111111" AND valid='1') report "test failed for input combination 1100000000000000001010000000000000001000000000000000000011000000" severity error;
    
    x <= "1111111111111111111111111111111111111111111111111111111111111111";
    wait for period;
    assert (y = "111111" AND valid='1') report "test failed for input combination 1111111111111111111111111111111111111111111111111111111111111111" severity error;
    
    x <= "1000000000000000000000000000000000000000000000000000000000000000";
    wait for period;
    assert (y = "111111" AND valid='1') report "test failed for input combination 1000000000000000000000000000000000000000000000000000000000000000" severity error;
        
    report "Done testing pEncoder64...";
    wait;
end process;

end Behavioral;