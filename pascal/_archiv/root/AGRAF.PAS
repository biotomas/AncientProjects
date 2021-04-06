uses graph,crt;
var a,a1,a2,scr,i,j,x,y,gd,gm:integer;
begin
initgraph(gd,gm,'c:\tp7\bgi');
setcolor(8);
i:=1;
line(320,60,320,420);
for j:=1 to 6 do ellipse(320,240,0,360,j*30,180);
line(0,240,640,240);
for i:=1 to 5 do ellipse(320,420,0,180,i*i*15+60,i*30);
for i:=1 to 5 do ellipse(320,60,180,360,i*i*15+60,i*30);
setcolor(15);
circle(320,240,180);
setfillstyle(1,0);
floodfill(5,5,15);
setcolor(8);
circle(320,240,180);
readkey;
closegraph;
end.