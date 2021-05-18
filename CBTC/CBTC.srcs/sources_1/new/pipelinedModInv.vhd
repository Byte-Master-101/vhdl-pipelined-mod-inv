----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/17/2021 03:23:40 AM
-- Design Name: 
-- Module Name: pipelinedModInv - Behavioral
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

entity pipelinedModInv is
    Port ( clk : in STD_LOGIC;
           a : in UNSIGNED (255 downto 0);
           p : in UNSIGNED (255 downto 0);
           res : out UNSIGNED (255 downto 0));
end pipelinedModInv;

architecture Behavioral of pipelinedModInv is

component modInvIterationSync is
    Port ( clk : in STD_LOGIC;
           
           in_t : in SIGN_MAGNITUDE;
           in_new_t : in SIGN_MAGNITUDE;
           in_r : in UNSIGNED (255 downto 0);
           in_new_r : in UNSIGNED (255 downto 0);
           
           out_t : out SIGN_MAGNITUDE;
           out_new_t : out SIGN_MAGNITUDE;
           out_r : out UNSIGNED (255 downto 0);
           out_new_r : out UNSIGNED (255 downto 0));
end component;

constant iterations : integer := 256;

type UNSIGNED_ARRAY is array (iterations downto 0) of UNSIGNED (255 downto 0);
type SIGN_MAGNITUDE_ARRAY is array (iterations downto 0) of SIGN_MAGNITUDE;

signal t_arr : SIGN_MAGNITUDE_ARRAY;
signal new_t_arr : SIGN_MAGNITUDE_ARRAY;
signal r_arr : UNSIGNED_ARRAY;
signal new_r_arr : UNSIGNED_ARRAY;

signal last_t : SIGN_MAGNITUDE;

begin

GEN_ITERS : for i in 0 to iterations-1 generate
  ITER :  modInvIterationSync port map(clk=> clk,
                                       in_t=> t_arr(i), in_new_t=>  new_t_arr(i), out_t=> t_arr(i+1), out_new_t=> new_t_arr(i+1),
                                       in_r=> r_arr(i), in_new_r=> new_r_arr(i), out_r=> r_arr(i+1), out_new_r=> new_r_arr(i+1));
end generate GEN_ITERS;

t_arr(0).sign <= '0';
t_arr(0).magnitude <= to_unsigned(0,256);

new_t_arr(0).sign <= '0';
new_t_arr(0).magnitude <= to_unsigned(1,256);

r_arr(0) <= p;
new_r_arr(0) <= a;

last_t <= t_arr(iterations);
res <= p - last_t.magnitude when last_t.sign = '1' else last_t.magnitude;

end Behavioral;














