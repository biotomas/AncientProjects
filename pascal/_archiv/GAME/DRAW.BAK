uses graph,crt;
var gd,gm,mx,my,mb:integer;
    k:char;
    x,y,col,i,j,sx,sy:byte;
    strin:string;

procedure savepict;
type hor=array [1..100] of byte;
var fil:file of hor;
    ln:hor;
begin
assign(fil,'c:\tp7\game\'+strin+'.pic');
rewrite(fil);
ln[1]:=sx;
ln[2]:=sy;
ln[3]:=gd;
ln[4]:=gm;
write(fil,ln);
 for i:=1 to sy do
  begin
   for j:=1 to sx do ln[j]:= getpixel(16+(j-1)*trunc(500/sx),16+(i-1)*trunc((getmaxy-30)/sy));
   write(fil,ln);
  end;
close(fil);
end;


procedure kboard;
begin
k:=readkey;
if k in ['s','S'] then savepict;
end;

procedure egerke(egcl:byte);
var col: array [1..15] of byte;
  begin
   for i:=1 to 8 do begin
                     col[i]:=getpixel(mx,my-1+i);
                     putpixel(mx,my-1+i,egcl);
                    end;
   for i:=9 to 15 do begin
                     col[i]:=getpixel(mx+i-8,my+i-8);
                     putpixel(mx+i-8,my+i-8,egcl);
                    end;
  delay(10);
   for i:=1 to 8 do putpixel(mx,my-1+i,col[i]);
   for i:=9 to 15 do putpixel(mx+i-8,my+i-8,col[i]);

  end;


begin
clrscr;
Writeln('Zvol graf. mod');
writeln('640x480  \1\');
writeln('640x350  \2\');
k:=readkey;
if k='2' then begin gd:=3; gm:=1; end;
writeln('OK');
writeln('Zadaj rozmery obrazku (max 100x100)');
write('x = '); readln(sx);
write('y = '); readln(sy);
write('nazov suboru: '); readln(strin);
initgraph(gd,gm,'');
rectangle(5,5,525,getmaxy-5);
rectangle(534,4,636,106);
for i:=0 to 15 do
    begin
     rectangle(550,110+i*14,600,122+i*14);
     setfillstyle(1,i);
     floodfill(555,112+i*14,15);
    end;
setfillstyle(1,2);
floodfill(1,1,15);
for i:=0 to sx-1 do
  for j:=0 to sy-1 do
     rectangle(15+i*trunc(500/sx),15+j*trunc((getmaxy-30)/sy),15+(i+1)*trunc(500/sx),15+(j+1)*trunc((getmaxy-30)/sy));

repeat
asm
   mov ax,3
   int 33h
   mov mx,cx
   mov my,dx
   mov mb,bx
end;
egerke(15);
if (mb=2) and (getpixel(mx,my)<>15) then col:=getpixel(mx,my);
if (mb=1) and (mx<530) and (getpixel(mx,my)<>15) then
   begin
    setfillstyle(1,col);
    floodfill(mx,my,15);
    x:=1+ (mx-15) div trunc(500/sx);
    y:=1+ (my-15) div trunc((getmaxy-30)/sy);
    putpixel(534+x+trunc(sx/2),4+y+trunc(sy/2),col);
   end;
if keypressed then kboard;
until ord(k)=27;
closegraph;
end.