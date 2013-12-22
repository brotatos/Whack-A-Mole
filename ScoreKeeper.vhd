----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:40:40 12/03/2013 
-- Design Name: 
-- Module Name:    ScoreKeeper - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
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
use IEEE.math_real.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ScoreKeeper is
    Port ( LEDS      : in  STD_LOGIC_VECTOR(7 downto 0);
           RESET     : in  STD_LOGIC;
           CLK       : in  STD_LOGIC;
           TIME_LEFT : in  STD_LOGIC_VECTOR (7 downto 0);
           SWITCHES  : in  STD_LOGIC_VECTOR (7 downto 0);
           SCORE     : out  STD_LOGIC_VECTOR (7 downto 0));
end ScoreKeeper;

architecture Behavioral of ScoreKeeper is
   signal score_tmp : STD_LOGIC_VECTOR(7 downto 0)  := "00000000";
begin

   count: process (LEDS, RESET, SWITCHES, CLK)
   begin

      if (rising_edge(CLK)) then
         if (TIME_LEFT > "00000000") then
            if (LEDS = SWITCHES) then
               score_tmp <= score_tmp + 1;
            end if;
            SCORE <= TIME_LEFT;
         else
            SCORE <= score_tmp;
         end if;
      end if;

      if (RESET = '1') then
         score_tmp <= "00000000";
      end if;

   end process count;

end Behavioral;
