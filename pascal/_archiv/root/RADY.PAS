program z;
uses crt;
var a:array[1..20] of real;i:integer;
begin
clrscr;
a[1]:=1;
for i:=2 to 20 do a[i]:=a[i-1]/2;
writeln(a[20]:20:10);
writeln(1+a[20]:20:10);
readkey;
end.

