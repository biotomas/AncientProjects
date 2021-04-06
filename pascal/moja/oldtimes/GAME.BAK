uses graph,crt;

const car='auto.pic';

var i,gd,gm:integer;
    a,j,scr:byte;
    k:char;
    p:pointer;

procedure automem;
type jaj=array[1..50] of byte;
var f:file of jaj;
    r:jaj;
    x,y,i,j:byte;
    gd,gm:integer;
 begin
  assign(f,car);
  reset(f);
  read(f,r);
  x:=r[1]+1; y:=r[2]+1;
  for i:=1 to x do
   begin
    read(f,r);
    for j:=1 to y do putpixel(i,j,r[j]);
   end;
  getmem(p,imagesize(1,1,x,y));
  getimage(1,1,x,y,p^);
  close(f);
  cleardevice;
 end;

procedure pline(ay:integer);
   procedure mt(x,y:word); begin moveto(x+220,ay-y); end;
   procedure lt(x,y:word); begin lineto(x+220,ay-y); end;
 begin
  mt(50,0); lt(30,150); lt(30,350); lt(100,500);
  lt(100,700); lt(50,900); lt(0,1000); lt(200,1000);
  lt(150,900); lt(200,700); lt(200,500); lt(170,320); lt(150,150); lt(150,0);
 end;

procedure screen;
 begin
  setvisualpage(scr);
  scr:=1-scr;
  setactivepage(scr);
  delay(20);
  cleardevice;
 end;

begin
randomize;
gd:=3;
gm:=1;
initgraph(gd,gm,'c:\tp\bgi');

a:=100;
i:=1;
outtextxy(100,200,'Press a key when ready');
screen;
automem;
readkey;
repeat
  screen;
  pline(i);
  if keypressed then
    begin
     k:=readkey; if ord(k)=77 then a:=a+5; if ord(k)=75 then a:=a-5;
     if ord(k)=27 then halt;
    end;
  putimage(220+a,300,p^,xorput);
  i:=i+2
until i>1300;
readkey;
closegraph;
end.