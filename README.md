Whack-A-Mole
============

An implementation of Whack A Mole! for the Nexys2 board.

Implementation
--------------

This program utilizes a pseudo-random number generator to set a specific LED
on.

Since the array of LEDs can be represented as an 8-bit bitstring, the program
then checks if the switches (which can also be represented as an 8-bit
bitstring) are the same string.

If they are the same string, the `ScoreKeeper` increments the previous score
using a latch.

Finally, `Countdown` increments down from 30 to 0. Once the timer hits 0, the
score is displayed and the user may no longer whack any moles (even as they
continue to pop up).
