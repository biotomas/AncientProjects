program feri;
uses crt;
var n,a,s:integer;
begin
clrscr;
randomize;
a:=random(100);
repeat
write('Hadaj cislo od 1 do 100: ');readln(n);
if (n<a) then writeln('Cislo je vecsie');s:=s+1;
if (n>a) then writeln('Cislo je mensie');s:=s+1;
if (n=a) then write('Uhadol si na ',round(s/2),' krat');
until n=a;
if s/2<7 then write (', si dobry') else write (', si slaby');
readkey;
end.
