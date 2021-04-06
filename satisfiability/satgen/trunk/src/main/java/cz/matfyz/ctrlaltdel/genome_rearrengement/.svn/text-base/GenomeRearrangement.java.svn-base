package cz.matfyz.ctrlaltdel.genome_rearrengement;

import java.util.ArrayList;
import java.util.List;

import cz.matfyz.ctrlaltdel.modeler.CnfFormula;
import cz.matfyz.ctrlaltdel.modeler.Formula;
import cz.matfyz.ctrlaltdel.modeler.LargeClause;
import cz.matfyz.ctrlaltdel.modeler.Literal;
import cz.matfyz.ctrlaltdel.modeler.Modeler;
import cz.matfyz.ctrlaltdel.modeler.ModellingException;
import cz.matfyz.ctrlaltdel.modeler.QuadraticClause;
import cz.matfyz.ctrlaltdel.modeler.StaticClause;
import cz.matfyz.ctrlaltdel.modeler.generators.PointsGenerator;
import cz.matfyz.ctrlaltdel.modeler.generators.RangeSettings;
import cz.matfyz.ctrlaltdel.modeler.generators.TupleLiteralHelper;
import cz.matfyz.ctrlaltdel.modeler.generators.RangeSettings.Range;
import cz.matfyz.ctrlaltdel.modeler.generators.RangeSettings.RangeSetting;
import cz.matfyz.ctrlaltdel.modeler.literals.IntegerTuple;
import cz.matfyz.ctrlaltdel.modeler.literals.TupleMap;

public class GenomeRearrangement extends Modeler {

	public static class StateLiteralTuple extends IntegerTuple {

		public StateLiteralTuple(int time, int value, int position) {
			super(VariableType.STATE.getValue(), time, value, position);
		}

	}

	public static class TransitionLiteralTuple extends IntegerTuple {

		public TransitionLiteralTuple(int time, boolean start, int position) {
			super(
					VariableType.TRANSITION.getValue(), 
					time, 
					start ? TransitionType.START.getValue() : TransitionType.FINISH.getValue(), 
					position
			);
		}

	}
	
	protected boolean encodeTransitionStartImpliesTransitionFinish = true;
	
	protected boolean encodeTransitionStartExists = true;
	
	protected boolean encodeState = true;
	
	public boolean getEncodeTransitionStartImpliesTransitionFinish() {
		return encodeTransitionStartImpliesTransitionFinish;
	}

	public void setEncodeTransitionStartImpliesTransitionFinish(boolean encodeTransitionStartImpliesTransitionFinish) {
		this.encodeTransitionStartImpliesTransitionFinish = encodeTransitionStartImpliesTransitionFinish;
	}

	public boolean getEncodeTransitionStartExists() {
		return encodeTransitionStartExists;
	}

	public void setEncodeTransitionStartExists(boolean encodeTransitionStartExists) {
		this.encodeTransitionStartExists = encodeTransitionStartExists;
	}

	public boolean getEncodeState() {
		return encodeState;
	}

	public void setEncodeState(boolean encodeState) {
		this.encodeState = encodeState;
	}

	public static enum TransitionType {
		
		START(1), FINISH(0);
		
		public static final Range range = new Range(0, 2); 
		
		private final int value;

		private TransitionType(int value) {
			this.value = value;
		}

		public int getValue() {
			return value;
		}
		
	}

	public static enum VariableType {

		TRANSITION(0), STATE(1);

		private final int value;

		private VariableType(int value) {
			this.value = value;
		}

		public int getValue() {
			return value;
		}

	}

	public static enum Dimension {

		TYPE(0), TIME(1), VALUE(2), TRANSITION(2), POSITION(3);

		private final int value;

		private Dimension(int value) {
			this.value = value;
		}

		public int getValue() {
			return value;
		}

	}

	protected List<Integer> permutation;

	protected List<Integer> finalPermutation;

	protected int time;

	protected CnfFormula f;

	protected GenomeRearrangementTupleMap tm;

	public GenomeRearrangement(int time, int... permutation) throws Exception {
		ArrayList<Integer> p = new ArrayList<Integer>(permutation.length);
		for (int i = 0; i < permutation.length; ++i) {
			p.add(permutation[i]);
		}
		
		setPermutation(p);
		setTime(time);
	}

	public GenomeRearrangement(int time, List<Integer> permutation) throws Exception {
		setPermutation(permutation);
		setTime(time);
	}

	protected boolean isPermutation(List<Integer> permutation) {
		List<Boolean> check = new ArrayList<Boolean>(permutation.size());
		for (int i = 0, c = permutation.size(); i != c; ++i) {
			check.add(false);
		}
		
		for (int i = 0, c = permutation.size(); i != c; ++i) {
			check.set(permutation.get(i), true);
		}

		for (int i = 0, c = permutation.size(); i != c; ++i) {
			if (!check.get(i)) {
				return false;
			}
		}

		return true;
	}
	
	public TupleMap getTupleMap() {
		return tm;
	}

	@Override
	public Formula model() throws ModellingException {
		return modelInCnf();
	}
	
	public CnfFormula modelInCnf() throws ModellingException {
		createEnvironment();

		createInitialPermutation();
		createFinalPermutation();
		encodeStates();
		encodeTransitions();

		CnfFormula rf = f;
		return rf;
	}

	protected void createEnvironment() {
		cleanEnvironment();
		
		tm = new GenomeRearrangementTupleMap();
		f = new CnfFormula();
		finalPermutation = new ArrayList<Integer>(permutation.size());
		for (int i = 0, c = permutation.size(); i != c; ++i) {
			finalPermutation.add(i);
		}
	}

	public void cleanEnvironment() {
		tm = null;
		f = null;
		finalPermutation = null;
	}

	protected void createInitialPermutation() {
		encodePermutation(permutation, 0);
	}

	protected void createFinalPermutation() {
		encodePermutation(finalPermutation, time - 1);
	}

	protected void encodePermutation(List<Integer> permutation, int time) {
		QuadraticClause cl;
		
		for (int i = 0, c = permutation.size(); i != c; ++i) {
			cl = new QuadraticClause(f, true);
			cl.addLiteral(tm.getStateLiteral(true, time, permutation.get(i), i));

			for (int j = 0; j != c; ++j) {
				if (j == permutation.get(i)) {
					continue;
				}

				cl = new QuadraticClause(f, true);
				cl.addLiteral(tm.getStateLiteral(false, time, j, i));
			}
		}
	}

	protected void encodeStates() throws ModellingException {
		for (int i = 1; i < time - 1; ++i) {
			// Last state is the final permutation, no special enforcing
			// needed. Also note that the variables can not be set
			// arbitrarily because of the transition validity.
			// Also note that from the previous reason and because of the
			// fact that the first state is a permutation the encode state
			// can be omitted.
			encodeState(i);
		}
	}

	protected void encodeTransitions() throws ModellingException {
		// We mark two points start and end. The start point must be before the
		// end point.Then we enforce the reversal between the two points and
		// make the other values remain at the same positions.

		// For every transversal y(time, start, position) make sure that y(time,
		// end, position) is higher.
		// So if y(time, end, p) => OR(i = 0, p - 1) y(time, start, i).
		RangeSettings settings = new RangeSettings(
				new RangeSetting(
						Dimension.TYPE.getValue(), 
						false, 
						new Range(VariableType.TRANSITION.getValue(), VariableType.TRANSITION.getValue() + 1)
				), 
				new RangeSetting(
						Dimension.TIME.getValue(),
						false, 
						new Range(0, getTime() - 1)
				), 
				new RangeSetting(
						Dimension.TRANSITION.getValue(), 
						false, 
						getEncodeTransitionStartImpliesTransitionFinish() ?
								TransitionType.range :
								new Range(TransitionType.FINISH.getValue(), TransitionType.FINISH.getValue() + 1)
				), 
				new RangeSetting(
						Dimension.POSITION.getValue(), 
						false,
						new Range(0, permutation.size())
				)
		);
		
		new PointsGenerator(TupleLiteralHelper.toVector(settings, false)) {  

			protected void onPointGenerated(int[] point) {
				if (point[Dimension.TRANSITION.getValue()] == TransitionType.START.getValue()) {
					LargeClause c = new LargeClause(f, true);
					
					c.addLiteral(tm.getTransitionLiteral(
							false, 
							point[Dimension.TIME.getValue()], 
							true, 
							point[Dimension.POSITION.getValue()]
					));
					
					for (int i = point[Dimension.POSITION.getValue()]; i < permutation.size(); ++i) {
						c.addLiteral(tm.getTransitionLiteral(true, point[Dimension.TIME.getValue()], false, i));
					}
				} else {
					LargeClause c = new LargeClause(f, true);
					
					c.addLiteral(tm.getTransitionLiteral(
							false, 
							point[Dimension.TIME.getValue()], 
							false, 
							point[Dimension.POSITION.getValue()]
					));
					
					for (int i = 0; i <= point[Dimension.POSITION.getValue()]; ++i) {
						c.addLiteral(tm.getTransitionLiteral(true, point[Dimension.TIME.getValue()], true, i));
					}
				}
			}
		}.generatePoints();
		
		// Make sure that every transition value exists y(start, end, i) for any i. This
		// implies the existence of the start.
		TupleLiteralHelper.createClauses(
				tm, 
				f,
				new RangeSettings(
						new RangeSetting(
								Dimension.TYPE.getValue(), 
								true, 
								new Range(VariableType.TRANSITION.getValue(), VariableType.TRANSITION.getValue() + 1)
						), 
						new RangeSetting(
								Dimension.TIME.getValue(),
								true, 
								new Range(0, getTime() - 1)
						), 
						new RangeSetting(
								Dimension.TRANSITION.getValue(), 
								true, 
								getEncodeTransitionStartExists() ? 
										TransitionType.range :
										new Range(
												TransitionType.FINISH.getValue(), 
												TransitionType.FINISH.getValue() + 1
										)
						), 
						new RangeSetting(
								Dimension.POSITION.getValue(), 
								false,
								new Range(0, permutation.size())
						)
				)
		);
		
		// Also make sure that the start and end is defined correctly.
		TupleLiteralHelper.createMutuallyExclusiveClauses(
				tm, 
				f, 
				new RangeSettings(
						new RangeSetting(
								Dimension.TYPE.getValue(), 
								true, 
								new Range(VariableType.TRANSITION.getValue(), VariableType.TRANSITION.getValue() + 1)), 
						new RangeSetting(
								Dimension.TIME.getValue(),
								true, 
								new Range(0, getTime() - 1)
						), 
						new RangeSetting(
								Dimension.TRANSITION.getValue(), 
								true, 
								TransitionType.range
						), 
						new RangeSetting(
								Dimension.POSITION.getValue(), 
								false,
								new Range(0, permutation.size())
						)
				)
		);

		// Implement the transition.
		// Every non affected variable stays the same and the affected are reverted.
		settings = new RangeSettings(
				new RangeSetting(
						Dimension.TYPE.getValue(), 
						false, 
						new Range(VariableType.TRANSITION.getValue(), VariableType.TRANSITION.getValue() + 1)
				), 
				new RangeSetting(
						Dimension.TIME.getValue(),
						false, 
						new Range(0, getTime() - 1)
				), 
				new RangeSetting(
						Dimension.TRANSITION.getValue(), 
						false, 
						new Range(TransitionType.FINISH.getValue(), TransitionType.FINISH.getValue() + 1)
				), 
				new RangeSetting(
						Dimension.POSITION.getValue(), 
						false,
						new Range(0, permutation.size())
				)
		);
	
		new PointsGenerator(TupleLiteralHelper.toVector(settings, false)) {  

			protected void onPointGenerated(int[] point) {
				int t = point[Dimension.TIME.getValue()];
				int finish = point[Dimension.POSITION.getValue()]; 
				
				for (int start = 0; start <= finish; ++start) {
					noChangeClauses(t, start, finish, true);
					noChangeClauses(t, start, finish, false);
					
					changeClauses(t, start, finish);
				}
			}
		}.generatePoints();
	}
	
	protected void changeClauses(int time, int start, int finish) {
		for (int i = start; i <= (finish + start) / 2; ++i) {
			swap(time, start, finish, i, finish - i + start);
		}
	}
	
	protected void swap(int time, int start, int finish, int p1, int p2) {
		List<Literal> literals = new ArrayList<Literal>();
		for (int v = 0, s = permutation.size(); v < s; ++v) {
			literals.clear();
			addTransitionBody(literals, time, start, finish);
			addEquivalence(literals, time, time + 1, p1, p2, v);
			new StaticClause(f, true, literals);

			literals.clear();
			addTransitionBody(literals, time, start, finish);
			addEquivalence(literals, time + 1, time, p1, p2, v);
			new StaticClause(f, true, literals);

			literals.clear();
			addTransitionBody(literals, time, start, finish);
			addEquivalence(literals, time, time + 1, p2, p1, v);
			new StaticClause(f, true, literals);

			literals.clear();
			addTransitionBody(literals, time, start, finish);
			addEquivalence(literals, time + 1, time, p2, p1, v);
			new StaticClause(f, true, literals);
		}
	}
	
	protected void noChangeClauses(int time, int start, int finish, boolean first) {
		int from = first ? 0 : finish + 1;
		int to = first ? start : permutation.size();
		
		List<Literal> literals = new ArrayList<Literal>();
		for (int k = from; k < to; ++k) {
			for (int v = 0, s = permutation.size(); v < s; ++v) {
				// transition from i to j => x at k stays the same.
				literals.clear();
				addTransitionBody(literals, time, start, finish);
				addEquivalence(literals, time, time + 1, k, k, v);
				new StaticClause(f, true, literals);
				
				literals.clear();
				addTransitionBody(literals, time, start, finish);
				addEquivalence(literals, time + 1, time, k, k, v);
				new StaticClause(f, true, literals);
			}
		}
	}
	
	protected void addTransitionBody(List<Literal> literals, int time, int start, int finish) {
		literals.add(tm.getTransitionLiteral(false, time, true, start));
		literals.add(tm.getTransitionLiteral(false, time, false, finish));
	}
	
	protected void addEquivalence(List<Literal> literals, int time1, int time2, int position1, int position2, int value) {
		literals.add(tm.getStateLiteral(false, time1, value, position1));
		literals.add(tm.getStateLiteral(true, time2, value, position2));
	}

	protected void encodeState(int time) throws ModellingException {
		if (getEncodeState()) {
			// Mutexy na jednotlive pozicie.
			TupleLiteralHelper.createMutuallyExclusiveClauses(tm, f, new RangeSettings(
					new RangeSetting(
							Dimension.TYPE.getValue(), 
							true, 
							new Range(VariableType.STATE.getValue(), VariableType.STATE.getValue() + 1)
					), 
					new RangeSetting(
							Dimension.TIME.getValue(),
							true, 
							new Range(0, getTime() - 1)
					), 
					new RangeSetting(
							Dimension.VALUE.getValue(), 
							true, 
							new Range(0, permutation.size())
					), 
					new RangeSetting(
							Dimension.POSITION.getValue(), 
							false,
							new Range(0, permutation.size())
					)
			));

			// Existencia na jednotlive pozicie.
			TupleLiteralHelper.createClauses(tm, f, new RangeSettings(
					new RangeSetting(
							Dimension.TYPE.getValue(), 
							true, 
							new Range(VariableType.STATE.getValue(), VariableType.STATE.getValue() + 1)
					), 
					new RangeSetting(
							Dimension.TIME.getValue(),
							true, 
							new Range(0, getTime() - 1)
					), 
					new RangeSetting(
							Dimension.VALUE.getValue(), 
							true, 
							new Range(0, permutation.size())
					), 
					new RangeSetting(
							Dimension.POSITION.getValue(), 
							false,
							new Range(0, permutation.size())
					)
			));
		}
	}

	public List<Integer> getPermutation() {
		return permutation;
	}

	public void setPermutation(List<Integer> permutation) throws Exception {
		if (!isPermutation(permutation)) {
			throw new Exception("Invalid permutation.");
		}

		this.permutation = permutation;
	}

	public int getTime() {
		return time;
	}

	public void setTime(int time) {
		this.time = time;
	}

}
