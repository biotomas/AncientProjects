program dimensions;
uses graph,crt,dim;
var gd,gm: integer;
    cex,cey,i,j,x,y,z: integer;
    scr,mb,mx,my:integer;
    k:char;

procedure screen;
begin
setactivepage(scr);
scr:=1-scr;
setvisualpage(scr);
end;
{procedure redim2(rx,ry,rz,i:integer);
begin
cx[i]:=round(rx+(rz/500*(320-rx)));
cy[i]:=round(ry+(rz/500*(240-ry)));
end;}

begin
gd:=3;
gm:=1;
initgraph(gd,gm,'c:\tp7\bgi');
{3d}
{Z dline(0,0,-500,0,0,500);
setcolor(15);
X dline(-500,0,0,500,0,0);
setcolor(15);
Y dline(0,-500,0,0,500,0);}
cex:=320;
cey:=240;
setcentre(cex,cey);
scr:=1;
setbkcolor(1);
repeat
screen;
cleardevice;
setcolor(8);
for i:=-10 to 10 do dline(i*35,-20,-350,i*35,-20,350);
for i:=-10 to 10 do dline(350,-20,i*35,-350,-20,i*35);
setcolor(15);
cube(-150,-100,100,-100,-20,20);
cube(-150,-100,100,-100,-175,20);
cube(60,-20,0,150,40,120);
cube(0,-20,-200,100,75,-220);
asm
   mov ax,3
   int 33h
   mov mx,cx
   mov my,dx
   mov mb,bx
end;
circle(mx,my,5);
if mx<2 then cex:=cex+9;
if mx>638 then cex:=cex-9;
if my<2 then cey:=cey+9;
if my>338 then cey:=cey-9;
{
   setcolor(0);
   for i:=-10 to 10 do dline(i*35,-20,-350,i*35,-20,350);
   for i:=-10 to 10 do dline(350,-20,i*35,-350,-20,i*35);
   cube(-150,-100,100,-100,-20,20);
   cube(-150,-100,100,-100,-175,20);
   cube(60,-20,0,150,40,120);
   cube(0,-20,-200,100,75,-220);
}
setcentre(cex,cey);

until keypressed;
closegraph;
end.