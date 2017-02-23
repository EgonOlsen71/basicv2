package com.sixtyfour.test;

import com.sixtyfour.Assembler;
import com.sixtyfour.Loader;
import com.sixtyfour.plugins.CpuCallListener;
import com.sixtyfour.system.Cpu;
import com.sixtyfour.system.CpuTracer;
import com.sixtyfour.system.Machine;

public class AssemblerBeer
{
  public static void main(String[] args) {
    testBeer();
  }
  
  private static void testBeer() {
    String[] code = Loader.loadProgram("src/test/resources/asm/beer.asm");
    Assembler asm = new Assembler(code);
    asm.compile();
    Machine machine = asm.getMachine();
    
    System.out.println(asm.toString());
    
    machine.getCpu().setCpuTracer(new CpuTracer() {

      @Override
      public void commandExecuted(Cpu cpu, int opcode, int opcodePc, int newPc)
      {
        System.out.println(Integer.toHexString(opcode)+"/"+Integer.toHexString(opcodePc));
      }
      
    });
    
    machine.getCpu().setCpuCallListener(new CpuCallListener() {

      @Override
      public boolean jsr(Cpu cpu, int addr)
      {
        if (addr==65490) {
          if (cpu.getAcc()!=0) {
            System.out.print((char) (cpu.getAcc()));
          }
          return true;
        }
        return false;
      }
    });
    asm.run();
  }
  
}
