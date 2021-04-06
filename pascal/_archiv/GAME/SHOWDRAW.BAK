uses graph,crt;
type hor=array [1..100] of byte;
var fil:file of hor;
    ln:hor;
    i,j,sx,sy:byte;
    gd,gm:integer;
    k:char;
    strin:string;
begin
repeat
clrscr;
repeat
write('nazov suboru: ');
k:=readkey;
if ord(k)<>27 then
 begin
  write(k);
  readln(strin);
  strin:=k+strin;
  assign(fil,'c:\tp7\game\'+strin+'.pic');
  {$I-}
  Reset(fil);
  Close(fil);
  {$I+}
  if IOResult <> 0 then writeln('File not found') else j:=1;
 end;
until (ord(k)=27) or (j=1);

if ord(k)<>27 then
begin
reset(fil);
read(fil,ln);
gd:=ln[3];
gm:=ln[4];
sx:=ln[1];
sy:=ln[2];
initgraph(gd,gm,'');
for i:=1 to sy do
    begin
     read(fil,ln);
     for j:=1 to sx do putpixel(100+j,100+i,ln[j]);
    end;
outtextxy(1,1,'esc=exit  other=repeat');
k:=readkey;
closegraph;
close(fil);
end;
until ord(k)=27;
end.