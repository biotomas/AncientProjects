uses crt;
const max=4;
type tperm=array[1..max] of word;
var p:tperm;
    i:word;

procedure swap(var a,b:word);
var x:integer;
begin
x:=a;
a:=b;
b:=x;
end;

procedure sort(var p:tperm; od:word);
var ok:boolean;
    i:word;
begin
repeat
ok:=true;
  for i:=od to max-1 do
    if p[i]>p[i+1] then
       begin
       swap(p[i],p[i+1]);
       ok:=false;
       end;
until ok;
end;

procedure nextp(var p:tperm);
var i,j:word;
begin
i:=max;
while (i > 1) and (p[i]<p[i-1]) do dec(i);
swap(p[i-1],p[i]);
if i < max then sort(p,i)
end;

procedure pis(const p:tperm);
var i:word;
begin
for i:=1 to max do write(p[i],' ');
writeln;
end;

begin
p[1]:= 1;
p[2]:= 2;
p[3]:= 3;
p[4]:= 4;
clrscr;
for i:=1 to 10 do
 begin
 pis(p);
 nextp(p);
 end;

readkey;
end.