package cz.matfyz.ctrlaltdel.modeler.generators;

import java.util.Vector;

import cz.matfyz.ctrlaltdel.modeler.generators.RangeSettings.RangeSetting;

/**
 * Generates and stores the list of variable points.
 * 
 * @author Martin Babka
 */
public class VariablePointsGenerator extends PointsGenerator {

	public VariablePointsGenerator(Vector<RangeSetting> variableSettings) throws GenerationException {
		super(variableSettings);

		for (RangeSetting s : variableSettings) {
			if (s.isFixed()) {
				throw new GenerationException("Invalid variable settings.");
			}
		}
	}

	protected void onPointGenerated(int[] point) {
		super.onPointGenerated(point);
		int[] cpy = new int[point.length];
		for (int i = 0, c = point.length; i != c; ++i) {
			cpy[i] = point[i];
		}

		this.variablePoints.add(cpy);
	}

	/**
	 * Generated points.
	 * 
	 * @return List of generated points.
	 */
	protected Vector<int[]> getVariablePoints() {
		return this.variablePoints;
	}

	protected final Vector<int[]> variablePoints = new Vector<int[]>();

}