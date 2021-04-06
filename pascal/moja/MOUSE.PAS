uses graph,crt;
var gd,gm:integer;
    mx,my,mb:integer;
    scr:boolean;
    sdelay:byte;

procedure screen; {vymiena obrazovky pre plynulejsie animacie}
begin
setactivepage(ord(scr));
scr:=not scr;
setvisualpage(ord(scr));
delay(sdelay);
cleardevice;
end;



begin
initgraph(gd,gm,'c:\tp\bgi');
sdelay:=10;
repeat

if mb=1 then
   begin
   line(0,my,640,my);
   line(mx,0,mx,480);
   end;
if mb=3 then cleardevice;
if mb=2 then setcolor(getcolor+1 mod 16);

asm
 mov ax,3
 int 33h
 mov mx,cx
 mov my,dx
 mov mb,bx
end;

until keypressed;
closegraph;
end.