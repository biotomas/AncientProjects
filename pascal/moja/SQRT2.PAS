const max=1000;

type cislo=record
     n:array[1..max] of byte;
     dc,l:word; {dc je pozicia desat. carky, l je dlzka zapisu}
     end;

var x:cislo;

function mensie(const a,b:cislo):boolean; {ak a<b tak true, inak false}
var i:word;
begin
if a.dc < b.dc then mensie:=true
else
if a.dc > b.dc then mensie:=false
else
  begin
  while (a.n[i]=b.n[i]) and (i < max) do inc(i);
  if a.n[i]<b.n[i] then mensie:=true
  else mensie:=false;
  end;
end;


procedure krat(a,b:cislo; var xx:cislo); {xx = a*b }
var i,j,h,p:word;
    x:cislo;
begin
for i:=1 to max do x.n[i]:=0;

if a.l < b.l then {a<b => a <-> b }
  begin
  x:=a; a:=b; b:=x;
  end;
{vieme ze b ma kratsi zapis nez a}
p:=0;
h:=max;
for i:=b.l downto 1 do
  begin
  for j:=a.l downto 1 do
    begin
    h:= max - ((b.l-i)+(a.l-j));
    inc(x.n[h] , ((b.n[i]*a.n[j] + p) mod 10) );
    p:= b.n[i]*a.n[j] div 10;
    end;
  dec(h);
  inc(x.n[h],p);
  p:=0;
  end;
end;


for i:=max downto 1 do
    if c2[i]<>0 then
    for j:=max downto 1 do
        if (i+j-1) <= max then
        begin
        v[i+j-1]:=(v[i+j-1] + c2[i]*c1[j] + prenos) mod 10;
        prenos:=(v[i+j-1] + c2[i]*c1[j] + prenos) div 10;
        end;

begin

end.