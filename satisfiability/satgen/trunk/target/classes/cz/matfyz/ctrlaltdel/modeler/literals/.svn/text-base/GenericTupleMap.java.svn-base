package cz.matfyz.ctrlaltdel.modeler.literals;

import java.util.Dictionary;
import java.util.Hashtable;

public class GenericTupleMap implements TupleMap {

	public GenericTupleMap(int dimension) {
		this.dimension = dimension;
		this.freeNo = 0;
	}

	public int getDimension() {
		return this.dimension;
	}

	public TupleLiteral getTupleLiteral(boolean positive, IntegerTuple t) {
		if (this.contains(t)) {
			TupleVariableInfo i = tuples.get(t);
			if (null == i.get(positive)) {
				TupleLiteral l = new TupleLiteral(positive, t, i.variableNo);
				i.set(positive, l);
				return l;
			} else {
				return i.get(positive);
			}
		} else {
			++this.freeNo;
			TupleLiteral l = new TupleLiteral(positive, t, this.freeNo);
			tuples.put(t, new TupleVariableInfo(l));
			return l;
		}
	}

	public int getNo(IntegerTuple t) throws NotFoundException {
		if (this.contains(t)) {
			return this.tuples.get(t).variableNo;
		} else {
			throw new NotFoundException("Given tuple has not been found inside the TupleMap.");
		}
	}

	public boolean contains(IntegerTuple t) {
		return this.tuples.get(t) != null;
	}

	protected final int dimension;

	protected int freeNo;

	protected Dictionary<IntegerTuple, TupleVariableInfo> tuples = new Hashtable<IntegerTuple, TupleVariableInfo>();

}
