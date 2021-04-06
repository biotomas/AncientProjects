uses crt,graph;
var d,i,gd,gm,x,u:integer;
    xp,r:real;
begin
initgraph(gd,gm,'c:\tp7\bgi');
cleardevice;
line(0,470,639,470);
d:=2;
x:=80;
xp:=80;
u:=0;
r:=2*pi*70/180;
repeat
cleardevice;
line(0,470,639,470);
line(630,400,630,470);
line(10,400,10,470);
circle(x,400,70);
for i:=1 to 12 do
begin
line(x,400,x+round(70*cos(pi/180*(u+i*30))),400+round(70*sin(pi/180*(u+i*30))));
end;
u:=u+d*2;
if u>=360 then u:=0;
xp:=xp+d*r;
x:=round(xp);
if (x>557) or (x<83) then d:=-d;
delay(5);
until keypressed;
closegraph;
end.