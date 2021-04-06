program fw2;
uses crt,graph;
var scr,gd,gm:integer;
    f,col:integer;
    i,x,y: integer;
    mx,my,mb,p: integer;
    k:char;
    r:integer;

procedure screen;
begin
 setactivepage(scr);
 scr:=1-scr;
 setvisualpage(scr);
end;

procedure shooting;
begin
for i:=1 to 74 do begin
 line(x+7,(439-(i*5)),x+7,(434-(i*5)));
 delay(10);
 setcolor(0);
 line(x+7,(439-(i*5)),x+7,(434-(i*5)));
 setcolor(15);
end;
end;

procedure panak;
begin
 rectangle(x,435,x+15,450);
 setcolor(0);
 line(x,450,x+15,450);
 setcolor(15);
end;
procedure clpanak;
begin
 setcolor(0);
 rectangle(x,435,x+15,450);
 setcolor(15);
end;

begin
 randomize;
  gd:=3;
  gm:=1;
  initgraph(gd,gm,'c:\tp7\bgi\');
  if graphresult<>grok then halt;

repeat
cleardevice;
setbkcolor(5);
asm
   mov ax,3
   int 33h
   mov mx,cx
   mov my,dx
   mov mb,bx
end;

 setcolor(14);
 line(mx,my,mx,my+10);
 line(mx,my,mx+8,my+10);
 line(mx,my+10,mx+2,my+6);
 line(mx+8,my+10,mx+2,my+6);
 setfillstyle(1,14);
 floodfill(mx+1,my+3,14);

delay(50);
screen;
until keypressed;

closegraph;
end.