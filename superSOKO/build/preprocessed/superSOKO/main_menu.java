/*
 * main_menu.java
 *
 * Created on 5. èervenec 2007, 0:08
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */

package superSOKO;
import editor.FilesIO;
import java.io.IOException;
import java.io.InputStream;
import javax.microedition.lcdui.Canvas;
import javax.microedition.lcdui.Display;
import javax.microedition.lcdui.Font;
import javax.microedition.lcdui.Graphics;
import javax.microedition.lcdui.Image;
import javax.microedition.midlet.MIDlet;
/**
 * Hlavne menu
 * @author tomas balyo
 */
public class main_menu extends Canvas implements constants
{
	/**
	 * logo obrazok
	 */
    private Image img;
	/**
	 * LOGO alebo MENU
	 */
    private int state;
	/**
	 * prave vybrany pociatocny level
	 */
    private int lev;
	/**
	 * sirka retazca
	 */
    private int w1;
	/**
	 * sirka retazca
	 */
    private int w2;
	/**
	 * sirka retazca
	 */
    private int w3;
	/**
	 * polozka menu ktora je vybrana
	 */
    private int selected;
	/**
	 * automaticky posun obrazu za hracom
	 */
    private boolean autoscroll;
	/**
	 * prekresli celu mapu v kazdom cykle
	 */
    private boolean allwaysrepaint;
	/**
	 * pocet poloziek v menu
	 */
    private static final int options = 5;
	/**
	 * pocet levelov
	 */
    private int levels;
	/**
	 * font nadpisu
	 */
    private Font font1;
	/**
	 * font poloziek
	 */
    private Font font2;
	/**
	 * midlet ktoremu patrime
	 */
    private MIDlet chef;
    
    private static final int LOGO = 0;
    private static final int MENU = 1;
    
    /**
	 * konstruktor
	 * @param chef_ midlet ktoremu patrime
	 */
    public main_menu(MIDlet chef_)
    {
	chef = chef_;
	try
	{
	    img = Image.createImage("/images/logo.JPG");
	}
	catch (IOException ex)
	{
	    ex.printStackTrace();
	}
	state = LOGO;
	font1 = Font.getFont(Font.FACE_PROPORTIONAL,Font.STYLE_BOLD,Font.SIZE_LARGE);
	font2 = Font.getFont(Font.FACE_MONOSPACE,Font.STYLE_BOLD,Font.SIZE_MEDIUM);
	w1 = font1.stringWidth("SUPER SOKOBAN");
	w2 = font2.stringWidth("Start a new game");
	w3 = font2.stringWidth("Exit Game");
	
	lev = 0;
	selected = 0;
	byte []p = new byte[2];
	
	FilesIO.getRSparameters(p);
	levels = initial_levels + custom_levels;
	autoscroll = (p[0]==1) ? true : false;
	allwaysrepaint = (p[1]==1) ? true : false;
    }
    
	/**
	 * klavesnica
	 * @param code kod klavesy
	 */
    public void keyPressed(int code)
    {
	if (state == LOGO)
	{
	    state = MENU;
	    repaint();
	    return;
	}
	int action = getGameAction(code);
	switch(action)
	{
	    case Canvas.DOWN:
		selected = (selected+1)%options;
		break;
	    case Canvas.UP:
		selected = (selected-1+options)%options;
		break;
	    case Canvas.RIGHT:
		if (selected == 1) lev = (lev+1)%levels;
		if (selected == 2) autoscroll = ! autoscroll;
		if (selected == 3) allwaysrepaint = ! allwaysrepaint;
		break;
	    case Canvas.LEFT:
		if (selected == 1) lev = (lev-1+levels)%levels;
		if (selected == 2) autoscroll = ! autoscroll;
		if (selected == 3) allwaysrepaint = ! allwaysrepaint;
		break;
	    case Canvas.FIRE:
		switch(selected)
		{
		    case 4:
			// save RS parameters
			byte[]p = new byte[2];
			FilesIO.getRSparameters(p);
			p[0] = autoscroll ? (byte)1 : (byte)0;
			p[1] = allwaysrepaint ? (byte)1 : (byte)0;
			FilesIO.setRSparameters(p);
			chef.notifyDestroyed();
			break;
		    case 0:
			startlevel(0);
			break;
		    case 1:
			startlevel(lev);
		}
		
		break;
	}
	
	repaint();
	
    }
    
	/**
	 * nastartuje hru v danom levely
	 * @param lvl cislo pociatocneho levelu
	 */
    private void startlevel(int lvl)
    {
	// save RS parameters
	byte[]p = new byte[2];
	FilesIO.getRSparameters(p);
	p[0] = autoscroll ? (byte)1 : (byte)0;
	p[1] = allwaysrepaint ? (byte)1 : (byte)0;
	FilesIO.setRSparameters(p);
	
	game g = new game(chef, lvl, levels, this, autoscroll, allwaysrepaint);
	Display.getDisplay(chef).setCurrent(g);
    }
    
	/**
	 * kresli menu
	 * @param g grafika
	 */
    protected void paint(Graphics g)
    {
	if(state == LOGO)
	{
	    g.setColor(0x000000);
	    g.fillRect(0,0,getWidth(), getHeight());
	    g.translate((getWidth()-img.getWidth())/2, (getHeight()-img.getHeight())/2);
	    g.drawImage(img,0,0,0);
	}
	else //state == MENU
	{
	    g.setColor(0x000000);
	    g.fillRect(0,0,getWidth(), getHeight());
	    g.setFont(font1);
	    g.setColor(0xCC0000);
	    g.drawString("SUPER SOKOBAN",(getWidth()-w1)/2,20,0);
	    
	    g.setFont(font2);
	    if (selected == 0) g.setColor(0xFFFFFF);
	    g.drawString("Start a new game", (getWidth()-w2)/2, 60,0);
	    
	    g.setColor(0xCC0000);
	    if (selected == 1) g.setColor(0xFFFFFF);
	    int w = font2.stringWidth("Start in level <"+lev+">");
	    g.drawString("Start in level <"+lev+">", (getWidth()-w)/2, 75,0);
	    
	    g.setColor(0xCC0000);
	    if (selected == 2) g.setColor(0xFFFFFF);
	    int ww = font2.stringWidth("autoscroll: "+autoscroll);
	    g.drawString("autoscroll: "+autoscroll, (getWidth()-ww)/2, 90,0);

	    g.setColor(0xCC0000);
	    if (selected == 3) g.setColor(0xFFFFFF);
	    int www = font2.stringWidth("allways repaint : "+allwaysrepaint);
	    g.drawString("allways repaint : "+allwaysrepaint, (getWidth()-www)/2, 105,0);

	    g.setColor(0xCC0000);
	    if (selected == 4) g.setColor(0xFFFFFF);
	    g.drawString("Exit Game", (getWidth()-w3)/2, 120,0);
	}
    }
    
}
