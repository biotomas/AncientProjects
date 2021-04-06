package cz.matfyz.ctrlaltdel.modeler.literals;

import java.io.IOException;
import java.io.PrintWriter;

import cz.matfyz.ctrlaltdel.modeler.Literal;

public class TupleLiteral extends Literal {

    public TupleLiteral(boolean positive, IntegerTuple tuple, int no) {
        super(no, positive);

        this.tuple = tuple;
    }

    protected IntegerTuple getTuple() {
        return this.tuple;
    }

    public void printOut(PrintWriter out) throws IOException {
        super.printOut(out);

        /**
        out.write(' ');
        if (!this.positive) {
            out.write('-');
        }

        out.write("[");
        for (int i = 0, c = tuple.getLength(); i != c; ++i) {
            out.write(Integer.toString(this.tuple.getItem(i)));
            if (c == i + 1) {
                break;
            } else {
                out.write(", ");
            }
        }
        out.write("]");
        /**/
    }

    protected final IntegerTuple tuple;

}
