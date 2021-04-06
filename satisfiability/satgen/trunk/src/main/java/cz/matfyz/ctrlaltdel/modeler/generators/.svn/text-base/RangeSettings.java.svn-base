package cz.matfyz.ctrlaltdel.modeler.generators;

import java.util.Iterator;
import java.util.Vector;

public class RangeSettings implements Iterable<RangeSettings.RangeSetting> {

    public static class Range implements Iterable<Integer> {

        public Range(int start, int end) {
            this.start = start;
            this.end = end;
        }

        protected final int start, end;

        public Iterator<Integer> iterator() {
            return this.rangeIterator();
        }

        public RangeIterator rangeIterator() {
            return new RangeIterator();
        }

        protected class RangeIterator implements Iterator<Integer> {

            public RangeIterator() {
                this.reset();
            }

            public boolean hasNext() {
                return end > this.iterator;
            }

            public Integer next() {
                return iterator++;
            }

            public void remove() {
                throw new UnsupportedOperationException();
            }

            public void reset() {
                this.iterator = start;
            }

            public int iterator;

        }

    }

    public static class RangeSetting {

        public RangeSetting(int dimension, boolean fixed, Range range) {
            this.fixed = fixed;
            this.range = range;
            this.dimension = dimension;
        }

        /**
         * @return the fixed
         */
        public boolean isFixed() {
            return fixed;
        }

        /**
         * @return the range
         */
        public Range getRange() {
            return range;
        }

        /**
         * @return the dimension
         */
        public int getDimension() {
            return this.dimension;
        }

        protected final Range range;

        protected final boolean fixed;

        protected final int dimension;

    }

    public RangeSettings(RangeSetting... settings) throws RangeSettingsException {
        boolean[] dimensions = new boolean[settings.length];

        this.settings = new Vector<RangeSetting>();
        for (RangeSetting s : settings) {
            if (s.dimension >= settings.length) {
                throw new IndexOutOfBoundsException("Dimension is out of range.");
            }

            if (dimensions[s.dimension]) {
                throw new RangeSettingsException("Dimension already defined.");
            }
            dimensions[s.dimension] = true;

            this.settings.add(s);
        }

        for (boolean d : dimensions) {
            if (!d) {
                throw new RangeSettingsException("Dimension is not specified.");
            }
        }
    }

    public RangeSetting getSetting(int i) {
        return this.settings.get(i);
    }

    public int size() {
        return this.settings.size();
    }

    public Iterator<RangeSetting> getFixedSettings() {
        return new RangeSettingIterator(true);
    }

    public Iterator<RangeSetting> getVariableSettings() {
        return new RangeSettingIterator(false);
    }

    public Iterator<RangeSetting> iterator() {
        return settings.iterator();
    }

    protected class RangeSettingIterator implements Iterator<RangeSetting> {

        public RangeSettingIterator(boolean fixed) {
            this.setting = -1;
            this.fixed = fixed;

            this.moveNext();
        }

        protected void moveNext() {
            ++this.setting;
            while (this.setting < settings.size()) {
                if (settings.get(this.setting).isFixed() == fixed) {
                    break;
                }

                ++this.setting;
            }

            if (this.setting == settings.size()) {
                this.setting = -1;
            }
        }

        public boolean hasNext() {
            return this.setting != -1;
        }

        public RangeSetting next() {
            RangeSetting setting = settings.get(this.setting);
            this.moveNext();
            return setting;
        }

        public void remove() {
            throw new UnsupportedOperationException();
        }

        protected int setting;

        protected final boolean fixed;

    }

    protected final Vector<RangeSetting> settings;

}
