program jolvan;
uses crt;
var i,n  : integer;
    v    :  char;
    x    :  array[1..20000] of integer;
procedure cfor;
begin
clrscr;
for i:=1 to n do
    begin
    x[i]:=random(201);
    write(x[i]:4);
    end;
readln;
end;

procedure crepeat;
begin
clrscr;
i:=1;
repeat
x[i]:=random(201);
write(x[i]:4);
i:=i+1;
until i> n;
readln;
end;

procedure cwhile;
begin
clrscr;
i:=1;
while i<=n do
begin
x[i]:=random(201);
write(x[i]:4);
i:=i+1;
end;
readln;
end;


begin
clrscr;
randomize;
repeat
write('n=');
readln(n);
if (n<3) or (n>20) then
begin
writeln('zla hodnota');
delay(1000);
clrscr;
end;
until (n>=3) and (n<=20);
repeat
clrscr;
gotoxy(30,8);write('ak chces cyklus for stlac ..f');
gotoxy(30,9);write('ak chces cyklus repeat stlac ..r');
gotoxy(30,10);write('ak chces cyklus while stlac ..w');
gotoxy(30,
11);write('ak chces skoncit stlac  ..k');
v:=readkey;
case v of
'F','f': cfor;
'R','r': crepeat;
'W','w': cwhile;
end;   {case}
until v in ['K','k'];
end.



