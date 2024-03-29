x122How to use GAMES.TPU -- overview -- by Lou DuChez, Pascal-kind-of-guy

GAMES.TPU is a Turbo Pascal unit designed to rework the keyboard and timer
interrupts to better function in game writing.  The keyboard is the biggest
problem in a lot of games: the keyboard buffer reads keys sequentially, but you
want simultaneous reads for action games.  Now scan codes for key presses and
releases are transmitted through port 60h, so it seems like it should be
possible just to keep an eye on that memory location.  Unfortunately, interrupt
09h (the keyboard interrupt) ends up resetting the port to 0 before you can
rwad the contents.  So I wrote a new interrupt handler that does these steps:

1)  reads port 60h and records presses / releases;
2)  calls the regular keyboard interrupt;
3)  clears the keyboard buffer.

All key presses are stored in an array of 128 boolean values.  I've found that
you can keep track of about six keys simultaneously -- more than enough for
most games.

I've also found it useful to nullify the "Ctrl-Break" interrupt.  Basically,
you don't want to "Ctrl-Break" out of a Pascal program before resetting the
keyboard interrupt, so I made a "Ctrl-Break" interrupt that does absolutely
nothing.

Finally, when you write an action game, you want it to run at the same speed on
all computers, be they original PC's or 486's.  The best way to do that is to
monitor the computer's timer; I wrote an interrupt that will pause until a
fixed number of "ticks" (18.2 per second) go by.

                      GAMES.TPU -- the Keyboard interrupt

You install the new keyboard interrupt by invoking procedure INITNEWKEYINT (and
reset to the old one by invoking SETOLDKEYINT).  As mentioned before, the
status of the keys is recorded in a boolean array (from 0 to 127) called
KEYDOWN.  A "True" indicates the key is down; a "False" indicates it is not. 
So your program just has to check this array periodically to see what keys are
down.

Now as for figuring out which array elements correspond to which keys: I
provide two ways.  First of all, there is a function "SCANOF": it takes a
character argument, and returns (as a byte) what scan code corresponds to the
character (more accurately, the key that makes the character).  If, for
example, you need to know the scan code of the "1" key, you'd want the value
returned by SCANOF('1') (or SCANOF('!'), since you're trying to see if the
"1"/"!" key is down, and the "Shift" keys aren't an issue).  In particular,
you'd know that the "1" key is down if KEYDOWN[SCANOF('1')] was "True".

The SCANOF function works for all the alphanumeric and punctuation keys; it
doesn't work for the arrows, "NumLock", function keys, etc. because there's no
particular characters to associate with them.  So here are some constants that
you can use instead:















2CONSTANT  VAL  DESCRIPTION              CONSTANT  VAL  DESCRIPTION

escscan   $01  "Esc"                    entscan   $1c  "Enter"
backscan  $0e  Backspace                rshscan   $36  Right Shift
ctrlscan  $1d  "Ctrl"                   prtscan   $37  "PrntScrn"
lshscan   $2a  Left Shift               altscan   $38  "Alt"
capscan   $3a  "CapLock"                homescan  $47  "Home"
f1scan    $3b  F1                       upscan    $48  Up Arrow
f2scan    $3c  F2                       pgupscan  $49  "Pg Up"
f3scan    $3d  F3                       minscan   $4a  "-" on keypad
f4scan    $3e  F4                       leftscan  $4b  Left Arrow
f5scan    $3f  F5                       midscan   $4c  "5" on keypad
f6scan    $40  F6                       rightscan $4d  Right Arrow
f7scan    $41  F7                       plusscan  $4e  "+" on keypad
f8scan    $42  F8                       endscan   $4f  "End"
f9scan    $43  F9                       downscan  $50  Down Arrow
f10scan   $44  F10                      pgdnscan  $51  "Pg Down"
f11scan   $d9  F11                      insscan   $52  "Ins"
f12scan   $da  F12                      delscan   $53  "Del"
scrlscan  $46  "ScrollLock"             numscan   $45  "Num Lock"
tabscan   $0f  Tab

Is the left arrow down?  It is, if KEYDOWN[LEFTSCAN] is "True".

There is a second array of booleans (0 to 127), called WASDOWN: it records
whether or not a key has been depressed in a period of time.  This is more
useful for keys that get tapped instead of continuously held down: for example,
a movement key is held, but a fire button is tapped.  Has the Space Bar been
pressed?  Only if WASDOWN[SCANOF(' ')] is "True".  A procedure to use with the
WASDOWN array is CLEARWASDOWNARRAY:  resets all the elements of WASDOWN to
"False".  ("FOR COUNTER := 0 TO 127 DO WASDOWN[COUNTER] := FALSE")  So you
reset the array with CLEARWASDOWNARRAY, and WASDOWN will record all the keys
that have been pressed until you call CLEARWASDOWNARRAY again.

                     GAMES.TPU -- the "Ctrl-Brk" interrupt

This one takes little to no explanation.  Call INITNEWBRKINT to call the new
interrupt (essentially, to disable it); call SETOLDBRKINT to reset it.

                       GAMES.TPU -- the Timer interrupt

18.2 times per second, the computer generates a "tick", calls hardware
interrupt 08h, updates its clock/calendar, does various house-cleaning
functions, and then calls interrupt 1Bh.  1Bh is an interrupt for programmers
to hook their programs onto for timing purposes; that's exactly what GAMES.TPU
does.  Invoke the new timer handler with INITNEWTIMINT (and disable it with
SETOLDTIMINT); it first calls whatever TSR's might be using that interrupt
already, then it increments a counter.  You indirectly access that counter by
the procedure TICKWAIT: the computer waits until the counter gets to the number
of ticks specified before doing anything else (byte values only).  Once that
number has been reached, the counter resets to 0.

I think an example is in order: let's say you have an action game where each
round should take one-half second on any machine.  So at the beginning of the












2first round, call TICKWAIT(0) (to set the tick counter to 0).  At the end of
each round, call TICKWAIT(9) (to wait out the half second).  Now between those
steps, while the computer has been drawing things on the screen, updating enemy
positions, etc., the tick counter has been automatically incrementing every
.055 seconds.  On a 4.77Mhz XT, the counter may have gotten to 6 by the time
the program gets to the TICKWAIT(9) statement, which waits three more ticks
before proceeding to the next step.  On a 486, the tick counter might get only
to 1 before encountering the TICKWAIT(9); in which case, the computer will wait
eight ticks before proceeding.  So you can make programs that run at the same
speed on any computer via the timer interrupt and TICKWAIT.

Some sample pseudocode:

program gamething;
uses games;

procedure movefoes;
     begin
       .
       .
     end;

procedure firephasers;
     begin
       .
       .
     end;

procedure updatescore;
     begin
       .
       .
     end; 

procedure playgame;
     begin
     repeat begin
          movefoes;
          firephasers;
          updatescore;
          tickwait(2);
          end until igotblownup;
     end;

begin {main program}
initnewtimint;
tickwait(0);
playgame;
setoldtimint;
end.

Included are GAMES.PAS (compile it yourself -- I wrote it via Turbo Pascal 6.0,
but it ought to work on 4 and 5 too), and RAIDERS.EXE, a game I wrote using all
those interrupts.  Enjoy!












