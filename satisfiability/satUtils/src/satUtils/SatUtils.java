package satUtils;

import graph.FormulaGraphLoader;
import graph.Graph;
import graph.FormulaGraphLoader.FormulaInfo;

import java.io.IOException;
import java.io.PrintStream;

import satUtils.componentGraph.CompGraphVerifier;
import satUtils.componentGraph.Finder;
import satUtils.componentGraph.greedyFind.GreedyFind;
import satUtils.experiment.Experiment;
import satUtils.experiment.PhaseTransitionFormulae;
import utilities.Arguments;
import utilities.MathUtils;

public class SatUtils {
	
	public static void main(String[] args) {
		//consoleUse(args);
		Experiment e = new PhaseTransitionFormulae();
		System.out.println(e.runTimedExperiment());
	}
	
	@SuppressWarnings("unused")
	private static void consoleUse(String[] args) {
		Arguments param = new Arguments(args);
		Graph mg = null;
		FormulaInfo info = new FormulaInfo();
		try {
			mg = FormulaGraphLoader.loadFromCNF(param.getFilename(), info);
		} catch (IOException e) {
			e.printStackTrace();
		}
		PrintStream infoStream = param.isComputeGraph() ? System.err : System.out;
		
		Finder gf = new GreedyFind(mg);
		
		if (param.isPrintSrc()) {
			infoStream.print(info.srcName + " ");
		}
		if (param.isPrintVarsAndClauses()) {
			infoStream.print(info.varsNum + " " + info.clausesNum + " ");
		}
		infoStream.println(gf.getValue() + " " + MathUtils.log2(gf.getValue()));
		if (param.isComputeGraph()) {
			System.out.println(gf.getTree().printAsDirectedGraph());
		}
		mg.checkOwnConsistency();
		gf.getTree().checkOwnConsistency();
		CompGraphVerifier.verifyCompGraph(mg, gf);
	}
}
