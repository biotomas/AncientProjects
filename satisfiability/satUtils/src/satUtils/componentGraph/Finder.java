package satUtils.componentGraph;

import graph.Graph;

public interface Finder {
	
	public double getValue();
	
	public void recompute();
	
	public Graph getTree();
	
}
