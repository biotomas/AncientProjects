package satUtils.componentGraph.greedyFind;

import graph.Edge;
import graph.Graph;
import graph.SimpleGraph;
import graph.Vertex;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashSet;
import java.util.LinkedList;
import java.util.List;
import java.util.Set;

import satUtils.componentGraph.Finder;

public class GreedyFind implements Finder {
	
	private Graph graph;
	private Graph tree = null;
	private double value;
	
	//optimalization arrays
	private List<Vertex> vertList;
	
	public GreedyFind(Graph graph) {
		this.graph = graph;
		vertList = new ArrayList<Vertex>();
	}

	@Override
	public Graph getTree() {
		if (tree == null) {
			recompute();
		}
		return tree;
	}

	@Override
	public double getValue() {
		if (tree == null) {
			recompute();
		}
		return value;
	}

	@Override
	public void recompute() {
		if (tree != null) {
			return;
		}
		tree = new SimpleGraph();
		List<Vertex> queue = new LinkedList<Vertex>(graph.getAllVertices());
		VertexComparator comparator = new VertexComparator();
		while(!queue.isEmpty()) {
			comparator.recompute(queue);
			Vertex v = Collections.min(queue, comparator);
			queue.remove(v);
			tree.addVertex(v);
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
					tree.addEdgeIfNotPresent(v, rep);
					rep.representative = v;
					v.value += rep.value;
				}
				v.value *= 2;
				value = v.value;
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
	
	private class VertexComparator implements Comparator<Vertex> {

		@Override
		public int compare(Vertex o1, Vertex o2) {
			return (int)(o1.temporalValue - o2.temporalValue);
		}
		
		public void recompute(List<Vertex> verts) {
			for (Vertex v : verts) {
				v.temporalValue = computeValue(v);
			}
		}
		
		private double computeValue(Vertex v) {
			Set<Vertex> comp = new HashSet<Vertex>();
			double x = 0;
			for (Edge e : graph.getEdgesOf(v)) {
				Vertex other = e.otherVertex(v);
				if (other.used) {
					comp.add(findTopRepresentative(other));
				}
				x += 1;
			}
			for (Vertex sup : comp) {
				x += 2d*sup.value;
			}
			return x;
		}
	}
}
