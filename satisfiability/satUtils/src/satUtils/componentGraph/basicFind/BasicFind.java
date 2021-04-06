package satUtils.componentGraph.basicFind;

import java.util.Random;
import java.util.Set;

import org.jgraph.graph.DefaultEdge;
import org.jgrapht.UndirectedGraph;
import org.jgrapht.experimental.dag.DirectedAcyclicGraph;
import org.jgrapht.experimental.dag.DirectedAcyclicGraph.CycleFoundException;

public class BasicFind {
	
	private UndirectedGraph<Integer, DefaultEdge> graph;
	private DirectedAcyclicGraph<Integer, DefaultEdge> tree;
	private double valuation;
	private Random randomGenerator;

	public BasicFind(UndirectedGraph<Integer, DefaultEdge> graph) {
		this.graph = graph;
		this.randomGenerator = new Random();
	}
	
	public DirectedAcyclicGraph<Integer, DefaultEdge> getTree() {
		if (tree == null) {
			recompute();
		}
		return tree;
	}
	
	public double getValue() {
		if (tree == null) {
			recompute();
		}
		return valuation;
	}
	
	public void recompute() {
		tree = new DirectedAcyclicGraph<Integer, DefaultEdge>(DefaultEdge.class);
		int size = graph.vertexSet().size();
		int rnd = randomGenerator.nextInt(size);
		Integer selectedVertex = null;
		for (Integer vertex : graph.vertexSet()) {
			if (rnd == 0) {
				selectedVertex = vertex;
				break;
			}
			rnd--;
		}
		valuation = find(selectedVertex);				
	}
	
	private double find(Integer vertex) {
		double myValue = 0;
		tree.addVertex(vertex);
		while(true) {		
			Set<DefaultEdge> neighbours = graph.edgesOf(vertex);
			Integer selected = null;
			for (DefaultEdge edge : neighbours) {
				if (!tree.containsVertex((Integer) edge.getTarget())) {
					selected = (Integer) edge.getTarget();
					break;
				}
				if (!tree.containsVertex((Integer) edge.getSource())) {
					selected = (Integer) edge.getSource();
					break;
				}
			}
			if (selected == null) {
				break;
			}
			tree.addVertex(selected);
			try {
				DefaultEdge edge = new DefaultEdge();
				edge.setSource(vertex);
				edge.setTarget(selected);
				tree.addDagEdge(vertex, selected, edge);
			} catch (CycleFoundException e) {
				System.out.println(e);
			}
			myValue += find(selected);
		}
		if (myValue == 0.0) {
			return 1.0;
		} else {
			return 2*myValue;
		}
	}
}
