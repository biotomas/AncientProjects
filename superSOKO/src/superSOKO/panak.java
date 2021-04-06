/*
 * panak.java
 *
 * Created on 4. èervenec 2007, 11:38
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */

package superSOKO;

import javax.microedition.lcdui.Graphics;
import javax.microedition.lcdui.Image;
import java.io.IOException;

/**
 * hybe a kresli panakom
 * @author tomas
 */
public class panak implements constants
{
	/**
	 * obrazok reprezentujuci hraca
	 */
    private static Image panak;
	/**
	 * obrazok panaka otoceneho dolava
	 */
    private static Image panakl;
	/**
	 * obrazok panaka otoceneho doprava
	 */
    private static Image panakr;
	/**
	 * pozicia hraca x
	 */
    private int px;
	/**
	 * pozicia hraca y
	 */
    private int py;
    
    
	/**
	 * smer ktorym idem
	 */
    private int go;
    
	/**
	 * kresli panaka
	 * @param g grafika
	 */
    public void paint(Graphics g)
    {
	g.drawImage(panak, px*tile_width, py*tile_height, 0);
    }

	/**
	 * kresli panaka s posunom
	 * @param g grafika
	 * @param tx posun x v pixeloch
	 * @param ty posun x v pixeloch
	 */
    public void paint(Graphics g, int tx, int ty)
    {
	g.drawImage(panak, px*tile_width+tx, py*tile_height+ty, 0);
    }
    
	/**
	 * nastavi poziciu panaka
	 * @param x x
	 * @param y y
	 */
    public void setpos(int x, int y)
    {
	px = x;
	py = y;
    }
    
	/**
	 * pozicia panaka
	 * @return x
	 */
    public int getposx()
    {
	return px;
    }
    
	/**
	 * pozicia panaka
	 * @return y
	 */
    public int getposy()
    {
	return py;
    }
    
	/**
	 * pohne hracom, tiez posuva debny pred nim
	 * @param lev aktualny level
	 */
    public void move(level lev)
    {
	if (go == GO_NONE) return;
	
	int npx=px, npy=py, w, f;
	switch(go)
	{
	    case GO_UP:
		npy-=1;
		break;
	    case GO_DOWN:
		npy+=1;
		break;
	    case GO_RIGHT:
		npx+=1;
		break;
	    case GO_LEFT:
		npx-=1;
		break;
	}
	w = lev.getpos(npx, npy);
	if (w == WALL || w == PIT) return; //collision detection :)
	
	if (w == BOX || w == INBOX)
	{
	    int bx, by;
		// kam pojde debna.
	    if (npx == px) 
	    {
		bx=px;
		if (npy > py) by = npy+1; else by = npy-1;
	    } else 
	    {
		by=py;
		if (npx > px) bx = npx+1; else bx = npx-1;
	    }
	    f = lev.getpos(bx,by);
	    
	    switch(f)
	    {
		case SPACE:
		    lev.setpos(bx,by, BOX);
		    break;
		case STORE:
		    lev.setpos(bx,by, INBOX);
		    break;
		case PIT:
		    lev.setpos(bx,by, SPACE);
		    break;
		default:
		    return;
	    }
	    if (w == BOX)
		lev.setpos(npx,npy, SPACE);
	    else
		lev.setpos(npx,npy, STORE);
	}
	
	py=npy;
	px=npx;
    }
    
	/**
	 * nastavi smer cesty hraca
	 * @param dir smer pohybu
	 */
    public void set_go(int dir)
    {
	go = dir;
	if (go == GO_RIGHT)
	    panak = panakr;
	if (go == GO_LEFT)
	    panak = panakl;
    }
    
    /**
	 * konstruktor
	 */
    public panak()
    {
	try
	{
	    panakl = Image.createImage("/images/panakl.png");
	    panakr = Image.createImage("/images/panakr.png");
	} catch (IOException ex)
	{
	    System.out.println("nenacital sa panak");	    
	    ex.printStackTrace();
	}
	go = GO_NONE;
	panak = panakl;
    }
    
}
