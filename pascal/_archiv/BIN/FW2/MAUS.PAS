uses graph, crt;
var x,y,mx,mb,my,gd,gm:integer;
begin
    gd:=detect;
  initgraph(gd,gm,'c:\tp7\bgi\');
  if graphresult<>grok then halt;

  repeat
  asm
   mov ax,3
   int 33h
   mov mx,cx
   mov my,dx
   mov mb,bx
  end;
   x:=mx;
   y:=my;
   setcolor(14);
  circle(x,y,4);
   delay(50);
   setcolor(0);
  circle(x,y,4);
 until keypressed;
 closegraph;
end.