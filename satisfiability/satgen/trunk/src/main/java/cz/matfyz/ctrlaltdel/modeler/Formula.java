package cz.matfyz.ctrlaltdel.modeler;

import java.io.IOException;
import java.io.PrintWriter;

public abstract class Formula implements Printable {

	public abstract void printOut(PrintWriter writer) throws IOException;
	
}

