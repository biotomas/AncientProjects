uses crt, graph;
const c=9;
type obrazok=array[1..50,1..50] of byte;
var gd,gm:integer;
    i,j,col: byte;
    k: char;
    f: file of obrazok;
    s: string[20];
    o: obrazok;
{---------------------------------------------------------------}
{---------------------------------------------------------------}
procedure draw;
begin
initgraph(gd,gm,'c:\tp7\bgi');
setcolor(8);
for i:=1 to 50 do
  for j:=1 to 50 do
   begin
    rectangle(c+i*c,c+j*c,2*c+i*c,2*c+j*c);
    setfillstyle(1,o[i,j]);
    floodfill(c+i*c+1,c+j*c+1,8);
    putpixel(525+i,10+j,o[i,j]);
   end; {of for}
for i:=0 to 15 do
  begin
   rectangle(500,100+i*20,600,118+i*20);
   setfillstyle(1,i);
   floodfill(550,105+i*20,8);
  end; {of for}
setcolor(15); circle(620,110,7);
rectangle(525,10,576,61);
setcolor( 0); rectangle(2*c,2*c,3*c,3*c);
i:=1; j:=1;
repeat
  k:=readkey;
  setcolor(0); circle(620,col*20+110,7);
  setcolor(8); rectangle(c+i*c,c+j*c,2*c+i*c,2*c+j*c);
  if k='+' then begin col:=col+1; if col=16 then col:=0; end;
  if k='-' then begin col:=col-1; if col=255 then col:=15; end;
  case ord(k) of 75: begin i:=i-1; if i=0 then i:=50; end;
                 77: begin i:=i+1; if i=51 then i:=1; end;
                 80: begin j:=j+1; if j=51 then j:=1; end;
                 72: begin j:=j-1; if j=0 then j:=50; end;
                 32: begin
                      setfillstyle(1,col);
                      floodfill(1+c+i*c,1+c+j*c,8);
                      putpixel(525+i,10+j,col);
                      o[i,j]:=col;
                     end;
                 end;
  setcolor(15); circle(620,col*20+110,7);
  setcolor(col); rectangle(c+i*c,c+j*c,2*c+i*c,2*c+j*c);
until ord(k)=27;
closegraph;
end; {of proc draw}
{---------------------------------------------------------------}
procedure pack;
begin
end; {of proc pack}
{---------------------------------------------------------------}
procedure newf;
begin
write('Enter filename: ');
readln(s);
assign(f,s);
rewrite(f);
draw;
pack;
write(f,o);
close(f);
end; {of proc newf}
{---------------------------------------------------------------}
procedure openf;
begin
repeat
write('Enter filename: ');
readln(s);
{$I-}
Assign(f,s);
reset(f);
close(f);
{$I+}
if (IOResult = 0) then
  begin
   assign(f,s);
   reset(f);
   read(f,o);
   draw;
   seek(f,0);
   write(f,o);
   close(f);
   exit;
  end
  else writeln('File not found, enter exit to exit.')
until (s='exit')
end; {of proc openf}
{---------------------------------------------------------------}
{---------------------------------------------------------------}
{---------------------------------------------------------------}
begin
clrscr;
writeln('A-Draw version 1.0');
writeln;
writeln(' 1, New file');
writeln(' 2, Edit file');
writeln(' 3, Exit');
repeat k:=readkey; until k in ['1','2','3'];
if k='3' then halt;
if k='1' then newf;
if k='2' then openf;
end.