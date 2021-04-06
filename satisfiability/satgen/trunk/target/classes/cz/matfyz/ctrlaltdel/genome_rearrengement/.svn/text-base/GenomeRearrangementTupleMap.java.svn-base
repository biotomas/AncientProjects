package cz.matfyz.ctrlaltdel.genome_rearrengement;

import java.util.Hashtable;

import cz.matfyz.ctrlaltdel.genome_rearrengement.GenomeRearrangement.TransitionType;
import cz.matfyz.ctrlaltdel.genome_rearrengement.GenomeRearrangement.VariableType;
import cz.matfyz.ctrlaltdel.modeler.literals.IntegerTuple;
import cz.matfyz.ctrlaltdel.modeler.literals.NotFoundException;
import cz.matfyz.ctrlaltdel.modeler.literals.TupleLiteral;
import cz.matfyz.ctrlaltdel.modeler.literals.TupleMap;
import cz.matfyz.ctrlaltdel.modeler.literals.TupleVariableInfo;

public class GenomeRearrangementTupleMap implements TupleMap {

	@Override
	public boolean contains(IntegerTuple t) {
		return contains(t.getItem(0), t.getItem(1), t.getItem(2), t.getItem(3));
	}

	@Override
	public int getNo(IntegerTuple t) throws NotFoundException {
		return getNo(t.getItem(0), t.getItem(1), t.getItem(2), t.getItem(3));
	}

	@Override
	public TupleLiteral getTupleLiteral(boolean positive, IntegerTuple t) {
		return getLiteral(positive, t.getItem(0), t.getItem(1), t.getItem(2), t.getItem(3));
	}

	public boolean containsState(int time, int value, int position) {
		return contains(VariableType.STATE.getValue(), time, value, position);
	}

	public boolean containsTransition(int time, boolean start, int position) {
		return contains(VariableType.TRANSITION.getValue(), time,
				(start ? TransitionType.START : TransitionType.FINISH).getValue(), position);
	}

	protected boolean contains(int type, int time, int value, int position) {
		return map.containsKey(getKey(type, time, value, position));
	}

	protected int getNo(int type, int time, int value, int position) throws NotFoundException {
		String key = getKey(type, time, value, position);
		if (!map.containsKey(key)) {
			throw new NotFoundException("Given tuple has not been found inside the TupleMap.");
		}

		return map.get(key).getVariableNo();
	}

	private String getKey(int type, int time, int value, int position) {
		return String.format("%d-%d-%d-%d", type, time, value, position);
	}

	public TupleLiteral getLiteral(boolean positive, int type, int time, int value, int position) {
		String key = getKey(type, time, value, position);

		TupleLiteral tl = null;
		if (!map.containsKey(key)) {
			tl = new TupleLiteral(positive, new IntegerTuple(type, time, value, position), ++freeNo);
			TupleVariableInfo i = new TupleVariableInfo(tl);
			map.put(key, i);
		} else {
			TupleVariableInfo i = map.get(key);
			tl = i.get(positive);
			if (tl == null) {
				tl = new TupleLiteral(positive, new IntegerTuple(type, time, value, position), i.getVariableNo());
				i.set(positive, tl);
			}
		}

		return tl;
	}

	public TupleLiteral getTransitionLiteral(boolean positive, int time, boolean start, int position) {
		return getLiteral(positive, VariableType.TRANSITION.getValue(), time, start ? TransitionType.START.getValue()
				: TransitionType.FINISH.getValue(), position);
	}

	public TupleLiteral getStateLiteral(boolean positive, int time, int value, int position) {
		return getLiteral(positive, VariableType.STATE.getValue(), time, value, position);
	}

	@Override
	public int getDimension() {
		return TUPLE_DIMENSION;
	}

	static final int TUPLE_DIMENSION = 4;

	private int freeNo = 0;

	private final Hashtable<String, TupleVariableInfo> map = new Hashtable<String, TupleVariableInfo>();

}
