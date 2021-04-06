from random import shuffle
from timeit import Timer

def test_grimm(n):
    t = Timer('os.system("./grimm -f input.grimm -L -u")', "import os")
    return t.timeit(1)

def test_satgen(n):
    t = Timer('os.system("java -jar satgen-jar-with-dependencies.jar input.satgen")', "import os")
    return t.timeit(1)

def create_input(n):
    s = range(1, n)
    p = list(s)
    shuffle(p)
    
    print "Permutation used: ", p

    s = map(str, s)
    p = map(str, p)
    
    f = open('input.grimm', 'w')
    
    f.write('>perm1\n')
    f.write(" ".join(p))
    f.write(';\n')
    
    f.write('>perm2\n')
    f.write(" ".join(s))
    f.write(';\n')
    
    f.close()

    f = open("input.satgen", 'w')
    f.write(" ".join(p))
    f.close()

if __name__ == "__main__":
    grimm_time = {}
    satgen_time = {}
    test_range = range(12, 15)
    tries_range = range(10)

    for i in test_range:
        print
        print "Number of elements: ", i
        
        gt = 0
        st = 0
        for j in tries_range:
            print
            create_input(i)
            
            print "Running grimm"
            gt += test_grimm(i)
            
            print "Running satgen"
            st += test_satgen(i)
            
        grimm_time[i] = gt
        satgen_time[i] = st
        

    f = open("result.txt", "w")
    f.write("Length\tGrimm\tRsat\n")
    for i in test_range:
        f.write(str(i))
        f.write('\t')
        f.write(str(grimm_time[i]))
        f.write('\t')
        f.write(str(satgen_time[i]))
        f.write('\n')

        print
        print "Length: ", i
        print "Grimm: ", grimm_time[i]
        print "Satgen: ", satgen_time[i]
    f.close()
