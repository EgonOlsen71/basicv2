package com.sixtyfour.test;

import com.sixtyfour.Assembler;
import com.sixtyfour.Basic;
import com.sixtyfour.Loader;
import com.sixtyfour.cbmnative.NativeCompiler;
import com.sixtyfour.cbmnative.PseudoCpu;
import com.sixtyfour.cbmnative.mos6502.c64.Platform64;
import com.sixtyfour.config.CompilerConfig;
import com.sixtyfour.config.LoopMode;
import com.sixtyfour.config.MemoryConfig;
import com.sixtyfour.parser.assembly.AssemblyParser;
import com.sixtyfour.system.*;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author EgonOlsen
 */
public class GamesCompiler {

    public static void main(String[] args) throws Exception {
        File src = new File("src/test/resources/games");
        File dst = new File("compiled");
        dst.mkdir();
        File[] games = src.listFiles((dir, name) -> name.endsWith(".bas"));
        if (games == null) {
            throw new Exception("No files today...");
        }

        //compileGame("src/test/resources/games/Test.bas", dst);

        long s = System.currentTimeMillis();
        for (File game : games) {
			System.out.println("=================");
            System.out.println("Compiling: " + game.getCanonicalPath());

            //if (game.getName().contains("xtris"))
            if (game.getName().contains("Playground"))
            compileGame(game, dst);
        }
        System.out.println("Compile time: " + (System.currentTimeMillis() - s) + "ms");

    }

    private static void compileGame(String game, File dst) throws IOException {
        File gameFile = new File(game);
        compileGame(gameFile, dst);
    }

    private static void compileGame(File game, File dst) throws IOException {
        System.out.println("Compiling " + game);
        String[] vary = Loader.loadProgram(new FileInputStream(game));
        String gameName = game.getName();
        Assembler assy = initTestEnvironment(gameName, vary, false, 30000, -1);
        String target = dst.getPath() + "/+" + gameName.replace(".bas", ".prg");
        System.out.println("Code ends at: " + assy.getProgram().getParts().get(0).getEndAddress());
        System.out.println("Binary ends at: "
                + assy.getProgram().getParts().get(assy.getProgram().getParts().size() - 1).getEndAddress());
        FileWriter.writeAsPrg(assy.getProgram(), target, assy.getProgram().getCodeStart() < 2100);

        // assy.getCpu().setCpuTracer(new MySimpleTracer(assy));
        //executeTest(assy);
    }

    private static Machine executeTest(CompilerConfig conf, final Assembler assy) {
        Program prg = assy.getProgram();
        for (ProgramPart pp : prg.getParts()) {
            System.out.println("Size: " + pp.size());
        }

        System.out.println("Running compiled program...");
        Machine machine = assy.getMachine();
        machine.addRoms();
        // printZeropage(assy);

        System.out.println(assy.toString());
        try {
            assy.run(conf);
        } catch (Exception e) {
            e.printStackTrace();
            printMemory(assy, machine);
        }
        System.out.println("program end: " + prg.getParts().get(prg.getParts().size() - 1).getEndAddress());
        System.out.println("...done!");

        // printMemory(assy, machine);

        return machine;
    }

    private static void printMemory(Assembler assy, Machine machine) {
        Program prg = assy.getProgram();
        String code = assy.toString();
        String[] lines = code.split("\n");
        System.out.println("Lines: " + lines.length);
        Map<String, String> addr2line = new HashMap<String, String>();
        for (String line : lines) {
            if (line.startsWith(".")) {
                int pos = line.indexOf("\t");
                addr2line.put(line.substring(0, pos), line);
            }
        }
        StringBuilder sb = new StringBuilder();

        for (ProgramPart pp : prg.getParts()) {
            for (int i = pp.getAddress(); i < pp.getEndAddress(); i++) {
                String addr = Integer.toString(i, 16);
                addr = "." + addr;
                if (addr2line.containsKey(addr)) {
                    if (sb.length() > 0) {
                        sb.append("\n");
                    }
                    sb.append("> ").append(addr2line.get(addr)).append("\n");
                    sb.append("  " + addr).append("\t");
                }
                int val = AssemblyParser.getLowByte(machine.getRam()[i]);
                String num = Integer.toString(val, 16);
                if (num.length() == 1) {
                    num = "0" + num;
                }
                sb.append(num).append(" ");
            }
        }
        System.out.println(sb.toString());

        System.out.println("--------------------------------------------------------------");

        lines = sb.toString().split("\n");
        for (int i = 0; i < lines.length; i += 2) {
            String l1 = lines[i];
            String l2 = lines[i + 1];
            if (l1.length() > 0 && l2.length() > 0 && l1.substring(1).equals(l2.substring(1))) {
                continue;
            }
            System.out.println(l1);
            System.out.println(l2);
        }
    }

    private static Assembler initTestEnvironment(String name, String[] vary, boolean executePseudo, int variableStart,
                                                 int stringMemoryEnd) {
        CompilerConfig conf = new CompilerConfig();
        boolean optis = true;
        conf.setConstantFolding(optis);
        conf.setConstantPropagation(optis);
        conf.setDeadStoreElimination(optis);
        conf.setDeadStoreEliminationOfStrings(optis);
        conf.setIntermediateLanguageOptimizations(optis);
        conf.setNativeLanguageOptimizations(optis);
        conf.setOptimizedLinker(optis);
        conf.setLoopMode(LoopMode.REMOVE);
        conf.setCompactThreshold(4);

        final Basic basic = new Basic(vary);
        basic.compile(conf);

        List<String> mCode = NativeCompiler.getCompiler().compileToPseudoCode(conf, basic);
        System.out.println("------------------------------");
        for (String line : mCode) {
            System.out.println(line);
        }
        System.out.println("------------------------------");

        if (executePseudo) {
            System.out.println("Running pseudo code...");
            PseudoCpu pc = new PseudoCpu();
            pc.execute(conf, basic.getMachine(), mCode);
        }
        System.out.println("------------------------------");

        int start = -1;
        if (name.indexOf("_") != -1) {
            name = name.substring(name.lastIndexOf("_") + 1, name.lastIndexOf("."));
            try {
                start = Integer.valueOf(name);
            } catch (Exception e) {
                throw new RuntimeException(e);
            }
        }

        System.out.println("Program '" + name + "' starts at " + start);
        List<String> nCode = NativeCompiler.getCompiler().compile(conf, basic,
                new MemoryConfig(start, -1, variableStart, stringMemoryEnd), new Platform64());
        for (String line : nCode) {
            System.out.println(line);
        }

        final Assembler assy = new Assembler(nCode);
        assy.compile(conf);

        return assy;
    }

    @SuppressWarnings("unused")
    private static class MySimpleTracer implements CpuTracer {
        private final Assembler assy;
        private int cnt;

        private MySimpleTracer(Assembler assy) {
            this.assy = assy;
        }

        @Override
        public void commandExecuted(Cpu cpu, int opcode, int opcodePc, int newPc) {

            String line = assy.getCodeLine(opcodePc);
            if (line != null) {
                cnt++;

                System.out.println(Integer.toHexString(opcodePc) + " - " + Integer.toHexString(opcode) + " -> "
                        + Integer.toHexString(newPc) + " / a=" + cpu.getAcc() + " / x=" + cpu.getX() + " / y="
                        + cpu.getY() + "/ z=" + (cpu.getStatus() & 0b10) + " / TMP_ZP=" + printReg(105, assy)
                        + " / TMP2_ZP=" + printReg(107, assy) + " / TMP3_ZP=" + printReg(34, assy) + "/" + line + " "
                        + assy.getRam()[opcodePc + 1] + "/" + cnt + " - FAC1:"
                        + Conversions.convertFloat(assy.getMachine(), 0x61) + " @ " + cpu.getClockTicks());

            }

        }

        private String printReg(int i, Assembler assy) {
            int addr = (assy.getRam()[i] + 256 * assy.getRam()[i + 1]);
            return addr + " [" + (assy.getRam()[addr] + 256 * assy.getRam()[addr + 1]) + "] ";
        }

        private String print16Bit(int i, Assembler assy) {
            return (assy.getRam()[i] + 256 * assy.getRam()[i + 1]) + "";
        }

        @Override
        public void exception(Cpu cpu, int opcode, int opcodePc, int newPc) {
            System.out.println("Exception in " + cnt);
        }
    }
}
