program cifsuc;
uses crt;
var c,d:longint;

function cifsucet(a:longint):integer;
var f,suc:integer;
begin
suc:=0;
repeat
f:=a mod 10;
suc:=suc+f;
a:=a div 10;
until a=0;
cifsucet:=suc;
end;

begin
clrscr;
write('Zadaj cislo na ciferny sucet: ');readln(c);
writeln(cifsucet(c));
write('Zadaj druhe cislo na ciferny sucet: ');readln(d);
writeln(cifsucet(d));
if cifsucet(c)=cifsucet(d) then write
('Ciferne sucti cisel sa rovnaju') else
if cifsucet(c)<cifsucet(d) then write
('Ciferny sucet prveho cisla je mensi ako druheho') else
write('Ciferny sucet prveho cisla je vacsi ako druheho');
readln;
end.