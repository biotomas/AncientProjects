program mocniny;
uses crt;
var h,d,krok:real;nm,i:integer;

function mocnina(x:real;n:integer):real;
var p:real;i:integer;
begin
p:=1;
for i:=1 to n do p:=p*x;
mocnina:=p;
end;

begin
clrscr;
writeln('Zadaj interval od-do: ');readln(d,h);
write('Zadaj krok medzi nimi: ');readln(krok);
write('Zadaj najvyssiu mocninu: ');readln(nm);
while d<=h do begin
      for i:=2 to nm do write(d:1:1,' na ',i,' = ',mocnina(d,i):6:2,', ');
      writeln;
      d:=d+krok;
      end;
readln;
end.