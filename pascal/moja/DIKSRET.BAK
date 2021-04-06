function roz(n,i:word):word;
begin
if i>n then roz:=0
else
if ((i=n)or(i=1)) then roz:=1
else
    roz:=i*roz(n-1,i) + roz(n-1,i-1);
end;

var s,i,n:word;

begin
 s:=0;
 readln(n);
 for i:=1 to n do
     s:=s + roz(n, i);
 writeln(s);
readln;
end.