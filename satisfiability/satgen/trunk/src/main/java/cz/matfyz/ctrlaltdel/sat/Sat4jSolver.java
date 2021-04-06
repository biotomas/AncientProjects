package cz.matfyz.ctrlaltdel.sat;

import org.sat4j.core.VecInt;
import org.sat4j.minisat.SolverFactory;
import org.sat4j.specs.ContradictionException;
import org.sat4j.specs.ISolver;

import cz.matfyz.ctrlaltdel.modeler.Clause;
import cz.matfyz.ctrlaltdel.modeler.CnfFormula;
import cz.matfyz.ctrlaltdel.modeler.Formula;

public class Sat4jSolver extends Solver {

	@Override
	protected void solve(Formula formula) throws SolvingException {
		if (!(formula instanceof CnfFormula)) {
			throw new SolvingException("Invalid formula type, must be in CNF.");
		}

		CnfFormula f = (CnfFormula) formula;
		ISolver solver = SolverFactory.newDefault();

		try {
			for (int i = 0, c = f.getClauseCount(); i < c; ++i) {
				Clause originalClause = f.getClause(i);
				solver.addClause(new VecInt(originalClause.toArray()));
			}
		} catch (ContradictionException e) {
			throw new SolvingException("Invalid input formula.", e);
		}

		try {
			if (!solver.isSatisfiable()) {
				formulaStatus = new FormulaStatus(formula);
			} else {
				formulaStatus = new FormulaStatus(formula, true, solver.model());
			}
		} catch (Exception e) {
			new SolvingException(e.getMessage(), e);
		}
	}

}
