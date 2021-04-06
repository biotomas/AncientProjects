uses crt;
var i,n,m:integer;
    x: array[1..90] of longint;
    k:char;
begin
clrscr;
repeat

repeat
 n:=random(90)+1;
 for i:=1 to 90 do begin
 if n=i then x[i]:=x[i]+1;

 end;

for i:=1 to 10 do begin
 gotoxy(1,i);
 if i<>10 then
 write('0',i,' ',x[i])
 else  write(i,' ',x[i]);
end;
for i:=11 to 20 do begin
 gotoxy(8,(i-10));
 write(i,' ',x[i]);
end;
for i:=21 to 30 do begin
 gotoxy(16,(i-20));
 write(i,' ',x[i]);
end;
for i:=31 to 40 do begin
 gotoxy(24,(i-30));
 write(i,' ',x[i]);
end;
for i:=41 to 50 do begin
 gotoxy(32,(i-40));
 write(i,' ',x[i]);
end;
for i:=51 to 60 do begin
 gotoxy(40,(i-50));
 write(i,' ',x[i]);
end;
for i:=61 to 70 do begin
 gotoxy(48,(i-60));
 write(i,' ',x[i]);
end;
for i:=71 to 80 do begin
 gotoxy(56,(i-70));
 write(i,' ',x[i]);
end;
for i:=81 to 90 do begin
 gotoxy(64,(i-80));
 write(i,' ',x[i]);
end;
until keypressed;
k:=readkey;

until (ord(k)=27);

end.