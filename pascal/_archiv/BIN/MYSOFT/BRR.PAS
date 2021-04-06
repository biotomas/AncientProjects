program hello;
var a,b,c:integer;
begin
writeln;
writeln;
writeln('Zadaj A ');
readln(a);
writeln('Zadaj B ');
readln(b);
writeln('Zadaj C ');
readln(c);
writeln;
if a>b then
   if a>c then
      if b>c then writeln(a,' > ',b,' > ',c) else writeln(a,' > ',c,' > ',b)
   else writeln(c,' > ',a,' > ',b)
else
    if b>c then
       if a>c then writeln(b,' > ',a,' > ',c) else writeln(b,' > ',c,' > ',a)
    else writeln(c,' > ',b,' > ',a);
writeln;
writeln('Stlacte klavesu ENTER ');
readln;
end.