# Problem

Q: 虚拟机网络问题，连不上网/用不了vpn
- 打开虚拟网卡（tun）模式。
  
Q: 如何自己写一个shell，然后加载到系统里；shell能以一个终端的图形界面形式展现出来，显然不“普通”吧。 
- 首先要区分两个程序：**Terminal & shell**；Terminal是一个GUI程序，负责加载图形界面（类似前端）；shell类似一个文本处理器，接收与处理用户输入的命令（类似后端）；每次运行Terminal，它会开启新进程来运行配置文件中指定的程序，比如shell，同时把自己的管道和shell的管道连接起来（这样就能在终端里输入输出了）。因此，可以修改配置文件里的启动命令为其它任意的程序，比如python。这是一种 **解耦** 的思想。

Q: 在xv6项目下，从运行 make qemu 到xv6系统启动完成，这一整个过程会经历什么？

Q: what's the difference between `exit` and `return` ？
- 简单的说，exit 作用于整个进程，会释放所有资源，并且通知父进程；而 return 只是一个关键字，用于弹出栈桢，恢复寄存器。

# Unix介绍短片

[Unix](https://www.youtube.com/watch?v=tc4ROCJYbm0)
- Kernighan 在《Unix传奇》这本书里提到了这次电视采访。
- Unix、C、shell
- 三层结构、管道、文件系统(hierarchy)、modules思维

# Chapter 1：Operating system interfaces

- system calls：由kernel定义，暴露给user的接口；
- hardware protection：不同区域的硬件访问等级不同；
- shell：一个普通的用户级交互程序，用于读取和执行用户的命令；

## 1.1 Process & memory

- xv6 提供的system calls 如下表：
<img src="../assets/L01_Introduction_2026-01-19-16-44-45.png" width="80%" align="center" />S

## 1.2 I/O & file descriptors

- a fd can refer to a file, a device or a console, etc.

- one process with **one fd table**(the fd table matters). Obviously, the fd talbe must include fds, referred objects and flags, e.g., (1, file, readonly).

- you can release a fd with the system call `close()`.

- one fd with one offset; `read/write` n from the offset; then offset += n.

- with `dup()`, two different fds can refer to the same object and they share the offset; `fork()` copies **the fd table** from the parent, and `exec()` also preserves **the fd table**;

## 1.3 Pipes

- A *pipe* is **a small kernel buffer** exposed to processes as a pair of file descriptors, one for reading and one for writing.

```C
int p[2];
pipe(p); // p[0] for reading, p[1] for writing
```

- A cmd consists of  white-spaces, sub-cmds and different symbols(like `|`: pipeline, `>`: redirection), e.g., `grep pattern test.txt | wc -l`.
  1. the shell gets the cmd and stores it in a **tree** structure; (ignores the white space and labels the others with `EXEC`, `REDIR`, `PIPE`...).
  2. one pipeline   <=>  three processes: one parent(the interior process), two childs(left & right), just like the **'tree'**.

## 1.4 File 