program zz;

uses graph,crt,games;

const v=10;
      posun=5;

type player=record
                  name:string[20];
                  x,y:integer;
                  health,ort,col1,col2:byte;
                  end;

var p1:player;
    scr:byte;
    k:char;
    gd,gm,x,y,i,j:integer;

procedure zaciatok;
begin
initnewkeyint;
gd:=3; gm:=1;
initgraph(gd,gm,'c:\tp\bgi');
end;

procedure koniec;
begin
closegraph;
setoldkeyint;
end;

procedure screen;
begin
setactivepage(scr);
scr:=1-scr;
setvisualpage(scr);
delay(20);
cleardevice;
end;

procedure hrac(s1,s2:integer; f1,f2,smer:byte);
var a,b,c,d:integer;
begin
setcolor(f1);
case smer of
0: begin
        rectangle(s1-5,s2,s1-7,s2-8);
        rectangle(s1+5,s2,s1+7,s2-8);
   end;
1: begin
        rectangle(s1,s2-5,s1+8,s2-7);
        rectangle(s1,s2+5,s1+8,s2+7);
   end;
2: begin
        rectangle(s1-5,s2,s1-7,s2+8);
        rectangle(s1+5,s2,s1+7,s2+8);
   end;
3: begin
        rectangle(s1,s2-5,s1-8,s2-7);
        rectangle(s1,s2+5,s1-8,s2+7);
   end;
4: begin
   line(s1-3,s2-3,s1-5,s2-5);
   line(s1+3,s2+3,s1+5,s2+5);
   line(s1-3,s2-3,s1+2,s2-7);
   line(s1+3,s2+3,s1+7,s2-2);
   line(s1-5,s2-5,s1,s2-10);
   line(s1+5,s2+5,s1+10,s2);
   line(s1+2,s2-7,s1,s2-10);
   line(s1+7,s2-2,s1+10,s2);
   end;
5: begin
   line(s1+3,s2-3,s1+5,s2-5);
   line(s1-3,s2+3,s1-5,s2+5);
   line(s1+3,s2-3,s1+7,s2+2);
   line(s1-3,s2+3,s1+2,s2+7);
   line(s1+5,s2-5,s1+10,s2);
   line(s1-5,s2+5,s1,s2+10);
   line(s1+7,s2+2,s1+10,s2);
   line(s1+2,s2+7,s1,s2+10);
   end;
6: begin
   line(s1-3,s2-3,s1-5,s2-5);
   line(s1+3,s2+3,s1+5,s2+5);
   line(s1-3,s2-3,s1-7,s2+2);
   line(s1+3,s2+3,s1-2,s2+7);
   line(s1-5,s2-5,s1-10,s2);
   line(s1+5,s2+5,s1,s2+10);
   line(s1-7,s2+2,s1-10,s2);
   line(s1-2,s2+7,s1,s2+10);
   end;
7: begin
   line(s1+3,s2-3,s1+5,s2-5);
   line(s1-3,s2+3,s1-5,s2+5);
   line(s1+3,s2-3,s1-2,s2-7);
   line(s1-3,s2+3,s1-7,s2-2);
   line(s1+5,s2-5,s1,s2-10);
   line(s1-5,s2+5,s1-10,s2);
   line(s1-2,s2-7,s1,s2-10);
   line(s1-7,s2-2,s1-10,s2);
   end;
end;
if smer<4 then
begin
 rectangle(s1-5,s2-5,s1+5,s2+5);
 setfillstyle(1,f1);
 floodfill(s1,s2,f1);
 setfillstyle(1,f2);
 setcolor(f2);
 rectangle(s1-2,s2-2,s1+2,s2+2);
 floodfill(s1,s2,f2);
end else
begin
 line(s1-6,s2,s1,s2-6);
 line(s1+6,s2,s1,s2-6);
 line(s1-6,s2,s1,s2+6);
 line(s1+6,s2,s1,s2+6);
 setfillstyle(1,f1);
 floodfill(s1,s2,f1);
 setfillstyle(1,f2);
 setcolor(f2);
 line(s1-3,s2,s1,s2-3);
 line(s1+3,s2,s1,s2-3);
 line(s1-3,s2,s1,s2+3);
 line(s1+3,s2,s1,s2+3);
 floodfill(s1,s2,f2);
end;


end;

begin
zaciatok;
p1.x:=100; p1.y:=100;
p1.ort:=1;
p1.col1:=4;
p1.col2:=1;
j:=100; i:=90;
scr:=1;
repeat
   if keydown[upscan] then begin p1.ort:=0; dec(p1.y,posun); end;
   if keydown[downscan] then begin p1.ort:=2; inc(p1.y,posun); end;
   if keydown[leftscan] then begin p1.ort:=3; dec(p1.x,posun); end;
   if keydown[rightscan] then begin p1.ort:=1; inc(p1.x,posun); end;
   if (keydown[upscan]) and (keydown[rightscan]) then p1.ort:=4;
   if (keydown[downscan]) and (keydown[rightscan]) then p1.ort:=5;
   if (keydown[downscan]) and (keydown[leftscan]) then p1.ort:=6;
   if (keydown[upscan]) and (keydown[leftscan]) then p1.ort:=7;

   screen;
   hrac(p1.x,p1.y,p1.col1,p1.col2,p1.ort);
until keydown[escscan];
koniec;
end.