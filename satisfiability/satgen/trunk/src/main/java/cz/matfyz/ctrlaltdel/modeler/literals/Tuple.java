package cz.matfyz.ctrlaltdel.modeler.literals;

import java.util.*;

public class Tuple<T> {

	public Tuple(T[] params) {
		tuple = new Vector<T>();
		for (T i : params) {
			tuple.add(i);
		}
	}

	public int getLength() {
		return this.tuple.size();
	}

	public T getItem(int i) {
		return this.tuple.get(i);
	}

	public int hashCode() {
		int hc = 0;
		int i = 0;

		for (T x : this.tuple) {
			hc = hc ^ (x.hashCode() << i);
			++i;
		}

		return hc;
	}

	protected final Vector<T> tuple;

}
