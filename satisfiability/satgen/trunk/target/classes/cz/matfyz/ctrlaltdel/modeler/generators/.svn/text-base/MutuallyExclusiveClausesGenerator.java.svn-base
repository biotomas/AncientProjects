/**
 * 
 */
package cz.matfyz.ctrlaltdel.modeler.generators;

import java.util.Vector;

import cz.matfyz.ctrlaltdel.modeler.CnfFormula;
import cz.matfyz.ctrlaltdel.modeler.QuadraticClause;
import cz.matfyz.ctrlaltdel.modeler.generators.RangeSettings.RangeSetting;
import cz.matfyz.ctrlaltdel.modeler.literals.TupleMap;
import cz.matfyz.ctrlaltdel.modeler.literals.IntegerTuple;

public class MutuallyExclusiveClausesGenerator extends FixedPointsGenerator {

	public MutuallyExclusiveClausesGenerator(Vector<RangeSetting> fixedSettings, Vector<RangeSetting> variableSettings,
			TupleMap map, CnfFormula formula) throws GenerationException {

		super(fixedSettings, variableSettings, map, formula);
	}

	protected void onPointGenerated(int[] point) {
		super.onPointGenerated(point);

		int[] myPoint1 = new int[this.settings.size() + this.variableSettings.size()];
		int[] myPoint2 = new int[this.settings.size() + this.variableSettings.size()];
		for (int i = 0, c = this.variablePoints.size(); i != c; ++i) {
			for (int j = i + 1; j != c; ++j) {
				// Assemble the points.
				this.fillPoint(myPoint1, this.variablePoints.get(i), this.variableSettings);
				this.fillPoint(myPoint2, this.variablePoints.get(j), this.variableSettings);
				this.fillPoint(myPoint1, point, this.settings);
				this.fillPoint(myPoint2, point, this.settings);

				// Make the clause.
				QuadraticClause clause = new QuadraticClause(this.formula, true);
				clause.addLiteral(map.getTupleLiteral(false, new IntegerTuple(myPoint1)));
				clause.addLiteral(map.getTupleLiteral(false, new IntegerTuple(myPoint2)));
			}
		}
	}

}