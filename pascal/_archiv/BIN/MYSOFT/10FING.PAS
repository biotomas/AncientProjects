program push;
uses crt;
var h,k:char;
a,s,dy,x,y,ts,dyf,t:integer;
begin
randomize;
t:=1;
clrscr;
writeln('  Choose your starting difficulty level');
gotoxy(10,3);
writeln('level 1');
gotoxy(10,4);
writeln('level 2');
gotoxy(10,5);
writeln('level 3');
gotoxy(10,6);
writeln('level 4');
gotoxy(10,7);
writeln('level 5');
gotoxy(10,8);
writeln('level 6');
gotoxy(10,9);
writeln('level 7');

x:=8;
y:=3;
repeat
gotoxy(x,y);
write(char(4));
gotoxy(80,24);
h:=readkey;
if (ord(h)=80) and (y<9) then y:=y+1;
if (ord(h)=72) and (y>3) then y:=y-1;
gotoxy(8,3); write(' ');
gotoxy(8,4); write(' ');
gotoxy(8,5); write(' ');
gotoxy(8,6); write(' ');
gotoxy(8,7); write(' ');
gotoxy(8,8); write(' ');
gotoxy(8,9); write(' ');
until ord(h)=13;

dy:=900-(y-2)*100;

clrscr;
ts:=0;
s:=5;
repeat
repeat
if t=1 then begin
gotoxy(5,3);
write('Your task is to type the letter in the square until it is completed.');
gotoxy(5,4);
write('                 Press a key if you are ready');
k:=readkey;
t:=0;
end;
clrscr;
gotoxy(10,2);
writeln('Score is ',s);
dyf:=(9000-dy) div 1000;
gotoxy(10,5);
writeln('Difficulty level is ',dyf);
a:=random(26)+97;
gotoxy(20,8);
write(char(a));
               x:=18;
               y:=7;
               repeat
               gotoxy(x,y);
               write(char(4));
               x:=x+1;
               gotoxy(20,8);
               delay(dy);
               until (x=22) or (Keypressed);
               if keypressed then h:=readkey else begin
               repeat
               gotoxy(x,y);
               write(char(4));
               y:=y+1;
               gotoxy(20,8);
               delay(dy);
               until (y=9) or (Keypressed);
               if keypressed then h:=readkey else begin
               repeat
               gotoxy(x,y);
               write(char(4));
               x:=x-1;
               gotoxy(20,8);
               delay(dy);
               until (x=18) or (Keypressed);
               if keypressed then h:=readkey else begin
               repeat
               gotoxy(x,y);
               write(char(4));
               y:=y-1;
               gotoxy(20,8);
               delay(dy);
               until (y=7) or (Keypressed);
               if keypressed then h:=readkey;
               end;
               end;
               end;
if ord(h)=a then begin s:=s+1;
                       ts:=ts+1;
end else begin s:=s-1; ts:=ts-2 end;
until (s=15) or (s=0);
if s>0 then begin
gotoxy(10,2);
write('Score is ',s);
gotoxy(10,3);
dy:=dy-1000;
if dy>1000 then begin
Writeln('df are good but what will you do in the next level');
delay(600);
end;
s:=5;
end;
until (dy=1000) or (s=0);
clrscr;
gotoxy(30,12);
if s>0 then
write('  You are victorious') else
write('    You are a loser ');
gotoxy(30,16);
write('      Press a key');
gotoxy(30,14);
write('Your Total score is ',ts);
h:=readkey
end.