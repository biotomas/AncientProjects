program intro;
uses crt,graph;
var gd,gm:integer;
    x,y,f,col:integer;
    k:char;
    r:integer;
begin
 randomize;

  gd:=detect;
  initgraph(gd,gm,'c:\tp7\bgi\');
  if graphresult<>grok then halt;

r:=1;
x:=160;
y:=120;
col:=9;

delay(1000);
repeat
 putpixel(x,y,col);
 putpixel(x,(240+(240-y)),col);
 putpixel((320+(320-x)),(240+(240-y)),col);
 putpixel((320+(320-x)),y,col);

 putpixel((x+320),(y+240),col);
 putpixel((x+320),(240+(240-(y+240))),col);
 putpixel((320+(320-(x+320))),(240+(240-(y+240))),col);
 putpixel((320+(320-(x+320))),(y+240),col);
 f:=random(8);
if f=0 then x:=x+1;
if f=1 then x:=x-1;
if f=2 then y:=y+1;
if f=3 then y:=y-1;
if f=4 then begin x:=x+1; y:=y+1; end;
if f=5 then begin x:=x-1; y:=y+1; end;
if f=6 then begin x:=x-1; y:=y-1; end;
if f=7 then begin x:=x+1; y:=y-1; end;

if x>320 then x:= 320;
if y>240 then y:= 240;
if y<10 then y:= 10;
if x<10 then x:= 10;

r:=r+1;
if r= 30001 then begin
      repeat
      col:=(random(16)+1); r:=0;
      cleardevice;
      until (col<>14) and (col<>0);
      end;

if r mod 100 =0 then begin
      setcolor(14);
      settextstyle(1,0,8);
      moveto(80,150);
      outtext('Farm Wars II');
      settextstyle(1,0,5);
      moveto(45,230);
      outtext('The Agrocultural Revolution');
      end;
until keypressed;

readkey;
k:=readkey;
closegraph;
end.