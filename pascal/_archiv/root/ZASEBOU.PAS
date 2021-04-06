program zasebou;
uses crt;
var  a,b:array [1..50] of longint;i,j,poc,n:integer;z,x,y:string;
begin
randomize;
clrscr;
poc:=0;
write('Zadaj pocet kodov:');readln(n);
for i:=1 to n do a[i]:=random(9000)+1000;
for i:=1 to n do begin b[i]:=trunc(a[i]);
write(b[i],',');
for j:=0 to 9 do begin
str(b[i],x);
str(j,y);
z:=y+y;
if pos(z,x)>0 then poc:=poc+1;
end;
end;
writeln;
write(poc);
readkey;
end.