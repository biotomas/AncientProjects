package satUtils.experiment;


public class PhaseTransitionFormulae extends BaseExperiment {
	
	@Override
	public void runExperiment() {
		int clauses;
		for (int i = 100; i < 1000; i += 10) {
			clauses = (int)(4.3*(double)i);
			System.out.println(i + " " + clauses + " " + avgOn(i, clauses, 10, i));
		}
	}
	
}
