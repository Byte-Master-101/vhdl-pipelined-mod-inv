----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/13/2021 03:56:20 AM
-- Design Name: 
-- Module Name: pEncoder256 - Behavioral
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

entity pEncoder256 is
    Port ( x : in UNSIGNED (255 downto 0);
           y : out UNSIGNED (7 downto 0);
           valid : out STD_LOGIC);
end pEncoder256;

architecture Behavioral of pEncoder256 is

component pEncoder64 is
    Port ( x : in UNSIGNED (63 downto 0);
           y : out UNSIGNED (5 downto 0);
           valid : out STD_LOGIC);
end component;

signal y0, y1, y2, y3 : UNSIGNED (5 downto 0);
signal valid0, valid1, valid2, valid3 : STD_LOGIC;

begin

enc3 : pEncoder64 port map(x=> x(255 downto 192), y=> y3, valid=> valid3);
enc2 : pEncoder64 port map(x=> x(191 downto 128), y=> y2, valid=> valid2);
enc1 : pEncoder64 port map(x=> x(127 downto 64), y=> y1, valid=> valid1);
enc0 : pEncoder64 port map(x=> x(63 downto 0), y=> y0, valid=> valid0);
    
y <=    ("11" & y3) when valid3 = '1' else
        ("10" & y2) when valid2 = '1' else
        ("01" & y1) when valid1 = '1' else
        ("00" & y0);

valid <= valid0 OR valid1 OR valid2 OR valid3;

end Behavioral;
