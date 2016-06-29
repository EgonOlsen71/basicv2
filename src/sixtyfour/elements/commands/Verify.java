package sixtyfour.elements.commands;

import sixtyfour.plugins.DeviceProvider;
import sixtyfour.system.Machine;
import sixtyfour.system.ProgramCounter;


public class Verify
  extends FileOperation
{

  public Verify()
  {
    super("VERIFY");
  }


  @Override
  public ProgramCounter execute(Machine machine)
  {
    DeviceProvider device = machine.getDeviceProvider();

    try
    {
      switch (pars.size())
      {
        case 0:
          device.verify("", 1, 0);
          break;
        case 1:
          device.verify((String) pars.get(0).eval(machine), 1, 0);
          break;
        case 2:
          device.verify((String) pars.get(0).eval(machine), ((Number) pars.get(1).eval(machine)).intValue(), 0);
          break;
        case 3:
          device.verify((String) pars.get(0).eval(machine), ((Number) pars.get(1).eval(machine)).intValue(),
              ((Number) pars.get(2).eval(machine)).intValue());
          break;
        default:
          throw new RuntimeException("Syntax error: " + this);
      }
    }
    catch (ClassCastException e)
    {
      throw new RuntimeException("Syntax error: " + this);
    }

    return null;
  }

}
