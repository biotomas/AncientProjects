/**
 * 
 */
package cz.matfyz.ctrlaltdel.modeler;

import java.io.IOException;
import java.io.PrintWriter;
import java.security.InvalidParameterException;
import java.util.Vector;

public class LargeClause implements Clause {

	/**
	 * 
	 */
	private final CnfFormula cnfFormula;

	public LargeClause(CnfFormula cnfFormula) {
		this(cnfFormula, false);
	}

	public LargeClause(CnfFormula cnfFormula, boolean addToClause) {
		this.cnfFormula = cnfFormula;
		if (addToClause) {
			this.cnfFormula.addClause(this);
		}
	}

	public void setComment(String comment) {
		this.comment = comment;
	}

	public String getComment() {
		return comment;
	}

	public void addLiteral(Literal l) {
		if (l.getNo() == 0) {
			throw new InvalidParameterException("l");
		}

		this.literals.add(l);
		this.cnfFormula.addLiteral(l);
	}

	public void printOut(PrintWriter out) throws IOException {
		// if (this.comment != null) {
		// out.println("c " + this.comment);
		// }

		for (Literal l : this.literals) {
			l.printOut(out);
			out.write(' ');
		}
	}

	public int getLiteralCount() {
		return literals.size();
	}

	public int[] toArray() {
		int[] array = new int[literals.size()];
		for (int i = 0; i < array.length; ++i) {
			array[i] = literals.get(i).getNo();
		}

		return array;
	}

	public Literal getLiteral(int i) {
		return literals.get(i);
	}

	protected final Vector<Literal> literals = new Vector<Literal>();

	protected String comment = null;

}