package cz.matfyz.ctrlaltdel;

import java.io.File;
import java.util.ArrayList;
import java.util.Scanner;

import cz.matfyz.ctrlaltdel.genome_rearrengement.GenomeRearrangement;
import cz.matfyz.ctrlaltdel.genome_rearrengement.GenomeRearrangement.TransitionLiteralTuple;
import cz.matfyz.ctrlaltdel.modeler.CnfFormula;
import cz.matfyz.ctrlaltdel.modeler.literals.TupleMap;
import cz.matfyz.ctrlaltdel.sat.RSatSolver;
import cz.matfyz.ctrlaltdel.sat.Solver;

public class App {
	
	public static class Solution {
		int[] model;
		TupleMap tupleMap;
		int time;
		
		Solution(int[] model, TupleMap tupleMap, int time) {
			this.model = model;
			this.tupleMap = tupleMap;
			this.time = time;
		}
	}
	
	public static Solution findSolution(int time, int[] permutation) throws Exception {
		// Model.
		GenomeRearrangement gr = new GenomeRearrangement(time, permutation);
		CnfFormula f = gr.modelInCnf();
		TupleMap tm = gr.getTupleMap();

		/*/ Vystup fle do suboru.
		PrintWriter pw = new PrintWriter(new BufferedOutputStream(new FileOutputStream("formula.cnf")));
		f.printOut(pw);
		pw.close();
		/**/

		Solver solver = new RSatSolver();
		if (!solver.isSatisfiable(f)) {
			return null;
		}
		return new Solution(solver.findModel(f), tm, time);
	}
	
	public static void main(String[] args) {
		try {
			if (args.length < 1) {
				System.err.println("Usage: satgen <input_file> [time]");
				return;
			}

			// Precitame vstup.
			Scanner scanner = new Scanner(new File(args[0]));
			ArrayList<Integer> inputPermutation = new ArrayList<Integer>();
			while (scanner.hasNextInt()) {
				int nextInt = scanner.nextInt();
				if (nextInt < 1) {
					System.err.println("Invalid input permutation element: " + nextInt);
					return;
				}
				inputPermutation.add(nextInt - 1);
			}
			scanner.close();

			// Vypis permutacie.
			int[] permutation = new int[inputPermutation.size()];
			final int permutationSize = permutation.length;
			System.out.println("Starting permutation:");
			for (int j = 0; j < permutation.length; ++j) {
				permutation[j] = inputPermutation.get(j);
				System.out.print(1 + permutation[j]);
				System.out.print(' ');
			}
			System.out.println();

			Solution result;
			if (args.length == 2) {
				int time = Integer.valueOf(args[1]);
				result = findSolution(time, permutation);
				if (result == null) {
					System.out.println("Unsatisfiable.");
					return;
				}
			} else {
				InterpolFind finder = new InterpolFind();
				result = finder.findSolution(permutation);
			}

//			for (int i = 0; i < model.length; ++i) {
//				System.out.print(i);
//				System.out.print(' ');
//				System.out.println(model[i]);
//			}

			// Zostavenie vysledku.
			for (int t = 0; t < result.time - 1; ++t) {
				int p = 0;
				int var = 0;
				int start = 0;
				int finish = 0;
				boolean assigned;

				for (assigned = false; p < permutationSize; ++p) {
					var = result.tupleMap.getTupleLiteral(true, new TransitionLiteralTuple(t, true, p)).getVarNo();
					if (result.model[var - 1] > 0) {
						assert !assigned : "Start point already assigned";
						start = p;
						assigned = true;
					}
				}
				assert assigned : "Start point not assigned";

				for (p = 0, assigned = false; p < permutationSize; ++p) {
					var = result.tupleMap.getTupleLiteral(true, new TransitionLiteralTuple(t, false, p)).getVarNo();
					if (result.model[var - 1] > 0) {
						assert !assigned : "Finish point already assigned";
						finish = p;
						assigned = true;
					}
				}
				assert assigned : "Finish point not assigned";

				System.out.println(String.format("At time %d we reversed from %d to %d.", t, start, finish));

				for (int j = start; j <= (finish + start) / 2; ++j) {
					int tmp = permutation[j];
					permutation[j] = permutation[finish + start - j];
					permutation[finish + start - j] = tmp;
				}
				for (int j = 0; j < permutation.length; ++j) {
					System.out.print(1 + permutation[j]);
					System.out.print(' ');
				}
				System.out.println();
				System.out.println("Distance: " + result.time);
			}
		} catch (Exception e) {
			System.out.println(e.toString());
			e.printStackTrace();
		}
	}
}
