----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/13/2021 01:44:13 AM
-- Design Name: 
-- Module Name: pEncoder16_TB - Behavioral
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

entity pEncoder16_TB is
--  Port ( );
end pEncoder16_TB;

architecture Behavioral of pEncoder16_TB is

component pEncoder16 is
    Port ( x : in UNSIGNED (15 downto 0);
           y : out UNSIGNED (3 downto 0);
           valid : out STD_LOGIC);
end component;

signal x : UNSIGNED (15 downto 0);
signal y : UNSIGNED (3 downto 0);
signal valid : STD_LOGIC;

begin

UUT : pEncoder16 port map(x=> x, y=> y, valid=> valid);

process is
    constant period: time := 20 ns;
begin
    report "Testing pEncoder16...";
    
    x <= "0000000000000000";
    wait for period;
    assert (y = "0000" AND valid = '0') report "test failed for input combination 0000000000000000" severity error;
    
    x <= "0000000000000001";
    wait for period;
    assert (y = "0000" AND valid = '1') report "test failed for input combination 0000000000000001" severity error;
    
    x <= "0000000000001001";
    wait for period;
    assert (y = "0011" AND valid = '1') report "test failed for input combination 0000000000001001" severity error;
        
    x <= "0000000000100101";
    wait for period;
    assert (y = "0101" AND valid = '1') report "test failed for input combination 0000000000100101" severity error;
        
    x <= "0000000010000000";
    wait for period;
    assert (y = "0111" AND valid = '1') report "test failed for input combination 0000000010000000" severity error;
    
    x <= "0000010000000000";
    wait for period;
    assert (y = "1010" AND valid = '1') report "test failed for input combination 0000010000000000" severity error;
    
    x <= "0011010000000000";
    wait for period;
    assert (y = "1101" AND valid = '1') report "test failed for input combination 0011010000000000" severity error;
    
    x <= "1011010000000000";
    wait for period;
    assert (y = "1111" AND valid = '1') report "test failed for input combination 1011010000000000" severity error;
        
    x <= "1000000000000000";
    wait for period;
    assert (y = "1111" AND valid = '1') report "test failed for input combination 1000000000000000" severity error;
    
    report "Done testing pEncoder16...";
    wait;
end process;

end Behavioral;
