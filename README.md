# basicv2

A Commodore BASIC V2 interpreter/compiler written in Java with some 6502 assembler on top.

BasicV2 is an attempt to write a BASIC interpreter/compiler in Java that is compatible with the BASIC dialect that older 
Commodore home computers like the C64 or VIC 20 were using. It can run BASIC programs written in BASIC V2 or ANSI BASIC.
It doesn't use any parts of the implementation of the original Commodore BASIC like similar projects do. 
It's a complete reimplementation in Java.

In addition, it offers a symbolic assembler that compiles assembler code into actual 6502 machine code. To execute these programs, it comes with a 6502 cpu emulation.

The sources come in a basic Maven like project structure as an Eclipse project. However, it doesn't actually use Maven and it has no
dependencies to any other Java libraries. It's a stand-alone thing.

It can run BASIC programs from inside your application or from the command line. 
You can even use it to process HTML-templates as it comes with a basic templating implementation.

In addition to normal BASIC V2, it features a BASIC extension named GRAPHICS BASIC, which adds some commands for...graphics. The graphics capabilities aren't limited by some artifical C64 specs but take full advantage of a modern PC's capabilities.

Thanks to nietoperz809's efforts, there's a simple BASIC shell/editor available as well (see basicshell-package) that lets you load/save/edit/run BASIC programs in a C64-like editor. Or you can have a look at this second approach on this topic: https://github.com/nietoperz809/C64Screen


