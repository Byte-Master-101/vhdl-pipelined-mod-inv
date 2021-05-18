----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/17/2021 05:39:25 AM
-- Design Name: 
-- Module Name: pipelinedModInv_TB - Behavioral
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

entity pipelinedModInv_TB is
--  Port ( );
end pipelinedModInv_TB;

architecture Behavioral of pipelinedModInv_TB is

component pipelinedModInv is
    Port ( clk : in STD_LOGIC;
           a : in UNSIGNED (255 downto 0);
           p : in UNSIGNED (255 downto 0);
           res : out UNSIGNED (255 downto 0));
end component;

signal clk : STD_LOGIC;
signal a, p, res : UNSIGNED (255 downto 0);

constant period : time := 20 ns;
   
begin

UUT : pipelinedModInv port map(clk=> clk, a=> a, p=> p, res=> res);

process is begin
    clk <= '0';
    wait for period/2;
    clk <= '1';
    wait for period/2;
end process;

process is begin
    report "Testing pipelinedModInv...";
    wait for period/2;
    
    a <= x"243b00f54ba4955f2122611a8955bfa58dd0c2bccfd25cd96e00d5d6ebcbf5b2";
    p <= x"fffffffffffffffffffffffffffffffffffffffffffffffffffffffefffffc2f";
    wait for period;
    
    a <= x"cd811f6a7fbfb17041041fd7c4faa4049329b8e7efa63a48b61d31cc9d8b9bf8";
    p <= x"fffffffffffffffffffffffffffffffffffffffffffffffffffffffefffffc2f";
    wait for period;
    
    a <= x"49c1947344f52d0f6935e1f428f959da76fa569c134a5b0db0415d553a0bb90a";
    p <= x"fffffffffffffffffffffffffffffffffffffffffffffffffffffffefffffc2f";
    wait for period;
    
    a <= to_unsigned(89, 256);
    p <= to_unsigned(7919, 256);
    wait for period;
    
    a <= to_unsigned(89, 256);
    p <= to_unsigned(10000, 256);
    wait for period;
    
    a <= to_unsigned(17, 256);
    p <= to_unsigned(500, 256);
    wait for period;
    
    a <= to_unsigned(33, 256);
    p <= to_unsigned(34, 256);
    wait for period;
    
    a <= x"0000000000000000000000000000000000000000000000000000000000000001";
    p <= x"ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff";
    wait for period;
    
    a <= to_unsigned(0, 256);
    p <= to_unsigned(0, 256);
    
    wait;
end process;

process is begin
    wait for period/2;
    wait for period;
    wait for period*256;
    
    assert (res = x"2fe2977e73e1d8aad29780a746218895b2df21c30ecd978722f91101e9446b57") report "test failed for input combination 1" severity error; wait for period;
    assert (res = x"35a7bbeb54a1114c6d7d732198bea148f4464209c6b42fa9b2978612d8a4a9cf") report "test failed for input combination 2" severity error; wait for period;
    assert (res = x"c16581aca18abba2269816185d0c9e15831a189241fcd8a4bf4e3465b4f07c89") report "test failed for input combination 3" severity error; wait for period;
    assert (res = to_unsigned(4004, 256)) report "test failed for input combination 4" severity error; wait for period;
    assert (res = to_unsigned(2809, 256)) report "test failed for input combination 5" severity error; wait for period;
    assert (res = to_unsigned(353, 256)) report "test failed for input combination 6" severity error; wait for period;
    report "RES: " & INTEGER'image(to_integer(res));
    assert (res = to_unsigned(33, 256)) report "test failed for input combination 7" severity error; wait for period;
    assert (res = to_unsigned(1, 256)) report "test failed for input combination 8" severity error;
    
    report "Done testing pipelinedModInv...";
    wait;
end process;

end Behavioral;
