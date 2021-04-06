package graph;

import java.util.Collection;
import java.util.List;

public interface Graph {

	/**
	 * Check the graphs consistency. Throws an exception if
	 * the graphs inner structures are inconsistent.
	 */
	public void checkOwnConsistency();
	
	/**
	 * Finds vertices which have no input edges
	 * @return
	 */
	public List<Vertex> findRoots();
	
	public boolean containsVertex(String id);
	
	/**
	 * Adds a vertex to graph. If the edge is present, throws an exception.
	 * @param vertex
	 */
	public void addVertex(Vertex vertex);
	
	/**
	 * Creates a new vertex with the given ID, and adds it to the graph.
	 * If a vertex with this id already exists, throws an exception.
	 * @param id
	 */
	public void addVertexById(String id);
	
	/**
	 * Adds an edge between vertices with given IDs. Throws an exception if
	 * such an edge already exists.
	 * @param v1
	 * @param v2
	 */
	public void addEdgeById(String v1, String v2);
	
	/**
	 * Adds an edge between vertices with given IDs. does nothing if
	 * such an edge already exists.
	 * @param v1
	 * @param v2
	 */
	public void addEdgeIfNotPresent(String v1, String v2);
	
	/**
	 * Adds an edge between the vertices. does nothing if
	 * such an edge already exists.
	 * @param v1
	 * @param v2
	 */
	public void addEdgeIfNotPresent(Vertex v1, Vertex v2);
	
	/**
	 * Adds an edge between the given vertices. Throws an exception if
	 * such an edge already exists.
	 * @param v1
	 * @param v2
	 */
	public void addEdge(Vertex v1, Vertex v2);
	
	/**
	 * Returns the vertex with the given ID.
	 * @param id
	 * @return
	 */
	public Vertex getVertexById(String id);
	
	/**
	 * Removes the specified vertex and all his edges.
	 * @param vertex
	 */
	public void removeVertex(String vertex);
	
	/**
	 * Removes the specified edge.
	 * @param edge
	 */
	public void removeEdge(Edge edge);
	
	public Collection<Edge> getEdgesOf(Vertex vertex);
	
	public Collection<Edge> getAllEdges();
	
	public Collection<Vertex> getAllVertices();
	
	public String printAsDirectedGraph();
	
	public String printAsGraph();
	
}
