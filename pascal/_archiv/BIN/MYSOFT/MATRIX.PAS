program matrix;
uses crt;
var a,b,c,l,h:integer;
begin
randomize;
repeat
a:=random(10)+1;
b:=random(10)+1;
c:=random(10)+1;
for h:=1 to a do write('0');
for h:=1 to b do write('I');
for h:=1 to c do write('0');
DELAY(70);
until KeyPressed;
end.




