program funkcie;
uses crt, graph;

var
 gd,gm,f:integer;
 x,y:word;

procedure fcia;
 begin
  f:=x-320;
  y:=f*f*f;
  y:=320-y;
 end;

begin
   gd:=detect;
   initgraph(gd,gm,'c:\windows\system');
   if graphresult<>grok then halt;
cleardevice;
line(0,240,640,240);
line(320,0,320,480);
 x:=10;
 fcia;
 moveto(x,y);
 for x:=10 to 630 do begin
  fcia;
  lineto(x,y);
 end;

readkey;
closegraph;
end.