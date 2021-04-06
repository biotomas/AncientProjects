uses graph, crt;
var mx,my,mb,a,b:integer;
    k,x1,y1,x,y:real;
procedure movem;
begin
x1:=mx;
y1:=my;
if abs(y-y1)<>0 then
k:=abs(x-x1)/abs(y-y1);
repeat
if x>x1 then begin
             if y>y1 then begin
                          x:=x-k;
                          y:=y-1; end; end;
if x>x1 then begin
             if y<y1 then begin
                          x:=x-k;
                          y:=y+1; end; end;
if x<x1 then begin
             if y>y1 then begin
                          x:=x+k;
                          y:=y-1; end; end;
if x<x1 then begin
             if y<y1 then begin
                          x:=x+k;
                          y:=y+1; end; end;
setcolor(6);
circle(round(x),round(y),10);
delay(100);
until (round(x)=x1) or (round(y)=y1) ;
end;


begin
initgraph(a,b,'c:\tp7\bgi');
x:=320;
y:=240;
repeat
  asm
   mov ax,3
   int 33h
   mov mx,cx
   mov my,dx
   mov mb,bx
  end;
setcolor(15);
circle(mx,my,5);
delay(10);
setcolor(0);
circle(mx,my,5);
setcolor(10);
if mb=1 then movem;
until keypressed;
closegraph;
end.