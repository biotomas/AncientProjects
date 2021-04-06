uses graph, crt;
var da,gd,gm,x,y,mx,my,mb,pix:integer;
    k : char;
    action:boolean;


procedure town(town:integer);
 begin
 cleardevice;
if town=1 then begin
    setcolor(15);
    circle(320,720,400);
    rectangle(30,350,130,330);
    rectangle(150,300,250,280);
    rectangle(270,250,370,230);
    rectangle(510,350,610,330);
    rectangle(390,300,490,280);
    setfillstyle(1,2);
    floodfill(100,340,15);
    setfillstyle(1,4);
    floodfill(200,290,15);
    setfillstyle(1,6);
    floodfill(300,240,15);
    setfillstyle(1,7);
    floodfill(520,340,15);
    setfillstyle(1,5);
    floodfill(400,290,15);
   end;
repeat
  asm
   mov ax,3
   int 33h
   mov mx,cx
   mov my,dx
   mov mb,bx
  end;
   setcolor(14);
  circle(mx,my,4);
   delay(50);
   setcolor(0);
  circle(mx,my,4);
 until keypressed;

readkey;
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
  setcolor(9);
  circle(300,200,50);
  setfillstyle(1,9);
  floodfill(300,200,9);
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
 case da of 7: pix:=(getpixel((x-15),(y-20)));
            8: pix:=(getpixel((x),(y-24)));
            1: pix:=(getpixel((x+15),(y-20)));
            6: pix:=(getpixel((x-19),(y)));
            2: pix:=(getpixel((x+19),(y)));
            5: pix:=(getpixel((x-15),(y+20)));
            4: pix:=(getpixel((x),(y+24)));
            3: pix:=(getpixel((x+15),(y+20)));
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

if (action=true) and (pix=6) then begin
  setcolor(15);
   repeat
  moveto(505,400);
  outtext('want enter? (Y/N)');
  k:=readkey;

  if (ord(k)=121) or (ord(k)=89)  then begin
                 town(1);
                 map(1);
                end;
   until (ord(k)=110) or (ord(k)=78) or (ord(k)=121) or (ord(k)=89);
  setcolor(0);
  moveto(505,400);
  outtext('want enter? (Y/N)');

end;

until ord(k)=27;
  closegraph;
end.