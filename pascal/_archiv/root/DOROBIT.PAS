uses crt,graph;
var gd,gm,b:integer;
        a:word;
function fuck(a:word):longint;
var i :integer; v:longint;
begin
v:=1;
for i:=a downto 2 do v:=v+i;
fuck:=v;
end;

begin
repeat
write('povedz cislo ');
readln(a);
writeln('faktorial toho cisla je ',fuck(a));
until a=27;
end.