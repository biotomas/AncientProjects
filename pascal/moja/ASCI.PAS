uses crt;
var k:char;
    i:byte;
begin
for i:=0 to 255 do write(i,': ',char(i));
repeat
k:=readkey;
writeln(ord(k):4,':',k);
until k=#68;
end.