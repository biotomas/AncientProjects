program quadratic;
var a,b,c:integer;
     x1,x2:real;
begin
     writeln('Zadaj A ');
     readln(a);
     writeln('Zadaj B ');
     readln(b);
     writeln('Zadaj C ');
     readln(c);
writeln;
if a<>0 then
   if (b*b-a*c*4)>=0 then begin
   x1:=(-b-sqrt(b*b-4*a*c))/2*a;
   writeln('x1= ',x1);
   x2:=(-b+sqrt(b*b-4*a*c))/2*a;
   writeln('x2= ',x2);
   end
else writeln('Not Possible');
writeln;
writeln('Press Enter');
readln;
end.