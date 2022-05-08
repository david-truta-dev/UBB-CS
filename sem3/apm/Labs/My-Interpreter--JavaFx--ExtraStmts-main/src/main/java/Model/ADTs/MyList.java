package Model.ADTs;

import Exceptions.ListException;
import java.util.ArrayList;

public class MyList<T> implements MyIList<T>{
    private final ArrayList<T> list;

    public MyList(){
        this.list = new ArrayList<>();
    }

    @Override
    public int size() {
        return this.list.size();
    }

    @Override
    public void insert(T elem, int pos) throws ListException {
        if (pos <0 || pos > this.list.size())
            throw new ListException("INVALID POSITION!");
        this.list.add(pos,elem);
    }

    @Override
    public boolean isEmpty() {
        return this.list.size() == 0;
    }

    @Override
    public void removeByElem(T elem) throws ListException{
        if (this.list.contains(elem))
            throw new ListException("Element is already in list");
        this.list.remove(elem);
    }

    @Override
    public void removeByPos(int pos) throws ListException{
        if (pos <0 || pos >= this.list.size())
            throw new ListException("INVALID POSITION!");
        this.list.remove(pos);
    }

    @Override
    public int getPosition(T elem) throws ListException{
        if (!this.list.contains(elem))
            throw new ListException("Element not in list");
        return this.list.indexOf(elem);
    }

    @Override
    public T getElem(int pos) throws ListException{
        if (pos <0 || pos >= this.list.size())
            throw new ListException("INVALID POSITION!");
        return this.list.get(pos);
    }

    public String toString(){
        return this.list.toString();
    }

    public ArrayList<T> values(){
        return (ArrayList<T>) this.list.clone();
    }
}
