uses crt;
var c,z:integer;y:real;

function mocnina(a:integer):integer;
var i,j,suc:integer;
begin
suc:=0;
repeat
j:=a mod 10;
suc:=suc+j;
a:=a div 10;
until a=0;
mocnina:=suc;
end;

function odmocnina(b:integer):real;
var x:real;
begin
x:=sqrt(b);
odmocnina:=x;
end;

begin
clrscr;
write('Zadaj cislo: ');readln(c);
writeln(mocnina(c));
y:=int(odmocnina(c));
writeln(y:4:2);
z:=round(c-y*y);
writeln(z);
readln;
end.