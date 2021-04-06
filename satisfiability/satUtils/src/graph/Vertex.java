package graph;

public class Vertex {
	
	private String name;
	
	// public properties
	public boolean used = false;
	public boolean visited = false;
	public double value = 0;
	public double temporalValue = 0;
	public Vertex representative = null;
	
	public Vertex(String name) {
		this.name = name;
	}
	public String getName() {
		return name;
	}
	
	@Override
	public String toString() {
		return name;
	}
	
}
