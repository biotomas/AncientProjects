package satUtils.formulaGenerators.test;

import junit.framework.TestCase;
import satUtils.formulaGenerators.Random3SatFormula;
import satUtils.formulaGenerators.Random3SatFormula.RandomFormula;

public class TestRandom3SatGen extends TestCase {

	public void testGenerator() {
		Random3SatFormula rnd = new Random3SatFormula(10, 15);
		RandomFormula f = rnd.getNextRandomFormula();
		System.out.println(f.getDimacs());
		System.out.println(f.getGraph());
	}
}
