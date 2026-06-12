package com.sixtyfour.test;

import com.sixtyfour.Loader;
import com.sixtyfour.parser.preprocess.IntPromotionAnalyzer;

import java.util.Arrays;

public class LoopAnalyzerTest {

    public static void main(String[] args) {
        IntPromotionAnalyzer.AnalysisResult res = IntPromotionAnalyzer.analyzeProgram(Arrays.asList(Loader.loadProgram("src/test/resources/transform/fractal_transform.bas")));
        res.getAllSafeVariables().forEach(System.out::println);
        System.out.println("---------------------------------------------");
        res = IntPromotionAnalyzer.analyzeProgram(Arrays.asList(Loader.loadProgram("src/test/resources/transform/farbdemo.bas")));
        res.getAllSafeVariables().forEach(System.out::println);
        System.out.println("---------------------------------------------");
        res = IntPromotionAnalyzer.analyzeProgram(Arrays.asList(Loader.loadProgram("src/test/resources/transform/fractions.bas")));
        res.getAllSafeVariables().forEach(System.out::println);
        System.out.println("---------------------------------------------");
    }

}
