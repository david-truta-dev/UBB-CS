import java.util.concurrent.atomic.AtomicLong;
import java.util.ArrayList;

public class Main {

    private static interface TestClass
    {
        void add(long iter);
        long sum();
    };

    private static class TestWrong implements TestClass
    {
        @Override
        public void add(long iter)
        {
            for (long i = 0; i < iter; ++i)
            {
                m_sum += i;
            }
        }

        @Override
        public long sum()
        {
            return m_sum;
        }

        private long m_sum = 0;
    };

    private static class TestAtomic implements TestClass
    {
        public TestAtomic()
        {
            m_sum = new AtomicLong(0);
        }

        @Override
        public void add(long iter)
        {
            for (long i = 0; i < iter; ++i)
            {
                m_sum.getAndAdd(i);
            }
        }

        @Override
        public long sum()
        {
            return m_sum.get();
        }

        private final AtomicLong m_sum;
    };

    private static class TestMutex implements TestClass
    {
        public TestMutex()
        {
            m_mutex = new Object();
            m_sum = 0;
        }

        @Override
        public void add(long iter)
        {
            for (long i = 0; i < iter; ++i)
            {
                synchronized(m_mutex) {
                    m_sum += i;
                }
            }
        }

        @Override
        public long sum()
        {
            synchronized(m_mutex) {
                return m_sum;
            }
        }

        private Object m_mutex;
        private long m_sum;
    };

    private static void executeTest(final TestClass testObj, final long iter, final int nrThreads)
    {
        Thread[] threads = new Thread[nrThreads];
        for (int i = 0; i < nrThreads; ++i)
        {
            threads[i] = new Thread(new Runnable() {
                @Override
                public void run() {
                    testObj.add(iter);
                }
            });
        }

        final long startTime = System.currentTimeMillis();

        for (int i = 0; i < nrThreads; ++i)
        {
            threads[i].start();
        }

        for (int i = 0; i < nrThreads; ++i)
        {
            try {
                threads[i].join();
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        }

        final long stopTime = System.currentTimeMillis();

        long expectedSum = (iter * (iter - 1) / 2) * nrThreads;
        long actualSum = testObj.sum();
        System.out.println("Sum: expected=" + expectedSum + ", actual=" + actualSum +
                ((expectedSum == actualSum) ? " OK" : " wrong"));
        System.out.println("Real time=" + (stopTime-startTime) + "ms");
    }

    public static void main(String[] args) {
        TestClass test = new TestAtomic();
        executeTest(test, 1000000, 8);
    }

}