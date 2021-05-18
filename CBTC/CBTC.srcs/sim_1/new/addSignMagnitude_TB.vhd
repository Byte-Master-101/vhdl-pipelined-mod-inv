----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/16/2021 11:30:42 PM
-- Design Name: 
-- Module Name: addSignMagnitude_TB - Behavioral
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
use work.common.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity addSignMagnitude_TB is
--  Port ( );
end addSignMagnitude_TB;

architecture Behavioral of addSignMagnitude_TB is

component addSignMagnitude is
    Port ( a : in SIGN_MAGNITUDE;
           b : in SIGN_MAGNITUDE;
           c : out SIGN_MAGNITUDE);
end component;

signal a,b,c : SIGN_MAGNITUDE;

begin

UUT : addSignMagnitude port map(a=> a, b=> b, c=> c);

process is
    constant period: time := 20 ns;
begin
    report "Testing addSignMagnitude...";
    
    a.sign <= '0';
    a.magnitude <= to_unsigned(0, 256);
    b.sign <= '0';
    b.magnitude <= to_unsigned(0, 256);
    wait for period;
    assert (c.sign = '0' AND c.magnitude = 0) report "test failed for input combination 1" severity error;
    
    a.sign <= '0';
    a.magnitude <= to_unsigned(5000, 256);
    b.sign <= '0';
    b.magnitude <= to_unsigned(0, 256);
    wait for period;
    assert (c.sign = '0' AND c.magnitude = 5000) report "test failed for input combination 2" severity error;
    
    a.sign <= '0';
    a.magnitude <= to_unsigned(0, 256);
    b.sign <= '0';
    b.magnitude <= to_unsigned(5000, 256);
    wait for period;
    assert (c.sign = '0' AND c.magnitude = 5000) report "test failed for input combination 3" severity error;
        
    a.sign <= '0';
    a.magnitude <= to_unsigned(10000, 256);
    b.sign <= '0';
    b.magnitude <= to_unsigned(5000, 256);
    wait for period;
    assert (c.sign = '0' AND c.magnitude = 15000) report "test failed for input combination 4" severity error;
    
    a.sign <= '0';
    a.magnitude <= to_unsigned(10000, 256);
    b.sign <= '1';
    b.magnitude <= to_unsigned(3000, 256);
    wait for period;
    assert (c.sign = '0' AND c.magnitude = 7000) report "test failed for input combination 5" severity error;
        
    a.sign <= '1';
    a.magnitude <= to_unsigned(3000, 256);
    b.sign <= '0';
    b.magnitude <= to_unsigned(10000, 256);
    wait for period;
    assert (c.sign = '0' AND c.magnitude = 7000) report "test failed for input combination 6" severity error;
    
    a.sign <= '1';
    a.magnitude <= to_unsigned(10000, 256);
    b.sign <= '0';
    b.magnitude <= to_unsigned(3000, 256);
    wait for period;
    assert (c.sign = '1' AND c.magnitude = 7000) report "test failed for input combination 7" severity error;
        
    a.sign <= '0';
    a.magnitude <= to_unsigned(3000, 256);
    b.sign <= '1';
    b.magnitude <= to_unsigned(10000, 256);
    wait for period;
    assert (c.sign = '1' AND c.magnitude = 7000) report "test failed for input combination 8" severity error;
    
    a.sign <= '1';
    a.magnitude <= to_unsigned(10000, 256);
    b.sign <= '1';
    b.magnitude <= to_unsigned(3000, 256);
    wait for period;
    assert (c.sign = '1' AND c.magnitude = 13000) report "test failed for input combination 9" severity error;
    
    a.sign <= '0';
    a.magnitude <= to_unsigned(10000, 256);
    b.sign <= '1';
    b.magnitude <= to_unsigned(0, 256);
    wait for period;
    assert (c.sign = '0' AND c.magnitude = 10000) report "test failed for input combination 10" severity error;
    
    a.sign <= '1';
    a.magnitude <= to_unsigned(10000, 256);
    b.sign <= '1';
    b.magnitude <= to_unsigned(0, 256);
    wait for period;
    assert (c.sign = '1' AND c.magnitude = 10000) report "test failed for input combination 11" severity error;
        
    a.sign <= '1';
    a.magnitude <= to_unsigned(0, 256);
    b.sign <= '1';
    b.magnitude <= to_unsigned(10000, 256);
    wait for period;
    assert (c.sign = '1' AND c.magnitude = 10000) report "test failed for input combination 12" severity error;
        
    a.sign <= '1';
    a.magnitude <= to_unsigned(0, 256);
    b.sign <= '0';
    b.magnitude <= to_unsigned(10000, 256);
    wait for period;
    assert (c.sign = '0' AND c.magnitude = 10000) report "test failed for input combination 13" severity error;
    
    report "Done testing addSignMagnitude...";
    wait;
end process;

end Behavioral;
