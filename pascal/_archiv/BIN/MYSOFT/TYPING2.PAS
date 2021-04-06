program typing2;
uses crt;
var     x,y:integer;
        k:char;
begin
x:=1;
y:=1;
repeat
clrscr;
gotoxy(1,1);
{hello   123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789}
writeln('Hello Peti, de jo nagyon gyorsan tudok irni a gepen mi ugy irigykedel hogy ');
gotoxy(x,y);
clreol;
x:=x+1;
k:=readkey;
until x=80;
end.












