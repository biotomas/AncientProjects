package satUtils.experiment;

public class VariableClauseRatio extends BaseExperiment {

	@Override
	public void runExperiment() {
		for (float ratio = 1; ratio < 10; ratio += 0.1) {
			double result = avgOn(300, (int)(ratio * 300f), 10, 35);
			System.out.println(ratio + " " + result);
		}
		
	}

}
