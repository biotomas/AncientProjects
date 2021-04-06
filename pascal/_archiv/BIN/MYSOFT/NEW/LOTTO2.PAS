uses graph, crt;
var x: array [1..90] of longint;
    i,r,a,b:integer;
    k:char;
begin
initgraph(a,b,'c:\tp7\bgi');
randomize;
repeat
r:=random(90)+1;
for i:=1 to 90 do begin
if r=i then x[i]:=x[i]+1;
 line((20+i),475,(20+i),(475-4*x[i]));
end;



if keypressed then k:=readkey;
until ord(k)=27;
closegraph;
end.