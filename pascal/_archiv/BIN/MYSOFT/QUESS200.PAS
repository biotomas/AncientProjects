program menu;
uses crt;
var x,y,a,b,c,d:integer;
    h:char;
begin
randomize;
clrscr;
gotoxy(13,8);
write('  Bon-Sai software and Nuclear Poison presents ');
gotoxy(13,10);
write('             Quessing Game 2002 ');
gotoxy(26,12);
write('Loading:');
x:=35;
y:=12;
repeat
gotoxy(x,y);
write(char(5));
x:=x+1;
delay(9000);
until x=45;
clrscr;
gotoxy(10,3);
writeln(' Quessing Game 2002');
                x:=8; y:=2;
                repeat
                gotoxy(x,y);
                write(char(4));
                x:=x+1;
                delay(1000);
                until x=31;
                repeat
                gotoxy(x,y);
                write(char(4));
                y:=y+1;
                delay(1000);
                until y=4;
                repeat
                gotoxy(x,y);
                write(char(4));
                x:=x-1;
                delay(1000);
                until x=8;
                repeat
                gotoxy(x,y);
                write(char(4));
                y:=y-1;
                delay(1000);
                until y=2;
gotoxy(10,7);
writeln('I want to quess numbers from :');
gotoxy(13,9);
writeln('1 to  100');
gotoxy(13,10);
writeln('1 to  500');
gotoxy(13,11);
write('1 to 1000');
gotoxy(13,12);
write('Exit');

x:=11;
y:=9;
repeat
gotoxy(x,y);
write(char(4));
h:=readkey;
if (ord(h)=80) and (y<12) then y:=y+1;
if (ord(h)=72) and (y>9) then y:=y-1;
gotoxy(11,9); write(' ');
gotoxy(11,10); write(' ');
gotoxy(11,11); write(' ');
gotoxy(11,12); write(' ');
until ord(h)=13;

if y=9 then begin
clrscr;
writeln;
Writeln('So quess my number, remember, it is from 1 to 100');
Writeln;
c:=1;
a:=random(99)+1;
repeat
write('Your tip is: ');
readln(b);
if b>a then writeln('It is less than ',b);
if b<a then writeln('It is more than ',b);
if a<>b then c:=c+1;
until a=b;
writeln;
writeln('You are victorious, it was ',a);
writeln('You needed ',c,' trials');
end;

if y=10 then begin
clrscr;
writeln;
Writeln('So quess my number, remember, it is from 1 to 500');
Writeln;
c:=1;
a:=random(499)+1;
repeat
write('Your tip is: ');
readln(b);
if b>a then writeln('It is less than ',b);
if b<a then writeln('It is more than ',b);
if a<>b then c:=c+1;
until a=b;
writeln;
writeln('You are victorious, it was ',a);
writeln('You needed ',c,' trials');
end;

if y=11 then begin
clrscr;
writeln;
Writeln('So quess my number, remember, it is from 1 to 1000');
Writeln;
c:=1;
a:=random(999)+1;
repeat
write('Your tip is: ');
readln(b);
if b>a then writeln('It is less than ',b);
if b<a then writeln('It is more than ',b);
if a<>b then c:=c+1;
until a=b;
writeln;
writeln('You are victorious, it was ',a);
writeln('You needed ',c,' trials');
end;
if y=12 then begin
gotoxy (10,22);
write('Bye-Bye  press Esc');
end;
repeat
h:=readkey;
if ord(h)<>27 then begin
gotoxy(10,23);
write('I sayd Esc that button on the left upper corner');
end;
until ord(h)=27;
end.



