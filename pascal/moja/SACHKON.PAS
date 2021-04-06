{
sachovy konik skace ale brania mu prekazky, kam sa nedostane?
}
uses crt;
type tkam=record x,y:shortint; end;
const mx=8; {rozmer sachovnice}
      cs=255; {cislo prekazky}
      kam: array[1..8] of tkam = {takto skace konik}
      ((x:-2;y:1),(x:-2;y:-1),(x:2;y:-1),(x:2;y:1),
      (x:1;y:-2),(x:-1;y:-2),(x:-1;y:2),(x:1;y:2));
var p : array [-1..mx+2,-1..mx+2] of byte;
    k:char;
    i,j,x,y:integer;
    ptahu:byte;


procedure skakaj;
var i:byte;
begin
if p[x,y]>0 then exit;
p[x,y]:=ptahu;
for i:=1 to 8 do
  begin
    x:=x+kam[i].x;
    y:=y+kam[i].y;
    inc(ptahu);
    skakaj;
    dec(ptahu);
    x:=x-kam[i].x;
    y:=y-kam[i].y;
  end;
end;


procedure kresli2;  {kresli dev sachovnicu}
var i,j:shortint;
begin
clrscr;
for i:=-1 to mx+2 do
   for j:=-1 to mx+2 do
     begin
     gotoxy((j+2)*2,2+i);
     if p[i,j]=cs then write('*')
     else
     write(p[i,j]);
     end;
end;


procedure kresli;  {kresli sachovnicu}
var i,j:byte;
begin
clrscr;
for i:=1 to mx do
   for j:=1 to mx do
     begin
     gotoxy(j*5,2*i);
     if p[i,j]=cs then write('*')
     else
     write(p[i,j]);
     end;
end;

begin
clrscr;
for i:=-1 to mx+2 do
  for j:=-1 to mx+2 do p[i,j]:=0;

for i:=-1 to mx+2 do
 begin
  p[i,-1]:=cs;
  p[i,0]:=cs;
  p[i,mx+1]:=cs;
  p[i,mx+2]:=cs;
 end;
for i:=1 to mx do
 begin
  p[-1,i]:=cs;
  p[0,i]:=cs;
  p[mx+1,i]:=cs;
  p[mx+2,i]:=cs;
 end;

writeln('zadaj kde su prekazky, stlac 0 pre volno a 1 pre prekazku.');
for i:=1 to mx do
  begin
  for j:=1 to mx do
    begin
    repeat k:=readkey until k in ['1','0'];
    if k='1' then begin write(' X '); p[i,j]:=cs; end;
    if k='0' then begin write(' - '); p[i,j]:=0; end;
    end;
  writeln;
  end;
writeln('Dakujem, teraz zadaj pociatocnu poziciu konika:');
write('x = '); readln(y);
write('y = '); readln(x);
ptahu:=0;
skakaj;
kresli;
readkey;
end.