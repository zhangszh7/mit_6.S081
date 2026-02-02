# Memory in C

1. Static Memory:
- global variables.
- defined with `static` keyword.

2. Stack Memory:
- local variables, destroyed after function exits.

3. Heap Memory:
- malloc() and free().

use `extern` keyword

# Using the GNU Debugger

- one window: make qemu-gdb
- another window: gdb

gdb commands:
- help <command>
- `step`, `next`, `stepi`, `nexti`
- `continue`, `finish`, `advance <location>`
- `break <location>`: Locations can be memory addresses (“*0x7c00”) or names (“mon_backtrace”, “monitor.c:71”).
- `delete`, `disable`, `enable`

- `layout <name>`


# Chapter 2: operating system organization

- multiplexing
- isolation
- interaction

LP64C, RISC-V(CPU), OS, monolithic kernel or mirokernel

- three modes: machine, supervisor, user
- two spaces: user, kernel(allowed to execute privileged instructions)
- `ecall`: user space -> kernel space at an entry point

**process** is the unit of isolation.
- address space: translate *a virtual address* to *a physical address* by **a page table**.

a pointer consists of  64 bits, xv6 only uses 38 of 39 bits which means `MAXVA` = 0x3fffffffff.
- each process has a thread running on the CPU, which can be suspended ou resumed.
- each process has two stacks: `user stack` and `kernel stack`, alternate and separate.


