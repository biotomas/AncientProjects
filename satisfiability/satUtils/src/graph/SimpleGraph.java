package graph;

import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

public class SimpleGraph implements Graph {
	
	private Map<String, Vertex> vertexMap;
	private Map<String, List<Edge>> neighbours;
	private Map<String, Edge> edges;
	
	public SimpleGraph() {
		vertexMap = new HashMap<String, Vertex>();
		neighbours = new HashMap<String, List<Edge>>();
		edges = new HashMap<String, Edge>();
	}
	
	@Override
	public void addEdge(Vertex v1, Vertex v2) {
		addEdgeById(v1.getName(), v2.getName());
	}
	
	@Override
	public void addEdgeIfNotPresent(Vertex v1, Vertex v2) {
		addEdgeIfNotPresent(v1.getName(), v2.getName());
	}

	@Override
	public void addEdgeById(String v1, String v2) {
		if(!addEdgeIfPossible(v1, v2)) {
			throw new RuntimeException("edge already exists");
		}
	}

	@Override
	public void addEdgeIfNotPresent(String v1, String v2) {
		addEdgeIfPossible(v1, v2);
	}
	
	private boolean addEdgeIfPossible(String v1, String v2) {
		if (vertexMap.containsKey(v1) && vertexMap.containsKey(v2)) {
			Edge edge = new Edge(vertexMap.get(v1), vertexMap.get(v2));
			Edge symEdge = new Edge(vertexMap.get(v2), vertexMap.get(v1));
			if (edges.containsKey(edge.getID()) || edges.containsKey(symEdge.getID())) {
				return false;
			}
			neighbours.get(v1).add(edge);
			neighbours.get(v2).add(edge);
			edges.put(edge.getID(), edge);
			return true;
		}
		throw new RuntimeException("no such vertex");
	}

	@Override
	public void addVertex(Vertex vertex) {
		if (vertexMap.containsKey(vertex.getName())) {
			throw new RuntimeException("vertex already exists");
		}
		vertexMap.put(vertex.getName(), vertex);
		neighbours.put(vertex.getName(), new ArrayList<Edge>());
	}

	@Override
	public void addVertexById(String id) {
		addVertex(new Vertex(id));
	}

	@Override
	public Collection<Edge> getAllEdges() {
		return edges.values();
	}

	@Override
	public Collection<Vertex> getAllVertices() {
		return vertexMap.values();
	}

	@Override
	public Collection<Edge> getEdgesOf(Vertex vertex) {
		return neighbours.get(vertex.getName());
	}

	@Override
	public Vertex getVertexById(String id) {
		return vertexMap.get(id);
	}

	@Override
	public void removeEdge(Edge edge) {
		edges.remove(edge.getID());
		String id1 = edge.getV1().getName();
		String id2 = edge.getV2().getName();
		neighbours.get(id1).remove(edge);
		neighbours.get(id2).remove(edge);
	}

	@Override
	public void removeVertex(String vertex) {
		// TODO implement if needed
		throw new RuntimeException("not implemented yet");
	}
	
	@Override
	public String toString() {
		StringBuilder sb = new StringBuilder();
		sb.append("{");
		for (Edge e : edges.values()) {
			sb.append("(");
			sb.append(e.getV1().getName());
			sb.append(" - ");
			sb.append(e.getV2().getName());
			sb.append(")");
		}
		sb.append("}");
		return sb.toString();
	}

	@Override
	public boolean containsVertex(String id) {
		return vertexMap.containsKey(id);
	}

	@Override
	public String printAsDirectedGraph() {
		StringBuilder builder = new StringBuilder();
		builder.append("digraph G {\n");
		for (Edge e : edges.values()) {
			builder.append(e.getV1().getName() + " -> " + e.getV2().getName() + ";\n");
		}
		builder.append("}");
		return builder.toString();
	}

	@Override
	public String printAsGraph() {
		StringBuilder builder = new StringBuilder();
		builder.append("Graph G {\n");
		for (Edge e : edges.values()) {
			builder.append(e.getV1().getName() + " -- " + e.getV2().getName() + "\n");
		}
		builder.append("}");
		return builder.toString();
	}

	@Override
	public void checkOwnConsistency() {
		//egdes must be a set
		Set<Edge> edgesSet = new HashSet<Edge>(edges.values());
		Set<Edge> neighEdges = new HashSet<Edge>(edges.size());
		if (edgesSet.size() != edges.values().size()) {
			throw new RuntimeException("graph inconsistent, edges problem.");
		}
		//all edges in neighbors must be present in edges list
		for (List<Edge> ns : neighbours.values()) {
			Set<Edge> es = new HashSet<Edge>(ns);
			if (es.size() != ns.size()) {
				throw new RuntimeException("graph inconsistent, duplicate edge in neigbors.");
			}
			if (!edgesSet.containsAll(es)) {
				throw new RuntimeException("graph inconsistent, edges from neigh. not int edges");
			}
			neighEdges.addAll(es);
		}
		//all edges in ... must in neighbors
		if (!neighEdges.containsAll(edgesSet)) {
			throw new RuntimeException("graph inconsistent, not all edges from edges in neighbors");
		}
		for (Edge e : edges.values()) {
			Edge tmp = new Edge(e.getV2(), e.getV1());
			if (edges.containsKey(tmp.getID())) {
				throw new RuntimeException("graph inconsistent, 2-way edge");
			}
		}
	}

	@Override
	public List<Vertex> findRoots() {
		List<Vertex> res = new ArrayList<Vertex>();
		for (Vertex v : vertexMap.values()) {
			boolean input = false;
			for (Edge e : getEdgesOf(v)) {
				if (e.getV2() == v) {
					input = true;
				}
			}
			if (input == false) {
				res.add(v);
			}
		}
		return res;
	}

}
