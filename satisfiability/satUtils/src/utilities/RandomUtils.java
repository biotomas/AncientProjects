package utilities;

import java.util.Collection;
import java.util.Random;

public final class RandomUtils {
	
	private Random rnd;
	
	public RandomUtils(long seed) {
		rnd = new Random(seed);
	}
	
	public RandomUtils() {
		rnd = new Random();
	}
	
	public <T> T randomPick(Collection<T> collection) {
		int p = rnd.nextInt(collection.size());
		for (T item : collection) {
			if (p == 0) {
				return item;
			}
			p--;
		}
		return null;
	}
	
}
