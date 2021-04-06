/**
 * 
 */
package cz.matfyz.ctrlaltdel.modeler.literals;

public final class TupleVariableInfo {

	private TupleLiteral positive;

	private TupleLiteral negative;

	final int variableNo;

	public TupleLiteral getPositive() {
		return positive;
	}

	public TupleLiteral getNegative() {
		return negative;
	}

	public void setPositive(TupleLiteral positive) {
		this.positive = positive;
	}

	public void setNegative(TupleLiteral negative) {
		this.negative = negative;
	}

	public int getVariableNo() {
		return variableNo;
	}

	public TupleVariableInfo(TupleLiteral literal) {
		this.variableNo = literal.getVarNo();
		if (literal.isPositive()) {
			this.positive = literal;
		} else {
			this.negative = literal;
		}
	}

	public TupleLiteral get(boolean positive) {
		if (positive) {
			return this.positive;
		} else {
			return this.negative;
		}
	}

	public void set(boolean positive, TupleLiteral l) {
		if (positive) {
			this.positive = l;
		} else {
			this.negative = l;
		}
	}

}