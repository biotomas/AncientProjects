/**
 * 
 */
package cz.matfyz.ctrlaltdel.modeler;

import java.io.IOException;
import java.io.PrintWriter;

public class QuadraticClause implements Clause {
	
	public QuadraticClause(CnfFormula f, boolean addToFormula) {
		if (addToFormula) {
			f.addClause(this);
		}
		
		cnfFormula = f;
	}

	@Override
	public void addLiteral(Literal l) {
		if (l1 == null) {
			l1 = l;
		} else if (l2 == null) {
			l2 = l;
		} else {
			throw new IndexOutOfBoundsException("Can not add more literals to a quadratic clause.");
		}
		
		cnfFormula.addLiteral(l);
	}
	
	public boolean isPure() {
		return l1 != null && l2 != null;
	}

	@Override
	public String getComment() {
		return comment;
	}

	@Override
	public Literal getLiteral(int i) {
		if (i == 0 && l1 != null) {
			return l1;
		} else if (i == 1 && l2 != null) {
			return l2;
		} else {
			throw new IndexOutOfBoundsException();
		}
	}

	@Override
	public int getLiteralCount() {
		return l2 != null ? 2 : (l1 != null ? 1 : 0);
	}

	@Override
	public void setComment(String comment) {
		this.comment = comment;
	}

	@Override
	public int[] toArray() {
		if (l1 == null) {
			return new int[] {};
		} else if (l2 == null) {
			return new int[] { l1.getNo() };
		} else {
			return new int[] { l1.getNo(), l2.getNo() };
		}
	}

	@Override
	public void printOut(PrintWriter printWriter) throws IOException {
		if (l1 != null) {
			l1.printOut(printWriter);
			printWriter.append(' ');
		}
		
		if (l2 != null) {
			l2.printOut(printWriter);
			printWriter.append(' ');
		}
	}

	private Literal l1, l2;

	private String comment;
	
	private final CnfFormula cnfFormula;

}