----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/13/2021 05:30:11 AM
-- Design Name: 
-- Module Name: modInvIteration - Behavioral
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

entity modInvIteration is
    Port ( in_t : in SIGN_MAGNITUDE;
           in_new_t : in SIGN_MAGNITUDE;
           in_r : in UNSIGNED (255 downto 0);
           in_new_r : in UNSIGNED (255 downto 0);
           
           out_t : out SIGN_MAGNITUDE;
           out_new_t : out SIGN_MAGNITUDE;
           out_r : out UNSIGNED (255 downto 0);
           out_new_r : out UNSIGNED (255 downto 0));
end modInvIteration;

architecture Behavioral of modInvIteration is

component relativeShift is
    Port ( a : in UNSIGNED (255 downto 0);
           b : in UNSIGNED (255 downto 0);
           c : in UNSIGNED (255 downto 0);
           shiftedB : out UNSIGNED (255 downto 0);
           shiftedC : out UNSIGNED (255 downto 0));
end component;

component addSignMagnitude is
    Port ( a : in SIGN_MAGNITUDE;
           b : in SIGN_MAGNITUDE;
           c : out SIGN_MAGNITUDE);
end component;

signal shifted_r, updated_r : UNSIGNED (255 downto 0);
signal shifted_t, updated_t : SIGN_MAGNITUDE;

signal passDataOnly : STD_LOGIC;
signal swap : STD_LOGIC;

begin

shifted_t.sign <= NOT in_new_t.sign; -- Invert the sign here because this will be subtracted later
relativeShiftUnit : relativeShift port map(a=> in_r, b=> in_new_r, c=> in_new_t.magnitude, shiftedB=> shifted_r, shiftedC=> shifted_t.magnitude);

addSignMagnitudeUnit : addSignMagnitude port map(a=> in_t, b=> shifted_t, c=> updated_t);
updated_r <= in_r - shifted_r;

passDataOnly <= '1' when in_new_r = 0 else '0';
swap <= '0' when updated_r > in_new_r else '1';

out_t <= in_t when passDataOnly = '1' else
         in_new_t when swap = '1' else updated_t;
         
out_new_t <= in_new_t when passDataOnly = '1' else
             updated_t when swap = '1' else in_new_t;

out_r <= in_r when passDataOnly = '1' else
         in_new_r when swap = '1' else updated_r;

out_new_r <= in_new_r when passDataOnly = '1' else
             updated_r when swap = '1' else in_new_r;

end Behavioral;
