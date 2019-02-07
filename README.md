# basicv2

A Commodore BASIC V2 interpreter/compiler written in Java with some 6502 assembler on top.

BasicV2 is an attempt to write a BASIC interpreter/compiler in Java that is compatible with the BASIC dialect that older 
Commodore home computers like the C64 or VIC 20 were using. It can run BASIC programs written in BASIC V2 or ANSI BASIC.
It doesn't use any parts of the implementation of the original Commodore BASIC like similar projects do. 
It's a complete reimplementation in Java.

It's basically two solutions in one. You can either compile the BASIC programs so that you can run them inside a Java environment/application using the runtime that the project provides.
Or you can use the native cross compiler to compile it for the real C64 or VIC20 and run it on the actual machine or in an emulator. You'll find this compiler called MoSpeed as a command line application in the dist-directory (here: https://github.com/EgonOlsen71/basicv2/tree/master/dist ) of the project. It can be run on its own, you don't have to download/clone the whole project for this. There's also an experimental BASIC V2 -> Javascript compiler included. The result of that one is a set of html/js files that can be run in a browser.

In addition, it offers a symbolic assembler that compiles assembly code into actual 6502 machine code. To execute these programs, it comes with a 6502 cpu emulation.

The sources come in a basic Maven project structure as an Eclipse project. It has no dependencies to any other Java libraries. It's a stand-alone thing.

It can run BASIC programs from inside your application or from the command line. 
You can even use it to process HTML-templates as it comes with a basic templating implementation.

In addition to normal BASIC V2, it features a BASIC extension named GRAPHICS BASIC, which adds some commands for...graphics. The graphics capabilities aren't limited by some artifical C64 specs but take full advantage of a modern PC's capabilities.

Thanks to nietoperz809's efforts, there's a simple BASIC shell/editor available as well (see basicshell-package) that lets you load/save/edit/run BASIC programs in a C64-like editor. Or you can have a look at this second approach on this topic: https://github.com/nietoperz809/C64Screen


