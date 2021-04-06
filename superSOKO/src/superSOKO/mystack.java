/*
 * mystack.java
 *
 * Created on 4. èervenec 2007, 15:45
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */

package superSOKO;

/**
 * velmi jednoduchy zasobnik na int
 * @author tomas
 */
public class mystack
{
	/**
	 * samotny zasobnik
	 */
    private int[] stack;
	private int index;
	/**
	 * maximalna velkost zasobniku
	 */
    private int size;
    
	/**
	 * prida prvok do zasobniku
	 * @param val co pridat
	 */
    public void push(int val)
    {
	stack[index] = val;
	++index;
    }
    
	/**
	 * odoberie prvok zo zasobniku
	 * @return prvok zo zasobniku
	 */
    public int pop()
    {
	index--;
	return stack[index];
    }
    
	/**
	 * prazdny zasobnik
	 * @return ak je zasobnik prazdny vrati true inak false
	 */
    public boolean empty()
    {
	return (index == 0);
    }
    
	/**
	 * vyprazdni zasobnik
	 */
    public void make_empty()
    {
	index = 0;
    }
    /**
	 * konstruktor
	 * @param size_ maximalna velkost zasobniku
	 */
    public mystack(int size_)
    {
	size = size_;
	stack = new int[size];
	index = 0;
    }
    
}
