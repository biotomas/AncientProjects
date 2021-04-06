uses graph;

var gd,gm:integer;
function negyzet(a:integer):integer;
begin
detectgraph(gd,gm);
initgraph(gd,gm,'d:\bp\bgi');
     negyzet:=a*a;
end;

var szam, hatvany:integer;

begin
     writeln('add meg a szamot: ');
     readln(szam);
     hatvany:=negyzet(szam);
     writeln(hatvany);
end.
