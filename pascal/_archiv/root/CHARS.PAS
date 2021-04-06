program x;
uses crt;
var  i:integer;
     k:char;
begin
clrscr;
repeat
k:=readkey;
writeln('Kod= ',ord(k));
until ord(k)=27;
end.