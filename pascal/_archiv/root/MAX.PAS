uses crt;

var c,j,i,mm,m:integer;

begin
for i:=1 to 49 do
begin
  j:=1;
  repeat
    c:=(50-i)*j;
    if (c-2) mod 50 = 0 then textcolor(15) else textcolor(8);
    write(c:8);
    if (c>m) and (c<2003) then begin m:=c; mm:=i; end;
  j:=j+1;
  until c>2002;
delay(300);
writeln;
end;
Writeln('Max je ',m,' pri cene ',mm);
readln;
end.