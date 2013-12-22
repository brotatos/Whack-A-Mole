library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity WhackAMole is
    Port ( CLK      : in STD_LOGIC;
           RESET    : in  STD_LOGIC;
           SWITCHES : in  STD_LOGIC_VECTOR (7 downto 0);
           DISP_EN  : out  STD_LOGIC_VECTOR (3 downto 0);
           LEDS     : out  STD_LOGIC_VECTOR (7 downto 0);
           SEGMENTS : out  STD_LOGIC_VECTOR (7 downto 0));
end WhackAMole;


architecture Behavioral of WhackAMole is

   component clk_div2 is
       Port (  clk : in std_logic;
              sclk : out std_logic);
   end component;

   component countdown_clk_div is
       Port (  clk : in std_logic;
              sclk : out std_logic);
   end component;

   component Countdown is
       Port ( CLK       : in  STD_LOGIC;
              RESET     : in  STD_LOGIC;
              TIME_LEFT : out  STD_LOGIC_VECTOR (7 downto 0));
   end component;

   component sseg_dec is
      Port (      ALU_VAL : in std_logic_vector(7 downto 0);
                     SIGN : in std_logic;
                    VALID : in std_logic;
                      CLK : in std_logic;
                  DISP_EN : out std_logic_vector(3 downto 0);
                 SEGMENTS : out std_logic_vector(7 downto 0));
   end component;

   component ScoreKeeper is
       Port ( LEDS          : in  STD_LOGIC_VECTOR(7 downto 0);
              CLK           : in  STD_LOGIC;
              RESET         : in  STD_LOGIC;
              TIME_LEFT     : in  STD_LOGIC_VECTOR (7 downto 0);
              SWITCHES      : in  STD_LOGIC_VECTOR (7 downto 0);
              SCORE         : out  STD_LOGIC_VECTOR (7 downto 0));
   end component;

   component SetLED is
      Port ( RAND_INT : in  STD_LOGIC_VECTOR (2 downto 0);
             LEDS     : out  STD_LOGIC_VECTOR (7 downto 0));
   end component;

   component RandomNumberGenerator is
      generic ( width : integer :=  3 );
      Port (
        clk        : in std_logic;
        random_num : out std_logic_vector (width-1 downto 0)
      );
   end component;

   signal randNum : std_logic_vector(2 downto 0);
   signal clock_to_use, countdown_clock : std_logic;
   signal led_s, the_score, the_time_left : std_logic_vector(7 downto 0);

begin

   slow_clk : clk_div2
   port map ( clk  => CLK,
              sclk => clock_to_use
            );

   countdownClock : countdown_clk_div
   port map ( clk  => CLK,
              sclk => countdown_clock
            );


   rand : RandomNumberGenerator
   port map (  clk        => clock_to_use,
               random_num => randNum
            );

   daLED : SetLED
   port map ( RAND_INT => randNum,
              LEDS     => led_s
            );

   counter : Countdown
   port map ( CLK       => countdown_clock,
              RESET     => RESET,
              TIME_LEFT => the_time_left
            );

   score : ScoreKeeper
   port map ( LEDS      => led_s,
              RESET     => RESET,
              CLK       => clock_to_use,
              TIME_LEFT => the_time_left,
              SWITCHES  => SWITCHES,
              SCORE     => the_score
            );

   egg : sseg_dec
   port map ( ALU_VAL  => the_score,
              SIGN     => '0',
              VALID    => '1',
              CLK      => CLK,
              DISP_EN  => DISP_EN,
              SEGMENTS => SEGMENTS
            );

   LEDS <= led_s;

end Behavioral;

