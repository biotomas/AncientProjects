uses crt,graph, bnlmap;
var gd,gm,i,m:integer;
begin
gd:=3;
gm:=1;
initgraph(gd,gm,'c:\tp\bgi');
repeat
cleardevice;
setcolor(8);
for i:=1 to 12 do line(i*50,0,i*50,350);
for i:=1 to 7 do line(0,i*50,640,i*50);
circle(320,175,5);
initmines;
drawmap(m);
mines(m);
inc(m);
if m>5 then m:=1;
until #27=readkey;
closegraph;
end.