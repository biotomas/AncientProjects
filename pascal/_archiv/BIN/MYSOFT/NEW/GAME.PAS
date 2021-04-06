uses crt, graph;
var a,b,x,y,nx,ny:integer;
         k:char;
       crash:boolean;
procedure crashtest;
begin
if
(getpixel(nx-21,ny)<>0) or
(getpixel(nx+21,ny)<>0) or
(getpixel(nx,ny+28)<>0) or
(getpixel(nx,ny-28)<>0) then crash:=true;
if
(getpixel(nx-21,ny)=0) and
(getpixel(nx+21,ny)=0) and
(getpixel(nx,ny+21)=0) and
(getpixel(nx,ny-27)=0) then crash:=false;
end;

procedure hero;
begin
{setcolor(12);}
circle(x,y,15);
circle(x,y-19,7);
line(x+3,y+3,x+3,y+20);
line(x+3,y+3,x+20,y+20);
line(x+3,y+20,x+20,y+20);
line(x-3,y+3,x-3,y+20);
line(x-3,y+3,x-20,y+20);
line(x-3,y+20,x-20,y+20);
putpixel(x,y,12);
end;

procedure clhero;
begin
setcolor(0);
circle(x,y,15);
circle(x,y-19,7);
line(x+3,y+3,x+3,y+20);
line(x+3,y+3,x+20,y+20);
line(x+3,y+20,x+20,y+20);
line(x-3,y+3,x-3,y+20);
line(x-3,y+3,x-20,y+20);
line(x-3,y+20,x-20,y+20);
end;


begin
initgraph(a,b,'c:\tp7\bgi');
x:=240;
y:=240;
nx:=240;
ny:=240;
setcolor(5);
rectangle(10,10,100,100);
floodfill(12,12,5);
setcolor(12);
repeat
hero;
k:=readkey;
case ord(k) of 75: nx:=nx-30;
               77: nx:=nx+30;
               72: ny:=ny-30;
               80: ny:=ny+30;
               end;
  crashtest;
clhero;
if crash=true then setcolor(9) else setcolor(12);
x:=nx;
y:=ny;
until ord(k)=27;
closegraph;
end.