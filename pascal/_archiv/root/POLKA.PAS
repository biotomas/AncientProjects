program polka;
uses crt;
var i:integer;a:array [1..50] of real;c:real;
begin
clrscr;
a[1]:=1;
for i:=1 to 20 do begin
a[i+1]:=a[i]/2;
writeln(a[i]:12:11);
end;
c:=1+a[20];
writeln(c:12:11);
readkey;
end.

