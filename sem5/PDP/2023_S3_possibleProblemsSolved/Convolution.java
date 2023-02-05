import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

class Pair<K,V>{
    private final K k;
    private final V v;

    Pair(K k, V v){
        this.k = k;
        this.v = v;
    }
    K getKey(){
        return k;
    }

    V getValue(){
        return v;
    }
}

public class Convolution {

    public int modulo(int a, int b){
        if (a<0)
            return (a+b)%b;
        return a%b;
    }

    public List<Pair<Integer,Integer>> splitWorkload(int n, int t){
        List<Pair<Integer,Integer>> pairs = new ArrayList<>();
        int index = 0;
        int step = n/t;
        int mod = n%t;
        while(index<n){
            int aux;
            if(mod>0)
                aux = 1;
            else aux = 0;
            pairs.add(new Pair(index, index+step+aux));
            index+=step+aux;
            mod--;
        }
        return pairs;
    }

    public List<Integer> convolution(List<Integer> a, List<Integer> b, int T){
        List<Integer> c = new ArrayList<>();
        for (int i = 0; i < a.size(); i++) {
            c.add(0);
        }
        if(T==1){
            for (int i = 0; i < a.size(); i++) {
                for (int j = 0; j < a.size(); j++) {
                    c.set(i,c.get(i) + a.get(j) * b.get(modulo(i-j, a.size())));
                }
            }
        }
        else{
            List<Pair<Integer, Integer>> pairs = splitWorkload(a.size(),T);
            ExecutorService executorService = Executors.newFixedThreadPool(T);
            for(int k = 0;k<T;k++){
                int finalK = k;
                executorService.submit(()->{
                    for (int i = pairs.get(finalK).getKey(); i < pairs.get(finalK).getValue(); i++) {
                        for (int j = 0; j < a.size() ; j++) {
                            c.set(i,c.get(i) + a.get(j) * b.get(modulo(i-j,a.size())));
                        }
                    }
                });
            }
            executorService.shutdown();
        }
        return c;
    }
}