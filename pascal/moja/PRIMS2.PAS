uses crt; {pre neoptimalne riesenie pozri prims}
var a,i,j,n:longint;


function jepc(x:longint):boolean;
var i:longint;
    b:boolean;
begin
  b:=true;
  for i:=2 to trunc(sqrt(x)) do if x mod i = 0 then
     begin
       b:=false;
       break;
     end;
  jepc:=b;
end;


begin
clrscr;
write('zadajte n = ');
readln(a);
n:=a;

if jepc(n) then writeln(n,' je prvocislo.')
else
begin
i:=1;
   repeat
      repeat inc(i) until (jepc(i)) and (n mod i = 0);
      j:=0;
      repeat
        inc(j);
        n:=n div i;
      until n mod i <> 0;
      if j=1 then write(i,' * ') else write(i,'^',j,' * ');
   until (jepc(n)) or (n=1);
if n>1 then write(n) else
   begin
   gotoxy(wherex-2,wherey);
   writeln('   ');
   end;
end;
readkey;
end.