program riadky;
uses crt;
var f:text;poc:integer;veta:string;
begin
clrscr;
assign(f,'hihi.txt');
reset(f);
poc:=0;
while not eof(f) do
      while not eoln(f) do begin
      readln(f,veta);
      writeln(veta);
      poc:=poc+1;
end;
write('Text ma ',poc,' riadkov');
readln;
end.