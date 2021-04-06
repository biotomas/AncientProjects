uses crt;
type pol= array[1..5] of integer;
var f:file of pol;
    p:pol;
    r,i,j,a:integer;

begin
assign(f,'kolo.wrv');
rewrite(f);
clrscr;
write('Zada pocet riadkov ');
readln(r);
for i:=0 to r do begin
                  seek(f,i);
                  for j:=1 to 5 do begin
                                    p[j]:=random(100)+1;
                                   end;
                  write(f,p);
                 end;
close(f);
reset(f);
for i:=0 to r do begin
                  seek(f,i);
                  read(f,p);
                  for j:=1 to 5 do write(p[j]:4);
                  writeln;
                 end;

readkey;
close(f);
end.