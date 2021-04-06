uses graph,crt;
var x,y,xx,yy:array[1..60] of integer;
    del,max,u,uu,a,b,i: integer;
    x1,x2,y1,y2:string[4];
    k:char;
procedure display;
begin
setcolor(0);
outtextxy(100,5,x1);
str(del,x1);
setcolor(15);
outtextxy(100,5,x1);
end;

procedure keyboard;
begin
if ord(k)=32 then readkey;
if k='r' then
   begin
    u:=random(360)+5;
    uu:=random(360)+5;
   end;
if k='+' then del:=del+1;
if k='-' then del:=del-1;
if del<1 then del:=1;
if del>100 then del:=100;
end;

begin
initgraph(a,b,'c:\tp7\bgi');
u:=random(350)+5;
uu:=random(350)+5;

del:=30;
max:=26;
x[1]:=120;
y[1]:=120;
xx[1]:=200;
yy[1]:=120;

i:=2;

repeat
if i<>1 then begin
   x[i]:=x[i-1]+round(5*cos(pi/180*u));
   y[i]:=y[i-1]+round(5*sin(pi/180*u));
   xx[i]:=xx[i-1]+round(5*cos(pi/180*uu));
   yy[i]:=yy[i-1]+round(5*sin(pi/180*uu));
   end;
if i=1 then begin
   x[i]:=x[max]+round(5*cos(pi/180*u));
   y[i]:=y[max]+round(5*sin(pi/180*u));
   xx[i]:=xx[max]+round(5*cos(pi/180*uu));
   yy[i]:=yy[max]+round(5*sin(pi/180*uu));
   end;

if (x[i]<20) or (x[i]>620) then u:=180-u;
if (y[i]<20) or (y[i]>460) then u:=360-u;
if (xx[i]<20) or (xx[i]>620) then uu:=180-uu;
if (yy[i]<20) or (yy[i]>460) then uu:=360-uu;

setcolor(9);
rectangle(19,19,621,461);
setcolor(random(15)+1);
line(x[i],y[i],xx[i],yy[i]);
setcolor(0);
if i<>max then line(x[i+1],y[i+1],xx[i+1],yy[i+1]) else line(x[1],y[1],xx[1],yy[1]);
i:=i+1;
if i=max+1 then i:=1;
display;
delay(del);
if keypressed then begin k:=readkey; if ord(k)<>27 then keyboard; end;
until ord(k)=27;
closegraph;
end.