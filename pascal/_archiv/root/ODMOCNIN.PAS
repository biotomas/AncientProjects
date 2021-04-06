program moj;
uses crt;
var z,o:integer;
    u:real;
function odmocnina(a:integer):real;
var y:real;
begin
y:=sqrt (a);
odmocnina:=y;
end;
begin
clrscr;
write('Zadaj cislo: ');readln(z);
u:=int(odmocnina(z));
writeln('Odmocnina je ',u:3:0);
o:=round(z-u*u);
writeln('Zvysok je ',o);
readln;
end.