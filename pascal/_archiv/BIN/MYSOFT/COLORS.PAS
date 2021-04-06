program colors;
uses crt;
var i:integer;
begin
clrscr;
for i:=0 to 15 do begin
                  textcolor(i);
                  writeln(i);
                  end;

readkey;
end.