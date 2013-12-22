library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.math_real.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Countdown is
    Port ( CLK       : in  STD_LOGIC;
           RESET     : in  STD_LOGIC;
           TIME_LEFT : out  STD_LOGIC_VECTOR (7 downto 0));
end Countdown;

architecture Behavioral of Countdown is
   signal time_tmp : STD_LOGIC_VECTOR(7 downto 0) := "00011110";

begin
   countdown: process (CLK, RESET, time_tmp)
   begin
      if (time_tmp > "00000000") then
         if (rising_edge(CLK)) then
            time_tmp <= time_tmp - 1;
         end if;
      end if;

      if (RESET = '1') then
         time_tmp <= "00011110";
      end if;

   end process countdown;

   TIME_LEFT <= time_tmp;

end Behavioral;
