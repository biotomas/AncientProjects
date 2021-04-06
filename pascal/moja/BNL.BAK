{zaciatok babky na lade 13.10.2005 praha 00:18}
{koniec   BNL verzia 1  17.12.2005 praha 00:31}

uses graph,crt,games,bnltpu,bnlmap,dos,bnlmenu;

const front=true;
      back=false;

var gd,gm:integer;
    scr:boolean;
    i,x1,y1,x2,y2,oldx1,oldx2,oldy2,oldy1:integer;
    angle1,angle2,oldang1,oldang2,erc:integer;
    sdelay : word;
    options : toptions;
    moptions : tmenuoptions;
    hs1,hs2,map: byte;
    s:string[15];
    k:char;
    key:array[1..10] of byte;

procedure screen; {vymiena obrazovky pre plynulejsie animacie}
begin
setactivepage(ord(scr));
scr:=not scr;
setvisualpage(ord(scr));
delay(sdelay);
cleardevice;
end;

begin
randomize;
gd:=3;
gm:=1;
initgraph(gd,gm,'c:\tp\bgi');
map:=1;
hs1:=0;
hs2:=0;
k:=#27;

repeat {Hlavny cyklus}
   if k=#27 then gamemenu(moptions);
   initnewkeyint;
   initmines;

   options.maxhp:=moptions.maxhp;
   options.name1:=moptions.name1;
   options.name2:=moptions.name2;
   options.puplast:=moptions.puplast;
   options.pupwait:=moptions.pupwait;
   options.pupfreq:=moptions.pupfreq;
   options.soundon:=moptions.soundon;
   options.rules:=moptions.rules;
   options.allowpup:=moptions.allowpup;

with moptions do if (allowpup[1] or allowpup[2] or allowpup[3] or allowpup[4]
                     or allowpup[5] or allowpup[6] or allowpup[7])
                    then {nic} else powupson:=false;
         {keby nahodou vypol vsetky powerupy ale ich nezakazal}

   for i:=1 to 10 do key[i]:=moptions.controls[i];

   setoptions(options);
   sdelay:=moptions.screendelay;
   initvals;
   x1:=30;
   y1:=170;
   x2:=610;
   y2:=170;
   setkills;

   if moptions.map > 0 then map:=moptions.map
     else if moptions.map = 0 then inc(map)
     else if moptions.map =-1 then map:=random(numberofmaps)+1;
   if map > numberofmaps then map:=1;
   settextstyle(0,0,1);
{###########################################################################}
{###########################################################################}
{###########################################################################}
   repeat {herny cyklus}
      screen;
      drawmap(map);
      if drawb(x1,y1,angle1,1)   then
      begin
         x1:=oldx1;
         y1:=oldy1;
         angle1:=oldang1;
      end;

      if drawb(x2,y2,angle2,2) then
      begin
         x2:=oldx2;
         y2:=oldy2;
         angle2:=oldang2;
      end;

      if moptions.mineson then mines(map);

      if wasdown[key[5]] then
      begin
         addshot(1,x1,y1,angle1);
         clearwasdownarray;
      end;
      if wasdown[key[10]] then
      begin
         addshot(2,x2,y2,angle2);
         clearwasdownarray;
      end;

      shots;
      showscore(hs1,hs2);
      mimotest(x1,y1,x2,y2);
      if moptions.powupson then powerupsprocedure;

      oldx1:=x1;
      oldx2:=x2;
      oldy1:=y1;
      oldy2:=y2;
      oldang1:=angle1;
      oldang2:=angle2;

      if keydown[key[3]] then dec(angle1,3);
      if keydown[key[1]] then inc(angle1,3);
      if keydown[key[2]] then move(front,3,angle1,x1,y1);
      if keydown[key[4]] then move(back,2,angle1,x1,y1);

      if keydown[key[8]] then dec(angle2,3);
      if keydown[key[6]] then inc(angle2,3);
      if keydown[key[7]] then move(front,3,angle2,x2,y2);
      if keydown[key[9]] then move(back,2,angle2,x2,y2);

      if angle1 > 100 then angle1:=-99;
      if angle1 < -99 then angle1:=100;
      if angle2 > 100 then angle2:=-99;
      if angle2 < -99 then angle2:=100;

   until (wasdown[escscan]) or (getkills>0);

   clearwasdownarray;
   setoldkeyint;
   nosound;
   setvisualpage(0);
   setactivepage(0);
   if abs(getkills)=1 then
     begin
     destroy(x1,y1);
     s:=options.name2;
     inc(hs2);
     end
   else
   if abs(getkills)=2 then
     begin
     destroy(x2,y2);
     s:=options.name1;
     inc(hs1);
     end;

   outtextxy(200,10,'The winner is '+s+'. ');
   repeat
   k:=readkey;
   until (k=#32) or (k=#27);
until false; {naveky vekov, ved kto by chcel prestat hrat takuto
              vybornu hru (vychadza sa cez menu -> exit)}
end.