uses graph,crt;
var gd,gm:integer;
begin
  gd:=detect;
  initgraph(gd,gm,'c:\tp7\bgi\');
  if graphresult<>grok then halt;
cleardevice;
    circle(320,720,400);
    rectangle(30,350,130,300);
    rectangle(150,300,250,250);
    rectangle(270,250,370,200);
    rectangle(510,350,610,300);
    rectangle(390,300,490,250);
setfillstyle(1,2);
floodfill(100,320,15);
setfillstyle(1,4);
floodfill(200,275,15);
setfillstyle(1,6);
floodfill(300,210,15);
setfillstyle(1,7);
floodfill(520,320,15);
setfillstyle(1,5);
floodfill(400,260,15);


readkey;
closegraph;
end.