package com.sixtyfour.test;

import java.util.HashMap;
import java.util.Map;

import com.sixtyfour.templating.Template;
import com.sixtyfour.templating.TemplateManager;


/**
 * A basic template example/test.
 */
public class TemplateTest
{
  public static void main(String[] args)
    throws Exception
  {
    testTemplate();
    testLabeledTemplate();
  }


  private static void testTemplate()
    throws Exception
  {
    Map<String, Object> vars = new HashMap<String, Object>();
    vars.put("CN", 10);
    vars.put("NA$", "Test");
    vars.put("TT$", "At least better than PHP!");

    TemplateManager tm = new TemplateManager();
    Template templ = tm.getTemplate("src/test/resources/templates/html.cbm");
    templ.setVariables(vars);
    String res = templ.process();
    System.out.println(res);
  }


  private static void testLabeledTemplate()
    throws Exception
  {
    final TemplateManager tm = new TemplateManager();

    for (int i = 0; i < 10; i++)
    {

      Thread tr = new Thread()
      {
        @Override
        public void run()
        {
          Template templ = tm.getTemplate("src/test/resources/templates/htmlwithlabels.cbm");

          Map<String, Object> vars = new HashMap<String, Object>();
          vars.put("CN", 10);
          vars.put("NA$", "Test");
          vars.put("TT$", "At least better than PHP!");

          templ.setVariables(vars);
          String res = templ.process();
          System.out.println(res);
        }
      };
      tr.start();
    }

  }
}
