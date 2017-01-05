package com.sixtyfour.basicshell;

import com.sixtyfour.plugins.impl.ConsoleOutputChannel;

/**
 * @author nietoperz809
 */
public class ShellOutputChannel extends ConsoleOutputChannel
{
    private BasicShell shellFrame;

    public ShellOutputChannel (BasicShell shellFrame)
    {
        this.shellFrame = shellFrame;
    }

    @Override
    public void print (int id, String txt)
    {
        shellFrame.putString(txt);
    }

    @Override
    public void println (int id, String txt)
    {
        shellFrame.putString(txt+'\n');
    }
}
