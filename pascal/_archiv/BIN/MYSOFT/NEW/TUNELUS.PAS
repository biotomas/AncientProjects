uses graph,crt;
var l,j,xx,yy,i,a,b:integer;
    x,y,r,s: array [1..15] of real;
    col: array [1..5] of integer;
    k:char;
procedure kerekes;
begin
setcolor(10);
for i:=1 to 15 do circle(round(x[i]),round(y[i]),round(r[i]));
end;

procedure nonkerekes;
begin
setcolor(0);
for i:=1 to 15 do circle(round(x[i]),round(y[i]),round(r[i]));
end;

begin
for i:=1 to 15 do r[i]:=0;
l:=1;
xx:=320;
yy:=240;
initgraph(a,b,'c:\tp7\bgi\');

repeat

x[l]:=xx;
y[l]:=yy;
if r[l]=0 then r[l]:=10;

for j:=1 to 15 do begin
 if r[j]>0 then r[j]:=r[j]+r[j]*0.145;
 if r[j]>400 then r[j]:=10;
end;

kerekes;
delay(100);
if keypressed then begin
k:=readkey;
if ord(k)=77 then xx:=xx+1;
if ord(k)=72 then yy:=yy-1;
if ord(k)=75 then xx:=xx-1;
if ord(k)=80 then yy:=yy+1;
if xx=541 then xx:=540;
if xx=99 then xx:=100;
if yy=381 then yy:=380;
if yy=99 then yy:=100;
end;

nonkerekes;

l:=l+1;
if l=16 then l:=1;

until ord(k)=27;
closegraph;
end.