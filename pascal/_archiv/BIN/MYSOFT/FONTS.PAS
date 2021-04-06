program fonts;
uses graph, crt;
var a,b,i:integer;
    s:string;
begin
 initgraph(a,b,'c:\tp7\bgi');
  for i:=1 to 10 do begin
   settextstyle(i,0,4);
    str(i,s);
   outtextxy(50,i*30,s);
  end;
readkey;
 closegraph;
end.