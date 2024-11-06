# TASK 02: Text editor in C

I followed the steps outlined in [kilo.c](https://viewsourcecode.org/snaptoken/kilo/index.html) with some modifications to make my own version of the text editor.s.

### The terminal
By default, the terminal takes inputs only when we press enter. This is called **canonical mode**. Switching to the **raw mode**, can only be done by turning off respective flags in the terminal. To obtain a clear screen, we use [Escape sequences](https://gist.github.com/fnky/458719343aabd01cfb17a3a4f7296797). This is better than `clrscr()` because of faster execution.

### Cursor
Similarly, escape sequences are used to request the cursor position and have it on the home position when the program is run.
