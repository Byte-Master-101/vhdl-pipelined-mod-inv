----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/13/2021 04:35:47 AM
-- Design Name: 
-- Module Name: relativeShift - Behavioral
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

entity relativeShift is
    Port ( a : in UNSIGNED (255 downto 0);
           b : in UNSIGNED (255 downto 0);
           c : in UNSIGNED (255 downto 0);
           shiftedB : out UNSIGNED (255 downto 0);
           shiftedC : out UNSIGNED (255 downto 0));
end relativeShift;

architecture Behavioral of relativeShift is
    component pEncoder256 is
        Port ( x : in UNSIGNED (255 downto 0);
               y : out UNSIGNED (7 downto 0);
               valid : out STD_LOGIC);
    end component;
    
    signal shiftValA : UNSIGNED (7 downto 0);
    signal shiftValB : UNSIGNED (7 downto 0);
    
    signal relativeShiftVal : UNSIGNED (7 downto 0);
    signal overflow : std_logic;
    
    signal updatedRelativeShiftVal : UNSIGNED (7 downto 0);
    
    signal tmpShiftedB : UNSIGNED (255 downto 0);
begin

encoderA : pEncoder256 port map(x=>a, y=>shiftValA);
encoderB : pEncoder256 port map(x=>b, y=>shiftValB);

relativeShiftVal <= shiftValA - shiftValB;

tmpShiftedB <= shift_left(b, to_integer(relativeShiftVal)); 
overflow <= '1' when tmpShiftedB > a else '0';

updatedRelativeShiftVal <= relativeShiftVal-1 when overflow = '1' else relativeShiftVal;

shiftedB <= shift_right(tmpShiftedB, 1) when overflow = '1' else tmpShiftedB;
shiftedC <= shift_left(c, to_integer(updatedRelativeShiftVal));

end Behavioral;
