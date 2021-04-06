uses bmp,graph;

var gd,gm:integer;

begin
initgraph(gd,gm,'c:\tp\bgi');

load_bmp(1,1,'ahoj.bmp');
readln;
closegraph;
end.