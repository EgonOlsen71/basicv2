package sixtyfour;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.List;


/**
 * The Class Loader.
 */
public class Loader
{
  
  /**
	 * Load program.
	 * 
	 * @param file
	 *            the file
	 * @return the string[]
	 */
  public static String[] loadProgram(String file)
  {
    List<String> lines = new ArrayList<String>();
    try (BufferedReader br = new BufferedReader(new InputStreamReader(new FileInputStream(new File(file)), "UTF-8")))
    {
      while (br.ready())
      {
        String line = br.readLine();
        if (line!=null && line.trim().length() > 0)
        {
          lines.add(line.trim());
        }
      }
    }
    catch (Exception e)
    {
      throw new RuntimeException("Failed to load program file!", e);
    }
    return lines.toArray(new String[lines.size()]);
  }
}
