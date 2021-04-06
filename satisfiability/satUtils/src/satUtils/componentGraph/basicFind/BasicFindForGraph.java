package satUtils.componentGraph.basicFind;

import graph.Edge;
import graph.Graph;
import graph.SimpleGraph;
import graph.Vertex;
import satUtils.componentGraph.Finder;
import utilities.RandomUtils;

public class BasicFindForGraph implements Finder {
	
	private Graph graph;
	private Graph tree = null;
	private double value = 0;
	private RandomUtils rnd;
	
	public BasicFindForGraph(Graph graph) {
		this.graph = graph;
		rnd = new RandomUtils();
	}

	public Graph getTree() {
		if (tree == null) {
			recompute();
		}
		return tree;
	}

	public double getValue() {
		if (tree == null) {
			recompute();
		}
		return value;
	}

	public void recompute() {
		tree = new SimpleGraph();
		Vertex vertex = rnd.randomPick(graph.getAllVertices());
		tree.addVertex(vertex);
		value = find(vertex);
	}
	
	private double find(Vertex vertex) {
		double value = 0.0;
		for (Edge edge : graph.getEdgesOf(vertex)) {
			Vertex selected = getVertexIfSuitable(edge, vertex);
			if (selected == null) {
				continue;
			}
			tree.addVertex(selected);
			tree.addEdge(vertex, selected);
			value += find(selected);
		}		
		return value == 0 ? 1 : 2*value;
	}
	
	private Vertex getVertexIfSuitable(Edge e, Vertex v) {
		Vertex other = e.getV1();
		if (other.equals(v)) {
			other = e.getV2();
		}
		if (tree.containsVertex(other.getName())) {
			return null;
		}
		return other;
	}

}
