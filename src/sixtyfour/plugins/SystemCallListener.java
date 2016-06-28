package sixtyfour.plugins;

public interface SystemCallListener
{
  void sys(int addr, Object... params);
}
