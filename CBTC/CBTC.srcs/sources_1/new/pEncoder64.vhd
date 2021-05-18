----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/13/2021 02:05:26 AM
-- Design Name: 
-- Module Name: pEncoder64 - Behavioral
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

entity pEncoder64 is
    Port ( x : in UNSIGNED (63 downto 0);
           y : out UNSIGNED (5 downto 0);
           valid : out STD_LOGIC);
end pEncoder64;

architecture Behavioral of pEncoder64 is

component pEncoder16 is
    Port ( x : in UNSIGNED (15 downto 0);
           y : out UNSIGNED (3 downto 0);
           valid : out STD_LOGIC);
end component;

signal y0, y1, y2, y3 : UNSIGNED (3 downto 0);
signal valid0, valid1, valid2, valid3 : STD_LOGIC;

begin

enc3 : pEncoder16 port map(x=> x(63 downto 48), y=> y3, valid=> valid3);
enc2 : pEncoder16 port map(x=> x(47 downto 32), y=> y2, valid=> valid2);
enc1 : pEncoder16 port map(x=> x(31 downto 16), y=> y1, valid=> valid1);
enc0 : pEncoder16 port map(x=> x(15 downto 0), y=> y0, valid=> valid0);
    
y <=    ("11" & y3) when valid3 = '1' else
        ("10" & y2) when valid2 = '1' else
        ("01" & y1) when valid1 = '1' else
        ("00" & y0);

valid <= valid0 OR valid1 OR valid2 OR valid3;

end Behavioral;
