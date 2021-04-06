uses crt;
type pole=array[1..2] of integer;
var f:file of pole;
    rd:pole;
    i:integer;
begin
clrscr;
assign(f,'tsyze.syz');
rewrite(f);
for i:=0 to 5 do begin
     seek(f,i);
     rd[1]:=random(1000)+1;
     rd[2]:=random(1000)+1;
     write(f,rd);
    end;
close(f);
reset(f);
writeln(' velkost suboru je: ',filesize(f));
readkey;
close(f);

end.