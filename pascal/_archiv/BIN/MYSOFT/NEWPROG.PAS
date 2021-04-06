program dokola;
uses crt;
var x,y:integer;
begin

x:=1;
y:=1;
repeat
clrscr;
     repeat
write('*');
x:=x+1;
gotoxy(x,y);
delay (500);
until x=80;
      repeat
write('*');
y:=y+1;
gotoxy(x,y);
delay (500);
until y=24;
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
until keyPressed;
end.