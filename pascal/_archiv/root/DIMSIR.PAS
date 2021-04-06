program dimensions;
uses graph,crt;
var gd,gm: integer;
    cx,cy:array [1..5] of integer;
    x,y,z,zz: integer;
    omx,omy,mb,mx,my,x2,y2,z2,x4,y4,z4:integer;
    alf2,cont,r,alf,col,cex,cey,cez:integer;
    k:char;
    first:boolean;
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


begin
initgraph(gd,gm,'c:\tp7\bgi');
mx:=320;
my:=240;
cex:=320;
cey:=240;
cez:=500;
z:=350;
zz:=150;
alf:=0;
cont:=0;
r:=430;  {radius}
first:=true;

repeat

omx:=mx;
omy:=my;
asm
   mov ax,3
   int 33h
   mov mx,cx
   mov my,dx
   mov mb,bx
end;
cex:=mx;
cey:=my;
col:=random(15)+1;
setcolor(col);
dline(320,240,zz,(320+round(r*(cos(pi/180*alf)))),(240+round(r*(sin(pi/180*alf)))),z);
dline(320,240,zz,(320+round(r*(cos(pi/180*(alf+120))))),(240+round(r*(sin(pi/180*(alf+120))))),z);
dline(320,240,zz,(320+round(r*(cos(pi/180*(alf+240))))),(240+round(r*(sin(pi/180*(alf+240))))),z);
if cont>100 then
   BEGIN
    alf2:=alf-45;
    setcolor(0);
dline(320,240,zz,(320+round(r*(cos(pi/180*alf2)))),(240+round(r*(sin(pi/180*alf2)))),z);
dline(320,240,zz,(320+round(r*(cos(pi/180*(alf2+120))))),(240+round(r*(sin(pi/180*(alf2+120))))),z);
dline(320,240,zz,(320+round(r*(cos(pi/180*(alf2+240))))),(240+round(r*(sin(pi/180*(alf2+240))))),z);
    cont:=101;
   end;
cont:=cont+1;
alf:=alf+1;
if alf=360 then alf:=0;
if (omx<>mx) or (omy<>my) then cleardevice;
until keypressed;
closegraph;
end.