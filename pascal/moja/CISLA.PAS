{dopln +,-,*,/ medzi cisla aby vznikol vysledok - backtracking}
uses crt;
const pc=17;
var m,vysledok:integer;
    val:longint;
    c:array[1..pc] of integer;
    o:array[1..pc-1] of byte; {1 = +, 2 = -, 3 = *, 4 = /}
    i:byte;
    goback:boolean;

procedure vypis;
begin
write(c[1]);
for i:=1 to pc-1 do
 begin
 case o[i] of 1: write('+');
              2: write('-');
              3: write('*');
              end;
 write(c[i+1]);
 end;
writeln;
inc(m);
end;


procedure najdi(od:byte);
begin
if goback then exit;

if od=pc then
  begin
  val:=c[1];
  for i:=1 to pc-1 do
  case o[i] of 1: val:=val+c[i+1];
               2: val:=val-c[i+1];
               3: val:=val*c[i+1];
               end;
  if val=vysledok then vypis;
  end
else
 begin
  o[od]:=1; najdi(od+1);
  if goback then exit;
  o[od]:=2; najdi(od+1);
  if goback then exit;
  o[od]:=3; najdi(od+1);
 end;
end;

begin
m:=0;
write('zadaj ',pc,' cisel:  ');
for i:=1 to pc do read(c[i]);
write('vysledok: ');
read(vysledok);
goback:=false;
najdi(1);
if m=0 then writeln('nenasiel sem reseni.')
else writeln('nasel sem ',m,' reseni.');

readkey;
end.