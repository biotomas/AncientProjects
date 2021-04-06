uses crt;
const s:array[1..3] of string[5]=('Ook. ','Ook! ','Ook? ');
var l,i:byte;
    f:text;
begin
assign(f,paramstr(1));
rewrite(f);
randomize;

repeat
for i:=1 to 15 do
 begin
  l:=random(3)+1;
  write(f,s[l]);
 end;
writeln(f);
until keypressed;

close(f);
end.