uses graph,crt;
type rad=array[1..250] of byte;
var x,y,cx,cy,scr,i,j,gd,gm,l:integer;
    f:file of rad;
    r:rad;
    p:pointer;
    k:char;
    size:word;

procedure screen;
begin
setactivepage(scr);
scr:=scr-1;
setvisualpage(scr);
end;

begin
gd:=3;
gm:=1;
assign(f,'brick.tt');
reset(f);
read(f,r);
l:=r[1];
initgraph(gd,gm,'');
setactivepage(1);
setvisualpage(0);
for i:=1 to filesize(f)-1 do
    begin
     read(f,r);
     for j:=1 to l do putpixel(50+j,50+i,r[j]);
    end;

Size := ImageSize(50, 50, 50+l, 50+filesize(f));
GetMem(p, Size);   { Allocate memory on heap }
GetImage(50, 50, 50+l, 50+filesize(f),p^);

cx:=0;
cy:=300;

repeat
cleardevice;
putimage(cx,cy,p^,xorput);
screen;
{k:=readkey;
if ord(k)=75 then cx:=cx+13;
if ord(k)=77 then cx:=cx-13;}
cx:=cx+2;
cy:=cy-1;
until (keypressed) or (ord(k)=27);

closegraph;
close(f);
end.