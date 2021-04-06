program prog;
uses crt,graph;
var gd,gm  : integer;
    k:char;
    x,y,cl:integer;


begin
  gd:=detect;
  initgraph(gd,gm,'c:\tp7\bgi');
  if graphresult<>grok then halt;
  x:=320;
  y:=240;
  cl:=15;
  SetColor(cl);
  repeat
  Circle(x,y, 100);
  FloodFill(x,y, cl);
  k:=readkey;
  case ord(k) of  75: x:=x-3;
                  77: x:=x+3;
                  72: y:=y-3;
                  80: y:=y+3;
                  end;
  until ord(k)=27;
  closegraph;
end.
