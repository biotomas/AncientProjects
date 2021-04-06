program feengr;
uses crt;
var    x,y,l,rd,d,a,r,c,f:integer;
       h:char;
begin
randomize;
textbackground(0);
clrscr;
c:=0;
x:=40;
y:=12;
l:=5;
rd:=1;
repeat
repeat
gotoxy(x,y);
d:=random(3)+1;
a:=random(7)+1;
r:=random(250)+1;

if (rd=1) and (x<79) then
   begin
   x:=x+a;
   write(char(r));
   delay(l);
   end;

if (rd=2) and (x>1) then
   begin
   x:=x-a;
   write(char(r));
   delay(l);
   end;

if (rd=3) and (y<24) then
   begin
   y:=y+a;
   write(char(r));
   delay(l);
   end;

if (rd=4) and (y>1) then
   begin
   y:=y-a;
   write(char(r));
   delay(l);
   end;

c:=c+1;
f:=random(500)+1000;
if (c=f) or (c>1500) then begin clrscr; c:=0; end;
if rd+d < 5 then rd:=rd+d else rd:=rd+d-4;
until keypressed;
h:=readkey;
if ord(h)<>27 then clrscr;
until ord(h)=27;



end.
