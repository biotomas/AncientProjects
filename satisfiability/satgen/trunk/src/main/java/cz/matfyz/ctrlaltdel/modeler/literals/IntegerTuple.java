package cz.matfyz.ctrlaltdel.modeler.literals;

public class IntegerTuple extends Tuple<Integer> {

	protected static Integer[] convertArray(int[] params) {
		Integer[] params2 = new Integer[params.length];
		for (int i = 0, c = params.length; i < c; ++i) {
			params2[i] = params[i];
		}

		return params2;
	}

	public IntegerTuple(int... params) {
		super(IntegerTuple.convertArray(params));
	}

	public boolean equals(Object o) {
		if (!(o instanceof IntegerTuple)) {
			return false;
		}

		IntegerTuple t = (IntegerTuple)o;
		if (t.getLength() != this.getLength()) {
			return false;
		}

		for (int i = 0, c = t.getLength(); i != c; ++i) {
			if (t.getItem(i) != this.getItem(i)) {
				return false;
			}
		}

		return true;
	}

	/*
	public IntegerTuple(Integer... params) {
		super(params);
	}
	*/

}
