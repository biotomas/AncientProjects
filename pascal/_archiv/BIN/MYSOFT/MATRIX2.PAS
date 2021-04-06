program spetinek;
uses crt;
var x,y,a,d,rd,x1,y1,l,r:integer;
h:char;
begin
randomize;
clrscr;

x:=40;
y:=12;
l:=10;
rd:=1;
repeat
repeat
gotoxy(x,y);
d:=random(3)+1;
a:=random(7)+1;
r:=random(2);

if (rd=1) and (x<79) then
   begin
   x1:=x;
   y1:=y;
   repeat
   gotoxy(x,y);
   write(r);
   x:=x+1;
   delay(l);
   until (x=x1+a) or (x=79);
   end;

if (rd=2) and (x>2) then
   begin
   x1:=x;
   y1:=y;
   repeat
   gotoxy(x,y);
   write(r);
   x:=x-1;
   delay(l);
   until (x=x1-a) or (x=2);
   end;

if (rd=3) and (y<23) then
   begin
   x1:=x;
   y1:=y;
   repeat
   gotoxy(x,y);
   write(r);
   y:=y+1;
   delay(l);
   until (y=y1-a) or (y=23);
   end;

if (rd=4) and (y>1) then
   begin
   x1:=x;
   y1:=y;
   repeat
   gotoxy(x,y);
   write(r);
   y:=y-1;
   delay(l);
   until (y=y1-a) or (y=2);
   end;

if rd+d < 5 then rd:=rd+d else rd:=rd+d-4;
until keypressed;
h:=readkey;
if ord(h)<>27 then clrscr;
until ord(h)=27;
end.
