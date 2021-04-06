package cz.matfyz.ctrlaltdel;

import cz.matfyz.ctrlaltdel.App.Solution;

public class InterpolFind {
	
	private Solution bestSolution;
	private int[] permutation;
	
	public Solution findSolution(int[] permutation) {
		this.permutation = permutation;
		int len = permutation.length;
		find(2, 5 * (len - 1) / 3);
		return bestSolution;
	}
	
	private void find(int low, int high) {
		try {
			// heuristika
			int med = (low + high) / 2;
			if (med == low || med == high) {
				return;
			}
		
			System.out.println("Trying " + med + " steps.");
			Solution solution = App.findSolution(med, permutation);
			if (solution != null) {
				bestSolution = solution;
				find(low, med);
			} else {
				find(med, high);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}
}
