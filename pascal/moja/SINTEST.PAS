uses crt;
var i:longint;
    r:real;
    sinuses:array[0..180] of shortint;

function sinus(i:longint):real;
begin
i:=i div 360;
sinus:=s[i]/100;
end;
{36.5
 22.1
}
begin
for i:=0 to 180 do s[i]:=round(100*sin(pi/180*i));
readkey;
clrscr;
for i:=1 to 655340 do
 begin
  r:=sin(10);
  gotoxy(1,2);
  write(100*i div 655340);
  if keypressed then exit;
 end;
end.