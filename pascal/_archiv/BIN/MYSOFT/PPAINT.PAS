program ppaint;
uses crt;
var x,y,q :integer;
    h :char;
begin
clrscr;
textbackground(0);
clrscr;
x:=40;
y:=12;
q:=0;
gotoxy(x,y);
repeat
if (q=1) or (ord(h)=32) THEN clrscr;
if ord(h)=9 then q:=1;
if ord(h)=113 then q:=0;
gotoxy(x,y);
write(char(5));
h:=readkey;
if (ord(h)=72) and (y>1) then y:=y-1;
if (ord(h)=80) and (y<24) then y:=y+1;
if (ord(h)=75) and (x>1) then x:=x-1;
if (ord(h)=77) and (x<79) then x:=x+1;
until ord(h)=27;
end.






