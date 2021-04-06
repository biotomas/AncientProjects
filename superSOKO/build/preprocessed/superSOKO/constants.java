/*
 * constants.java
 *
 * Created on 4. èervenec 2007, 11:57
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */

package superSOKO;

/**
 * Spolocne konstanty hry
 * @author tomas balyo
 */
public interface constants
{
	/**
	 * maximalna dovolena sirka mapy v pocte dlazdiciek
	 */
    public static final int MAP_WIDTH = 30;
	/**
	 * maximalna dovolena vyska mapy v pocte dlazdiciek
	 */
    public static final int MAP_HEIGHT = 30;
	/**
	 * sirka dlazdicky v pixeloch
	 */
    public static final int tile_width = 20;
	/**
	 * vyska dlazdicky v pixeloch
	 */
    public static final int tile_height = 20;
    
	/**
	 * smer pohybu - nikam
	 */
    public static final int GO_NONE = 0;
	/**
	 * smer pohybu - hore
	 */
    public static final int GO_UP = 1;
	/**
	 * smer pohybu - doprava
	 */
    public static final int GO_RIGHT = 2;
	/**
	 * smer pohybu - dole
	 */
    public static final int GO_DOWN = 3;
	/**
	 * smer pohybu - dolava
	 */
    public static final int GO_LEFT = 4;
    
	/**
	 * prvok mapy - stena
	 */
    public static final int WALL = '#';
	/**
	 * prvok mapy - diera
	 */
    public static final int PIT = 'P';
	/**
	 * prvok mapy - chodnik, dlazba
	 */
    public static final int SPACE = ' ';
	/**
	 * prvok mapy - debna
	 */
    public static final int BOX = 'B';
	/**
	 * prvok mapy - miesto pre debnu
	 */
    public static final int STORE = 'S';
	/**
	 * prvok mapy - debna na mieste
	 */
    public static final int INBOX = 'I';
	/**
	 * specialna hodnota, nesmie byt v mape
	 */
    public static final int DIRT = ';';
	/**
	 * prvok mapy - pociatocna poloha hraca
	 */
    public static final int PLAYER = 'X';
	/**
	 * prvok mapy - nic
	 */
    public static final int NONE = '-';
    
	/**
	 * nazov RecordStore ktory drzi nastavenia autoscroll a 
	 * allways repaint
	 */
    public static final String record_store_name = "SuperSoko_RS";
	/**
	 * pocet predefinovanych levelov
	 */
    public static final byte initial_levels = 8;
	/**
	 * pocet levelov pre uzivatela ktore moze menit
	 */
    public static final byte custom_levels = 5;
}
