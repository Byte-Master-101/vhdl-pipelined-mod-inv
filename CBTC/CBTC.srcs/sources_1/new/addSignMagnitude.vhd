----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/16/2021 08:23:11 AM
-- Design Name: 
-- Module Name: addSignMagnitude - Behavioral
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

entity addSignMagnitude is
    Port ( a : in SIGN_MAGNITUDE;
           b : in SIGN_MAGNITUDE;
           c : out SIGN_MAGNITUDE);
end addSignMagnitude;

architecture Behavioral of addSignMagnitude is

signal comparisonLhs : UNSIGNED(255 downto 0);
signal comparisonRhs : UNSIGNED(255 downto 0);

signal comparison : STD_LOGIC;


signal concatenatedSigns : STD_LOGIC_VECTOR(2 downto 0);
signal subtractionLhsIsA : STD_LOGIC;

signal subtractionLhs : UNSIGNED(255 downto 0);
signal subtractionRhs : UNSIGNED(255 downto 0);

begin

-- Sign Values
-- a b | c
-- 0 0 | 0
-- 0 1 | 1 when b > a else 0
-- 1 0 | 1 when a > b else 0
-- 1 1 | 1

-- Magnitude Values
-- a b | c
-- 0 0 | add
-- 0 1 | b-a when b > a else a-b
-- 1 0 | a-b when a > b else b-a
-- 1 1 | add

-- c <= 
comparisonLhs <= a.magnitude when a.sign = '1' else b.magnitude;
comparisonRhs <= a.magnitude when b.sign = '1' else b.magnitude;

comparison <= '1' when comparisonLhs > comparisonRhs else '0';

concatenatedSigns <= comparison & a.sign & b.sign;
subtractionLhsIsA <= '1' when concatenatedSigns = "001" OR concatenatedSigns = "110" else '0';
subtractionLhs <= a.magnitude when subtractionLhsIsA = '1' else b.magnitude;
subtractionRhs <= a.magnitude when subtractionLhsIsA = '0' else b.magnitude;

c.sign <= a.sign when a.sign = b.sign else comparison;
c.magnitude <= subtractionLhs+subtractionRhs when a.sign = b.sign else
               subtractionLhs-subtractionRhs;

end Behavioral;
