program pridavok;
uses crt;
var f:text;i:integer;v:string;
begin
clrscr;
assign(f,'hihi.txt');
append(f);
writeln('Napis 2 vety:');
for i:=1 to 2 do begin readln(v);
writeln(f,v);
end;
close(f);
readln;
end.






