package cz.matfyz.ctrlaltdel.modeler;

import java.io.IOException;
import java.io.PrintWriter;

public class Literal implements Printable, Comparable<Literal> {

	public Literal(int no, boolean positive) {
		this.no = no;
		this.positive = positive;
	}

	public void printOut(PrintWriter out) throws IOException {
		out.write(Integer.toString(this.getNo()));
	}

	public int compareTo(Literal l) {
		return this.no - l.no;
	}

	public boolean equals(Object o) {
		if (o instanceof Literal) {
			return this.compareTo((Literal)o) == 0;
		}

		return false;
	}

	public int hashCode() {
		return this.no;
	}

	public int getNo() {
		return this.isPositive() ? this.no : -this.no;
	}

	public int getVarNo() {
		return this.no;
	}

	public boolean isPositive() {
		return this.positive;
	}

	protected final boolean positive;

	protected final int no;

}

