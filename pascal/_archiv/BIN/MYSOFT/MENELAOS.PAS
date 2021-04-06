program menelaos;
var a,b,c,x:integer;
begin
randomize;
writeln;
writeln('Zadaj x');
readln(x);
writeln;
a:=random(x)+1;
b:=random(x)+1;
c:=random(x)+1;
if a>b then
   if a>c then
      if b>c then writeln(a,' > ',b,' > ',c) else writeln(a,' > ',c,' > ',b)
   else writeln(c,' > ',a,' > ',b)
else
    if b>c then
       if a>c then writeln(b,' > ',a,' > ',c) else writeln(b,' > ',c,' > ',a)
    else writeln(c,' > ',b,' > ',a);
writeln('Stlacte ENTER');
readln;
end.









