program dimensions;
uses graph,crt;
var gd,gm: integer;
    cx,cy:array [1..5] of integer;
    x,y,z: integer;
    x2,y2,z2,x4,y4,z4:integer;
    cex,cez,cey:integer;
    k:char;

procedure hit;
begin
k:=readkey;
case ord(k) of 75: cex:=cex-4;
               77: cex:=cex+4;
               72: cez:=cez-4;
               80: cez:=cez+4;
               end;
end;

procedure redim(rx,ry,rz,i:integer);
begin
cx[i]:=round(rx+(rz/cez*(cex-rx)));
cy[i]:=round(ry+(rz/cez*(cey-ry)));
end;

procedure dline(x1,y1,z1,x2,y2,z2:integer);
begin
redim(x1,y1,z1,1);
redim(x2,y2,z2,2);
line(cx[1],cy[1],cx[2],cy[2]);
end;

procedure drectangle(x1,y1,z1,x3,y3,z3:integer);
begin
x2:=x3;
y2:=y1;
z2:=z3;
x4:=x1;
y4:=y3;
z4:=z1;
redim(x1,y1,z1,1);
redim(x2,y2,z2,2);
redim(x3,y3,z3,3);
redim(x4,y4,z4,4);
line(cx[1],cy[1],cx[2],cy[2]);
line(cx[2],cy[2],cx[3],cy[3]);
line(cx[3],cy[3],cx[4],cy[4]);
line(cx[4],cy[4],cx[1],cy[1]);
end;

begin
initgraph(gd,gm,'c:\tp7\bgi');
putpixel(320,240,15);
z:=450;
cez:=500;
cex:=320;
cey:=240;

repeat
setcolor(15);
drectangle(50,50,(z-250),50,430,z);
drectangle(590,50,(z-250),590,430,z);

delay(10);
setcolor(0);
drectangle(50,50,(z-250),50,430,z);
drectangle(590,50,(z-250),590,430,z);

z:=z-2;
if z=0 then z:=450;
if   keypressed then hit;
until ord(k)=27;
closegraph;
end.