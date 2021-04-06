uses graph,crt;
type rad=array[1..250] of byte;
var gd,gm,i,c1,c2,j,a,b,x1,y1,x2,y2,mx,my,mb:integer;
    f:file of rad;
    r:rad;
    k:char;
    fn:string[15];

procedure scan;
begin
 assign(f,fn);
 rewrite(f);
 r[1]:=x2-x1-1;
 write(f,r);
 for i:=y1+1 to y2-1 do
     begin
      for j:=x1+1 to x2-1 do r[j-x1]:=getpixel(j,i);
      write(f,r);
     end;
 close(f);
end;

procedure egerke;
var col: array [1..15] of byte;
  begin
   for i:=1 to 8 do begin
                     col[i]:=getpixel(mx,my-1+i);
                     putpixel(mx,my-1+i,15);
                    end;
   for i:=9 to 15 do begin
                     col[i]:=getpixel(mx+i-8,my+i-8);
                     putpixel(mx+i-8,my+i-8,0);
                    end;
  delay(10);
   for i:=1 to 8 do putpixel(mx,my-1+i,col[i]);
   for i:=9 to 15 do putpixel(mx+i-8,my+i-8,col[i]);

  end;

begin
gd:=3;
gm:=1;
initgraph(gd,gm,'');
rectangle(4,10,getmaxx-4,getmaxy-6);
rectangle(6,12,getmaxx-6,getmaxy-8);
outtextxy(3,1,'s to scan');
for i:=1 to 15 do
    begin
     setcolor(15);
     rectangle(600,i*20+5,625,i*20+20);
     setfillstyle(1,i);
     floodfill(612,i*20+7,15);
    end;
{write here}
fn:='brick.tt';
setcolor(1);
bar(50,50,200,100);
setcolor(8);
rectangle(55,55,195,95);

{write here}

repeat
asm
   mov ax,3
   int 33h
   mov mx,cx
   mov my,dx
   mov mb,bx
end;
egerke;
if mb=1 then
   begin
    if mx>600 then c1:=getpixel(mx,my) else putpixel(mx,my,c1);
   end;
if mb=2 then
   begin
    if mx>600 then c2:=getpixel(mx,my) else putpixel(mx,my,c2);
   end;

if keypressed then k:=readkey;
  if k in ['s','S'] then
     begin
      repeat
      setcolor(15);
      outtextxy(100,1,'point the upper left corner');
            repeat
                  asm
                  mov ax,3
                  int 33h
                  mov mx,cx
                  mov my,dx
                  mov mb,bx
                  end;
                  egerke;
                  if mb=1 then begin x1:=mx; y1:=my; end;
            until mb=1;
      setcolor(0);
      outtextxy(100,1,'point the upper left corner');
      putpixel(x1,y1,15);
      setcolor(15);
      outtextxy(100,1,'point the lower right corner');
      delay(500);
            repeat
                  asm
                  mov ax,3
                  int 33h
                  mov mx,cx
                  mov my,dx
                  mov mb,bx
                  end;
                  egerke;
                  if mb=1 then begin x2:=mx; y2:=my; end;
            until mb=1;
      setcolor(0);
      outtextxy(100,1,'point the lower right corner');
      setcolor(15);
      rectangle(x1,y1,x2,y2);
      outtextxy(100,1,'OK? (y/n)');
      k:=readkey;
      if k in ['y','Y'] then scan;
      setcolor(0);
      outtextxy(100,1,'OK? (y/n)');
      rectangle(x1,y1,x2,y2);
      until k in ['y','Y'];
      mb:=3;
     end;

until (ord(k)=27) or (mb=3);
closegraph;
end.