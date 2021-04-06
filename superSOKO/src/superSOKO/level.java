/*
 * level.java
 *
 * Created on 3. èervenec 2007, 23:47
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */

package superSOKO;

import editor.FilesIO;
import javax.microedition.lcdui.Graphics;

/**
 * Obsluhuje mapu z hladiska hry
 * @author tomas
 */
public class level implements constants
{    
	/**
	 * trieda ktora kresli tuto mapu
	 */
    private mappainter painter;
	/**
	 * pociatocna pozicia hraca
	 */
    private int startx;
	/**
	 * pociatocna pozicia hraca
	 */
    private int starty;
	/**
	 * pocet debien ktore este treba posunut do skladu
	 */
    private int badboxes;
	/**
	 * sirka mapy v pocte dlazdiciek
	 */
    private int width;
	/**
	 * vyska mapy v pocte dlazdiciek
	 */
    private int height;
	/**
	 * pole ktore uchovava mapu
	 */
    private int [] map;
	/**
	 * cislo tohoto levelu
	 */
    private int lev;
    
	/**
	 * sirka v dlazdickach
	 * @return sirka v dlazdickach
	 */
    public int width()
    {
	return width;
    }
    
	/**
	 * vyska v dlazdickach
	 * @return vyska v dlazdickach
	 */
    public int height()
    {
	return height;
    }
            
	/**
	 * pociatocna pozicia hraca
	 * @return  pociatocna pozicia hraca
	 */
    public int startx()
    {
	return startx;
    }
	/**
	 * pociatocna pozicia hraca
	 * @return  pociatocna pozicia hraca
	 */
    public int starty()
    {
	return starty;
    }
    
	/**
	 * zisti ci su vsetky debny na mieste
	 * @return true ak je level vyrieseny inak false
	 */
    public boolean finished()
    {
	return badboxes == 0;
    }
    
	/**
	 * nastavi mapu
	 * @param x x
	 * @param y y
	 * @param val pozadovany element
	 */
    public void setpos(int x, int y, int val)
    {
	if (x>=MAP_WIDTH || x<0 || y<0 || y>=MAP_HEIGHT) return;
	int p = x+y*MAP_WIDTH;

	if (map[p] == PIT) painter.request_repaint();
	if (val != DIRT) map[p]=val;
	if (val == INBOX) badboxes--;
	if (val == STORE) badboxes++;
	painter.adddirty(p);
    }
    
	/**
	 * zisti co je na danej pozicii
	 * @param x x
	 * @param y y
	 * @return element na danej pozicii
	 */
    public int getpos(int x, int y)
    {
	if (x>=MAP_WIDTH || x<0 || y<0 || y>=MAP_HEIGHT) 
	    return -1;
	return map[x+y*MAP_WIDTH];
    }
    
	/**
	 * kresli mapu
	 * @param g grafika
	 */
    public void paint(Graphics g)
    {
	painter.paint(g);
    }

	/**
	 * kresli mapu s posunom
	 * @param g grafika
	 * @param tx posun x
	 * @param ty posun y
	 */
    public void paint(Graphics g, int tx, int ty)
    {
	painter.paint(g, tx, ty);
    }
    
	/**
	 * ziadost o prekreslenie celej mapy
	 */
    public void request_repaint()
    {
	painter.request_repaint();
    }
        
	/**
	 * cislo levelu
	 * @return cislo levelu
	 */
    public int get_level_number()
    {
	return lev;
    }
    
    /**
	 * konstruktor
	 * @param lev_ cislo levelu
	 */
    public level(int lev_)
    {
	lev = lev_;
	
	badboxes = 0;
	map = new int[MAP_WIDTH * MAP_HEIGHT];
	for (int i = 0; i < map.length; i++)
	{
	    map[i] = NONE;
	}
	
	FilesIO.loadlevel(lev, map);
	
	width=height=0;
	
	for (int j = 0; j < MAP_HEIGHT; j++)
	{
	    int last = 0;
	    for (int i = MAP_WIDTH-1; i >= 0; i--)
	    {
		if (getpos(i,j) != NONE && i>last )
		{
		    last = i;
		}
		if (getpos(i,j)	== PLAYER)
		{
		    startx = i;
		    starty = j;
		    map[i+j*MAP_WIDTH] = SPACE;
		}
		if (getpos(i,j) == STORE)
		    badboxes++;
	    }
	    if(last == 0)
	    {
		height = j;
		break;
	    }
	    if(last > width)
		width = last;
	}
	width++;
	painter = new mappainter(map, width, height);
    }
}
