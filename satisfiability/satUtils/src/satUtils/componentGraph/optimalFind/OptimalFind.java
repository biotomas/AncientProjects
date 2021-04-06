package satUtils.componentGraph.optimalFind;

import graph.Edge;
import graph.Graph;
import graph.SimpleGraph;
import graph.Vertex;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import satUtils.componentGraph.Finder;
import utilities.PermutationGenerator;

public class OptimalFind implements Finder {
	
	private Graph graph;
	private Graph actualTree = null;
	private Graph tree = null;
	private double actualValue;
	private double value;
	
	//optimalization arrays
	private List<Vertex> vertList;
	
	public OptimalFind(Graph graph) {
		this.graph = graph;
		vertList = new ArrayList<Vertex>();
	}

	@Override
	public Graph getTree() {
		if (actualTree == null) {
			recompute();
		}
		return tree;
	}

	@Override
	public double getValue() {
		if (actualTree == null) {
			recompute();
		}
		return value;
	}

	@Override
	public void recompute() {
		List<Vertex> vertices = new ArrayList<Vertex>(graph.getAllVertices());
		PermutationGenerator perms = new PermutationGenerator(vertices.size());
		List<Vertex> order = new ArrayList<Vertex>(vertices.size());
		value = Double.MAX_VALUE;
		while (perms.hasMore()) {
			int[] perm = perms.getNext();
			order.clear();
			for (int i : perm) {
				order.add(vertices.get(i));
			}
			compute(order);
			if (actualValue < value) {
				value = actualValue;
				tree = actualTree;
			}
		}
	}
	
	private void compute(List<Vertex> queue) {
		for (Vertex v : queue) {
			v.used = false;
			v.representative = null;
			v.value = 0;
		}
		actualTree = new SimpleGraph();
		while(!queue.isEmpty()) {
			Vertex v = queue.remove(0);
			actualTree.addVertex(v);
			v.used = true;

			// find all used neighbours, add their representatives as successors
			Set<Vertex> reps = new HashSet<Vertex>();
			for (Edge e : graph.getEdgesOf(v)) {
				Vertex nv = e.otherVertex(v);
				if (nv.used) {
					Vertex rep = findTopRepresentative(nv);
					if (!rep.equals(v)) {
						reps.add(rep);
					}
				}
			}
			if (reps.isEmpty()) {
				v.value = 1;
			} else {
				for (Vertex rep : reps) {
					actualTree.addEdgeIfNotPresent(v, rep);
					rep.representative = v;
					v.value += rep.value;
				}
				v.value *= 2;
				actualValue = v.value;
			}
		}
	}
	
	private Vertex findTopRepresentative(Vertex v) {
		Vertex rep = v;
		vertList.clear();
		while (rep.representative != null) {
			vertList.add(rep);
			rep = rep.representative;
		}
		if (!rep.equals(v)) {
			for (Vertex vert : vertList) {
				vert.representative = rep;
			}
		}
		return rep;
	}
	
}
