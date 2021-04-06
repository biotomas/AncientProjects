program vatch;
uses crt;
var x,y,dif:integer;
h:char;
begin
dif:=1;
clrscr;
repeat
gotoxy(10,3);
write('This game will upgrade your writing skills');
gotoxy(10,7);
write('What do you want');
gotoxy(13,9);
write('Play this game');
gotoxy(13,10);
write('Change difficulty');
              gotoxy(35,10);
              if dif=1 then write('Easy  ');
              if dif=2 then write('Normal');
              if dif=3 then write('Hard  ');
gotoxy(13,11);
write('Exit program');

x:=11;
y:=10;
repeat
gotoxy(x,y);
write(char(4));
h:=readkey;
if (ord(h)=80) and (y<11) then y:=y+1;
if (ord(h)=72) and (y>9) then y:=y-1;
gotoxy(11,9); write(' ');
gotoxy(11,10); write(' ');
gotoxy(11,11); write(' ');
until ord(h)=13;






if y=10 then begin
if dif=1 then dif:=2 else
if dif=2 then dif:=3 else
if dif=3 then dif:=1;
end;
until y=11;
gotoxy (10,22);
write('Bye-Bye  press any key');
repeat until keypressed;
end.








