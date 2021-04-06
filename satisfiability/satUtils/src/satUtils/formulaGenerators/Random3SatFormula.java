package satUtils.formulaGenerators;

import graph.Graph;
import graph.SimpleGraph;

import java.util.ArrayList;
import java.util.List;
import java.util.Random;


public class Random3SatFormula {

	private Random rng;
	private int variables;
	private int clauses;
	
	public Random3SatFormula(int variables, int clauses) {
		this.variables = variables;
		this.clauses = clauses;
		rng = new Random();
	}
	
	public Random3SatFormula(int variables, int clauses, long seed) {
		this.variables = variables;
		this.clauses = clauses;
		rng = new Random(seed);		
	}
	
	public RandomFormula getNextRandomFormula() {
		List<int[]> formula = new ArrayList<int[]>(clauses);
		for (int i = 0; i < clauses; i++) {
			int l1,l2,l3;
			l1 = randomLiteral();
			l2 = randomLiteral();
			while (abs(l1) == abs(l2)) {
				l2 = randomLiteral();
			}
			l3 = randomLiteral();
			while (abs(l1) == abs(l3) || abs(l2) == abs(l3)) {
				l3 = randomLiteral();
			}
			int[] clause = {l1,l2,l3};
			formula.add(clause);
		}
		return new RandomFormula(clauses, variables, formula);
	}
	
	private int abs(int x) {
		return x >= 0 ? x : - x;
	}
	
	private int randomLiteral() {
		int var = rng.nextInt(variables) + 1;
		boolean sgn = rng.nextBoolean();
		return sgn ? var : -var;
	}
	
	public class RandomFormula {
		private List<int[]> formula;
		private int variables;
		private int clauses;
		
		public RandomFormula(int clauses, int variables, List<int[]> formula) {
			this.variables = variables;
			this.clauses = clauses;
			this.formula = formula;
		}
		
		public Graph getGraph() {
			Graph graph = new SimpleGraph();
			for (int i = 1; i <= variables; i++) {
				graph.addVertexById(Integer.toString(i));
			}
			for (int[] clause : formula) {
				graph.addEdgeIfNotPresent(Integer.toString(abs(clause[0])), Integer.toString(abs(clause[1])));
				graph.addEdgeIfNotPresent(Integer.toString(abs(clause[1])), Integer.toString(abs(clause[2])));
				graph.addEdgeIfNotPresent(Integer.toString(abs(clause[0])), Integer.toString(abs(clause[2])));
			}
			return graph;
		}
		
		public String getDimacs() {
			StringBuilder sb = new StringBuilder();
			sb.append("p cnf " + variables + " " + clauses + "\n");
			for (int[] clause : formula) {
				sb.append(clause[0] + " " + clause[1] + " " + clause[2] + " 0\n");
			}
			return sb.toString();
		}
	}
}
