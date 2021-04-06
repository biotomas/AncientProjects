uses graph, crt;
var c,endw,x,y,a,b,l,dir,speed:integer;
      wx,wy: array [1..500] of integer;
      k:char;
      sx,sy:string;
procedure body(hx,hy:integer);
begin
 setcolor(7);
if (dir=2) or (dir=4) then rectangle((hx-10),(hy-10),(hx+10),(hy+10));
if (dir=1) or (dir=3) then rectangle((hx-10),(hy-10),(hx+10),(hy+10));
 setfillstyle(1,7);
 floodfill(hx,hy,7);
end;



procedure worm;
begin
 if dir=1 then y:=y-20;
 if dir=2 then x:=x+20;
 if dir=3 then y:=y+20;
 if dir=4 then x:=x-20;
body(x,y);
delay(speed);
end;


begin
 initgraph(a,b,'c:\tp7\bgi\');
 setcolor(12);
 rectangle(20,20,520,460);
 rectangle(522,460,620,20);
 rectangle(18,18,622,462);

dir:=2;
x:=100;
y:=240;
speed:=200;
readkey;
 c:=0;
repeat
 if keypressed then begin
                     k:=readkey;
                     if ord(k)=72 then dir:=1;
                     if ord(k)=77 then dir:=2;
                     if ord(k)=80 then dir:=3;
                     if ord(k)=75 then dir:=4;
                        if ord(k)=27 then endw:=1;
                    end;
 if c=l then begin


             end;

setcolor(15);
str(x,sx);
str(y,sy);
outtextxy(550,30,sx);
outtextxy(550,40,sy);

 worm;
c:=c+1;

setcolor(2);
rectangle(535,25,600,50);
setfillstyle(1,0);
floodfill(550,35,2);

until endw=1;



closegraph;
end.