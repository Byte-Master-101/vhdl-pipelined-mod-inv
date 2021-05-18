----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/13/2021 12:57:20 AM
-- Design Name: 
-- Module Name: pEncoder4 - Behavioral
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

entity pEncoder4 is
    Port ( x : in UNSIGNED (3 downto 0);
           y : out UNSIGNED (1 downto 0);
           valid : out STD_LOGIC);
end pEncoder4;

architecture Behavioral of pEncoder4 is

begin

y(0) <= x(3) OR ((NOT x(2)) AND x(1));
y(1) <= x(3) OR x(2);

valid <= x(3) OR x(2) OR x(1) OR x(0);

end Behavioral;
