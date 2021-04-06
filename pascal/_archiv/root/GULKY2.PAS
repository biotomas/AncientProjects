uses graph,crt;   {buggy}
var x,y,px,py:array[1..5] of real;
    u,s:array[1..5] of integer;
    gd,gm,i:integer;

begin
randomize;
initgraph(gd,gm,'c:\tp7\bgi');
setlinestyle(0,1,2);
for i:=1 to 5 do
    begin
     s[i]:=20;
     x[i]:=random(300);
     y[i]:=random(250);
     u[i]:=random(360);
     px[i]:=cos(pi/180*u[i]);
     py[i]:=sin(pi/180*u[i]);
    end;

repeat
cleardevice;
for i:=1 to 5 do fillellipse(round(x[i]),round(y[i]),3,3);
for i:=1 to 5 do
    begin
     if (getpixel(round(x[i]+s[i]*px[i]),round(y[i]))<>0) or (getpixel(round(x[i]-s[i]*px[i]),round(y[i]))<>0)
     then u[i]:=180-u[i];
     if (getpixel(round(x[i]),round(y[i]+s[i]*py[i]))<>0) or (getpixel(round(x[i]),round(y[i]-s[i]*py[i]))<>0)
     then u[i]:=360-u[i];
     px[i]:=cos(pi/180*u[i]);
     py[i]:=sin(pi/180*u[i]);
     x[i]:=x[i]+s[i]*px[i];
     y[i]:=y[i]+s[i]*py[i];
    end;
until keypressed;
closegraph;
end.