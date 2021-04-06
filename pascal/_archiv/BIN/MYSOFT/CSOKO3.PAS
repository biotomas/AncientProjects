program csoko;
uses crt,graph;
var gd,gm,x,y,x1,x2,x3,x4,y1,y2,y3,y4 : integer;

procedure kresli;
begin
setfillstyle(1,4); setcolor(4); x:=x1; y:=y1;  circle(x,y,3); floodfill(x,y,4);
setfillstyle(1,5); setcolor(5); x:=x2; y:=y2;  circle(x,y,3); floodfill(x,y,5);
setfillstyle(1,6); setcolor(6); x:=x3; y:=y3;  circle(x,y,3); floodfill(x,y,6);
setfillstyle(1,7); setcolor(7); x:=x4; y:=y4;  circle(x,y,3); floodfill(x,y,7);
end;

begin
  gd:=detect;
  initgraph(gd,gm,'c:\windows\system');
  if graphresult<>grok then halt;
rectangle(270,170,370,270);
x1:=270;
y1:=270;
x2:=370;
y2:=270;
x3:=370;
y3:=170;
x4:=270;
y4:=170;

kresli;
  readkey;
  repeat
   x1:=x1+1;
   x2:=x2+1;
   x3:=x3+1;
   x4:=x4+1;
   kresli;
   delay(200);
   until x2=450;
{  until (x1=x2) and (x2=x3) and(x3=x4);}
readkey;
  closegraph;
end.
