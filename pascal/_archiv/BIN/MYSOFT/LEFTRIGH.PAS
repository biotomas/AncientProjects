program wad;
uses crt;
var x,y,d,h:integer;
begin
clrscr;
d:=500;
x:=25;
y:=12;
h:=5;
repeat
gotoxy(x,y);
write(char(h));
if x<55 then x:=x+1;
if x=55 then begin
   repeat
   gotoxy(x,y);
   write(char(h));
   x:=x-1;
   delay(d);
   clrscr;
   until x=25;
   end;
delay(d);
clrscr;
until keypressed;
end.