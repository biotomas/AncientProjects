uses graph, crt;
var c,x,y,a,b,s,x1,y1,s1:integer;
    k:char;
    sc:string;
begin
c:=0;
s:=1;
s1:=2;
initgraph(a,b,'c:\tp7\bgi\');
cleardevice;
setcolor(8);
x:=320;
y:=240;
setcolor(4);
setlinestyle(0,3,3);
rectangle(5,5,585,475);

repeat
moveto(x,y);
if keypressed then begin
   k:=readkey;
   delay(1);
   case ord(k) of 110: s:=s+1;
                  109: s:=s-1;
                  end;
   end;

x:=x+round(3*sin(pi/18*s));
y:=y+round(3*cos(pi/18*s));
setcolor(4);
lineto(x,y);
c:=c+1;
str(c,sc);
setcolor(15);
outtextxy(590,10,sc);
delay(200);
setcolor(0);
outtextxy(590,10,sc);

until ord(k)=32;
closegraph;
end.