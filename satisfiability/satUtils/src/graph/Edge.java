package graph;


public class Edge {
	
	private Vertex v1;
	private Vertex v2;
	
	public Edge(Vertex v1, Vertex v2) {
		this.v1 = v1;
		this.v2 = v2;
	}

	public Vertex getV1() {
		return v1;
	}

	public Vertex getV2() {
		return v2;
	}
	
	public String getID() {
		return v1.getName() + ":" + v2.getName();
	}
	
	public Vertex otherVertex(Vertex v) {
		return v1 == v ? v2 : v1;
	}
	
	@Override
	public String toString() {
		return v1.getName() + "->" + v2.getName();
	}

}
