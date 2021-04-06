/*
 * @(#)superSOKO.java	1.0 03/07/07
 */

package superSOKO;

import editor.FilesIO;
import javax.microedition.midlet.MIDlet;
import javax.microedition.lcdui.Display;
import javax.microedition.rms.RecordStore;
import javax.microedition.rms.RecordStoreException;

/**
 * midlet pre hru
 */
public class sokomain extends MIDlet implements constants
{
    main_menu m;
    
	/**
	 * konstruktor, inicializuje RecordStore parametre a uzivatelsky
	 * definovane levely
	 */
    public sokomain()
    {
	RecordStore rs;
	try
	{
	    rs = RecordStore.openRecordStore(record_store_name, true);
	    if(1 == rs.getNextRecordID())
	    {
		byte p[] = new byte[2];
		p[0] = 1; // autoscroll
		p[1] = 1; // allways repaint
		rs.addRecord(p, 0, 2);
	    }
	    rs.closeRecordStore();
	}
	catch (RecordStoreException ex)
	{
	    ex.printStackTrace();
	}
	FilesIO.initcustomlevels();
	m = new main_menu(this);
    }
    
    public void startApp()
    {
	Display.getDisplay(this).setCurrent(m);
    }

    public void pauseApp()
    { }
    
    public void destroyApp(boolean unc)
    { }
    
}
