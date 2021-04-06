package utilities;

public class Arguments {
	
	private String filename = null;
	private boolean computeGraph = false;
	private boolean printSrc = false;
	private boolean printVarsAndClauses = false;

	public Arguments(String[] args) {
		for (String arg : args) {
			if (arg.startsWith("-")) {
				switch (arg.charAt(1)) {
				case 'G':
				case 'g':
					computeGraph = true;
					break;
				case 'S':
				case 's':
					printSrc = true;
					break;
				case 'I':
				case 'i':
					printVarsAndClauses = true;
					break;
				case 'h':
				case 'H':
					System.out.println(helpText);
					break;
				default:
					System.out.println("No such argument: " + arg.charAt(1));
					System.out.println(helpText);
					System.exit(1);
					break;
				}
			} else {
				filename = arg;
			}
		}
		if (filename == null) {
			System.out.println(helpText);
			System.exit(1);
		}
	}
	
	private static final String helpText = 
		"Usage grapher.jar [-g][-h][-i][-s] filename.cnf \n" +
		"Parameters: \n" +
		"	g : compute and print the component tree.\n" +
		"	h : print this help.\n" +
		"	i : print formula information (number of variables and clauses.\n" +
		"	s : print formula source name.\n\n" +
		"By default only the component tree value is computed and printed.";

	public String getFilename() {
		return filename;
	}

	public boolean isComputeGraph() {
		return computeGraph;
	}

	public boolean isPrintSrc() {
		return printSrc;
	}

	public boolean isPrintVarsAndClauses() {
		return printVarsAndClauses;
	}
}
