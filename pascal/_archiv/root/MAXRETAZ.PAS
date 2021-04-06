program pelo;
uses crt;
type pole=array[1..100] of integer;
function maximum(n:integer;a:pole):integer;
var max,i:integer;
begin
max:=a[1];
for I:=2 to n do begin
if A[i]>max then max:=a[i];
end;
maximum:=max;
end;
var p,j:integer;c,b:pole;
begin
clrscr;
write('zadaj pocet cisel');readln(p);
for J:=1 to p do begin
b[j]:=random(10);write(b[j],',');end;writeln;
write('maximum prveho cisla je',maximum(p,b));
writeln;
for J:=1 to p do begin
c[j]:=random(10);write(c[j],',');end;writeln;
write('masimum prveho cisla je',maximum(p,c));writeln;
if maximum(p,b)>maximum(p,c) then write('max prve je vacsie')
else write('max druheho je vacsie');
readln;
end.
 
