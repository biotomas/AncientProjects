program KomGame;
uses crt;
var a,b,c,s,x,y :integer;
h:char;
begin
clrscr;
x:=1;
y:=1;
clrscr;
     repeat
write(char(6));
x:=x+1;
gotoxy(x,y);
delay (30);
until x=80;
      repeat
write(char(6));
y:=y+1;
gotoxy(x,y);
delay (30);
until y=24;
      repeat
write(char(6));
x:=x-1;
gotoxy(x,y);
delay (30);
until x=1;
      repeat
write(char(6));
y:=y-1;
gotoxy(x,y);
delay (30);
until y=1;



randomize;
gotoxy(20,3); write('If you see 2 same numbers press a key');
s:=0;
repeat
         repeat
         gotoxy(35,18);
         write('       ');
         gotoxy(15,22);
         writeln('Your Score is ',s);
         a:=random(6)+1;
         b:=random(6)+1;
         c:=random(6)+1;
         gotoxy(35,15);
         write(a);
         gotoxy(38,15);
         write(b);
         gotoxy(41,15);
         write(c);
         delay(2000);
         until KeyPressed;
         h:=readkey;
         if (a=b) or (b=c) or (c=a) then begin
         s:=s+1;
         gotoxy(35,18);
         write(' BINGO ');
         delay(2000);
         end
         else begin
         gotoxy(35,18);
         write(' Hoops ');
         delay(2000);
         gotoxy(15,22);
         writeln('Your Score is ',s);
         end;
until s=10;
gotoxy(55,22);
write('You won');
end.