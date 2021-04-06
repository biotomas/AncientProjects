/**
 * 
 */
package cz.matfyz.ctrlaltdel.modeler.generators;

import java.util.Vector;

import cz.matfyz.ctrlaltdel.modeler.CnfFormula;
import cz.matfyz.ctrlaltdel.modeler.LargeClause;
import cz.matfyz.ctrlaltdel.modeler.generators.RangeSettings.RangeSetting;
import cz.matfyz.ctrlaltdel.modeler.literals.TupleMap;
import cz.matfyz.ctrlaltdel.modeler.literals.IntegerTuple;

public class ClausesGenerator extends FixedPointsGenerator {

	public ClausesGenerator(Vector<RangeSetting> fixedSettings, Vector<RangeSetting> variableSettings,
			TupleMap map, CnfFormula formula) throws GenerationException {

		super(fixedSettings, variableSettings, map, formula);
	}

	protected void onPointGenerated(int[] point) {
		super.onPointGenerated(point);

		int[] myPoint = new int[this.settings.size() + this.variableSettings.size()];
		LargeClause clause = new LargeClause(this.formula);

		// For all variables create the clause.
		for (int i = 0, c = this.variablePoints.size(); i != c; ++i) {
			// Assemble the point.
			this.fillPoint(myPoint, this.variablePoints.get(i), this.variableSettings);
			this.fillPoint(myPoint, point, this.settings);

			// Add to the clause.
			clause.addLiteral(map.getTupleLiteral(true, new IntegerTuple(myPoint)));
		}

		this.formula.addClause(clause);
	}

}