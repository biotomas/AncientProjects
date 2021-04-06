uses graph,crt,dim;
var gd,gm,mx,my,mb:integer;
    l,omx,omy,x,y:integer;
begin
initgraph(gd,gm,'c:\tp7\bgi');
x:=100;
y:=100;
repeat
cleardevice;
bar(x,y,x+20,y+20);
omx:=mx;
omy:=my;
asm
   mov ax,3
   int 33h
   mov mx,cx
   mov my,dx
   mov mb,bx
end;
egerke(mx,my,15);
if mb=1 then l:=1-l;
if (l=1) then  begin
x:=x-omx+mx;
y:=y-omy+my;
end;{of if}

until keypressed;
closegraph;
end.