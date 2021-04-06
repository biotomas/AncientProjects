package cz.matfyz.ctrlaltdel.modeler.generators;

import java.util.Vector;

import cz.matfyz.ctrlaltdel.modeler.generators.RangeSettings.RangeSetting;
import cz.matfyz.ctrlaltdel.modeler.generators.RangeSettings.Range.RangeIterator;

/**
 * Generates all the points in the given range. Whenever a new point is generated the {@see #generatePoints()} 
 * method is called.
 * 
 * @author Martin Babka
 */
public class PointsGenerator {

	public PointsGenerator(Vector<RangeSetting> settings) {
		this.settings = settings;
	}
	
	/**
	 * Generates points from the given settings.
	 */
	public void generatePoints() {
		/* Needed variables */
		int i, c = this.settings.size();
		RangeIterator it;

		/* Initialize the array of values and iterators. */
		RangeIterator[] iterators = new RangeIterator[this.settings.size()];
		int[] values = new int[this.settings.size()];
		for (i = 0; i < c; ++i) {
			iterators[i] = this.settings.get(i).getRange().rangeIterator();
			values[i] = iterators[i].next();
		}

		/* Generate points */
		while (true) {
			/* Register a point */
			this.onPointGenerated(values);

			/* Move to the next point in the set. */
			for (i = c - 1; i >= 0; --i) {
				it = iterators[i];

				if (it.hasNext()) {
					values[i] = it.next();
					break;
				} else {
					it.reset();
					values[i] = it.next();
				}
			}

			/* No other possibility */
			if (i == -1) {
				return;
			}
		}
	}

	/**
	 * Point is generated.
	 * 
	 * @param point List of coordinates.
	 */
	protected void onPointGenerated(int[] point) {
		assert point.length == this.settings.size() : "Lengths do not match.";
	}

	protected final Vector<RangeSetting> settings;

}