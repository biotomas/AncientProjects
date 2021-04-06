program pascalko;
uses crt;
type matica=array[0..15,0..15] of integer;
var pocet:integer;mat:matica;

procedure vypmat(a:matica;m,n:integer);
var i,j:integer;
begin
for i:=0 to n do begin
    for j:=0 to n do write(a[i,j]:4);
    writeln;
    end;
end;

procedure pasc(n:integer;var a:matica);
var i,j:integer;
begin
a[0,0]:=1;a[1,0]:=1;a[1,1]:=1;
for i:=2 to n do begin a[i,0]:=1;
    for j:=1 to n-1 do a[i,j]:=a[i-1,j-1]+a[i-1,j];
    a[i,i]:=1;
end;
vypmat(a,n,n);
end;

begin
clrscr;
write('Zadaj pocet: ');readln(pocet);
pasc(pocet,mat);
readln;
end.