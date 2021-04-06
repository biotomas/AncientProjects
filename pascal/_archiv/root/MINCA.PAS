uses crt,graph;
var gd,gm,a:integer;
begin
initgraph(gd,gm,'c:\tp7\bgi\');
a:=100;

repeat
cleardevice;
ellipse(320,240,0,360,abs(a),100);
a:=a+1;
if a=101 then a:=-99;
until keypressed;

closegraph;
end.