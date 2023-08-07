package com.sixtyfour.parser.optimize;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;
import java.util.Set;

import com.sixtyfour.Logger;
import com.sixtyfour.config.CompilerConfig;
import com.sixtyfour.elements.Type;
import com.sixtyfour.elements.commands.Command;
import com.sixtyfour.elements.commands.Print;
import com.sixtyfour.parser.Term;
import com.sixtyfour.system.Machine;

/**
 * Optimizes the usage of strings in PRINT statements for memory usage.
 * 
 * @author EgonOlsen
 *
 */
public class StringOptimizer {

	private final static int MIN_STRING_SIZE = 12;
	private final static int MIN_SUB_SIZE = 8;
	private final static int MIN_SAVING = 5;
	
	/**
	 * 
	 * @param config
	 * @param machine
	 */
	public static void optimizeStrings(CompilerConfig config, Machine machine) {
		if (!config.isPrintSizeOptimization()) {
			return;
		}
		try {
			Logger.log("Optimizing PRINT for size...");
			Set<String> strings = new HashSet<>();
			List<Print> prints = new ArrayList<>();
			Command oldy = machine.getCurrentCommand();
			machine.setCurrentCommand(new Print());
			for (Command cmd : machine.getCommandList()) {
				if (cmd.isCommand("PRINT")) {
					Print print = (Print) cmd;
					List<Term> terms = print.getAllTerms();
					for (Term term:terms) {
						if (term!=null && term.isConstant() && term.getType() == Type.STRING) {
							String newString = term.eval(machine).toString();
							prints.add(print);
							if (!newString.isBlank()) {
								newString = newString.trim();
								if (!strings.contains(newString) && newString.length() > MIN_STRING_SIZE) {
									strings.add(newString);
								}
							}
						}
					}
				}
			}
			
			Logger.log("Strings to optimize: "+strings.size());
			if (strings.size()==0) {
				Logger.log("Nothing to optimize!");
				return;
			}
			Map<String, Match> found = new HashMap<>();
			for (String txt:strings) {
				boolean addOne = false;
				String sub = txt;
				String org = txt;
				String searchSub = removeFluff(sub);
				int pos = sub.length();
				do {
					do {
						pos = searchSub.lastIndexOf(" ", pos);
						if (pos!=-1) {
							sub = sub.substring(0, pos);
							searchSub = removeFluff(sub);
							if (!found.containsKey(sub)) {
								for (String str:strings) {
									if (!str.equals(org) && str.contains(sub)) {
										Match match = found.get(sub);
										if (match==null) {
											match = new Match(sub, addOne);
											found.put(sub, match);
										}
										match.inc();
									} 
								}
							}
						} else {
							sub = null;
						}
					} while (sub != null && sub.length()>MIN_SUB_SIZE);
					pos = txt.indexOf(" ");
					if (pos==-1) {
						sub=null;
					} else {
						sub = txt.substring(pos+1);
						txt = sub;
						searchSub = removeFluff(sub);
						pos = sub.length();
						addOne = true;
					}
					
				} while (sub != null && sub.length()>MIN_SUB_SIZE);
			}
			
			List<Match> matches = new ArrayList<>(found.values());
			matches = matches.stream().filter(p -> p.getWeight()>0 && p.getWeight()>MIN_SAVING).collect(Collectors.toList());
			
			Collections.sort(matches, new Comparator<Match>() {
				@Override
				public int compare(Match o1, Match o2) {
					return o2.getWeight()-o1.getWeight();
				}
			});
			
			int inx=1;
			List<Match> toRemove = new ArrayList<>();
			for (Match match:matches) {
				for (int i=inx; i<matches.size(); i++) {
					Match matchy = matches.get(i);
					if (matchy.words.contains(match.words) || match.words.contains(matchy.words)) {
						toRemove.add(matchy);
					}
				}
				inx++;
			}
			matches.removeAll(toRemove);
			
			int opti=0;
			
			for (Match match:matches) {
				//System.out.println("["+match+"]");
				for (Print print:prints) {
					List<Term> terms = print.getAllTerms();
					int idx=0;
					for (Term term:terms) {
						if (term!=null) {
							String str = term.eval(machine).toString();
							if (str.contains(match.words) && !str.equals(match.words)) {
								int pos = str.indexOf(match.words);
								String old = str.substring(0, pos);
								String newy = match.words;
								String leftOver = null;
								if ((old + newy).length() < str.length()) {
									leftOver = str.substring(pos + match.words.length());
								}
								if (old.isBlank()) {
									old = newy;
									newy = leftOver;
									leftOver = null;
								}
								try {
									idx+=print.update(config, machine, old, newy, leftOver, idx);
									opti++;
								} catch(Exception e) {
									Logger.log("Failed to optimize: "+old);
								}
								
							} 
						}
					}
				}
			}
			machine.setCurrentCommand(oldy);
			Logger.log("Strings optimized: "+opti);
			
		} catch(Exception e) {
			e.printStackTrace();
		}
		
	}
	
	private static String removeFluff(String txt) {
		return txt.replace('.', ' ').replace(',', ' ').replace(';', ' ').replace('!', ' ').replace('?', ' ');
	}
	
	private static class Match {
		
		String words;
		int cnt=0;
		boolean addOne;
		
		public Match(String words, boolean addOne) {
			this.words = words;
			this.addOne = addOne;
		}
		
		public void inc() {
			cnt++;
		}
		
		public int getWeight() {
			return (words.length()-11)*(cnt-1)-(addOne?10:0);
		}
		
		 @Override
		 public int hashCode() {
			 return words.hashCode();
		 }
		 
		 @Override
		 public boolean equals(Object obj) {
			 if (obj instanceof Match) {
				 return ((Match)obj).words.equals(words);
			 }
			 return false;
		 }
		
		 @Override
		 public String toString() {
			 return words+": "+cnt+" => "+getWeight();
		 }
	}
	
}
