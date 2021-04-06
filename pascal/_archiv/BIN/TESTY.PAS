uses crt;
var i,e:integer;
    a:longint;
    r,r2:real;
begin
for i:=1 to 30 do
begin
a:=a*(700-i);
if a>1000000 then begin
r:=a;
r2:=r/1000000;
a:=round(r2);
e:=e+6;
end;
end;
writeln('existuje ',a,' krat 10 na ',e,' testov.');
readln;
end.