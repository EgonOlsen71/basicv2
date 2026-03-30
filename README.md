# BasicV2

## Overview

BasicV2 is a Java-based interpreter and compiler for Commodore BASIC V2, the dialect used on systems like the C64 and VIC-20.

It allows you to run and compile BASIC V2 and ANSI BASIC programs in a modern Java environment without relying on the original Commodore BASIC implementation. Instead, it is a complete reimplementation written in Java, with additional support for 6502 assembly.


## Features

- Compile and run BASIC V2 and ANSI BASIC programs in Java
- Cross-compile programs for C64, VIC-20, and Commander X16 using MoSpeed
- Includes a 6502 assembler and CPU emulator
- No external Java dependencies (stand-alone project)
- Can run programs via the command line or within Java applications
- Includes basic HTML templating support
- Includes GRAPHICS BASIC extension for enhanced graphics
- Includes a BASIC shell/editor for writing and running programs (see `basicshell-package`)
- Includes compile backends for PowerShell, JavaScript, and Python


## Getting Started

You can use BasicV2 in two main ways:

- Run BASIC programs within a Java application using the provided runtime
- Use the MoSpeed cross-compiler to compile programs for systems like the C64, VIC-20, or Commander X16 and run them on real hardware or in an emulator

The MoSpeed compiler is available as a command-line tool in the `dist` directory:
https://github.com/EgonOlsen71/basicv2/tree/master/dist

It can be used independently without cloning the full repository.


## Links and Resources

- MoSpeed documentation: https://www.c64-wiki.com/wiki/MOSpeed
- Online MoSpeed tool: https://jpct.de/mospeed
- BASIC shell/editor project: https://github.com/nietoperz809/C64Screen
- Floating point optimizations by Michael Jørgensen: https://github.com/MJoergen
- Third-party UI (Windows/Linux): https://github.com/Error504TimeOut/MoSpeedUI/releases
