uses graph,crt;
var x,y,u,a,b,i: integer;

begin
initgraph(a,b,'c:\tp7\bgi');
x:=300;
y:=200;
u:=249;
readkey;
repeat
{setcolor(0);
circle(x,y,3);
circle(x,y,1);
circle(x,y,2);              }
x:=x+round(3*cos(pi/180*u));
y:=y+round(3*sin(pi/180*u));
if (x<0) or (x>640) then u:=180-u;
if (y<0) or (y>480) then u:=360-u;

setcolor(5);
putpixel(x,y,8);
{circle(x,y,3);
circle(x,y,1);
circle(x,y,2);}
{delay(1);}
until keypressed;
closegraph;
end.