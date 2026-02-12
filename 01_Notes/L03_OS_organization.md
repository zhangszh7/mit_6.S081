# Reading code

`proc.h`: 
- declarations of structure, such as `struct proc`.

`defs.h`:
- prototypes of functions.

`entry.S`:
- allocate stacks split from the stack0 for every cpu.

`main.c`:
- start up the whole system.

`initcode.S`:
- execute the init system call.

`init.c`:
- open the `console` and start up the shell.

`proc.c`:
- functions related to manipulate processes.

`exec.c`:
- exec system call.


