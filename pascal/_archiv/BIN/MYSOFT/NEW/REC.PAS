program programname;
uses crt,graph;
var g,col,gd,gm,a,b,c,d,a1,b1,c1,d1 ,i : integer;
          k:char;

procedure changecolor;
begin
setcolor(col);
col:=col+1;
if col=15 then col:=1;
end;


begin
  g:=5;
  col:=1;
  gd:=detect;
  initgraph(gd,gm,'c:\tp7\bgi');
setcolor(12);
rectangle(100,20,540,460);
a:=100;
a1:=240;
b:=320;
b1:=20;
c:=540;
c1:=240;
d:=320;
d1:=460;
i:=1;
readkey;
repeat
 i:=i+1;
 if i=15 then begin i:=1; changecolor; end;
 line(a,a1,b,b1);
 line(b,b1,c,c1);
 line(d,d1,a,a1);
 line(c,c1,d,d1);
 line(a,a1,320,240);

 if a=100 then a1:=a1-g;
 if a=540 then a1:=a1+g;
 if a1=460 then a:=a-g;
 if a1=20 then a:=a+g;

 if b=100 then b1:=b1-g;
 if b=540 then b1:=b1+g;
 if b1=460 then b:=b-g;
 if b1=20 then b:=b+g;

 if c=100 then c1:=c1-g;
 if c=540 then c1:=c1+g;
 if c1=460 then c:=c-g;
 if c1=20 then c:=c+g;

 if d=100 then d1:=d1-g;
 if d=540 then d1:=d1+g;
 if d1=460 then d:=d-g;
 if d1=20 then d:=d+g;

delay(100);

if keypressed then k:=readkey;
until ord(k)=27;
 closegraph;
end.
