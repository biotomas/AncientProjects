uses graph,crt;
var i,r,a,b,col,cont:integer;
    alf2,alf:real;
begin
initgraph(a,b,'c:\tp7\bgi');
alf:=0;
cont:=0;
r:=230;  {radius}
setcolor(8);
circle(320,240,231);
circle(320,240,232);
circle(320,240,233);
{setfillstyle(1,8);
floodfill(1,1,8);}
repeat
col:=random(15)+1;
setcolor(col);
line(320,240,(320+round(r*(cos(pi/180*alf)))),(240+round(r*(sin(pi/180*alf)))));
line(320,240,(320+round(r*(cos(pi/180*(alf+120))))),(240+round(r*(sin(pi/180*(alf+120))))));
line(320,240,(320+round(r*(cos(pi/180*(alf+240))))),(240+round(r*(sin(pi/180*(alf+240))))));
if cont>100 then
   BEGIN
    alf2:=alf-45;
    setcolor(0);
line(320,240,(320+round(r*(cos(pi/180*alf2)))),(240+round(r*(sin(pi/180*alf2)))));
line(320,240,(320+round(r*(cos(pi/180*(alf2+120))))),(240+round(r*(sin(pi/180*(alf2+120))))));
line(320,240,(320+round(r*(cos(pi/180*(alf2+240))))),(240+round(r*(sin(pi/180*(alf2+240))))));
    cont:=101;
   end;
cont:=cont+1;
alf:=alf+0.5;
if alf=360 then alf:=0;
{delay(5);}
until keypressed;
closegraph;
end.