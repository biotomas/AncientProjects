uses graph,crt;
type jaj=array[1..50] of byte;
var f:file of jaj;
    r:jaj;
    gd,gm:integer;
    x,y,ox,oy,i,j,c,oc:byte;
    k:char;
    s:string[15];

function FileExists(FileName: String): Boolean;
var
 F: file;
begin
 {$I-}
 Assign(F, FileName);
 Reset(F);
 Close(F);
 {$I+}
 FileExists := (IOResult = 0) and (FileName <> '');
end;


procedure savep;
type hop=array[1..50] of byte;
var r:hop; f:file of hop; sx,sy,ex,ey:byte;
    s:string[7]; k:char; go:boolean;
 begin
  s:='';
  setfillstyle(1,0);
  floodfill(507,67,15);
  setcolor(7);
  outtextxy(510,70,'Enter filename: ');
  repeat
  setcolor(7); outtextxy(510,90,s);
  k:=readkey; setcolor(0); outtextxy(510,90,s);
  if ord(k)=8 then s:=''; if ord(k)<>13 then s:=s+k;
  until ord(k)=13;
  setcolor(7); outtextxy(510,90,'Saved as '+s);

  i:=0; go:=false; repeat
  i:=i+1;
  for j:=1 to 49 do if getpixel(520+i,10+j)<>0 then go:=true;
  until go; sx:=i;
  i:=50; go:=false; repeat
  i:=i-1;
  for j:=1 to 49 do if getpixel(520+i,10+j)<>0 then go:=true;
  until go; ex:=i;
  i:=0; go:=false; repeat
  i:=i+1;
  for j:=1 to 49 do if getpixel(520+j,10+i)<>0 then go:=true;
  until go; sy:=i;
  i:=50; go:=false; repeat
  i:=i-1;
  for j:=1 to 49 do if getpixel(520+j,10+i)<>0 then go:=true;
  until go; ey:=i;

  assign(f,s+'.pic');
  rewrite(f);
  r[1]:=ex-sx; r[2]:=ey-sy; write(f,r);
  for i:=sx to ex do
   begin
    for j:=sy to ey do r[j-sy+1]:=getpixel(520+i,10+j);
    write(f,r)
   end;
  close(f);
 end;

begin
c:=1; oc:=1;
x:=1; y:=1; ox:=1; oy:=1;
clrscr;
writeln('New file ? (y/n) ');
repeat k:=readkey; until k in ['y','n','Y','N'];
if k in ['n','N'] then
   begin
    write('Enter the filename: ');
    readln(s);
    if fileexists(s) then
     begin
     assign(f,s);
     reset(f);
     end;
   end;

writeln('Select display mode');
writeln('*1* 640x480');
writeln('*2* 640x350');
repeat k:=readkey; if k='2' then begin gd:=3; gm:=1; end; until k in ['1','2'];
initgraph(gd,gm,'c:\tp\bgi');
setcolor(8);
if k='1' then
 begin
 for i:=1 to 50 do line(10,1+i*9,500,1+i*9);
 for i:=1 to 50 do line(i*10,10,i*10,451);
 end;
if k='2' then
 begin
 for i:=1 to 50 do line(10,i*7-3,500,i*7-3);
 for i:=1 to 50 do line(i*10,4,i*10,347);
 end;
for i:=0 to 15 do
 begin
 setcolor(i); setfillstyle(1,i);
 rectangle(520,100+i*15,600,112+i*15);
 floodfill(525,100+i*15+2,i);
 end;
setcolor(15);
circle(610,122,7);
rectangle(520,10,570,60);
rectangle(505,65,635,110);
setcolor(7);
outtextxy(510,70,'hit s to save');

repeat
k:=readkey;

if k in ['+','-'] then begin
   if k='+' then c:=c+1; if k='-' then c:=c-1;
   if c=0 then c:=16; if c=17 then c:=1;
   setcolor(15);
   circle(610,107+c*15,7);
   setcolor(0);
   circle(610,107+oc*15,7);
    setcolor(c);
    if gd=3 then rectangle(x*10,y*7-3,10+x*10,4+y*7) else
                 rectangle(x*10,y*9+1,10+x*10,10+y*9);
   oc:=c;
   end;

if ord(k) in [72,75,77,80] then
   begin
    case ord(k) of 75: x:=x-1;
                   77: x:=x+1;
                   72: y:=y-1;
                   80: y:=y+1; end;
    if x=50 then x:=1; if x=0 then x:=49;
    if y=50 then y:=1; if y=0 then y:=49;
    setcolor(8);
    if gd=3 then rectangle(ox*10,oy*7-3,10+ox*10,4+oy*7) else
                 rectangle(ox*10,oy*9+1,10+ox*10,10+oy*9);
    setcolor(c);
    if gd=3 then rectangle(x*10,y*7-3,10+x*10,4+y*7) else
                 rectangle(x*10,y*9+1,10+x*10,10+y*9);
    ox:=x; oy:=y;
   end;

if ord(k)=32 then
   begin
    setfillstyle(1,c);
    if gd=3 then floodfill(2+x*10,y*7,c) else
                 floodfill(2+x*10,y*9+3,c);
    putpixel(520+x,10+y,c);
   end;

if k in ['s','S'] then savep;

until ord(k)=27;
closegraph;
end.