package utilities;

public final class MathUtils {
	
	public static double log2(double number) {
		return Math.log(number) / Math.log(2);
	}
	
	public static double multBy2(double value, int times) {
		for (int i = 0; i < times; i++) {
			value *= 2;
		}
		return value;
	}

}
