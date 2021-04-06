package cz.matfyz.ctrlaltdel.sat;

import java.util.List;

import cz.matfyz.ctrlaltdel.modeler.Formula;

public abstract class Solver {

	public final static class FormulaStatus {

		private final boolean satisfiable;

		private final int[] model;

		private final Formula formula;

		public FormulaStatus(Formula formula, boolean satisfiable, int[] model) {
			this.formula = formula;
			this.satisfiable = satisfiable;
			this.model = model;
		}

		public FormulaStatus(Formula formula, boolean satisfiable, List<Integer> model) throws SolvingException {
			this(formula, satisfiable, getModelAsIntArray(model));
		}
		
		public FormulaStatus(Formula formula) {
			this(formula, false, (int[]) null);
		}

		public static int[] getModelAsIntArray(List<Integer> model) throws SolvingException {
			int[] modelInArray = new int[model.size()];
			for (int i = 0, c = model.size(); i < c; ++i) {
				if (Math.abs(model.get(i)) != i + 1) {
					throw new SolvingException("Invalid model.");
				}
				
				modelInArray[i] = model.get(i);
			}
			return modelInArray;
		}

		public boolean isSatisfiable() {
			return satisfiable;
		}

		public int[] getModel() {
			return model;
		}

		public Formula getFormula() {
			return formula;
		}

	}

	protected FormulaStatus formulaStatus;

	public boolean isSatisfiable(Formula f) throws SolvingException {
		refreshStatus(f);
		return formulaStatus.satisfiable;
	}

	public int[] findModel(Formula f) throws SolvingException {
		refreshStatus(f);
		return formulaStatus.getModel();
	}

	public FormulaStatus getFormulaStatus(Formula f) throws SolvingException {
		refreshStatus(f);
		return formulaStatus;
	}

	abstract protected void solve(Formula f) throws SolvingException;

	protected void refreshStatus(Formula f) throws SolvingException {
		if (null == formulaStatus || formulaStatus.getFormula() != f) {
			this.solve(f);
		}
	}

}
