/*
 * FilesIO.java
 *
 * Created on 8. èervenec 2007, 18:44
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */

package editor;

import java.io.IOException;
import java.io.InputStream;
import javax.microedition.rms.RecordStore;
import javax.microedition.rms.RecordStoreException;
import superSOKO.constants;

/**
 * Tato trieda ma vsetky metody staticke a nie je mozne ju instanciovat.
 * Stara sa o pracu so subormi a triedou RecordStore, ktora umoznuje ukladat
 * perzistentne data v mobilnom telefone. Moznost zapisovat do suborov nie je, 
 * alebo som ju neobjavil, technologia RecordStore ju nahradza.
 * @author tomas balyo
 */
public class FilesIO implements constants
{
    
    /** Tuto triedu nie je mozne instanciovat */
    private FilesIO()
    {
    }
    /**
	 * Metoda do bytoveho pola p nastavi data, ktore su ulozene v RecordStore.
	 * tieto data obsahuju nastavenia autoscroll a allways_repaint
	 * p[0] je 1 ak autoscroll je true, inak 0, podobne p[1] pre allways_repaint
	 * @param p bytove pole dlzky 2.
	 */
    static public void getRSparameters(byte[] p)
    {
	RecordStore rs;
	try
	{
	    rs = RecordStore.openRecordStore(record_store_name, false);
	    rs.getRecord(1, p, 0);
	    rs.closeRecordStore();
	    //
	}
	catch (RecordStoreException ex)
	{
	    ex.printStackTrace();
	}
    }
    
	/**
	 * Metoda pre nastavenie parametrov autoscroll a allways_repaint
	 * p[0] je 1 ak autoscroll je true, inak 0, podobne p[1] pre allways_repaint
	 * @param p naalokovane bytove pole dlzky 2
	 */
    static public void setRSparameters (byte []p)
    {
	RecordStore rs;
	try
	{
	    rs = RecordStore.openRecordStore(record_store_name, false);
	    rs.setRecord(1, p, 0, 2);
	    rs.closeRecordStore();
	}
	catch (RecordStoreException ex)
	{
	    ex.printStackTrace();
	}
    }
    
	/**
	 * Tato inicializacia sa ma spustit len raz po nainstalovani hry
	 * do mobilneho telefonu. Vytvori nove zaznamy v RecordStore pre
	 * uzivatelske levely a dosadi do nich defaultny level.
	 */
    public static void initcustomlevels()
    {
	try
	{
	    RecordStore rs = RecordStore.openRecordStore("SuperSokoLevels", true);
	    if (rs.getNextRecordID() == 1)
	    {
		String s = "######\n#X BS#\n######\n";
		byte []p = s.getBytes();
	
		for (int i = 0; i < custom_levels; i++)
		{
		    rs.addRecord(p, 0, p.length);
		}
	    }
	}
	catch (RecordStoreException ex)
	{
	    ex.printStackTrace();
	}
	
    }
    
    
	/**
	 * Ulozi level do telefonu, kedze (pravdepodobne) nie je mozne
	 * zapisovat do suborov, pouzije sa trieda RecordStore, ktoru
	 * dava k dispozicii API mobilovych aplikacii.
	 * @param lev cislo levelu, do ktoreho sa ma mapa ulozit, cislo
	 * musi byt vyssie ako initial_levels, pretoze do tych
	 * levelov nie je dovolene zapisovat
	 * @param map pole int ktore obsahuje mapu.
	 */
    static public void savelevel(int lev, int[] map)
    {
	lev = lev - initial_levels + 1;
	String maps = "";
	int last=0;
	for (int j = 0; j < MAP_HEIGHT; j++)
	{
	    last = MAP_WIDTH-1;
	    while(last > 0 && (map[last+j*MAP_WIDTH] == NONE))
	    {
		--last;
	    }
	    if(last == 0)
		break;
	    for (int i = 0; i <= last; i++)
	    {
		maps+=(char)map[i+j*MAP_WIDTH];	
	    }
	    maps+='\n';
	}
	byte []p = new byte[maps.length()];
	p = maps.getBytes();
	
	try
	{
	    RecordStore rs = RecordStore.openRecordStore("SuperSokoLevels", true);
	    rs.setRecord(lev, p, 0, p.length);
	}
	catch (RecordStoreException ex)
	{
	    ex.printStackTrace();
	}
    }
    
	/**
	 * Nacita level zo suboru alebo z RecordStore, rozhoduje sa podla
	 * parametru lev
	 * @param lev cislo levelu, ktore sa ma nacitat
	 * @param map pole int do ktoreho sa nacita mapa
	 * @return vracia true ak sa mapu podarilo nacitat, inak vracia false
	 */
    static public boolean loadlevel(int lev, int[] map)
    {
	if (lev < 0) 
	    return false;
	if (lev < initial_levels) 
	    return loadfromfile(lev, map);
	else
	    return loadfromRS(lev-initial_levels+1, map);
    }
    
	/**
	 * Nacita mapu z RecordStore
	 * @param lev cislo levelu relativne k RecordStore
	 * @param map pole int kam sa nahra mapa
	 * @return vracia true ak sa mapu podarilo naciat inak false
	 */
    static private boolean loadfromRS(int lev, int[] map)
    {
	try
	{
	    RecordStore rs = RecordStore.openRecordStore("SuperSokoLevels", true);
	    int size = rs.getRecordSize(lev);
	    byte[] p = rs.getRecord(lev);
	    int i, j;
	    i = j = 0;
	    for (int k = 0; k < p.length; k++)
	    {
		if(p[k] != '\n')
		    map[i+j*MAP_WIDTH] = p[k];
		else
		{
		    j++;
		    i = -1;
		}
		i++;
	    }
	}
	catch (RecordStoreException ex)
	{
	    ex.printStackTrace();
	    return false;
	}
	
	return true;
    }
    
	/**
	 * Nacita mapu z externeho suboru.
	 * @param lev cislo levelu relativne k RecordStore
	 * @param map pole int kam sa nahra mapa
	 * @return vracia true ak sa mapu podarilo naciat inak false
	 */
    static private boolean loadfromfile(int lev, int[] map)
    {
	InputStream is;
	is = InputStream.class.getResourceAsStream("/levels/l"+lev+".lvl");
	if (is == null)
	{
	    System.out.println("level not loaded");
	    return false;
	}
	
	int i,j,k;
	i=j=0;
	try
	{
	    while((k=is.read()) != -1)
	    {
		if(k == '\n')
		{
		    ++j;
		    i=0;
		}
		else if (k != '\f')
		{
		    map[i+j*MAP_WIDTH] = k;
		    ++i;
		}
	    }
	    is.close();
	}
	catch (IOException ex)
	{
	    ex.printStackTrace();
	}
	return true;
    }    
}
