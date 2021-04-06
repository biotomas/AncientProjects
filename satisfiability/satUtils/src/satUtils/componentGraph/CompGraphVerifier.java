package satUtils.componentGraph;

import graph.Edge;
import graph.Graph;
import graph.Vertex;

import java.util.ArrayList;
import java.util.List;

import utilities.MathUtils;


public class CompGraphVerifier {
	
	private static class Tuple {
		public double value;
		public int vertices;
		
		public Tuple(double value, int vertices) {
			this.value = value;
			this.vertices = vertices;
		}
	}
	
	public static void verifyCompGraph(Graph graph, Finder tree) {
		/**
		 * Algorithm:
		 * go down until the first branching and mark the vertices as used.
		 * call DFS for each son to test if they are not connected. The DFS must
		 * not go through vertices marked as used. To check this, you count the number 
		 * of visited vertices. Call the algorithm recursively for the sons.
		 * 
		 * on the way check if the given "tree" is a tree (only one parent)
		 */
		Graph compTree = tree.getTree();
		for (Vertex v : compTree.getAllVertices()) {
			v.used = false;
		}
		
		List<Vertex> roots = compTree.findRoots();
		if (roots.isEmpty()) {
			throw new RuntimeException("The given tree has no root");
		}
		int sum = 0;
		double value = 0;
		for (Vertex root : roots) {
			Tuple t = testTree(compTree, graph, root);
			sum += t.vertices;
			value += t.value;
		}
		if (sum != graph.getAllVertices().size()) {
			throw new RuntimeException("The given component tree is not valid for the given graph");
		}
		if (value != tree.getValue()) {
			throw new RuntimeException("The given component tree value is invalid");
		}
	}
	
	private static Tuple testTree(Graph tree, Graph graph, Vertex root) {
		Vertex v = root;
		int vertices = 0;
		List<Vertex> output = outpoutVertices(tree, v); 
		while (output.size() == 1) {
			v.used = true;
			vertices += 1;
			v = output.get(0);
			output = outpoutVertices(tree, v);
		}
		v.used = true;
		vertices += 1;
		int subTreeSum = 0;
		for (Vertex son : output) {
			unvisitGraph(graph);
			subTreeSum += dfs(graph, son);
		}
		int sum = 0;
		double value = 0;
		for (Vertex son : output) {
			Tuple t = testTree(tree, graph, son);
			sum += t.vertices;
			value += t.value;
		}
		if (sum != subTreeSum) {
			throw new RuntimeException("component tree incorrect");
		}
		if (value == 0) {
			value = MathUtils.multBy2(1, vertices - 1);
		} else {
			value = MathUtils.multBy2(value, vertices);
		}
		return new Tuple(value, sum + vertices);
	}
	
	private static int dfs(Graph graph, Vertex start) {
		if (start.visited || start.used) {
			return 0;
		}
		start.visited = true;
		int sum = 0;
		for (Edge e : graph.getEdgesOf(start)) {
			sum += dfs(graph, e.otherVertex(start));
		}
		return sum + 1;
	}
	
	private static void unvisitGraph(Graph g) {
		for (Vertex v : g.getAllVertices()) {
			v.visited = false;
		}
	}
	
	private static List<Vertex> outpoutVertices(Graph g, Vertex v) {
		boolean inputEdge = false;
		List<Vertex> outputs = new ArrayList<Vertex>();
		for (Edge e : g.getEdgesOf(v)) {
			if (e.getV2() == v) {
				if (inputEdge) {
					throw new RuntimeException("2 inputs in a vertex");
				}
				inputEdge = true;
			} else {
				outputs.add(e.getV2());
			}
		}
		return outputs;
	}

}
