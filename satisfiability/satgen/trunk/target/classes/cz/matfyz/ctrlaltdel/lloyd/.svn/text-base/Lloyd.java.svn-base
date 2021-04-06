package cz.matfyz.ctrlaltdel.lloyd;

import cz.matfyz.ctrlaltdel.modeler.CnfFormula;
import cz.matfyz.ctrlaltdel.modeler.Formula;
import cz.matfyz.ctrlaltdel.modeler.LargeClause;
import cz.matfyz.ctrlaltdel.modeler.Literal;
import cz.matfyz.ctrlaltdel.modeler.Modeler;
import cz.matfyz.ctrlaltdel.modeler.generators.RangeSettings;
import cz.matfyz.ctrlaltdel.modeler.generators.RangeSettingsException;
import cz.matfyz.ctrlaltdel.modeler.generators.TupleLiteralHelper;
import cz.matfyz.ctrlaltdel.modeler.generators.RangeSettings.Range;
import cz.matfyz.ctrlaltdel.modeler.generators.RangeSettings.RangeSetting;
import cz.matfyz.ctrlaltdel.modeler.literals.TupleMap;
import cz.matfyz.ctrlaltdel.modeler.literals.IntegerTuple;
import cz.matfyz.ctrlaltdel.modeler.literals.GenericTupleMap;

public class Lloyd extends Modeler {

	/*
	static protected final int[][] initialPosition = {
		{1,		2,		3,		4},
		{5,		6,		7,		8},
		{0,		9,		10,		11},
		{12,	13,		14,		15}
	};


	static protected final int[][] initialPosition = {
		{1,		2},
		{0,		3}
	};
	*/

	public Formula model() {
		try {
			// Initialize it.
			CnfFormula formula = new CnfFormula();
			TupleMap map = new GenericTupleMap(4);
			int numbers = this.getRows() * this.getColumns();

			// Initial position.
			this.createInitialPosition(formula, map);

			// X(k, t, x, y) => -X(k', t, x, y) for all k' != k
			TupleLiteralHelper.createMutuallyExclusiveClauses(
				map,
				formula,
				new RangeSettings(
					new RangeSetting(
						0,
						false,
						new Range(0, numbers)
					),
					new RangeSetting(
						1,
						true,
						new Range(0, this.getTime())
					),
					new RangeSetting(
						2,
						true,
						new Range(0, this.getRows())
					),
					new RangeSetting(
						3,
						true,
						new Range(0, this.getColumns())
					)
				)
			);

			// OR_k X(k, t, x, y) for all t, x, y
			TupleLiteralHelper.createClauses(
				map,
				formula,
				new RangeSettings(
					new RangeSetting(
						0,
						false,
						new Range(0, numbers)
					),
					new RangeSetting(
						1,
						true,
						new Range(0, this.getTime())
					),
					new RangeSetting(
						2,
						true,
						new Range(0, this.getRows())
					),
					new RangeSetting(
						3,
						true,
						new Range(0, this.getColumns())
					)
				)
			);

			// Transitions.
			// X(0, t + 1, x, y) & X(0, t, x - 1, y) & X(k, t - 1, x, y) => X(k, t + 1, x - 1, y)
			// X(k, t, x, y) & -X(0, t + 1, x, y) => X(k, t + 1, x, y)
			// X(0, t + 1, x, y) => X(0, t, x, y) or X(0, t, x, y) or X(0, t, x - 1, y) or X(0, t, x + 1, y) or X(0, t, x, y - 1) or X(0, t, x, y + 1)
			for (int t = 1; t < this.time; ++t) {
				for (int x = 0; x < this.getRows(); ++x) {
					for (int y = 0; y < this.getColumns(); ++y) {
						for (int k = 1; k < numbers; ++k) {
							this.transitionClauses(t, x, y, k, map, formula, k == 1);
						}
					}
				}
			}

			// Final position.
			for (int x = 0, maxTime = this.time - 1; x < this.getRows(); ++x) {
				for (int y = 0; y < this.getColumns(); ++y) {
					LargeClause clause = new LargeClause(formula);
					clause.addLiteral(map.getTupleLiteral(true, new IntegerTuple((x * this.getColumns() + y + 1) % numbers, maxTime, x, y)));
					formula.addClause(clause);
				}
			}

			return formula;
		} catch (RangeSettingsException e) {
			return null;
		} catch (LloydException e) {
			return null;
		}
	}

	protected void createInitialPosition(CnfFormula formula, TupleMap map) throws LloydException {
		LargeClause clause;
		for (int x = 0; x != this.getRows(); ++x) {
			for (int y = 0; y != this.getColumns(); ++y) {
				clause = new LargeClause(formula);
				Literal l = map.getTupleLiteral(true, new IntegerTuple(this.getMatrix().getAt(x, y), 0, x, y));
				clause.addLiteral(l);
				formula.addClause(clause);
			}
		}
	}

	public class LloydException extends Exception {

		private static final long serialVersionUID = 1L;

		public LloydException() {
			super();
		}

		public LloydException(String arg0, Throwable arg1) {
			super(arg0, arg1);
		}

		public LloydException(String arg0) {
			super(arg0);
		}

		public LloydException(Throwable arg0) {
			super(arg0);
		}

	}

	protected void transitionClauses(int t, int x, int y, int k, TupleMap map, CnfFormula f, boolean notJump) {
		int xt, yt;

		// Clause3 means that 0 can not jump (only moves).
		Literal lZeroT = map.getTupleLiteral(false, new IntegerTuple(0, t, x, y));
		LargeClause clauseT3 = new LargeClause(f);
		clauseT3.addLiteral(lZeroT);
		clauseT3.setComment("0 can not jump.");

		for (int[] trans : transitions) {
			xt = x + trans[0];
			yt = y + trans[1];

			if (!(xt >= 0 && xt < this.getRows())) {
				continue;
			}
			if (!(yt >= 0 && yt < this.getColumns())) {
				continue;
			}

			Literal lZeroTB = map.getTupleLiteral(false, new IntegerTuple(0, t - 1, xt, yt));
			Literal lKTB = map.getTupleLiteral(false, new IntegerTuple(k, t - 1, x, y));
			Literal lKT = map.getTupleLiteral(true, new IntegerTuple(k, t, xt, yt));

			// Swapping k and 0
			LargeClause clauseT1 = new LargeClause(f);
			clauseT1.addLiteral(lKTB);
			clauseT1.addLiteral(lZeroT);
			clauseT1.addLiteral(lZeroTB);
			clauseT1.addLiteral(lKT);
			f.addClause(clauseT1);
			clauseT1.setComment("swapping k and 0");

			Literal lZeroTB2 = map.getTupleLiteral(true, new IntegerTuple(0, t - 1, xt, yt));
			clauseT3.addLiteral(lZeroTB2);
		}

		// If k did not swap the positions with 0, it must remain on the same position.
		Literal lKTBXY = map.getTupleLiteral(false, new IntegerTuple(k, t - 1, x, y));
		Literal lZeroTXY = map.getTupleLiteral(true, new IntegerTuple(0, t, x, y));
		Literal lKTXY = map.getTupleLiteral(true, new IntegerTuple(k, t, x, y));
		LargeClause clauseT2 = new LargeClause(f);
		clauseT2.addLiteral(lKTBXY);
		clauseT2.addLiteral(lZeroTXY);
		clauseT2.addLiteral(lKTXY);
		f.addClause(clauseT2);
		clauseT2.setComment("stay on the same");

		if (notJump) {
			f.addClause(clauseT3);
		}
	}

	protected static final int[][] transitions = {
		{0, 1}, {1, 0}, {0, -1}, {-1, 0}
	};

	/**
	 * @return the rows
	 */
	public int getRows() {
		return this.matrix.getRows();
	}

	/**
	 * @return the columns
	 */
	public int getColumns() {
		return this.matrix.getColumns();
	}

	/**
	 * @return the size
	 */
	public int getTime() {
		return time;
	}

	/**
	 * @param time the size to set
	 */
	public void setTime(int time) {
		this.time = time;
	}

	public void setMatrix(LlyodMatrix m) {
		this.matrix = m;
	}

	public LlyodMatrix getMatrix() {
		return this.matrix;
	}

	protected int time;

	protected LlyodMatrix matrix;

}
