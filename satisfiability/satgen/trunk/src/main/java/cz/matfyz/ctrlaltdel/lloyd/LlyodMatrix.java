package cz.matfyz.ctrlaltdel.lloyd;

import java.io.*;
import java.util.*;

public class LlyodMatrix {

	public LlyodMatrix(String path) throws IOException {
		this(new BufferedReader(new FileReader(path)), true);
	}

	public LlyodMatrix(Reader r) throws IOException {
		Scanner s = new Scanner(r);

		this.rows = s.nextInt();
		this.cols = s.nextInt();
		this.matrix = new int[this.rows][this.cols];

		for (int i = 0; i < this.rows; ++i) {
			for (int j = 0; j < this.cols; ++j) {
				this.matrix[i][j] = s.nextInt();
			}
		}
	}

	public LlyodMatrix(Reader s, boolean close) throws IOException {
		this(s);
		if (close) {
			s.close();
		}
	}

	public int getAt(int x, int y) {
		return this.matrix[x][y];
	}

	public void change(int x0, int y0, int x1, int y1) {
		int v = this.matrix[x0][y0];
		this.matrix[x0][y0] = this.matrix[x1][y1];
		this.matrix[x1][y1] = v;
	}

	public int getColumns() {
		return this.cols;
	}

	public int getRows() {
		return this.rows;
	}

	public final int[][] matrix;

	public final int cols, rows;

}
