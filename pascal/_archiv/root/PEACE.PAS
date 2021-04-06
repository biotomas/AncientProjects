uses crt,graph;
var s,uu,d,i,gd,gm,x,y,u:integer;
    rx,ry,xp,yp,r:real;
    st:string;
    k:char;
procedure nov1;
 begin
  u:=180-u;
     xp:=cos(pi/180*u);
     yp:=sin(pi/180*u);
  u:=(360+u) mod 360;
 end;
procedure nov2;
 begin
  u:=360-u;
     xp:=cos(pi/180*u);
     yp:=sin(pi/180*u);
  u:=(360+u) mod 360;
 end;

begin
randomize;
initgraph(gd,gm,'c:\tp7\bgi');
cleardevice;
line(0,470,639,470);
s:=5;
d:=2;
rx:=300;
ry:=280;
u:=random(360);
r:=2*pi*70/180;
repeat
cleardevice;
str(u,st);
outtextxy(5,5,st);
circle(x,y,70);
line(x,y,x+round(70*cos(pi/180*(uu+0))),y+round(70*sin(pi/180*(uu))));
line(x,y,x+round(70*cos(pi/180*(uu+180))),y+round(70*sin(pi/180*(uu+180))));
line(x,y,x+round(70*cos(pi/180*(uu+45))),y+round(70*sin(pi/180*(uu+45))));
line(x,y,x+round(70*cos(pi/180*(uu-45))),y+round(70*sin(pi/180*(uu-45))));
uu:=uu+d*2;
if uu>=360 then uu:=0;
     if (x>560) or (x<80) then nov1;
     if (y>400) or (y<80) then nov2;

     rx:=rx+s*xp;
     ry:=ry+s*yp;
x:=round(rx);
y:=round(ry);
delay(7);
until keypressed;
closegraph;
end.