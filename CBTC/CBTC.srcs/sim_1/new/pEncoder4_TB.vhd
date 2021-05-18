----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/13/2021 01:32:24 AM
-- Design Name: 
-- Module Name: pEncoder4_TB - Behavioral
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

entity pEncoder4_TB is
--  Port ( );
end pEncoder4_TB;

architecture Behavioral of pEncoder4_TB is

component pEncoder4 is
    Port ( x : in UNSIGNED (3 downto 0);
           y : out UNSIGNED (1 downto 0);
           valid : out STD_LOGIC);
end component;

signal x : UNSIGNED (3 downto 0);
signal y : UNSIGNED (1 downto 0);
signal valid : STD_LOGIC;

begin

UUT : pEncoder4 port map(x=> x, y=> y, valid=> valid);

process is
    constant period: time := 20 ns;
begin
    report "Testing pEncoder4...";

    x <= "0000";
    wait for period;
    assert (y = "00" AND valid = '0') report "test failed for input combination 0000" severity error;
    
    x <= "0001";
    wait for period;
    assert (y = "00" AND valid = '1') report "test failed for input combination 0001" severity error;
    
    x <= "0010";
    wait for period;
    assert (y = "01" AND valid = '1') report "test failed for input combination 0010" severity error;
    
    x <= "0011";
    wait for period;
    assert (y = "01" AND valid = '1') report "test failed for input combination 0011" severity error;
    
    x <= "0100";
    wait for period;
    assert (y = "10" AND valid = '1') report "test failed for input combination 0100" severity error;
    
    x <= "0101";
    wait for period;
    assert (y = "10" AND valid = '1') report "test failed for input combination 0101" severity error;
    
    x <= "0110";
    wait for period;
    assert (y = "10" AND valid = '1') report "test failed for input combination 0110" severity error;
    
    x <= "0111";
    wait for period;
    assert (y = "10" AND valid = '1') report "test failed for input combination 0111" severity error;
    
    x <= "1000";
    wait for period;
    assert (y = "11" AND valid = '1') report "test failed for input combination 1000" severity error;
    
    x <= "1001";
    wait for period;
    assert (y = "11" AND valid = '1') report "test failed for input combination 1001" severity error;
    
    x <= "1010";
    wait for period;
    assert (y = "11" AND valid = '1') report "test failed for input combination 1010" severity error;
    
    x <= "1011";
    wait for period;
    assert (y = "11" AND valid = '1') report "test failed for input combination 1011" severity error;
    
    x <= "1100";
    wait for period;
    assert (y = "11" AND valid = '1') report "test failed for input combination 1100" severity error;
    
    x <= "1101";
    wait for period;
    assert (y = "11" AND valid = '1') report "test failed for input combination 1101" severity error;
    
    x <= "1110";
    wait for period;
    assert (y = "11" AND valid = '1') report "test failed for input combination 1110" severity error;
    
    x <= "1111";
    wait for period;
    assert (y = "11" AND valid = '1') report "test failed for input combination 1111" severity error;
    
    report "Done testing pEncoder4...";
    wait;
end process;

end Behavioral;
