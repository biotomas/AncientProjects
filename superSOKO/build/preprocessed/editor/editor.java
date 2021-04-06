/*
 * editor.java
 *
 * Created on 6. èervenec 2007, 11:22
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */

package editor;

import com.sun.midp.lcdui.Text;
import java.io.IOException;
import javax.microedition.lcdui.Alert;
import javax.microedition.lcdui.Canvas;
import javax.microedition.lcdui.Command;
import javax.microedition.lcdui.CommandListener;
import javax.microedition.lcdui.Display;
import javax.microedition.lcdui.Displayable;
import javax.microedition.lcdui.Graphics;
import javax.microedition.lcdui.Image;
import javax.microedition.lcdui.TextBox;
import javax.microedition.lcdui.TextField;
import javax.microedition.midlet.MIDlet;
import superSOKO.constants;
import superSOKO.mappainter;
/**
 * Trieda sa stara o vsetky zalezitosti editoru map
 * @author tomas balyo
 */
public class editor extends Canvas implements CommandListener, constants
{
	/**
	 * obsahuje mapu reprezentovanu znakmi, 
	 * definovane su v {@link superSOKO.constants }
	 */
    private int[] map;
	/**
	 * instancia triedy ktora kresli mapu
	 */
    private mappainter painter;
	/**
	 * x-suradnica kurzoru v dlazdickach, nie pixeloch
	 */
	private int cx;
	/**
	 * y-suradnica kurzoru v dlazdickach, nie pixeloch
	 */
	private int cy;
	/**
	 * aktualny prvok, ktory sa ma umiestnit
	 */
    private int element;
	/**
	 * x-posun mapy v pixeloch
	 */
	private int transx;
	/**
	 * y-posun mapy v pixeloch
	 */
	private int transy;
	/**
	 * predosly posun mapy
	 */
	private int otransx;
	/**
	 * predosly posun mapy
	 */
    private int otransy;
	/**
	 * obrazok kurzoru
	 */
    private Image cursor;
	/**
	 * vyska dolneho panelu v pixeloch
	 */
    private int panelheight;
	/**
	 * MIDlet ktory nas zavolal
	 */
    private MIDlet caller;
    
    /**
	 * konstruktor
	 * @param caller_ MIdlet ktory nas konstruoval
	 */
    public editor(MIDlet caller_)
    {
	caller = caller_;
	panelheight = getHeight() - (getHeight()/tile_height-1)*tile_height;
	mappainter.load_images(getWidth(), getHeight()-panelheight);
	map = new int[MAP_WIDTH*MAP_HEIGHT];
	painter = new mappainter(map, MAP_WIDTH, MAP_HEIGHT);
	clearmap();
	element = WALL;
	transx = transy = otransx = otransy = 0;
	try
	{
	    cursor = Image.createImage("/images/cursor.PNG");
	}
	catch (IOException ex)
	{
	    ex.printStackTrace();
	}
	setupcommands();
    }
    
	/**
	 * Vycisti mapu, nastavi NONE na kazdu poziciu, kurzor da do pociatku
	 */
    private void clearmap()
    {
	for (int i = 0; i < map.length; i++)
	    map[i] = NONE;

	cx = cy = 0;
	painter.request_repaint();
	transx = transy = 0;
    }
    
	/**
	 * nastavi element na danu poziciu mapy
	 * @param x x
	 * @param y y
	 * @param elem aky element sa ma nastavit
	 */
    private void setmap(int x, int y, int elem)
    {
	if(x>=0 && x<MAP_WIDTH && y>=0 && y<MAP_HEIGHT)
	{
	    map[x + y*MAP_WIDTH] = elem;
	    painter.adddirty(x + y*MAP_WIDTH);
	}
    }
    
	/**
	 * vrati element na danej pozicii
	 * @param x x
	 * @param y y
	 * @return element na danej pozicii
	 */
    private int getmap(int x, int y)
    {
	if(x>=0 && x<MAP_WIDTH && y>=0 && y>MAP_HEIGHT)
	    return map[x + y*MAP_WIDTH];
	return -1;
    }
    
	/**
	 * spracuje vstup z klavesnice, nastavuje posun mapy
	 * @param code kod klavesy
	 */
    protected void keyPressed(int code)
    {
	int action = getGameAction(code);
	switch(action)
	{
	    case Canvas.UP:
		cy--;
		if(cy<0) cy = 0;
		break;
	    case Canvas.DOWN:
		cy++;
		if (cy == MAP_HEIGHT) --cy;
		break;
	    case Canvas.RIGHT:
		cx++;
		if (cx == MAP_WIDTH) --cx;
		break;
	    case Canvas.LEFT:
		cx--;
		if(cx<0) cx = 0;
		break;
	    case Canvas.FIRE:
		setmap(cx,cy, element);
		break;
	}
	switch(code)
	{
	    case KEY_POUND:
		switch (element)
		{
		    case WALL:
			element = NONE; break;
		    case NONE:
			element = PLAYER; break;
		    case PLAYER:
			element = INBOX; break;
		    case INBOX:
			element = STORE; break;
		    case STORE:
			element = BOX; break;
		    case BOX:
			element = SPACE; break;
		    case SPACE:
			element = PIT; break;
		    case PIT:
			element = WALL; break;
		}
		break;
	    case KEY_STAR:
		switch(element)
		{
		    case WALL:
			element = PIT; break;
		    case NONE:
			element = WALL; break;
		    case PLAYER:
			element = NONE; break;
		    case INBOX:
			element = PLAYER; break;
		    case STORE:
			element = INBOX; break;
		    case BOX:
			element = STORE; break;
		    case SPACE:
			element = BOX; break;
		    case PIT:
			element = SPACE; break;
		}
		break;		
	}
	
	//posun mapy
	if(cx*tile_width < transx) transx -= tile_width;
	if(cy*tile_height < transy) transy -= tile_height;
	if(cx*tile_width >= getWidth()+transx-tile_width) transx+=tile_width;
	if(cy*tile_height >= getHeight()+transy-panelheight) transy+=tile_height;
	
	repaint();
    }
    
	/**
	 * kresli grafiku
	 * @param g grafika
	 */
    protected void paint(Graphics g)
    {
	if (otransx != transx || otransy !=transy)
	{
	    painter.request_repaint();
	    otransx = transx;
	    otransy = transy;
	}
	g.translate(-transx, -transy);
	painter.request_repaint();
	painter.paint(g);
	//paint cursor
	g.drawImage(cursor, cx*tile_width, cy*tile_height, 0);
	painter.adddirty(cx + cy * tile_width);
	
	paintpanel(g);
    }
    
	/**
	 * kresli dolny informacny panel
	 * @param g grafika
	 */
    private void paintpanel(Graphics g)
    {
	g.translate(-g.getTranslateX(), -g.getTranslateY());
	g.setColor(0xFFFFFF);
	g.fillRect(0,getHeight()-panelheight, getWidth(), getHeight()-panelheight);
	g.drawLine(0,getHeight()-panelheight, getWidth(), getHeight()-panelheight);
	g.drawImage(painter.lendimage(WALL), 5+0*tile_width, getHeight()-panelheight, 0);
//	g.drawImage(painter.lendimage(NONE), 5+1*tile_width, getHeight()-panelheight, 0);
	g.drawImage(painter.lendimage(PLAYER), 5+2*tile_width, getHeight()-panelheight, 0);
	g.drawImage(painter.lendimage(INBOX), 5+3*tile_width, getHeight()-panelheight, 0);
	g.drawImage(painter.lendimage(STORE), 5+4*tile_width, getHeight()-panelheight, 0);
	g.drawImage(painter.lendimage(BOX), 5+5*tile_width, getHeight()-panelheight, 0);
	g.drawImage(painter.lendimage(SPACE), 5+6*tile_width, getHeight()-panelheight, 0);
	g.drawImage(painter.lendimage(PIT), 5+7*tile_width, getHeight()-panelheight, 0);
	int pos = 0;
	switch (element)
	{
	    case WALL: pos = 0; break;
	    case NONE: pos = 1; break;
	    case PLAYER: pos = 2; break;
	    case INBOX: pos = 3; break;
	    case STORE: pos = 4; break;
	    case BOX: pos = 5; break;
	    case SPACE: pos = 6; break;
	    case PIT: pos = 7; break;
	}
	g.setColor(0xFFFFFF);
	
	g.drawLine(0, getHeight()-panelheight, 
		    getWidth(), getHeight()-panelheight);
	
	g.drawLine(0, getHeight()-panelheight+tile_height, 
		getWidth(), getHeight()-panelheight+tile_height);
	g.drawLine(0, getHeight()-panelheight+tile_height+1, 
		getWidth(), getHeight()-panelheight+tile_height+1);
	
	g.setColor(0xFF0000);
	
	g.drawLine(5+pos*tile_width, getHeight()-panelheight, 
		4+(pos+1)*tile_width, getHeight()-panelheight);	
	
	g.drawLine(5+pos*tile_width, getHeight()-panelheight+tile_height, 
		4+(pos+1)*tile_width, getHeight()-panelheight+tile_height);	
	g.drawLine(5+pos*tile_width, getHeight()-panelheight+tile_height+1, 
		4+(pos+1)*tile_width, getHeight()-panelheight+tile_height+1);	
    }
    
    //======================================================================================
    //======================================================================================
    //======================================================================================
    private Command exit, save, help, validate, load, clear, okCommand, prev; 
    private TextBox tbox;
    
	/**
	 * Inicializuje pracu s menu
	 */
    private void setupcommands()
    {	
	okCommand = new Command("OK", Command.OK, 30);
	exit = new Command("Exit", Command.EXIT, 1);
	save = new Command("Save as", Command.SCREEN, 2);
	help = new Command("Help", Command.SCREEN, 3);
	validate = new Command("Validate", Command.SCREEN, 3);
	load = new Command("Load", Command.SCREEN, 2);
	clear = new Command("Clear", Command.SCREEN, 3);

	addCommand(exit);
	addCommand(save);
	addCommand(load);
	addCommand(help);
	addCommand(validate);
	addCommand(clear);
	
	tbox = new TextBox("Enter level", "", 2, TextField.NUMERIC);
	tbox.addCommand(okCommand);
	tbox.setCommandListener(this);

	setCommandListener(this);	
    }
    
	/**
	 * Zobrazi screen so spravou
	 * @param title nadpis
	 * @param text text spravy
	 */
    private void showalert(String title, String text)
    {
	Alert alert = new Alert(title);
	alert.setString(text);
	alert.setTimeout(Alert.FOREVER);
        Display.getDisplay(caller).setCurrent(alert, this);
    }    
    
	/**
	 * kontrouluje aktualnu mapu ci sedi pocet hracov (1) a
	 * ci je mapa tvorena jednym suvislym kusom.
	 * @return sprava obsahuje chyby, pripadne slovo OK
	 */
    private String validate()
    {
	String errors="";
	int players=0, player=0;
	boolean[] in = new boolean[map.length];
	boolean first = true;
	int start=0;
	
	for (int i = 0; i < map.length; i++)
	{
	    if (map[i] != NONE && first)
	    {
		first = false;
		start = i;
	    }
	    if (map[i]==PLAYER)
	    {
		players++;
		player = i;
	    }
	}
	if (players != 1)
	{
	    errors = "There should be exactly one player, but you have placed "+players+" players.\n";
	    if(players > 1)
		errors+="Please remove "+(players-1)+" player(s).";
	    else
		errors+="Please add one.";
	    return errors;
	}
	
	setins(start, in);
	
	for (int i = 0; i < in.length; i++)
	{
	    if (in[i]==false && map[i] != NONE)
		return "Map has more parts, it must be olny one big \"island\".";
	}
	
	return "OK";
    }
    
    private void setins(int start, boolean[] in)
    {
	int x;
	in[start] = true;
	
	x = start - 1;
	if(x < in.length && x >= 0 && map[x] != NONE && in[x] == false)
	    setins(x, in);
	
	x = start + 1;
	if(x < in.length && x >= 0 && map[x] != NONE && in[x] == false)
	    setins(x, in);
	
	x = start + MAP_WIDTH;
	if(x < in.length && x >= 0 && map[x] != NONE && in[x] == false)
	    setins(x, in);
	
	x = start - MAP_WIDTH;
	if(x < in.length && x >= 0 && map[x] != NONE && in[x] == false)
	    setins(x, in);
    }
        
	/**
	 * spracuje jednotlive poziadavky z menu
	 * @param command polozka z menu
	 * @param d screen
	 */
    public void commandAction(Command command, Displayable d)
    {
	painter.request_repaint();
	if (command == exit)
	{
	    caller.notifyDestroyed();
	}
	if (command == save)
	{
	    Display.getDisplay(caller).setCurrent(tbox);
	    prev = save;
	}
	if (command == okCommand)
	{
	    Display.getDisplay(caller).setCurrent(this);
	    String s;
	    int selected_lev = Integer.parseInt(tbox.getString());
	    if (prev == save)
	    {
		if (selected_lev < initial_levels)
		    showalert("save level", "Sorry, but you can not save to the " +
			    "first "+(initial_levels-1)+" levels. Use a number between " +
			    ""+initial_levels+" and "+(initial_levels+custom_levels-1));
		else if (selected_lev >= initial_levels+custom_levels)
		    showalert("save level","No such level. Use a number between " +
			    ""+initial_levels+" and "+(initial_levels+custom_levels-1));
		else if (!(s=validate()).equals("OK"))
		    showalert("validation failed","Your level is not valid. Errors: \n"+s);
		else 
		    FilesIO.savelevel(selected_lev, map);
	    }
	    else if (prev == load)
	    {
		if (selected_lev < initial_levels+custom_levels)
		    FilesIO.loadlevel(selected_lev, map);
		else
		    showalert("No such level", "sorry, but there are only " +
			    ""+(initial_levels+custom_levels-1)+" levels.");
	    }	    	    
	}
	if (command == load)
	{
	    clearmap();
	    Display.getDisplay(caller).setCurrent(tbox);
	    prev = load;
	}
	if (command == help)
	{
	    showalert("help", "Use directional keys to move the cursor (or 2,4,6,8) and" +
		    " action (or 5) key to place an item. Use the pound (#) and star (*) " +
		    "keys to change the item. You can see which item is selected in the bottom" +
		    " of the screen. \n\nYour map must be valid if you want to save it. The map" +
		    " is valid if there is exactly one player and it is \"one-piece\"." +
		    " The validator checks the validity of your map, BUT it does not check" +
		    " whether it is possible to win your map. The winning condition is that" +
		    " all STORES are occupied.");
	}
	if (command == clear)
	{
	    clearmap();
	}
	if (command == validate)
	{
	    showalert("validation", validate());
	}
	repaint();
    }
}
