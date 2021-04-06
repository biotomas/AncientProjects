uses crt;
var k:char;
    f:integer;
procedure klaves;
begin
k:=readkey;
if k='+' then f:=f+30;
if k='-' then f:=f-30;
gotoxy(1,1);
clrscr;
write(f);
end;

begin
f:=1500;
clrscr;
repeat
sound(f);
delay(250);
nosound;
delay(400);
if keypressed then klaves;
until ord(k)=27;
end.