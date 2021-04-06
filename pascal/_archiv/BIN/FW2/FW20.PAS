uses graph, crt;
var da,gd,gm,x,y:integer;
    k : char;
    action:boolean;

procedure town(town:integer);
 begin
  if town=7 then false;
 end;


procedure map(lvl:integer);
 begin
  cleardevice;
  if lvl=1 then begin
  setcolor(6);
  circle(100,100,50);
  setfillstyle(1,6);
  floodfill(100,100,6);
  setcolor(8);
  line(10,0,10,470);
  line(10,470,490,470);
  line(490,470,490,0);
  line(500,0,500,480);

  setfillstyle(1,8);
  floodfill(5,5,8);
  end;

  if lvl=2 then begin
  setcolor(6);
  circle(300,200,50);
  setfillstyle(1,9);
  floodfill(300,200,6);
  setcolor(8);
  line(10,10,10,480);
  line(10,10,490,10);
  line(490,10,490,480);
  line(500,0,500,480);
  setfillstyle(1,8);
  floodfill(5,5,8);
  end;

 end;


procedure jacky;
begin
 setcolor(9);
 circle(x,y,8);
 circle(x,(y-10),4);
 line(x,(y-8),(x-10),(y+15));
 line((x-10),(y+15),x,(y+8));
 line(x,(y-8),(x+10),(y+15));
 line((x+10),(y+15),x,(y+8));
end;

procedure delem;
begin
 setcolor(0);
 circle(x,y,8);
 circle(x,(y-10),4);
 line(x,(y-8),(x-10),(y+15));
 line((x-10),(y+15),x,(y+8));
 line(x,(y-8),(x+10),(y+15));
 line((x+10),(y+15),x,(y+8));
end;

procedure testj;
begin
 if (getpixel((x-15),(y-20))<>0)
 or (getpixel((x),(y-24))<>0)
 or (getpixel((x+15),(y-20))<>0)
 or (getpixel((x-19),(y))<>0)
 or (getpixel((x+19),(y))<>0)
 or (getpixel((x-15),(y+20))<>0)
 or (getpixel((x),(y+24))<>0)
 or (getpixel((x+15),(y+20))<>0)
 then action:=true else action:=false;
 if action=false then da:=0;
 if action=true then
 begin
 if (getpixel((x-15),(y-20))<>0)  then da:=7;
 if (getpixel((x),(y-24))<>0)     then da:=8;
 if (getpixel((x+15),(y-20))<>0)  then da:=1;
 if (getpixel((x-19),(y))<>0)     then da:=6;
 if (getpixel((x+19),(y))<>0)     then da:=2;
 if (getpixel((x-15),(y+20))<>0)  then da:=5;
 if (getpixel((x),(y+24))<>0)     then da:=4;
 if (getpixel((x+15),(y+20))<>0)  then da:=3;
 end;
if (da=7) or (da=6) or (da=5) then x:=x+4;
if (da=1) or (da=2) or (da=3) then x:=x-4;
if (da=7) or (da=8) or (da=1) then y:=y+4;
if (da=3) or (da=4) or (da=5) then y:=y-4;
end;


begin
 x:=300;
 y:=200;
randomize;
  gd:=detect;
  initgraph(gd,gm,'c:\tp7\bgi\');
  if graphresult<>grok then halt;
map(1);
repeat
jacky;
k:=readkey;
delem;
case ord(k) of 72: y:=y-4;
               80: y:=y+4;
               75: x:=x-4;
               77: x:=x+4;
               end;
testj;
if y<10 then begin
              map(2);
              y:=460;
             end;
if y>470 then begin
              map(1);
              y:=11;
             end;
until ord(k)=27;
  closegraph;
end.