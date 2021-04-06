package solver;

import java.util.Map;

public class SatResult {
	
	private boolean satisfiable;
	private Map<String, Boolean> values;
	
	public SatResult(Map<String, Boolean> values, boolean satisfiable) {
		this.values = values;
		this.satisfiable = satisfiable;
	}
	
	public Map<String, Boolean> getValues() {
		return values;
	}

	public boolean isSatisfiable() {
		return satisfiable;
	}

}
