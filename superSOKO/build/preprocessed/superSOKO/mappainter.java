/*
 * mappainter.java
 *
 * Created on 6. èervenec 2007, 12:00
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */

package superSOKO;

import javax.microedition.lcdui.Image;
import java.io.IOException;
import javax.microedition.lcdui.Graphics;


/**
 * kresli mapu
 * @author tomas
 */
public class mappainter implements constants
{
	/**
	 * zasobnik dlazdiciek, ktore je treba prekreslit
	 */
    private mystack dirty;
	/**
	 * priznak pre prekreslenie celej mapy
	 */
    private boolean painted;    
	/**
	 * pole obsahujuce mapu
	 */
    private int [] map;
    
    private static Image box, wall, ground, store, inbox, man,
		    pit_u, pit_r, pit_dl, pit_ur, pit_c, pit_s, pit_ss;

	/**
	 * sirka obrazovky telefonu v pixeloch
	 */
    private static int screen_width;
	/**
	 * vyska obrazovky telefonu v pixeloch
	 */
    private static int screen_height;
	/**
	 * sirka mapy v pocte dlazdiciek
	 */
    private int width;
	/**
	 * vyska mapy v pocte dlazdiciek
	 */
    private int height;
    
    
    /**
	 * nahra obrazky, nastavi rozlisenie obrazovky
	 * @param width sirka obrazovky telefonu v pixeloch
	 * @param height vyska obrazovky telefonu v pixeloch
	 */
    public static void load_images(int width, int height)
    {
	screen_width = width;
	screen_height = height;
	try
	{
	    ground = Image.createImage("/images/ground.PNG");
	    box = Image.createImage("/images/box.PNG");
	    wall = Image.createImage("/images/wall.PNG");
	    store = Image.createImage("/images/store.PNG");
	    inbox = Image.createImage("/images/inbox.PNG");
	    man = Image.createImage("/images/panakl.png");
	    pit_u = Image.createImage("/images/pit_u.PNG");
	    pit_r = Image.createImage("/images/pit_r.PNG");
	    pit_ur = Image.createImage("/images/pit_ur.PNG");
	    pit_dl = Image.createImage("/images/pit_dl.PNG");
	    pit_c = Image.createImage("/images/pit_c.PNG");
	    pit_s = Image.createImage("/images/pit_s.PNG");
	    pit_ss = Image.createImage("/images/pit_ss.PNG");

	} catch (IOException ex)
	{
	    System.out.println("level nenacital obrazok");	    
	    ex.printStackTrace();
	}
    }
    
    
    /**
	 * konstruktor
	 * @param map_ pole obsahujuce mapu
	 * @param width_ sirka mapy v pocte dlazdiciek
	 * @param height_ vyska mapy v pocte dlazdiciek
	 */
    public mappainter(int [] map_, int width_, int height_)
    {
	map = map_;
	width = width_;
	height = height_;
	dirty = new mystack(20);
	painted = false;
    }
    
	/**
	 * poziadavok an prekreslenie celej mapy
	 */
    public void request_repaint()
    {
	painted = false;
    }
    
	/**
	 * prida prvok do zasobniku dlazdiciek ktore sa budu prekreslovat
	 * @param x co sa ma pridat do zasobniku
	 */
    public void adddirty(int x)
    {
	dirty.push(x);
    }
    
	/**
	 * pozicia obrazok
	 * @param code kod obrazku
	 * @return obrazok
	 */
    public Image lendimage(int code)
    {
	switch(code)
	{
	    case WALL: return wall;
	    case BOX: return box;
	    case INBOX: return inbox;
	    case PLAYER: return man;
	    case PIT: return pit_ur;
	    case SPACE: return ground;
	    case STORE: return store;
	}
	return wall;
    }
        
	/**
	 * zisti aky prvok sa nachadza na danej pozicii
	 * @param x x
	 * @param y y
	 * @return prvok na x,y
	 */
    private int getpos(int x, int y)
    {
	if (x>=MAP_WIDTH || x<0 || y<0 || y>=MAP_HEIGHT) return -1;
	return map[x+y*MAP_WIDTH];
    }

    /**
	 * prekresli tie casti mapy ktore boli zmenene
	 * @param g grafika
	 */
    private void paintdirty(Graphics g)
    {
	int bad,x,y;
	while(dirty.empty()==false)
	{
	    bad = dirty.pop();
	    x = bad % MAP_WIDTH;
	    y = bad / MAP_WIDTH;
	    paintsquare(g, x, y, x+1, y+1);
	}	
    }
    
	/**
	 * prekresli tie casti mapy ktore boli zmenene + posun
	 * @param g grafika
	 * @param tx posun x
	 * @param ty posun y
	 */
    private void paintdirty(Graphics g, int tx, int ty)
    {
	int bad,x,y;
	while(dirty.empty()==false)
	{
	    bad = dirty.pop();
	    x = bad % MAP_WIDTH;
	    y = bad / MAP_WIDTH;
	    paintsquare(g, x, y, x+1, y+1, tx, ty);
	}	
    }
    
    /**
	 * kresli stvorec mapy
	 * @param g grafika
	 * @param x1 lavy horny roh v dlazdickovych jednotkach
	 * @param y1 lavy horny roh v dlazdickovych jednotkach
	 * @param x2 pravy dolny roh v dlazdickovych jednotkach
	 * @param y2 pravy dolny roh v dlazdickovych jednotkach
	 */
    private void paintsquare(Graphics g, int x1, int y1, int x2, int y2)
    {
	int w;
	Image img;
	for(int i=y1; i<y2; i++)
	    for(int j=x1; j<x2; j++)
	    {
		w = getpos(j,i);
		switch(w)
		{
		    case WALL:
			img = wall;
			break;
		    case SPACE:
			img = ground;
			break;
		    case PIT:
			int u = getpos(j+1,i);
			int v = getpos(j,i-1);
			int z = getpos(j+1,i-1);
			img = pit_ur;
			if (u == PIT && v == PIT) img = pit_dl;
			if (u == PIT && v != PIT) img = pit_u;
			if (u != PIT && v == PIT) img = pit_r;
			if (u != PIT && v != PIT) img = pit_ur;
			if (u != PIT && v == PIT && z == PIT) img = pit_s;
			if (u == PIT && v == PIT && z != PIT) img = pit_c;
			if (u == PIT && v != PIT && z == PIT) img = pit_ss;

			break;
		    case BOX:
			img = box;
			break;
		    case STORE:
			img = store;
			break;
		    case INBOX:
			img = inbox;
			break;
		    case PLAYER:    //len kvoli editoru map
			img = man;
			break;
		    default:
			continue;
		}
		g.drawImage(img, j*tile_width, i*tile_height,0);
	    }	
    }
    /**
	 * kresli stvorec mapy s posunom
	 * @param tx posun x v pixeloch
	 * @param ty posun y v pixeloch
	 * @param g grafika
	 * @param x1 lavy horny roh v dlazdickovych jednotkach
	 * @param y1 lavy horny roh v dlazdickovych jednotkach
	 * @param x2 pravy dolny roh v dlazdickovych jednotkach
	 * @param y2 pravy dolny roh v dlazdickovych jednotkach
	 */
    private void paintsquare(Graphics g, int x1, int y1, int x2, int y2, int tx, int ty)
    {
	int w;
	Image img;
	for(int i=y1; i<y2; i++)
	    for(int j=x1; j<x2; j++)
	    {
		w = getpos(j,i);
		switch(w)
		{
		    case WALL:
			img = wall;
			break;
		    case SPACE:
			img = ground;
			break;
		    case PIT:
			int u = getpos(j+1,i);
			int v = getpos(j,i-1);
			int z = getpos(j+1,i-1);
			img = pit_ur;
			if (u == PIT && v == PIT) img = pit_dl;
			if (u == PIT && v != PIT) img = pit_u;
			if (u != PIT && v == PIT) img = pit_r;
			if (u != PIT && v != PIT) img = pit_ur;
			if (u != PIT && v == PIT && z == PIT) img = pit_s;
			if (u == PIT && v == PIT && z != PIT) img = pit_c;
			if (u == PIT && v != PIT && z == PIT) img = pit_ss;

			break;
		    case BOX:
			img = box;
			break;
		    case STORE:
			img = store;
			break;
		    case INBOX:
			img = inbox;
			break;
		    case PLAYER:    //len kvoli editoru map
			img = man;
			break;
		    default:
			continue;
		}
		g.drawImage(img, j*tile_width+tx, i*tile_height+ty,0);
	    }	
    }
    
    /**
	 * kresli mapu, celu alebo len tie casti ktore treba prekreslit
	 * podla toho ci bol request_repaint()
	 * @param g grafika
	 */
    public void paint(Graphics g)
    {
	if (painted == false)
	{
	    g.setColor(0xDDDDDD);
	    g.fillRect(0,0,screen_width-g.getTranslateX(), screen_height-g.getTranslateY());
	    paintsquare(g, 0, 0, width, height);
	    dirty.make_empty();
	    painted = true;
	}
	else
	    paintdirty(g);
    }

	/**
	 * kresli mapu, celu alebo len tie casti ktore treba prekreslit
	 * podla toho ci bol request_repaint() s posunom
	 * @param g grafika
	 * @param tx posun x v pixeloch
	 * @param ty posun x v pixeloch
	 */
    public void paint(Graphics g, int tx, int ty)
    {
	if (painted == false)
	{
	    g.setColor(0xDDDDDD);
	    g.fillRect(0,0,screen_width, screen_height);
	    paintsquare(g, 0, 0, width, height, tx, ty);
	    dirty.make_empty();
	    painted = true;
	}
	else
	    paintdirty(g,tx,ty);
    }
}

