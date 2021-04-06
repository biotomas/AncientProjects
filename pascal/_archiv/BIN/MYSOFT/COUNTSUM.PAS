program counter;
uses crt;
var a,b,c,l:integer;
begin
randomize;
writeln;
writeln;
writeln('[*][*][*][*][*][*][*][*][*][*][*][*][*][*][*][*][*][*][*][*][*][*][*][*][*][*]');
b:=0;
c:=0;
for l:=1 to 20 do begin
a:=random(99)+1;
if l<10 then
writeln(l,'.  ',a) else
writeln(l,'. ',a);
if a mod 2 = 0 then
begin
b:=b+1;
c:=c+a;
end
end;
writeln('Je tam ',b,' parnych cisel a ich sucet je ',c);
writeln;
writeln('[*][*][*][*][*][*][*][*][*][*][*][*][*][*][*][*][*][*][*][*][*][*][*][*][*][*]');
repeat until keyPressed;
end.