/*
 * editormidlet.java
 *
 * Created on 5. èervenec 2007, 17:30
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */

package editor;

import javax.microedition.lcdui.Display;
import javax.microedition.midlet.MIDlet;
import javax.microedition.rms.RecordStore;
import javax.microedition.rms.RecordStoreException;
import superSOKO.mappainter;
import superSOKO.constants;

/**
 * Editor mapy
 * @author tomas
 */
public class editormidlet extends MIDlet implements constants
{
    editor ed;
    
    /**
	 * Konstruuje editor, inicializuje uzivatelske mapy v RecordStore a
	 * nastavenia autoscroll a allways_repaint
	 */
    public editormidlet()
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
	ed = new editor(this);
    }
    
    protected void startApp()
    {
	Display.getDisplay(this).setCurrent(ed);
    }
    
    protected void pauseApp()
    {
    }
    
    protected void destroyApp(boolean b)
    {
    }
    
}
