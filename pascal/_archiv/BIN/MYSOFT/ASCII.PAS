program TheTable;
uses crt;
var a:integer;
h:char;
begin
clrscr;
writeln('Zadaj znak !');
repeat
h:=readkey;
writeln('Znaku ',h,' prislucha hodnota ',ord(h));
until ord(h)=27;
end.



