uses crt,graph;
var x,y,gd,gm,s,a:integer;
    r:real;
    t:string;
begin
initgraph(gd,gm,'c:\tp7\bgi');
setfillstyle(1,7);
bar(50,191,200,289);
s:=-70;
repeat
{delit}
setcolor(0);
line(201,195,210+a,195);
line(201,285,210+a,285);
line(210+a,195,210+a,285);
circle(210+a,240,5);
rectangle(60,180-a,160,190);
rectangle(60,300+a,160,290);
x:=530+round(70*cos(pi/70*s));
y:=240+round(70*sin(pi/70*s));
circle(x,y,5);
line(x,y,210+a,240);
line(x,y,530,240);
setcolor(15);
circle(530,240,70);
s:=s+1;
if s<0 then a:=2*(s+70) else a:=280-(2*(s+70));
if s>69 then s:=-70;

line(201,195,210+a,195);
line(201,285,210+a,285);
line(210+a,195,210+a,285);
circle(210+a,240,5);
x:=530+round(70*cos(pi/70*s));
y:=240+round(70*sin(pi/70*s));
circle(x,y,5);
line(x,y,210+a,240);
line(x,y,530,240);
rectangle(60,180-a,160,190);
rectangle(60,300+a,160,290);

delay(25);
until keypressed;


closegraph;
end.