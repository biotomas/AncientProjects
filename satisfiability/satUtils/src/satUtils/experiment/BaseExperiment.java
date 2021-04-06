package satUtils.experiment;

import graph.Graph;
import satUtils.componentGraph.CompGraphVerifier;
import satUtils.componentGraph.Finder;
import satUtils.componentGraph.greedyFind.GreedyFind;
import satUtils.formulaGenerators.Random3SatFormula;
import utilities.MathUtils;

public abstract class BaseExperiment implements Experiment {

	@Override
	public final long runTimedExperiment() {
		long start = System.currentTimeMillis();
		runExperiment();
		return System.currentTimeMillis() - start;
	}

	protected double avgOn(int vars, int clauses, int repeats, long seed) {
		Random3SatFormula generator = new Random3SatFormula(vars, clauses, seed);
		double result = 0;
		for (int i = 0; i < repeats; i++) {
			Graph fg = generator.getNextRandomFormula().getGraph();
			fg.checkOwnConsistency();
			Finder f = new GreedyFind(fg);
			f.getTree().checkOwnConsistency();
			CompGraphVerifier.verifyCompGraph(fg, f);
			result += MathUtils.log2(f.getValue());
		}
		return result/repeats;
	}
	
}
