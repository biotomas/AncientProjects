uses fw2tpu,graph,crt;

procedure screen;
begin
 setactivepage(scr);
 scr:=1-scr;
 setvisualpage(scr);
end;

begin
 a:=3;
 b:=1;
 initgraph(a,b,'c:\tp7\bgi');


 x:=320;
 y:=200;
 x1:=round(x);
 y1:=round(y);
 repeat
  cleardevice;
  setbkcolor(12);
  asm
   mov ax,3
   int 33h
   mov mx,cx
   mov my,dx
   mov mb,bx
  end;
  mouse;
  if mb=1 then begin
   x1:=mx;
   y1:=my;
  end;
  test;
  setcolor(15);
  circle(120,240,10);
  floodfill(120,240,15);
  setcolor(10);
  circle(x1,y1,2);
  circle(round(x),round(y),2);
  delay(50);
  screen;
 until keypressed;
end.