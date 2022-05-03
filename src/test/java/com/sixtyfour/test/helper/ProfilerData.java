package com.sixtyfour.test.helper;

/**
 * @author EgonOlsen
 * 
 */
public class ProfilerData implements Comparable<ProfilerData> {
	private long ticks;
	private String command;
	private int calls;
	private long startTicks;

	public long getTicks() {
		return ticks;
	}

	public void called(long startTicks) {
		this.startTicks = startTicks;
		calls++;
	}

	public void returned(long endTicks) {
		ticks += (endTicks - startTicks);
	}

	public void setTicks(long ticks) {
		this.ticks = ticks;
	}

	public String getCommand() {
		return command;
	}

	public void setCommand(String command) {
		this.command = command;
	}

	public int getCalls() {
		return calls;
	}

	public void setCalls(int calls) {
		this.calls = calls;
	}

	@Override
	public String toString() {
		return "Call: " + command + " has been called " + calls + " times. It took a total of " + ticks
				+ " clock ticks to execute it, which results in " + (ticks / calls) + " ticks/call.";
	}

	@Override
	public int compareTo(ProfilerData o) {
		return (int) (o.ticks - ticks);
	}

}
