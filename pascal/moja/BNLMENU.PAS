unit bnlmenu;

interface
    uses bnlmap;
    type string15=string[15];
         tmenuoptions=record
            {1st group}
            puplast,pupwait,pupfreq,maxhp,screendelay:byte;
            name1,name2:string15;
            rules:boolf;
            allowpup:boolf;
            {2nd group}
            mineson,soundon,powupson : boolean;
            map : shortint;
            controls:array[1..10] of byte;
         end;
    procedure gamemenu(var opt:tmenuoptions);

implementation
uses graph,crt,games;
const cfgfile='settings.cfg';
      allmap= 0;
      rndmap=-1;
var volba:byte;
    k:char;
    gamestart:boolean;

procedure createdefaultcfgfile;
var f:file of tmenuoptions;
    defopt:tmenuoptions;
    i:byte;
begin
{The default settings}
with defopt do
   begin
   puplast:=10;
   pupwait:=7;
   pupfreq:=20;
   maxhp:=30;
   name1:='manuleo estevez';
   name2:='louis magenta';
   rules[1]:=false;     allowpup[1]:=true;
   rules[2]:=false;     allowpup[2]:=true;
   rules[3]:=false;     allowpup[3]:=true;
   rules[4]:=false;     allowpup[4]:=true;
   rules[5]:=false;     allowpup[5]:=true;
   rules[6]:=false;     allowpup[6]:=true;
                        allowpup[7]:=true;
   map:=allmap;
   mineson:=true;
   soundon:=true;
   powupson:=true;
   screendelay:=20;
    {controls in order: right,front,left,back,shot, the same for pl2}
   controls[1]:=rightscan;
   controls[2]:=upscan;
   controls[3]:=leftscan;
   controls[4]:=downscan;
   controls[5]:=ctrlscan;
   controls[6]:=scanof('d');
   controls[7]:=scanof('w');
   controls[8]:=scanof('a');
   controls[9]:=scanof('s');
   controls[10]:=tabscan
   end;

assign(f,cfgfile);
rewrite(f);
write(f,defopt);
close(f);
end;

procedure kresliStvorceky;
var i:byte;
begin
cleardevice;
setcolor(8);
for i:=0 to 63 do
line(10*i,0,10*i,340);
for i:=0 to 34 do
line(0,10*i,630,i*10);
end;


procedure mainmenu;
begin
kresliStvorceky;
setcolor(7);
settextstyle(0,0,20);
outtextxy(100,20,'BNL');
settextstyle(0,0,2);
volba:=1;

repeat
if volba=1 then setcolor(15) else setcolor(7);
outtextxy(200,210,'start new game');
if volba=2 then setcolor(15) else setcolor(7);
outtextxy(255,230,'options');
if volba=3 then setcolor(15) else setcolor(7);
outtextxy(250,250,'controls');
if volba=4 then setcolor(15) else setcolor(7);
outtextxy(220,270,'help / rules');
if volba=5 then setcolor(15) else setcolor(7);
outtextxy(280,290,'exit');
k:=readkey;
if k=#72 then dec(volba);
if k=#80 then inc(volba);
if volba=0 then volba:=5;
if volba=6 then volba:=1;
until k=#13;
if volba=5 then
   begin
   closegraph;
   halt; {osklivost ale vela prace usetri.}
   end;
if volba=1 then gamestart:=true;
end;

procedure help;
begin
kresliStvorceky;
setcolor(7);
settextstyle(0,0,2);
outtextxy(100,25,'help / game rules / credits');
settextstyle(0,0,1);
{-----------------<*********************************************************>}
outtextxy(80,60, 'Rules: Kill your oponent and avoid mines, you can collect');
outtextxy(80,70, '       power ups, which appear allways in the centre of the');
outtextxy(80,80, '       screen. This increases the strategical value of the');
outtextxy(80,90, '       screen centre. For more read the manual.');

outtextxy(80,110,'Help:  You can modify game speed by changinng the screen');
outtextxy(80,120,'       delay setting in the options menu. Lowering this will');
outtextxy(80,130,'       increase the game speed but the screen will be blinking.');
outtextxy(80,140,'       Set it as you wish.');


outtextxy(80,170,'                      *** CREDITS *** ');

outtextxy(80,190,'                  everything: Tomas Balyo ');
outtextxy(80,200,'                    ctrlaltdel@matfyz.cz ');
outtextxy(80,210,'                    ctrlaltdel.matfyz.cz ');

outtextxy(80,230,'                         Thanks to:');
{-----------------<*********************************************************>}
outtextxy(135,250,'Lou DuChez, Martin Boros, Matej Juhas, Martin Babka');
outtextxy(135,260,'Radoslav Klic, Vojtech Bardiovsky, Robert Dianiska');
outtextxy(135,270,'  Richard Hantke, Martin Vilinsky, Peter Svajko');
outtextxy(135,290,'                  dec` 2005 ');

outtextxy(80,320,'                   <hit a key to go back>');
readkey;
end;

{############################################################################}
{############################################################################}
{############################################################################}

procedure options;
const onlywrite=char(1);
var volba:byte;
    f:file of tmenuoptions;
    k:char;
    opt: tmenuoptions;
{############################################################################}
    procedure mapoption(x,y:integer; name:string; var map:shortint);
    var s:string[16];
    begin
    if k=onlywrite then setcolor(7) else setcolor(15);
    outtextxy(x,y,name);
    if map=-1 then s:='random map' else
    if map=0 then s:='all maps' else str(map,s);
    outtextxy(x+200,y,s);
    if k=onlywrite then exit; {len vypisujeme}
       repeat
       if map=-1 then s:='random map' else
       if map=0 then s:='all maps' else str(map,s);
       setcolor(15);
       outtextxy(x+200,y,s);
       k:=readkey;
       if k=#77 then inc(map);
       if k=#75 then dec(map);
       if map<-1 then map:=numberofmaps;
       if map>numberofmaps then map:=-1;
       setcolor(0);
       outtextxy(x+200,y,s);
       until (k=#27) or (k=#72) or (k=#80); {kym neda sipku dole alebo hore}
    setcolor(7);
    outtextxy(x,y,name);
    outtextxy(x+200,y,s);
    end;
{############################################################################}
    procedure booloption(x,y:integer; name:string; var val:boolean);
    var s:string[6];
    begin
    if k=onlywrite then setcolor(7) else setcolor(15);
    outtextxy(x,y,name);
    if val then s:='true' else s:='false';
    outtextxy(x+200,y,s);
    if k=onlywrite then exit; {len vypisujeme}
       repeat
       if val then s:='true' else s:='false';
       setcolor(15);
       outtextxy(x+200,y,s);
       k:=readkey;
       if (k=#77) or (k=#75) then val:=not val;
       setcolor(0);
       outtextxy(x+200,y,s);
       until (k=#27) or (k=#72) or (k=#80); {kym neda sipku dole alebo hore}
    setcolor(7);
    outtextxy(x,y,name);
    outtextxy(x+200,y,s);
    end;
{############################################################################}
    procedure nameoption(x,y:integer; sname:string; var name:string15);
    var s:string15;
    begin
    if k=onlywrite then setcolor(7) else setcolor(15);
    outtextxy(x,y,sname);
    outtextxy(x+200,y,name);
    if k=onlywrite then exit; {len vypisujeme}
    s:=name;
       repeat
       k:=readkey;
       setcolor(0);
       outtextxy(x+200,y,s);
       if k in ['a'..'z',' ','0'..'9'] then s:=s+k
       else if k=#8 {backspace} then s:=copy(s,1,length(s)-1);
       setcolor(15);
       outtextxy(x+200,y,s);
       until (k=#27) or (k=#72) or (k=#80); {kym neda sipku dole alebo hore}
    name:=s;
    setcolor(7);
    outtextxy(x,y,sname);
    outtextxy(x+200,y,name);
    end;
{############################################################################}
    procedure byteoption(x,y:integer; name:string; var val:byte);
    var s:string[3];
    begin
    if k=onlywrite then setcolor(7) else setcolor(15);
    str(val,s);
    outtextxy(x,y,name);
    outtextxy(x+200,y,s);
    if k=onlywrite then exit; {len vypisujeme}
      repeat
      str(val,s);
      setcolor(15);
      outtextxy(x+200,y,s);
      k:=readkey;
      if k=#77 then inc(val);
      if k=#75 then dec(val);
      if val<1 then val:=250;
      if val>250 then val:=1;
      setcolor(0);
      outtextxy(x+200,y,s);
      until (k=#27) or (k=#72) or (k=#80); {kym neda sipku dole alebo hore}
    setcolor(7);
    outtextxy(x,y,name);
    outtextxy(x+200,y,s);
    end;
{############################################################################}
begin
assign(f,cfgfile);
reset(f);
seek(f,0);
read(f,opt);
kreslistvorceky;
setcolor(7);
settextstyle(0,0,4);
outtextxy(580,10, 'O');
outtextxy(580,60, 'P');
outtextxy(580,110,'T');
outtextxy(580,160,'I');
outtextxy(580,210,'O');
outtextxy(580,260,'N');
outtextxy(580,310,'S');
settextstyle(0,0,1);
{############################################################################}
setcolor(7);
with opt do
begin
  {vypisujeme}
  k:=onlywrite;
  outtextxy(50,30,'GAMEPLAY:');
  nameoption(150,30,'red player`s name:',name1);
  nameoption(150,40,'green player`s name:',name2);
  byteoption(150,60,'starting hit points:',maxhp);
  booloption(150,70,'enable mines:',mineson);
  mapoption(150,80,'play map:',map);
  byteoption(150,90,'powerup lasting:',puplast);
  byteoption(150,100,'powerup waiting:',pupwait);
  byteoption(150,110,'powerup frequency:',pupfreq);
  booloption(150,120,'enable powerups:',powupson);
  outtextxy(150,140,'enable:');
  booloption(220,140,'being a wall:',allowpup[1]);
  booloption(220,150,'wall-crossing:',allowpup[2]);
  booloption(220,160,'invulnerability:',allowpup[3]);
  booloption(220,170,'shooting rockets:',allowpup[4]);
  booloption(220,180,'no enemy ammo:',allowpup[5]);
  booloption(220,190,'go out-screen:',allowpup[6]);
  booloption(220,200,'being the enemy:',allowpup[7]);
  outtextxy(50,220,'HANDICAPS:');
  outtextxy(150,220,'red player`s rules:');
  booloption(220,230,'wall-crossing:',rules[1]);
  booloption(220,240,'shooting rockets',rules[2]);
  booloption(220,250,'go out-screen:',rules[3]);
  outtextxy(150,260,'green player`s rules:');
  booloption(220,270,'wall-crossing:',rules[4]);
  booloption(220,280,'shooting rockets',rules[5]);
  booloption(220,290,'go out-screen:',rules[6]);
  outtextxy(50,310,'SYSTEM:');
  booloption(150,310,'enable sound:',soundon);
  byteoption(150,320,'screen delay:',screendelay);

{############################################################################}
volba:=3;
k:=#2;
  repeat
  case volba of
          1:nameoption(150,30,'red player`s name:',name1);
          2:nameoption(150,40,'green player`s name:',name2);
          3:byteoption(150,60,'starting hit points:',maxhp);
          4:booloption(150,70,'enable mines:',mineson);
          5:mapoption(150,80,'play map:',map);
          6:byteoption(150,90,'powerup lasting:',puplast);
          7:byteoption(150,100,'powerup waiting:',pupwait);
          8:byteoption(150,110,'powerup frequency:',pupfreq);
          9:booloption(150,120,'enable powerups:',powupson);
         10:booloption(220,140,'being a wall:',allowpup[1]);
         11:booloption(220,150,'wall-crossing:',allowpup[2]);
         12:booloption(220,160,'invulnerability:',allowpup[3]);
         13:booloption(220,170,'shooting rockets:',allowpup[4]);
         14:booloption(220,180,'no enemy ammo:',allowpup[5]);
         15:booloption(220,190,'go out-screen:',allowpup[6]);
         16:booloption(220,200,'being the enemy:',allowpup[7]);
         17:booloption(220,230,'wall-crossing:',rules[1]);
         18:booloption(220,240,'shooting rockets',rules[2]);
         19:booloption(220,250,'go out-screen:',rules[3]);
         20:booloption(220,270,'wall-crossing:',rules[4]);
         21:booloption(220,280,'shooting rockets',rules[5]);
         22:booloption(220,290,'go out-screen:',rules[6]);
         23:booloption(150,310,'enable sound:',soundon);
         24:byteoption(150,320,'screen delay:',screendelay);
       end; {of case volba}
  if k=#72 then dec(volba);
  if k=#80 then inc(volba);
  if volba<1 then volba:=24;
  if volba>24 then volba:=1;
  until k=#27; {escape}
end; {of with opt do}
seek(f,0);
write(f,opt);
close(f);
end; {of options}

procedure controls;
var f:file of tmenuoptions;
    o:tmenuoptions;
    function getkey(const name:string):byte;
      var i:byte;
      begin
      setcolor(7);
      outtextxy(100,40,name);
      clearwasdownarray;
      i:=0;
      while not wasdown[i] do
            begin
            inc(i);
            if i=128 then i:=0;
            end;
      setcolor(0);
      outtextxy(100,40,name);
      getkey:=i;
      end;

begin
kreslistvorceky;
settextstyle(0,0,1);
assign(f,cfgfile);
reset(f);
read(f,o);
initnewkeyint;
setcolor(7);
outtextxy(50,100,'if you want to use the arrow keys, configure them by using 6,8,4,2.');
setcolor(15);
outtextxy(100,20,'Please press:');

o.controls[1]:=getkey('red player    [right]');
o.controls[2]:=getkey('red player    [up]   ');
o.controls[3]:=getkey('red player    [left] ');
o.controls[4]:=getkey('red player    [down] ');
o.controls[5]:=getkey('red player    [fire] ');
o.controls[6]:=getkey('green player  [right]');
o.controls[7]:=getkey('green player  [up]   ');
o.controls[8]:=getkey('green player  [left] ');
o.controls[9]:=getkey('green player  [down] ');
o.controls[10]:=getkey('green player  [fire] ');

setoldkeyint;
seek(f,0);
write(f,o);
close(f);
end; {of controls}

procedure gamemenu(var opt:tmenuoptions);
var f:file of tmenuoptions;
begin
assign(f,cfgfile);
{$I-}
reset(f);
close(f);
{$I+}
if ioresult<>0 then
  begin
  createdefaultcfgfile;
  end;
gamestart:=false;
repeat
mainmenu;
if volba=3 then controls
else
if volba=2 then options
else
if volba=4 then help;
until gamestart;

reset(f);
read(f,opt);
close(f);
end;

begin
end.