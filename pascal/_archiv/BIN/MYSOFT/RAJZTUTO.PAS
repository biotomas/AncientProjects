program programname;
uses crt,graph;
var gd,gm,a,b,c,d,a1,b1,c1,d1  : integer;

procedure point(x,y:integer);
begin
 if x=100 then y:=y-2;
 if x=540 then y:=y+2;
 if y=460 then x:=x-2;
 if y=20 then x:=x+2;

end;

begin
  gd:=detect;
  initgraph(gd,gm,'c:\windows\system');
  if graphresult<>grok then halt;
rectangle(100,20,540,460);
repeat
 line(a,a1,b,b1);
 line(b,b1,c,c1);
 line(c,c1,d,d1);
 line(d,d1,a,a1);

point(a,a1);
point(b,b1);
point(c,c1);
point(d,d1);


until keypressed;
 closegraph;
end.
