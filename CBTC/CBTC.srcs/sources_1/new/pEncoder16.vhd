----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/13/2021 01:07:32 AM
-- Design Name: 
-- Module Name: pEncoder16 - Behavioral
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

entity pEncoder16 is
    Port ( x : in UNSIGNED (15 downto 0);
           y : out UNSIGNED (3 downto 0);
           valid : out STD_LOGIC);
end pEncoder16;

architecture Behavioral of pEncoder16 is

component pEncoder4 is
    Port ( x : in UNSIGNED (3 downto 0);
           y : out UNSIGNED (1 downto 0);
           valid : out STD_LOGIC);
end component;

signal y0, y1, y2, y3 : UNSIGNED (1 downto 0);
signal valid0, valid1, valid2, valid3 : STD_LOGIC;

begin

enc3 : pEncoder4 port map(x=> x(15 downto 12), y=> y3, valid=> valid3);
enc2 : pEncoder4 port map(x=> x(11 downto 8), y=> y2, valid=> valid2);
enc1 : pEncoder4 port map(x=> x(7 downto 4), y=> y1, valid=> valid1);
enc0 : pEncoder4 port map(x=> x(3 downto 0), y=> y0, valid=> valid0);

y <=    ("11" & y3) when valid3 = '1' else
        ("10" & y2) when valid2 = '1'  else
        ("01" & y1) when valid1 = '1'  else
        ("00" & y0);

valid <= valid0 OR valid1 OR valid2 OR valid3;

end Behavioral;
