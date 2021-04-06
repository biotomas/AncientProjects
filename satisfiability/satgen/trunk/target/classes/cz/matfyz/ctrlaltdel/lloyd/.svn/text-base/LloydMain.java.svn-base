package cz.matfyz.ctrlaltdel.lloyd;

import java.io.*;
import cz.matfyz.ctrlaltdel.modeler.Formula;

public class LloydMain {

	protected static void printUsage() {
		System.err.println("./lloyd <input> <time> [<output>]");
	}

	public static void main(String[] args) {
		Reader r = null;
		PrintWriter w = null;
		if (args.length != 3 && args.length != 2) {
			LloydMain.printUsage();
		} else {
			try {
				r = new BufferedReader(new FileReader(args[0]));
			} catch (IOException e) {
				System.err.println("Could not open input file.");
				return;
			}

			if (args.length == 3) {
				try {
					w = new PrintWriter(new OutputStreamWriter(new BufferedOutputStream(new FileOutputStream(args[args.length - 1]))));
				} catch (IOException e) {
					System.err.println("Could not set output file.");
					return;
				}
			} else {
				w = new PrintWriter(System.out);
			}
		}

		Lloyd llyod = new Lloyd();
		llyod.setTime(Integer.parseInt(args[1]) + 1);
		try {
			llyod.setMatrix(new LlyodMatrix(r, true));
		} catch(IOException e) {
			System.err.println("Invalid matrix.");
			return;
		}
		Formula f = llyod.model();

		try {
			f.printOut(w);
			w.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}


}
