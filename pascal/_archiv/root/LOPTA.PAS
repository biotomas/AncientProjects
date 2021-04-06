uses graph,crt; {dokoncit}
var y,a,b,s:integer;
    gd,gm:integer;
begin
s:=1;
initgraph(gd,gm,'c:\tp7\bgi');
line(5,475,635,475);
y:=2;
repeat
circle(320,y,120);
y:=y+s;
s:=s+1;
delay(100);
until y>355;
readkey;
closegraph;
end.