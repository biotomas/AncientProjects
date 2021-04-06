package satUtils;


import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Set;

import org.jgraph.graph.DefaultEdge;
import org.jgrapht.UndirectedGraph;
import org.jgrapht.graph.SimpleGraph;

public class VariableGraph {

	private UndirectedGraph<Integer, DefaultEdge> graph;
	private int varNum;
	private int clauseNum;
	
	public UndirectedGraph<Integer, DefaultEdge> getGraph() {
		return graph;
	}
	
	public static String printUndirectedGraph(UndirectedGraph<Integer, DefaultEdge> graph) {
		StringBuilder builder = new StringBuilder();
		Set<DefaultEdge> edges = graph.edgeSet();
		builder.append("Graph G {\n");
		for (DefaultEdge edge : edges) {
			builder.append(edge.getSource() + " -- " + edge.getTarget() + "\n");
		}
		builder.append("}");
		return builder.toString();
	}
	
	public VariableGraph(String filename) {
		List<String> lines = getLines(filename);
		graph = new SimpleGraph<Integer, DefaultEdge>(DefaultEdge.class);
		
		for (String line : lines) {
			if (line.startsWith("c")) {
				continue;
			}
			if (line.startsWith("p")) {
				parseProblemDefinitionLine(line);
				for (int i = 1; i <= varNum; i++) {
					graph.addVertex(i);
				}
				continue;
			}
			line = line.trim();
			String[] slits = line.split(" +");
			int[] ilits = new int[slits.length-1];
			for (int i = 0; 1+i < slits.length; i++) {
				int tmp = Integer.parseInt(slits[i]);
				ilits[i] = tmp > 0 ? tmp : -tmp;
			}
			for (int i = 0; i < ilits.length; i++) {
				for (int j = i; j < ilits.length; j++) {
					if (ilits[i] != ilits[j]) {
						DefaultEdge edge = new DefaultEdge();
						edge.setSource(ilits[i]);
						edge.setTarget(ilits[j]);
						graph.addEdge(ilits[i], ilits[j], edge);
					}
				}
			}
		}
	}
	
	private List<String> getLines(String filename) {
		List<String> lines = new ArrayList<String>();
		try {
			BufferedReader reader = new BufferedReader(new FileReader(filename));
			String line;
			try {
				while ((line = reader.readLine()) != null) {
					lines.add(line);
				}
			} catch (IOException e) {
				System.out.println("Cannot read file: " + filename);
			}
		} catch (FileNotFoundException e) {
			System.out.println("File not found: " + filename);
		}
		return lines;
	}
	
	private void parseProblemDefinitionLine(String line) {
		String[] tokens = line.split(" +");
		varNum = Integer.parseInt(tokens[2]);
		clauseNum = Integer.parseInt(tokens[3]);
	}

	public int getVarNum() {
		return varNum;
	}

	public int getClauseNum() {
		return clauseNum;
	}
}
