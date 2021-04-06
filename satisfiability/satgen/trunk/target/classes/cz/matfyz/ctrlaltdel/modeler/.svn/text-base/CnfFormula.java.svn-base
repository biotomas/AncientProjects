package cz.matfyz.ctrlaltdel.modeler;

import java.io.IOException;
import java.io.PrintWriter;
import java.security.InvalidParameterException;
import java.util.Hashtable;
import java.util.Vector;

public class CnfFormula extends Formula {

	public void printOut(PrintWriter writer) throws IOException {
		writer.println(String.format("p cnf %1$s %2$s", this.getVariableCount(), this.getClauseCount()));

		for (Clause c : this.clauses) {
			c.printOut(writer);
			writer.println("0");
		}

		writer.println();
	}

	public int getClauseCount() {
		return this.clauses.size();
	}

	public int getLiteralCount() {
		return this.literalCount;
	}

	public int getVariableCount() {
		return this.variables.size();
	}

	public Clause getClause(int i) {
		return clauses.get(i);
	}

	public void addClause(Clause clause) {
		this.clauses.add(clause);
	}

	protected final Vector<Clause> clauses = new Vector<Clause>();

	protected final Hashtable<Integer, VariableInfo> variables = new Hashtable<Integer, VariableInfo>();

	protected int literalCount = 0;

	protected void addLiteral(Literal l) {
		int varNo = l.getVarNo();
		if (!this.variables.containsKey(varNo)) {
			this.variables.put(varNo, new VariableInfo(l));
			++this.literalCount;

			assert this.variables.size() == varNo : "lvlala";
		} else {
			VariableInfo i = this.variables.get(varNo);
			if (!i.hasSign(l.isPositive())) {
				++this.literalCount;
				i.setLiteral(l);
				assert this.literalCount <= this.getVariableCount() * 2 : "Invalid literals count.";
			}
		}
	}

	protected static class VariableInfo {

		public VariableInfo(Literal l) {
			if (l.isPositive()) {
				this.positive = l;
			} else {
				this.negative = l;
			}
		}

		public Literal getPositiveLiteral() {
			return this.positive;
		}

		public Literal getNegativeLiteral() {
			return this.negative;
		}

		public boolean hasPositive() {
			return this.positive != null;
		}

		public boolean hasNegative() {
			return this.negative != null;
		}

		public void setPositive(Literal l) {
			if (!l.isPositive()) {
				throw new InvalidParameterException("Invalid positive literal for variable.");
			}

			this.positive = l;
		}

		public void setNegative(Literal l) {
			if (l.isPositive()) {
				throw new InvalidParameterException("Invalid negative literal for variable.");
			}

			this.negative = l;
		}

		public boolean hasSign(boolean sign) {
			return sign ? this.hasPositive() : this.hasNegative();
		}

		public void setLiteral(Literal l) {
			if (l.isPositive()) {
				this.setPositive(l);
			} else {
				this.setNegative(l);
			}
		}

		protected Literal positive, negative;

	}

}
