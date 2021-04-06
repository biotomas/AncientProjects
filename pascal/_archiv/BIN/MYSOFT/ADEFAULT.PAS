program programname;
uses crt,graph;
var gd,gm  : integer;
begin
  gd:=detect;
  initgraph(gd,gm,'c:\windows\system');
  if graphresult<>grok then halt;
  closegraph;
end.
