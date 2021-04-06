package cz.matfyz.ctrlaltdel.modeler.generators;

import java.util.Vector;

import cz.matfyz.ctrlaltdel.modeler.CnfFormula;
import cz.matfyz.ctrlaltdel.modeler.generators.RangeSettings.RangeSetting;
import cz.matfyz.ctrlaltdel.modeler.literals.TupleMap;

/**
 * Fixed points generator. Every point consists of a fixed part and the variable part. For every fixed part the 
 * {@see #onPointGenerated(int[])} is called. There the user code can combine it with the variable part. The helper
 * method {@see #fillPoint(int[], int[], Vector&lt;RangeSetting&gt;)} may be used to fill the point by combining its
 * fixed and variable part. 
 * 
 * @author Martin Babka
 */
public class FixedPointsGenerator extends PointsGenerator {

	public FixedPointsGenerator(Vector<RangeSetting> fixedSettings, Vector<RangeSetting> variableSettings, TupleMap map, CnfFormula formula)
			throws GenerationException {
		super(fixedSettings);

		for (RangeSetting s : fixedSettings) {
			if (!s.fixed) {
				throw new GenerationException("Invalid fixed settings.");
			}
		}

		VariablePointsGenerator vpg = new VariablePointsGenerator(variableSettings);
		vpg.generatePoints();

		this.variablePoints = vpg.getVariablePoints();
		this.variableSettings = variableSettings;
		this.map = map;
		this.formula = formula;
	}

	/**
	 * Fills the point.
	 * 
	 * @param resPoint	Result point - will have its values set.
	 * @param point		Part of the point (fixed or variable) that is already generated.
	 * @param settings	Settings describing where the {@code point}'s values should be fitted into the 
	 * 					{@code resPoint}'s.	
	 */
	protected void fillPoint(int[] resPoint, int[] point, Vector<RangeSetting> settings) {
		for (int i = 0, c = settings.size(); i != c; ++i) {
			resPoint[settings.get(i).getDimension()] = point[i];
		}
	}

	protected final Vector<int[]> variablePoints;

	protected final Vector<RangeSetting> variableSettings;

	protected final TupleMap map;

	protected final CnfFormula formula;

}