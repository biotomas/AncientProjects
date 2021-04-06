unit bnltpu;
interface
         uses bnlmap;
         const pupnames: array[1..7] of string[20] =
              ('being a wall','wallcrossing','invulnerability','rockets',
              'no foe shots','outscreening','being the foe');
         type powerup = (none,beingwall,wallcrossing,invulnerability,rockets,
                         nofoeshots,outscreening,beingfoe);
              tbullet = record x,y:integer;
                         l:byte;
                         a:shortint;
                         r:boolean;
                        end;
             toptions = record
                         puplast,pupwait,pupfreq,maxhp:byte;
                         name1,name2:string[15];
                         rules: boolf;
                         allowpup: boolf;
                         soundon:boolean;
                        end;
         procedure destroy(x,y:integer);
         function  drawb( x,y:integer; angle,pl:shortint):boolean;
         procedure move(dir:boolean; spd:byte; angle:integer; var x,y:integer);
         procedure shots;
         procedure addshot(player:byte; x,y:integer; a:shortint);
         function  sinus( uhel:integer):real;
         procedure initvals;
         function  cosinus( uhel:integer):real;
         procedure showscore(const hscore1,hscore2:byte);
         procedure mimotest(x1,y1,x2,y2:integer);
         function  getkills:shortint;
         procedure powerupsprocedure;
         procedure setoptions(o:toptions);

implementation
uses graph, crt, dos;
var  b:array[0..30] of tbullet;
     powups:array[1..2] of powerup;
     rules:array[1..6] of boolean; {1:wallcross 2:rocket 3:outscr, 4,5,6 for pl2}
     allowpup: boolf; {tento typ je definovany v bnlmap.tpu}
     osec1,osec2,score1,score2:word;
     ps,s: string[3];
     powup:byte;
     puplast, pupfreq, pupwait, osc,time:byte;
     maxhp:byte;
     soundon:boolean;
     playername1, playername2:string[15];
{#####################################################################}
function updatetime:word; {zvysuje premennu time po sekundach}
var h,m,s,c:word;
begin
 gettime(h,m,s,c);
 if s <> osc then
 begin
    inc(time);
    osc:=s;
 end;
end;

function cosinus( uhel:integer):real;
begin {pocita kosinus z argumentu uhel, kde 100 je 180 stupnov (=pi)}
cosinus:=cos(pi/100*uhel)
end;

function sinus( uhel:integer):real;
begin {pocita sinus z argumentu uhel, kde 100 je 180 stupnov (=pi)}
sinus:=sin(pi/100*uhel)
end;

procedure setoptions(o:toptions);
var i:byte;
begin
puplast:=o.puplast;
pupwait:=o.pupwait;
pupfreq:=o.pupfreq;
maxhp:=o.maxhp;
playername1:=o.name1;
playername2:=o.name2;
for i:=1 to 6 do
  rules[i]:=o.rules[i];
allowpup:=o.allowpup;
soundon:=o.soundon;
end;


procedure move(dir:boolean; spd:byte; angle:integer; var x,y:integer);
begin
if dir then
  begin
    x:=x+round(spd*cosinus(angle));
    y:=y+round(spd*sinus(angle));
  end else
  begin
    x:=x-round(spd*cosinus(angle));
    y:=y-round(spd*sinus(angle));
  end;
end;

function drawb(x,y:integer; angle,pl:shortint):boolean;
var col:byte;
    x1,y1,x2,y2,x3,y3,x4,y4,x5,y5:integer; {4 vrcholy tanku + kanon}

    function crashtest:boolean;
    var b:boolean;             {test some crash points}
    begin
      b:=false;
      if getpixel(x,y) = 5 then b:=true
      else
      if getpixel(x1,y1) = 5 then b:=true
      else
      if getpixel(x2,y2) = 5 then b:=true
      else
      if getpixel(x3,y3) = 5 then b:=true
      else
      if getpixel(x4,y4) = 5 then b:=true
      else
      if getpixel(x5,y5) = 5 then b:=true;
      crashtest:=b;
    end;

begin
  if pl=1 then col:=red else col:=green;

  if powups[1]=beingfoe then col:=green
  else if powups[2]=beingfoe then col:=red;
  if powups[pl]=beingwall then col:=5;
  if powups[pl]=invulnerability then col:=15;
  setcolor(col);
    setlinestyle(0,0,1);

  x1:=x+round(15*cosinus(angle-25));
  y1:=y+round(10*sinus(angle-25));
  x2:=x+round(15*cosinus(angle+25));
  y2:=y+round(10*sinus(angle+25));
  x3:=x+round(15*cosinus(angle+80));
  y3:=y+round(10*sinus(angle+80));
  x4:=x+round(15*cosinus(angle-80));
  y4:=y+round(10*sinus(angle-80));
  x5:=x+round(15*cosinus(angle));
  y5:=y+round(15*sinus(angle));

  if (powups[pl]=wallcrossing) or (rules[3*pl-2]) then drawb:=false
     {ma povolene chodit cez stenu}
  else
  if crashtest then drawb:=true
  else drawb:=false;

    moveto(x1,y1);
    lineto(x2,y2);
    lineto(x3,y3);
    lineto(x4,y4);
    lineto(x1,y1);

    setfillstyle(1,col);

    floodfill(x,y,col);
    moveto(x5,y5);
      setcolor(15);
    if (powups[pl]=rockets) or (rules[3*pl-1]) then setcolor(14);
    lineto(x,y);
end;

procedure destroy(x,y:integer);
var
    p:array[1..30] of tbullet;
    j,i:byte;
begin
randomize;
for i:=1 to 20 do
  begin
   p[i].x:=x;
   p[i].y:=y;
   p[i].a:=i*10-100;
   p[i].l:=random(5)+1;
  end;

for j:=1 to 8 do
begin
  for i:=1 to 20 do
    begin
     move(true,p[i].l,p[i].a,p[i].x,p[i].y);
     putpixel(p[i].x,p[i].y,14);
    end;
     delay(10);
end;
end;

procedure addshot(player:byte; x,y:integer; a:shortint);
var i:byte;
begin
  if powups[3-player]=nofoeshots then exit;
  if player=1 then i:=1 else i:=0;
  while (b[i].l > 0) and (i<29) do inc(i,2);
  if i < 29 then
    begin
      b[i].l:=255;
      b[i].x:=x+round(15*cosinus(a));
      b[i].y:=y+round(15*sinus(a));
      b[i].a:=a;
      if (powups[player]=rockets) or (rules[3*player-1]) then b[i].r:=true
      else b[i].r:=false;
    end;
end;

procedure shots;
var pix,i:byte;
    put: array[1..30] of boolean;
begin
nosound;
for i:=1 to 30 do
begin
  put[i]:=false;
  if b[i].l > 0 then
  begin
    dec(b[i].l);
    b[i].x:=b[i].x+round(5*cosinus(b[i].a));
    b[i].y:=b[i].y+round(5*sinus(b[i].a));
    if (b[i].x > 700) or (b[i].x < -60) or (b[i].y >400) then b[i].l:=0
    else
    begin
    pix:=getpixel(b[i].x,b[i].y);
      if pix <> 0 then
        begin
          if (pix=green) or (pix=red)
          then
              begin
                if soundon then sound(300);
                b[i].l:=0;
                if (pix=green) then inc(score1)
                else inc(score2);
              end
          else
              if b[i].r=false then
              begin
                if (getpixel(b[i].x,b[i].y+7) = 5) or (getpixel(b[i].x,b[i].y-7) = 5)
                then     if (b[i].a) < 0 then
                         b[i].a:=(-100-b[i].a)
                         else b[i].a:=(100-b[i].a)
                else
                if (getpixel(b[i].x-7,b[i].y) = 5) or (getpixel(b[i].x+7,b[i].y) = 5)
                then b[i].a:=-b[i].a;
              if b[i].a > 100 then dec(b[i].a,200);
              end;
        end
        else put[i]:=true;
     end;
   end;
end; {of for}
for i:=1 to 30 do
  if put[i] then putpixel(b[i].x,b[i].y,15-ord(b[i].r));
end; {ze preco 15-ord(...)? aby rakety boli zltou :}


procedure showscore(const hscore1,hscore2:byte);
begin
setcolor(7);
str(maxhp-score2,s);
outtextxy(20,30,playername1+'s hit points: '+s);
str(maxhp-score1,s);
outtextxy(380,30,playername2+'s hit points: '+s);
str(hscore1:3,s);
outtextxy(288,30,s+' :');
str(hscore2,s);
outtextxy(328,30,s);
end;

procedure mimotest(x1,y1,x2,y2:integer); {zde testujeme jestli hraci nejsou mimo mapy a kdyz ano}
var h,m,sec,c:word; {tak jim za kazdou vterinu odebereme 1 zivot           }
begin
if (x1<0) or (x1>640) or (y1<0) or (y1>350) then
   if (powups[1]=outscreening) or (rules[3]) then {nic}
   else
   begin
   gettime(h,m,sec,c);
   if sec<>osec1 then
     begin
     inc(score2);
     osec1:=sec;
     end
   end;
if (x2<0) or (x2>640) or (y2<0) or (y2>350) then
   if (powups[2]=outscreening) or (rules[6]) then {nic}
   else
   begin
   gettime(h,m,sec,c);
   if sec<>osec2 then
     begin
     inc(score1);
     osec2:=sec;
     end
   end;
end;

function getkills:shortint;
var gmk:byte;
    gk:shortint;
begin
gmk:=getminekills;
if gmk > 0 then gk:=gmk
else
if score1 = maxhp then gk:=2
else
if score2 = maxhp then gk:=1
else
if score1 > score2 then gk:=-2
else
if score1 <= score2 then gk:=-1;
getkills:=gk;
end;

procedure initvals;
var i:byte;
begin
score1:=0;
score2:=0;
powups[1]:=none;
powups[2]:=none;
time:=0;
for i:=1 to 30 do b[i].l:=0;

end;

procedure powerupsprocedure;
var pix:byte;
begin
  if (powups[1]<>none) or (powups[2]<>none) then
  begin {niekto ma nejaky power up}
    if time < puplast then
    begin
       updatetime;
       str((puplast-time),ps);
       if powups[1]<>none then
         outtextxy(20,20,pupnames[ord(powups[1])]+': '+ps)
       else
         outtextxy(400,20,pupnames[ord(powups[2])]+': '+ps);
    end
    else {dosiel power up}
    begin
      powups[1]:=none;
      powups[2]:=none;
      time:=0;
    end;
  end
  else  {nikto nema power up}
  if time < pupfreq then updatetime
  else  {preslo pupfreq sekund objavi sa novy powerup na 7 sekund}
  begin
     if time=pupfreq then
     begin
       powup:=random(7)+1;
       repeat
       if allowpup[powup] then {nic} else inc(powup);
       if powup>7 then powup:=1;
       until (allowpup[powup]);

       inc(time); {aby toto bolo len jedenkrat}
       case powup of 1: ps:='w';
                     2: ps:='c';
                     3: ps:='I';
                     4: ps:='r';
                     5: ps:='n';
                     6: ps:='o';
                     7: ps:='b';
                     end;
     end;
     if time < pupfreq+1+pupwait then
     begin
       updatetime;
       setcolor(3);
       circle(320,175,8);
       pix:=getpixel(320,175);
       outtextxy(317,171,ps);
       if pix=green then
       begin
         powups[2]:=powerup(powup);
         time:=0;
       end
       else
       if pix=red then
       begin
         powups[1]:=powerup(powup);
         time:=0;
       end;
     end
     else time:=0;
  end;
end;

begin
end.