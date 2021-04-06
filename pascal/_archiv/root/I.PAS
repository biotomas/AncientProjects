program pelo;
uses crt,graph;
var i,x,gd,gm:integer;
begin
gd:=detect;
initgraph(gd,gm,'c:\tp7\bgi');
{for x:=1 to 100 do
circle(250,250,2*x);}
repeat
circle(250,250,200);
line(250,50,250,450);
line(250,250,100,380);
line(250,250,390,390);
delay(500);
setcolor(0);
line(250,50,250,450);
line(250,250,100,380);
line(250,250,390,390);
circle(250,250,200);
setcolor(15);
delay(500);
until keypressed;
readln;
closegraph;
end.
