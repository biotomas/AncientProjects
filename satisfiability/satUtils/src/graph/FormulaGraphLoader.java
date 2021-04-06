package graph;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;

public class FormulaGraphLoader {
	
	public static class FormulaInfo {
		public int varsNum;
		public int clausesNum;
		public String srcName;
		
		@Override
		public String toString() {
			return "src: " + srcName + " vars: " + varsNum + " clauses: " + clausesNum;
		}
	}
	
	private static String getFilenameFromPath(String path) {
		File file = new File(path);
		return file.getName();
	}
	
	public static Graph loadFromCNF(String filename, FormulaInfo info) throws IOException {
		FileReader fl = new FileReader(filename);
		info.srcName = getFilenameFromPath(filename);
		BufferedReader reader = new BufferedReader(fl);
		Graph graph = new SimpleGraph();
		String line;
		while((line = reader.readLine()) != null) {
			if (line.startsWith("c")) {
				continue;
			}
			if (line.startsWith("p")) {
				String[] tokens = line.split(" +");
				int vars = Integer.parseInt(tokens[2]);
				int clauses = Integer.parseInt(tokens[3]);
				info.varsNum = vars;
				info.clausesNum = clauses;
				for(int i = 1; i <= vars; i++) {
					graph.addVertexById(Integer.toString(i));
				}
				continue;
			}
			line = line.trim();
			line = line.replace("-", "");
			String[] slits = line.split(" +");
			for (int i = 0; i + 1 < slits.length; i++) {
				for (int j = i; j + 1 < slits.length; j++) {
					if (!slits[i].equals(slits[j])) {
						graph.addEdgeIfNotPresent(slits[i], slits[j]);
					}
				}
			}
		}
		fl.close();
		return graph;
	}

}
