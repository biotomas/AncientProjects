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
xk[2]:=x+(1/4)*p; yk[2]:=y+(1/4)*p; zk[2]:=z-(1/4)*p;
xk[3]:=x+p; yk[3]:=y-p; zk[3]:=z+p;
xk[4]:=x+(1/4)*p; yk[4]:=y-(1/4)*p; zk[4]:=z-(1/4)*p;
xk[5]:=x-p; yk[5]:=y+p; zk[5]:=z+p;
xk[6]:=x-(1/4)*p; yk[6]:=y+(1/4)*p; zk[6]:=z-(1/4)*p;
xk[7]:=x-p; yk[7]:=y-p; zk[7]:=z+p;
xk[8]:=x-(1/4)*p; yk[8]:=y-(1/4)*p; zk[8]:=z-(1/4)*p;

alf:=pi/180*alfa;
for i:=1 to 8 do begin
r[i]:=round(xk[i]+zk[i]*cos(alf));
t[i]:=round(yk[i]+zk[i]*sin(alf));
end;

setcolor(col[1]);
line(r[1],t[1],r[2],t[2]);
line(r[1],t[1],r[3],t[3]);
line(r[1],t[1],r[5],t[5]);
setcolor(col[2]);
line(r[4],t[4],r[2],t[2]);
setcolor(col[1]);
line(r[4],t[4],r[3],t[3]);
setcolor(col[2]);
line(r[4],t[4],r[8],t[8]);
line(r[6],t[6],r[2],t[2]);
setcolor(col[1]);
line(r[6],t[6],r[5],t[5]);
setcolor(col[2]);
line(r[6],t[6],r[8],t[8]);
setcolor(col[1]);
line(r[7],t[7],r[8],t[8]);
line(r[7],t[7],r[3],t[3]);
line(r[7],t[7],r[5],t[5]);


end;

procedure delkocka;
begin
setcolor(0);
line(r[1],t[1],r[2],t[2]);
line(r[1],t[1],r[3],t[3]);
line(r[1],t[1],r[5],t[5]);
line(r[4],t[4],r[2],t[2]);
line(r[4],t[4],r[3],t[3]);
line(r[4],t[4],r[8],t[8]);
line(r[6],t[6],r[2],t[2]);
line(r[6],t[6],r[5],t[5]);
line(r[6],t[6],r[8],t[8]);
line(r[7],t[7],r[8],t[8]);
line(r[7],t[7],r[3],t[3]);
line(r[7],t[7],r[5],t[5]);

end;

begin
readkey;
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