package cz.matfyz.ctrlaltdel.modeler.generators;

import java.util.Iterator;
import java.util.Vector;

import cz.matfyz.ctrlaltdel.modeler.CnfFormula;
import cz.matfyz.ctrlaltdel.modeler.generators.RangeSettings.RangeSetting;
import cz.matfyz.ctrlaltdel.modeler.literals.TupleMap;

public class TupleLiteralHelper {

	public static void createMutuallyExclusiveClauses(TupleMap map, CnfFormula formula, RangeSettings settings) {
		Vector<RangeSetting> fixed = toVector(settings, true);
		Vector<RangeSetting> variable = toVector(settings, false);

		try {
			FixedPointsGenerator fpg = new MutuallyExclusiveClausesGenerator(fixed, variable, map, formula);
			fpg.generatePoints();
		} catch(GenerationException e) {
			assert false : "Should not happen.";
		}
	}

	public static void createClauses(TupleMap map, CnfFormula formula, RangeSettings settings) {
		Vector<RangeSetting> fixed = new Vector<RangeSetting>();
		for (Iterator<RangeSetting> i = settings.getFixedSettings(); i.hasNext(); ) {
			fixed.add(i.next());
		}

		Vector<RangeSetting> variable = new Vector<RangeSetting>();
		for (Iterator<RangeSetting> i = settings.getVariableSettings(); i.hasNext(); ) {
			variable.add(i.next());
		}

		try {
			FixedPointsGenerator fpg = new ClausesGenerator(fixed, variable, map, formula);
			fpg.generatePoints();
		} catch(GenerationException e) {
			assert false : "Should not happen.";
		}
	}

	public static Vector<RangeSetting> toVector(RangeSettings settings, boolean fixed) {
		Vector<RangeSetting> s = new Vector<RangeSetting>();
		for (Iterator<RangeSetting> i = fixed ? settings.getFixedSettings() : settings.getVariableSettings(); i.hasNext(); ) {
			s.add(i.next());
		}
		
		return s;
	}

}
