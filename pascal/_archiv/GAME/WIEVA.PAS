uses graph,crt;
type rad=array[1..250] of byte;
var i,j,gd,gm,l:integer;
    f:file of rad;
    r:rad;
begin
gd:=3;
gm:=1;
assign(f,'brick.tt');
reset(f);
read(f,r);
l:=r[1];
initgraph(gd,gm,'');
for i:=1 to filesize(f)-1 do
    begin
     read(f,r);
     for j:=1 to l do putpixel(50+j,50+i,r[j]);
    end;
readkey;
closegraph;
close(f);
end.