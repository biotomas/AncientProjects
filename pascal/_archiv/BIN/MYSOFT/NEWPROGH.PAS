program dokola;
uses crt;
var x,y,l,a,b:integer;
begin
clrscr;
for l:=1 to 5 do begin
a:=0;
b:=0;
a:=a+1;
b:=b+1
x:=a;
y:=b;
     repeat
write('*');
x:=x+1;
gotoxy(x,y);
delay (500);
until x=x-a;
      repeat
write('*');
y:=y+1;
gotoxy(x,y);
delay (500);
until y=y-b;
      repeat
write('*');
x:=x-1;
gotoxy(x,y);
delay (500);
until x=1;
      repeat
write('*');
y:=y-1;
gotoxy(x,y);
delay (500);
until y=1;
end
end.