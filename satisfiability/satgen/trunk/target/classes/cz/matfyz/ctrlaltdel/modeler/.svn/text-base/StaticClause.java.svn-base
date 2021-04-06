package cz.matfyz.ctrlaltdel.modeler;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

public class StaticClause implements Clause {

	@Override
	public void addLiteral(Literal l) {
		throw new IndexOutOfBoundsException("Literals are static.");
	}

	@Override
	public String getComment() {
		return comment;
	}

	@Override
	public Literal getLiteral(int i) {
		return literals[i];
	}

	@Override
	public int getLiteralCount() {
		return literals.length;
	}

	@Override
	public void setComment(String comment) {
		this.comment = comment;
	}

	@Override
	public int[] toArray() {
		int[] literals = new int[this.literals.length];
		for (int i = 0; i < literals.length; ++i) {
			literals[i] = this.literals[i].getNo();
		}

		return literals;
	}

	@Override
	public void printOut(PrintWriter printWriter) throws IOException {
		for (int i = 0; i < literals.length; ++i) {
			literals[i].printOut(printWriter);
			printWriter.print(' ');
		}
	}

	public StaticClause(CnfFormula f, boolean addToFormula, Literal... literals) {
		cnfFormula = f;
		this.literals = literals;
		for (Literal l : literals) {
			f.addLiteral(l);
		}

		if (addToFormula) {
			cnfFormula.addClause(this);
		}
	}

	public StaticClause(CnfFormula f, boolean addToFormula, List<Literal> literals) {
		cnfFormula = f;
		this.literals = new Literal[literals.size()];
		literals.toArray(this.literals);
		for (Literal l : literals) {
			f.addLiteral(l);
		}

		if (addToFormula) {
			cnfFormula.addClause(this);
		}
	}

	private String comment;

	private final Literal[] literals;

	private final CnfFormula cnfFormula;

}
