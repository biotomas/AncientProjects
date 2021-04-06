function f(typ:integer):boolean;
var k:char;
begin
read(k);
if k='@' then f:=true
else if k='[' then f:=f(0)
else if k='(' then f:=f(1)
else if k='{' then f:=f(2)
else if (k=']') and (typ=0) then f:=true
else if (k=')') and (typ=1) then f:=true
else if (k='}') and (typ=2) then f:=true
else f:=false;
end;

var b:boolean;
    k:char;
begin
read(k);
if k='[' then b:=f(0)
else if k='(' then b:=f(1)
else if k='{' then b:=f(2);
writeln(b);
end.