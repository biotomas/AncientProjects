package cz.matfyz.ctrlaltdel.sat;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileWriter;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

import cz.matfyz.ctrlaltdel.modeler.CnfFormula;
import cz.matfyz.ctrlaltdel.modeler.Formula;

public class RSatSolver extends Solver {

	protected final String RSAT_EXECUTABLE = File.separator.equals("/") ? "/bin/bash rsat.sh" : "rsat_2.01_win.exe";

	@Override
	protected void solve(Formula formula) throws SolvingException {
		try {
			if (!(formula instanceof CnfFormula)) {
				throw new SolvingException("Invalid formula type, must be in CNF.");
			}

			CnfFormula f = (CnfFormula) formula;

			// Vstupna formula.
			File inputFile = File.createTempFile("satgen_input_", ".cnf", new File("."));
			inputFile.deleteOnExit();
			PrintWriter pw = new PrintWriter(new FileWriter(inputFile));
			f.printOut(pw);
			pw.close();

			// Zostav command.
			String[] rawCmd = RSAT_EXECUTABLE.split(" ");
			String[] cmd = new String[rawCmd.length + 2];
			for (int i = 0; i < rawCmd.length; ++i) {
				cmd[i] = rawCmd[i];
			}
			cmd[rawCmd.length] = inputFile.getAbsolutePath();
			cmd[rawCmd.length + 1] = "-s";
			
			// Vyries.
			Process p = Runtime.getRuntime().exec(cmd);
			BufferedReader is = new BufferedReader(new InputStreamReader(p.getInputStream()));

			// Ziskaj riesenie.
			List<Integer> model = new ArrayList<Integer>(f.getVariableCount());
			for (int i = 0, c = f.getVariableCount(); i < c; ++i) {
				model.add(i + 1);
			}
			
			String line;
			boolean found = false;
			while (null != (line = is.readLine())) {
				if (!line.startsWith("v")) {
					continue;
				}

				String[] rawModel = line.split(" ");
				int varNo, litNo;
				for (int i = 1; i < rawModel.length; ++i) {
					litNo = Integer.parseInt(rawModel[i]);
					varNo = Math.abs(litNo);
					
					if (varNo == 0) {
						continue;
					}
					model.set(varNo - 1, litNo);
				}
				
				found = true;
				break;
			}

			// Nastav riesenie.
			if (found) {
				formulaStatus = new FormulaStatus(f, true, model);
			} else {
				formulaStatus = new FormulaStatus(f);
			}
		} catch (Exception e) {
			throw new SolvingException(e.getMessage(), e);
		}
	}

}
