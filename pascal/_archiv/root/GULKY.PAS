uses graph,crt;
type pelo=array[1..50] of integer;
var  u,s:pelo;
     x,y,xp,yp:array[1..50] of real;
     scr,m,max,may,gd,gm,i:integer;
procedure nov1;
 begin
  u[i]:=180-u[i];
     xp[i]:=cos(pi/180*u[i]);
     yp[i]:=sin(pi/180*u[i]);
 end;
procedure nov2;
 begin
  u[i]:=360-u[i];
     xp[i]:=cos(pi/180*u[i]);
     yp[i]:=sin(pi/180*u[i]);
 end;
procedure screen;
begin
setactivepage(scr);
scr:=1-scr;
setvisualpage(scr);
delay(25);
end;

begin
scr:=1;
m:=7;
randomize;
gd:=3;
gm:=2;
initgraph(gd,gm,'c:\tp7\bgi');
max:=getmaxx;
may:=getmaxy;
outtextxy(200,100,'Loading...');
for i:=1 to m do
    begin
     x[i]:=random(max);
     y[i]:=random(may);
     u[i]:=random(360)+1;
     xp[i]:=cos(pi/180*u[i]);
     yp[i]:=sin(pi/180*u[i]);
     s[i]:=7*random(6)+10;
    end;
delay(300);

repeat
cleardevice;
for i:=1 to m do fillellipse(round(x[i]),round(y[i]),3,3);
for i:=1 to m do
    begin
     if (x[i]>max) or (x[i]<0) then nov1;
     if (y[i]>may) or (y[i]<0) then nov2;

     x[i]:=x[i]+s[i]*xp[i];
     y[i]:=y[i]+s[i]*yp[i];
    end;

until keypressed;
closegraph;
end.