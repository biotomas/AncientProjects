{FW2 The Age Of Business}
uses crt, graph;
var  gd, gm:integer;

begin
  gd:=detect;
  initgraph(gd,gm,'c:\tp7\bgi\');
  if graphresult<>grok then halt;
end.
