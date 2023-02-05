import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.atomic.AtomicInteger;

public class KCombinations {
    public AtomicInteger cnt;
    public ExecutorService executorService = Executors.newFixedThreadPool(10);
    public KCombinations() {
        cnt = new AtomicInteger(0);
    }

    public boolean check(List<Integer> vec){
        if(vec.size()==0)
            return false;
        return vec.get(0)%2==0;
    }

    public void generate(List<Integer> vec, int k, int n, int T) throws InterruptedException {
        if (vec.size()==k){
            System.out.println(vec.toString());
            System.out.println();
            if (check(vec)){
                cnt.getAndIncrement();
            }
            return;
        }
        int last = 0;
        if (vec.size()>0){
            last = vec.get(vec.size()-1);
        }
        if(T==1){
            for (int i = last+1; i <= n; i++) {
                vec.add(i);
                generate(vec, k, n, T);
                vec.remove(vec.size()-1);
            }
        }
        else{
            int finalLast = last;
            executorService.submit(()->{
                List<Integer> newV = new ArrayList<>();
                newV.addAll(vec);
                for(int i = finalLast +1; i<=n;i+=2){
                    newV.add(i);
                    try {
                        generate(newV, k, n, T/2);
                    } catch (InterruptedException e) {
                        e.printStackTrace();
                    }
                    newV.remove(newV.size()-1);
                }
            });
            List<Integer> aux = new ArrayList<>();
            aux.addAll(vec);
            for(int i = last+2; i<=n; i+=2){
                aux.add(i);
                generate(aux, k, n, T-T/2);
                aux.remove(aux.size()-1);
            }
        }
    }
}