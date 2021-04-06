uses graph,crt;
var gd,gm,u1,u2,j:integer;
    a,i,u,p:real;
    k:char;
begin
initgraph(gd,gm,'c:\tp7\bgi');
repeat
restorecrtmode;
clrscr;
repeat
write('Uhol pociatocny u = ');
readln(u1);
write('Uhol konecny    u = ');
readln(u2);
if u2<=u1 then writeln('Uhol konecny nech je vacsi ako pociatocny');
until u2>u1;
write('prirastok uhla  a = ');
readln(a);
p:=500/((u2-u1)/a);
setgraphmode(getgraphmode);
line(65,45,70,40);
line(70,40,75,45);
line(70,240,570,240);
line(70,40,70,440);
u:=u1;
i:=70;
moveto(70,240-round(150*sin(pi/180*u)));
repeat
u:=u+a;
i:=i+p;
lineto(round(i),240-round(150*sin(pi/180*u)));
until (u>=u2) or (keypressed);
outtextxy(120,10,'<Press any key to repeat or esc to exit>');
k:=readkey;
until ord(k)=27;
closegraph;
end.
