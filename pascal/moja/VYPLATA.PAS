const mpdp=30;
var castka,pdp:word;
    pp,peniaz:array[1..mpdp] of word;

procedure vypis;
var i:word;
begin
for i:=1 to pdp do if pp[i] > 0 then write(pp[i],' x ',peniaz[i],'; ');
writeln;
end;

procedure zaplat(od,suma:integer);
var i:word;
begin
if suma = 0 then vypis
else
if suma > 0 then
  for i:=od to pdp do
  if peniaz[i] <= suma then
    begin
      inc(pp[i]);
      zaplat(i,suma-peniaz[i]);
      dec(pp[i]);
    end;
end;{of zaplat}

var i:word;
begin
write('zadaj castku: ');
readln(castka);
write('zadaj pdp: ');
readln(pdp);
write('zadaj hodnoty: ');
for i:=1 to pdp do readln(peniaz[i]);
for i:=1 to pdp do pp[i]:=0;
zaplat(1,castka);
readln;
end.