{riesic sudoku, backtracking}
uses crt;
type mozne=array[1..9] of boolean;
     pole=array[1..9,1..9] of byte;
var p:pole;
    i,j:byte;
    konec:boolean;
    plno:byte;
    f:file of pole;
{####################################################################}
{####################################################################}
{####################################################################}

function zistimozne(var m:mozne; a,b:byte):byte;
var i:byte;
    x:mozne;
    k,l:byte;
begin
for i:=1 to 9 do
  begin
  x[i]:=true;
  {riadok}
  if (p[a,1]=i) or (p[a,2]=i) or (p[a,3]=i) or (p[a,4]=i) or (p[a,5]=i) or
     (p[a,6]=i) or (p[a,7]=i) or (p[a,8]=i) or (p[a,9]=i) then x[i]:=false;
  {stlpec}
  if (p[1,b]=i) or (p[2,b]=i) or (p[3,b]=i) or (p[4,b]=i) or (p[5,b]=i) or
     (p[6,b]=i) or (p[7,b]=i) or (p[8,b]=i) or (p[9,b]=i) then x[i]:=false;
  {stvorec 3x3}
  k:=(a-1) div 3;
  l:=(b-1) div 3;
  k:=(k)*3;
  l:=(l)*3;
  if (p[k+1,l+1]=i) or (p[k+2,l+1]=i) or (p[k+3,l+1]=i) or
     (p[k+1,l+2]=i) or (p[k+2,l+2]=i) or (p[k+3,l+2]=i) or
     (p[k+1,l+3]=i) or (p[k+2,l+3]=i) or (p[k+3,l+3]=i) then x[i]:=false;
  end;
m:=x;
l:=0;
for i:=1 to 9 do if x[i] then inc(l);
zistimozne:=l;
end;

{####################################################################}
{####################################################################}
{####################################################################}

procedure dopln(a,b:byte);
var m:mozne;
    x,i,j:byte;
    nasel:boolean;
begin
if plno=81 then konec:=true; {vyhrali sme }
if konec then exit;

nasel:=false;
while p[a,b]<>0 do
   begin
   for i:=1 to 9 do for j:=1 to 9 do if p[i,j]=0 then
      begin
      a:=i;
      b:=j;
      nasel:=true;
      break;
      end;
   end;

delay(10); {brkpoint a=1, b=5}

if not nasel then exit;
x:=zistimozne(m,a,b);
if x=0 then exit;
j:=1;
for i:=1 to x do
  begin
  while (m[j]<>true) and (j<9) do inc(j);
  p[a,b]:=j; inc(plno);
  dopln(a,b);
  if not konec then
               begin
               p[a,b]:=0;
               dec(plno);
               end;
  end;
end;

{####################################################################}
{####################################################################}
{####################################################################}
var k:char;

begin
assign(f,'sudoku.tab');
reset(f);

konec:=false;
plno:=0;

    {zadavanie}
    {
    for i:=1 to 9 do for j:=1 to 9 do p[i,j]:=0;
    writeln('zadaj pole, po riadkoch. zadaj 0 pre nezname pole: ');
    for i:=1 to 9 do for j:=1 to 9 do
      begin
      k:=readkey;
      p[i,j]:=ord(k)-48;
      write(k,' ');
      if j=9 then writeln;
      if p[i,j]<>0  then inc(plno);
      end;
    writeln('ok, dakujem.');
    { }

read(f,p); {vstup zo suboru}
close(f);
plno:=36;

{vypis}
for i:=1 to 9 do
   begin
   write('|');
   for j:=1 to 9 do write(' ',p[i,j],' |');
   writeln;
   end;
{konec vypisu}
dopln(1,1);
{vypis}
writeln('VYSLEDOK:');

for i:=1 to 9 do
   begin
   write('|');
   for j:=1 to 9 do write(' ',p[i,j],' |');
   writeln;
   end;
{konec vypisu}
readkey;
end.