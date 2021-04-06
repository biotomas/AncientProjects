uses crt,graph,games;
const maxAI=10;
type velkepole=array[1..20,1..20] of shortint;
type creat=array [1..6] of byte; {12:xy , 3:hp, 4:typ, 5:visible, 6:exist}
var i,j,koniec,tah:byte;
    gd,gm:integer;
    scr:boolean;
    mapa,vidmapa,mvm:velkepole;
    kzposun,posun:array[1..2] of shortint;
    hero:array[1..4] of byte; {12:xy , 3:hp, 4:zbran}
    ai:array[1..maxAI] of creat;
    vidai:array[0..maxAI] of byte;
    q:char;

procedure mriezka;
var i,j:byte;
begin
for i:=0 to 20 do line(120+i*20,40,120+i*20,440);
for i:=0 to 20 do line(120,40+i*20,520,40+i*20);
end;

procedure ziskajmapu(subor:string);
var i,j:byte;
    udaj:shortint;
    map:text;
begin
assign(map,subor);
reset(map);
for i:=1 to 20 do
    for j:=1 to 20 do begin
                      readln(map,udaj);
                      mapa[i,j]:=udaj;
                      end;
close(map);
end;

procedure farbi(a,b,styl:integer;farba:word);
var dlaz:byte;
begin
dlaz:=styl div 10;
styl:=styl mod 10;
setfillstyle(styl,farba);
bar(101+a*20-dlaz,21+b*20-dlaz,119+a*20+dlaz,39+b*20+dlaz);
end;

procedure kreslimapu;
var i,j:byte;
begin
for i:=1 to 20 do
    for j:=1 to 20 do
        if vidmapa[i,j]=1 then
           if mvm[i,j]=1 then
              if mapa[i,j]=-2 then farbi(i,j,16,9)
              else farbi(i,j,1,white)
           else
              if mapa[i,j]=-2 then farbi(i,j,16,9)
              else farbi(i,j,1,lightgray);
end;
procedure zistimvm;
var a,b:shortint;
begin
for a:=1 to 20 do
    for b:=1 to 20 do
        mvm[a,b]:=0;
for a:=-1 to 1 do
    for b:=-1 to 1 do
        mvm[hero[1]+a,hero[2]+b]:=1;
a:=hero[1];b:=1;              {!!!!!!!!!hod to do jednej procedury!!!!!!!!!!}
     repeat
     inc(a);inc(b);
     mvm[a,hero[2]]:=1;
     until (mapa[a,hero[2]]=-2) or (b=3);
a:=hero[1];b:=1;
     repeat
     dec(a);inc(b);
     mvm[a,hero[2]]:=1;
     until (mapa[a,hero[2]]=-2) or (b=3);
a:=hero[2];b:=1;
     repeat
     inc(a);inc(b);
     mvm[hero[1],a]:=1;
     until (mapa[hero[1],a]=-2) or (b=3);
a:=hero[2];b:=1;
     repeat
     dec(a);inc(b);
     mvm[hero[1],a]:=1;
     until (mapa[hero[1],a]=-2) or (b=3);
end;

procedure zistividmapu;
var a,b:shortint;
begin
zistimvm;
for a:=1 to 20 do
    for b:=1 to 20 do
        if mvm[a,b]=1 then vidmapa[a,b]:=1;
end;

procedure zistividai;
var i,j:byte;
begin
j:=0;
for i:=1 to maxAI do
    if mvm[ai[i][1],ai[i][2]]=1 then begin
                                     inc(j);
                                     vidai[j]:=i;
                                     end;
vidai[0]:=j;
end;

procedure vykresliai;
var i,j,k,a:byte;
    sub:text;
    prechod:array[1..20,1..20] of byte;
begin
zistividai;
assign(sub,'obr2.pas');
reset(sub);
for i:=1 to 20 do
    for j:=1 to 20 do read(sub,prechod[i,j]);
close(sub);
for k:=1 to vidai[0] do
    for i:=1 to 20 do
        for j:=1 to 20 do if prechod[i,j]<>0 then putpixel(100+i+ai[vidai[k]][1]*20,20+j+ai[vidai[k]][2]*20,a);
end;

procedure vypis(veta:string);  {tiez trochu divne}
begin
settextstyle(1,HorizDir,1);
outtextxy(300,20,veta);
end;

procedure vypistah(a:byte);  {oprav....chara}
var pocet:string;
    i:byte;
begin
pocet:='';
for i:=1 to a do pocet:=pocet+'I';
vypis(pocet);
end;

procedure vymazhlasku;   {to zvaz este}
begin
setfillstyle(1,black);
bar(120,10,520,35);
end;

procedure nulujAI;
var i:byte;
begin
for i:=1 to maxAI do ai[i][6]:=0;
end;

procedure herokresli(x,y:integer);
var i,j,a:integer;
    sub:text;
begin
assign(sub,'obr1.pas');
reset(sub);
for i:=1 to 20 do
    for j:=1 to 20 do begin
                      read(sub,a);
                      if a<>0 then putpixel(100+i+x*20,19+j+y*20,a);
                      end;
close(sub);
end;
procedure vytvorhera;
begin
hero[1]:=11;hero[2]:=19;hero[3]:=40;hero[4]:=1;
end;

function posunul:boolean;
begin
if (posun[1]=0) and (posun[2]=0) then posunul:=false
                                 else posunul:=true;
end;

function moze:boolean;
begin
if mapa[hero[1]+posun[1],hero[2]+posun[2]] = -2 then moze:=false
else if(hero[1]+posun[1]>20) or (hero[1]+posun[1]<1) or
       (hero[2]+posun[2]>20) or (hero[2]+posun[2]<1)
                                                then moze:=false
                                                else moze:=true;
end;


begin
initgraph(gd,gm,'c:\tp\bgi');
setrgbpalette(3,200,94,100);
setrgbpalette(2,217,44,48);
{mriezka;}
for i:=1 to 20 do
    for j:=1 to 20 do vidmapa[i,j]:=0;
ziskajmapu('map1.pas');
kreslimapu;
nulujAI;
vytvorhera;
herokresli(hero[1],hero[2]);
ai[1][6]:=1;
ai[1][1]:=10;
ai[1][2]:=16;
ai[1][3]:=1;
ai[1][4]:=1;
repeat
tah:=3;
posun[1]:=0;posun[2]:=0;
vypistah(3);
repeat
vymazhlasku;
vypistah(tah);
q:=readkey;
case ord(q) of
75:begin posun[1]:=-1; posun[2]:=0; end;
77:begin posun[1]:= 1; posun[2]:=0; end;
72:begin posun[1]:=0; posun[2]:=-1; end;
80:begin posun[1]:=0; posun[2]:= 1; end;
end;
if moze then else begin
                  posun[1]:=0;
                  posun[2]:=0;
                  end;
if posunul then
   begin
   farbi(hero[1],hero[2],1,white);
   hero[1]:=hero[1]+posun[1];
   hero[2]:=hero[2]+posun[2];
   zistividmapu;
   kreslimapu;
   vykresliai;
   herokresli(hero[1],hero[2]);
   dec(tah);
   posun[1]:=0;posun[2]:=0;
   end;

until (tah=0) or (ord(q)=27);



until (koniec=1) or (ord(q)=27);
closegraph;
end.