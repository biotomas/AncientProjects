program threed;
uses graph, crt;
var alf,x,y,p,z:real;
    cu,alfa,xo,yo,i,a,b:integer;
    xk,yk,zk: array[1..8] of real;
    col,r,t: array[1..8] of integer;
    k:char;

procedure kockb;
begin
xk[1]:=x+p; yk[1]:=y+p; zk[1]:=z+p;
xk[3]:=x+p; yk[3]:=y-p; zk[3]:=z+p;
xk[5]:=x-p; yk[5]:=y+p; zk[5]:=z+p;
xk[7]:=x-p; yk[7]:=y-p; zk[7]:=z+p;
xk[2]:=x; yk[2]:=y; zk[2]:=z-p;

alf:=pi/180*alfa;
for i:=1 to 8 do begin
r[i]:=round(xk[i]+zk[i]*cos(alf));
t[i]:=round(yk[i]+zk[i]*sin(alf));
end;

setcolor(col[1]);
line(r[1],t[1],r[5],t[5]);
line(r[1],t[1],r[3],t[3]);
line(r[7],t[7],r[5],t[5]);
line(r[7],t[7],r[3],t[3]);
line(r[2],t[2],r[3],t[3]);
line(r[2],t[2],r[5],t[5]);
line(r[2],t[2],r[1],t[1]);
line(r[2],t[2],r[7],t[7]);


end;

procedure delkocka;
begin
setcolor(0);
line(r[1],t[1],r[5],t[5]);
line(r[1],t[1],r[3],t[3]);
line(r[7],t[7],r[5],t[5]);
line(r[7],t[7],r[3],t[3]);
line(r[2],t[2],r[3],t[3]);
line(r[2],t[2],r[5],t[5]);
line(r[2],t[2],r[1],t[1]);
line(r[2],t[2],r[7],t[7]);

end;

begin
initgraph(a,b,'c:\tp7\bgi\');
randomize;
x:=320;       {coordinates of the centre}
y:=240;
z:=50;
p:=60;        {diameter}
alfa:=45;     {angle}
col[1]:=14;
col[2]:=10;
cu:=1;

repeat
kockb;
{putpixel(round(x+z*cos(alf)),round(y+z*sin(alf)),10);}
alfa:=alfa+1;

if cu=0 then p:=p-(0.5) else p:=p+(0.5);
if abs(p)=80 then cu:=1-cu;

delay(20);
if keypressed then
begin
k:=readkey;
if ord(k)<>27 then k:=readkey;
end;
delkocka;
until ord(k)=27;


closegraph;
end.