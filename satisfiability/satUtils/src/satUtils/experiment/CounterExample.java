package satUtils.experiment;

import graph.Graph;
import satUtils.componentGraph.Finder;
import satUtils.componentGraph.greedyFind.GreedyFind;
import satUtils.componentGraph.optimalFind.OptimalFind;
import satUtils.formulaGenerators.Random3SatFormula;

public class CounterExample extends BaseExperiment {

	@Override
	public void runExperiment() {
		Random3SatFormula generator = new Random3SatFormula(6, 6, 12);
		
		for (int i = 0; i < 100; i++) {
			Graph g = generator.getNextRandomFormula().getGraph();
	
			Finder f2 = new GreedyFind(g);
			double x = f2.getValue();
			
			Finder f = new OptimalFind(g);
			System.out.println(f.getValue() + " " + x);
			if (f.getValue() != x) {
				System.out.println(g);
				System.out.println(f.getTree());
				System.out.println(f2.getTree());
				break;
			}
		}
	}

}
