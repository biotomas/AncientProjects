uses crt,graph;
var r:array[1..101] of byte; {max 255}
    scr,d,i,gd,gm:integer;
    j:real;
procedure screen;
begin
setactivepage(scr);
scr:=1-scr;
setvisualpage(scr);
delay(25);
end;

begin
randomize;
scr:=1;
gd:=3;
gm:=1;
initgraph(gd,gm,'c:\tp7\bgi');
for i:=1 to 100 do r[i]:=random(25)+1;
j:=0;
ellipse(320,175,0,360,135,95);
repeat
screen;
cleardevice;
ellipse(320,175,0,360,135,95);
moveto(320+round((r[1]+150)*cos(pi/50*(1+j))),175+round((r[1]+100)*sin(pi/50*(1+j))));
for i:=1 to 100 do
    begin
     lineto(320+round((r[i]+150)*cos(pi/50*(i+j))),175+round((r[i]+100)*sin(pi/50*(i+j))));
    end;
lineto(320+round((r[1]+150)*cos(pi/50*(1+j))),175+round((r[1]+100)*sin(pi/50*(1+j))));

line(320,175,320+round(135*cos(pi/50*j)),175+round(95*sin(pi/50*j)));
line(320,175,320+round(135*cos(pi/50*(j+33))),175+round(95*sin(pi/50*(j+33))));
line(320,175,320+round(135*cos(pi/50*(j+66))),175+round(95*sin(pi/50*(j+66))));

j:=j+0.2;
if round(j) mod 4=0 then for i:=1 to 100 do r[i]:=random(25)+1;
if j=101 then j:=1;
until keypressed;
closegraph;
end.