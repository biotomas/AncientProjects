program threed;
uses graph, crt;
var alf,x,y,p,z:real;
    scr,alfa,xo,yo,i,a,b:integer;
    xk,yk,zk: array[1..8] of real;
    r,t: array[1..8] of integer;
    k:char;

procedure screen;
begin
 setactivepage(scr);
 scr:=1-scr;
 setvisualpage(scr);
end;


procedure kockb;
begin
xk[1]:=x+p; yk[1]:=y+p; zk[1]:=z+p;
xk[2]:=x+p; yk[2]:=y+p; zk[2]:=z-p;
xk[3]:=x+p; yk[3]:=y-p; zk[3]:=z+p;
xk[4]:=x+p; yk[4]:=y-p; zk[4]:=z-p;
xk[5]:=x-p; yk[5]:=y+p; zk[5]:=z+p;
xk[6]:=x-p; yk[6]:=y+p; zk[6]:=z-p;
xk[7]:=x-p; yk[7]:=y-p; zk[7]:=z+p;
xk[8]:=x-p; yk[8]:=y-p; zk[8]:=z-p;

alf:=pi/180*alfa;
for i:=1 to 8 do begin
r[i]:=round(xk[i]+zk[i]*cos(alf));
t[i]:=round(yk[i]+zk[i]*sin(alf));
end;

setcolor(14);
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

initgraph(a,b,'c:\tp7\bgi\');
randomize;
x:=320;       {coordinates of the centre}
y:=240;
z:=-80;
p:=60;        {diameter}
alfa:=45;     {angle}

repeat
kockb;
putpixel(round(x+z*cos(alf)),round(y+z*sin(alf)),10);
alfa:=alfa+1;

p:=p-(0.3);
if p<-80 then p:=80;
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