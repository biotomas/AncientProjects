program quess;
uses crt;
var a,b,c,z:integer;
begin
repeat
randomize;
clrscr;
Writeln('-------------------');
Writeln('---Quessing Game---');
writeln('-------------------');
Writeln;
Writeln('Hadaj na ake cislo myslim je to mensie ako 100 ale viac ako 0 ');
Writeln;
c:=1;
a:=random(99)+1;
repeat
write('Tipuj  ');
readln(b);
if b>a then writeln('Je to menej ako ',b);
if b<a then writeln('Je to viac ako ',b);
if a<>b then c:=c+1;
until a=b;
writeln;
writeln('Gratulujem, je to naozaj ',a);
writeln('Uhadol si to na ',c,'. pokus.');
Writeln;
writeln('Chces znovu ? /ano/=1 /nie/=0 ');
readln(z);
until z=0
end.