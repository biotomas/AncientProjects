uses graph;
var gd,gm:integer;

procedure ird_negyzet(a:integer);
begin
detectgraph(gd,gm);
initgraph(gd,gm,'d:\pb\bgi');

writeln(a*a);
end;

var szam:integer;

begin
     writeln('add meg a szamot: ');
     readln(szam);
     ird_negyzet(szam);
end.
