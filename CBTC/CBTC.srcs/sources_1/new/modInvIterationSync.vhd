----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/17/2021 04:06:47 AM
-- Design Name: 
-- Module Name: modInvIterationSync - Behavioral
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

entity modInvIterationSync is
    Port ( clk : in STD_LOGIC;
           
           in_t : in SIGN_MAGNITUDE;
           in_new_t : in SIGN_MAGNITUDE;
           in_r : in UNSIGNED (255 downto 0);
           in_new_r : in UNSIGNED (255 downto 0);
           
           out_t : out SIGN_MAGNITUDE;
           out_new_t : out SIGN_MAGNITUDE;
           out_r : out UNSIGNED (255 downto 0);
           out_new_r : out UNSIGNED (255 downto 0));
end modInvIterationSync;

architecture Behavioral of modInvIterationSync is

component modInvIteration is
    Port ( in_t : in SIGN_MAGNITUDE;
           in_new_t : in SIGN_MAGNITUDE;
           in_r : in UNSIGNED (255 downto 0);
           in_new_r : in UNSIGNED (255 downto 0);
           
           out_t : out SIGN_MAGNITUDE;
           out_new_t : out SIGN_MAGNITUDE;
           out_r : out UNSIGNED (255 downto 0);
           out_new_r : out UNSIGNED (255 downto 0));
end component;

signal tmp_t, tmp_new_t : SIGN_MAGNITUDE;
signal tmp_r, tmp_new_r : UNSIGNED (255 downto 0);

begin

UUT : modInvIteration port map(in_t=> in_t, in_new_t=> in_new_t, out_t=> tmp_t, out_new_t=> tmp_new_t,
                               in_r=> in_r, in_new_r=> in_new_r, out_r=> tmp_r, out_new_r=> tmp_new_r);

process(clk) is begin
    if(rising_edge(clk)) then
        out_t <= tmp_t;
        out_new_t <= tmp_new_t;
        out_r <= tmp_r;
        out_new_r <= tmp_new_r;
    end if;
end process;

end Behavioral;
