uses crt, graph;
var ender,i,di,a,b,x,y,nx,ny:integer;
         k:char;
       crash:boolean;


procedure crashtest(dir:integer);
begin
crash:=false;
case dir of
1: begin
    for i:=1 to 21 do begin
     if getpixel(x,(y-19-i))<>0 then crash:=true;
     if getpixel((x-20),(y-19-i))<>0 then crash:=true;
     if getpixel((x+20),(y-19-i))<>0 then crash:=true;
    end;
   end;
3: begin
    for i:=1 to 21 do begin
     if getpixel(x,(y+19+i))<>0 then crash:=true;
     if getpixel((x-20),(y+19+i))<>0 then crash:=true;
     if getpixel((x+20),(y+19+i))<>0 then crash:=true;
    end;
   end;
2: begin
    for i:=1 to 21 do begin
     if getpixel((x+20+i),y)<>0 then crash:=true;
     if getpixel((x+20+i),(y-19))<>0 then crash:=true;
     if getpixel((x+20+i),(y+19))<>0 then crash:=true;
    end;
   end;
4: begin
    for i:=1 to 21 do begin
     if getpixel((x-20-i),y)<>0 then crash:=true;
     if getpixel((x-20-i),(y-19))<>0 then crash:=true;
     if getpixel((x-20-i),(y+19))<>0 then crash:=true;
    end;
   end;
end;
end;

procedure hero;
begin
setcolor(12);
circle(x,y,15);
circle(x,y-19,7);
line(x+3,y+3,x+3,y+20);
line(x+3,y+3,x+20,y+20);
line(x+3,y+20,x+20,y+20);
line(x-3,y+3,x-3,y+20);
line(x-3,y+3,x-20,y+20);
line(x-3,y+20,x-20,y+20);
end;

procedure clhero;
begin
setcolor(0);
circle(x,y,15);
circle(x,y-19,7);
line(x+3,y+3,x+3,y+20);
line(x+3,y+3,x+20,y+20);
line(x+3,y+20,x+20,y+20);
line(x-3,y+3,x-3,y+20);
line(x-3,y+3,x-20,y+20);
line(x-3,y+20,x-20,y+20);
end;

procedure drawmap(map:integer);
begin
cleardevice;
case map of
1: begin
    setcolor(12);
    line(0,0,0,480);
    line(10,480,10,10);
    line(10,10,640,10);
    setfillstyle(1,12);
    floodfill(5,5,12)
   end;
2: begin
    setcolor(12);
    line(0,10,630,10);
    line(630,10,630,480);
    setfillstyle(1,12);
    floodfill(5,5,12)
   end;
11: begin
    setcolor(12);
{    line(10,0,10,480);   }
    line(0,470,640,470);
    setfillstyle(1,12);
    floodfill(5,475,12)
   end;
12: begin
{    setcolor(12);
    line(0,10,630,10);
    line(630,10,630,480);
    setfillstyle(1,12);
    floodfill(5,5,12)}
   end;

end;
end;

begin
initgraph(a,b,'c:\tp7\bgi');
x:=240;
y:=240;
drawmap(1);
setcolor(12);
repeat
hero;
repeat
k:=readkey;
case ord(k) of 75: di:=4;
               77: di:=2;
               72: di:=1;
               80: di:=3;
               end;
clhero;
crashtest(di);
if crash=false then begin
 case di of 1: y:=y-15;
            2: x:=x+15;
            3: y:=y+15;
            4: x:=x-15; end;
ender:=1;
end;
until (ord(k)=27) or (ender=1);
until (ord(k)=27);
closegraph;
end.