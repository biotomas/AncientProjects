program Nombersh;
var
a,b,c:integer;
begin
randomize;
a:=random(20)+1;
b:=random(20)+1;
writeln('--------------------');
writeln(' a = ',a);
writeln(' b = ',b);
if a=b then writeln(' a = b, No change required.');
if a<b then
begin
c:=a;
a:=b;
b:=c;
end;
writeln('   ',a);
writeln('   ',b);
end.