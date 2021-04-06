/*
 * game.java
 *
 * Created on 3. èervenec 2007, 18:02
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */

package superSOKO;

import java.io.IOException;
import java.util.Timer;
import java.util.TimerTask;
import javax.microedition.lcdui.Alert;
import javax.microedition.lcdui.Canvas;
import javax.microedition.lcdui.CommandListener;
import javax.microedition.lcdui.Graphics;
import javax.microedition.lcdui.Command;
import javax.microedition.lcdui.Displayable;
import javax.microedition.lcdui.Image;
import javax.microedition.midlet.MIDlet;
import javax.microedition.lcdui.Display;


/**
 * trieda hry sa stara o striedanie levelov, kreslenie levelov,
 * spracovanie klavesnice a menu, pohyb hraca.
 * @author tomas balyo
 */
public class game extends Canvas implements CommandListener, constants
{
	/**
	 * referencia na MIDlet ku ktoremu patrime
	 */
    private MIDlet midlet;
	/**
	 * pocet krokov
	 */
    private int steps;
	/**
	 * pocet levelov
	 */
    private int levels;
	/**
	 * x posun mapy v pixeloch
	 */
    private int transx;
	/**
	 * y posun mapy v pixeloch
	 */
    private int transy;
	/**
	 * predosly posun mapy v pixeloch
	 */
    private int otransx;
	/**
	 * predosly posun mapy v pixeloch
	 */
    private int otransy;
	/**
	 * mod pre pohyb mapou, ak true tak sa hybe mapa a nie hrac
	 */
    private boolean movemode;
	/**
	 * automaticky posun mapy za hracom
	 */
    private boolean autoscroll;
	/**
	 * v kazdom cykle prekresli celu mapu
	 */
    private boolean allwaysrepaint;
	/**
	 * konstanta pre pocitanie posunu mapy.
	 */
    private int c1;
	/**
	 * konstanta pre pocitanie posunu mapy.
	 */
    private int c2;
    
    
	/**
	 * nastavi pohyb na nikam
	 * @param code kod klavesy
	 */
    public void keyReleased(int code)
    {
	hrac.set_go(GO_NONE);
    }
    
	/**
	 * spracuje vstup klavesnice, posuva hraca a mapu
	 * @param code kod klavesy
	 */
    public void keyPressed(int code)
    {
	int game = getGameAction(code);
	int dirrection=GO_NONE;
	
	switch (game)
	{
	    case Canvas.DOWN:
		if(movemode) 
		    transy-=tile_height;
		else
		    dirrection = GO_DOWN;
		break;
	    case Canvas.UP:
		if(movemode) 
		    transy+=tile_height;
		else
		    dirrection = GO_UP;
		break;
	    case Canvas.LEFT:
		if(movemode) 
		    transx+=tile_width;
		else
		    dirrection = GO_LEFT;
		break;
	    case Canvas.RIGHT:
		if(movemode) 
		    transx-=tile_width;
		else
		    dirrection = GO_RIGHT;
		break;
	    case Canvas.FIRE:
		movemode = !movemode;
		break;
	}
	if (!movemode) 
	{
	    steps++;
	    hrac.set_go(dirrection);
	    hrac.move(thislevel);
	    if(thislevel.finished()) winning();
	    
	    if (autoscroll)
	    {
		transx = -hrac.getposx()*tile_width+getWidth()/2;
		transy = -hrac.getposy()*tile_height+getHeight()/2;
		filter();
	    }
	}
	else //movemode on
	{
	    filter();
	}
	repaint();
    }
    
	/**
	 * opravi posuny aby sa neposuvalo zbytocne, napriklad ked by v 
	 * polovici obrazovky uz nebolo nic (ziadna cast mapy) tak sa
	 * neposunie az tak na okraj
	 */
    private void filter()
    {
	if (transx < c1) transx=c1;
	if (transy < c2) transy=c2;
	if (transx > 0) transx = 0;
	if (transy > 0) transy = 0;
    }
    
	/**
	 * spracuje udalost vyhra
	 */
    private void winning()
    {

	int l=thislevel.get_level_number()+1;
	String str="CONGRATULATIONS, you have completed this level. It took you" +
		" "+steps+" steps. ";
	if(l>=levels)
	    str = str + "\n\n\nAs this is the last level, you have completed the game." +
		    " You are a real mastermind.";
	else
	{
	    str = str + "\n\n\nNow you can play the next level.";
	    thislevel = new level(l);
	    hrac.setpos(thislevel.startx(), thislevel.starty());
	    steps = 0;
            c1 = -(thislevel.width()*tile_width-getWidth());
	    c2 = -(thislevel.height()*tile_height-getHeight());
	    transx = -hrac.getposx()*tile_width+getWidth()/2;
	    transy = -hrac.getposy()*tile_height+getHeight()/2;
	    filter();
	}
	    
	
	Alert alert = new Alert("Level Completed");
	alert.setString(str);
	alert.setTimeout(Alert.FOREVER);
	if (l>=levels) 
	    Display.getDisplay(midlet).setCurrent(alert, menu);
	else
	    Display.getDisplay(midlet).setCurrent(alert);
	
	thislevel.request_repaint();
        repaint();
    }

	/**
	 * kresli grafiku
	 * @param g grafika
	 */
    public void paint(Graphics g)
    {
	if (otransx != transx || otransy != transy)
	{
	    thislevel.request_repaint();
	    otransx = transx;
	    otransy = transy;
	}
	if (allwaysrepaint) thislevel.request_repaint();
	thislevel.paint(g, transx, transy);

	hrac.paint(g, transx, transy);
	thislevel.setpos(hrac.getposx(), hrac.getposy(), DIRT);
    }
    
	/**
	 * spracuje menu
	 * @param c polozka menu
	 * @param d screen
	 */
    public void commandAction(Command c, Displayable d)
    {
	if (c == commands[0])
	{
	    // restart
	    int num = thislevel.get_level_number();
	    thislevel = new level(num);
	    hrac.setpos(thislevel.startx(), thislevel.starty());
	    otransx = otransy = 0;
	    transx = -hrac.getposx()*tile_width+getWidth()/2;
	    transy = -hrac.getposy()*tile_height+getHeight()/2;
	    filter();
	    steps = 0;
	}
	if (c == commands[1])
	{
	    Alert alert = new Alert("Super Sokoban by T.B.");
	    alert.setString("Move the worker using the direction keys. \n\n" +
		    "Push the boxes into the stores (X). Each store must " +
		    "be occupied to win. \n\nYou can push a box " +
		    "into a pit to make ground there.\n\n" +
		    "Use the Fire (Select) button to switch to screen moving mode.");
	    alert.setTimeout(Alert.FOREVER);
	    Display.getDisplay(midlet).setCurrent(alert);
	}
	if (c == commands[2])
	{
	    Display.getDisplay(midlet).setCurrent(menu);
	}
	thislevel.request_repaint();
	repaint();
	thislevel.request_repaint();
    }
    
    private level thislevel;
    private panak hrac;
    private Canvas menu;
    
    Command commands[];
    
    /**
	 * konstruktor
	 * @param midlet_ midlet ku ktoremu patrim
	 * @param start_lev pociatocny level
	 * @param levels_ posledny level
	 * @param menu_ referencia na menu ktory nas zavolal
	 * @param autoscroll_ automaticky posun obrazovky za hracom
	 * @param allwaysrepaint_ prekresli celu mapu v kazdom cykle
	 */
    public game(MIDlet midlet_, int start_lev, int levels_, Canvas menu_, boolean autoscroll_, boolean allwaysrepaint_)
    {
	allwaysrepaint = allwaysrepaint_;
	autoscroll = autoscroll_;
	menu = menu_;
	levels = levels_;
	midlet = midlet_;
	
	otransx = otransy = 0;

	movemode = false;
	
	mappainter.load_images(getWidth(), getHeight());
	thislevel = new level(start_lev);
	steps = 0;
	hrac = new panak();
	hrac.setpos(thislevel.startx(), thislevel.starty());
	
	commands = new Command[3];
	commands[0] = new Command("Restart", Command.EXIT, 0);
	commands[1] = new Command("Help", Command.SCREEN, 1);
	commands[2] = new Command("Exit to Menu", Command.SCREEN, 2);
	
	addCommand(commands[0]);
	addCommand(commands[1]);
	addCommand(commands[2]);
	setCommandListener(this);
	
        c1 = -(thislevel.width()*tile_width-getWidth());
	c2 = -(thislevel.height()*tile_height-getHeight());
	transx = -hrac.getposx()*tile_width+getWidth()/2;
	transy = -hrac.getposy()*tile_height+getHeight()/2;
	filter();
    }
}
