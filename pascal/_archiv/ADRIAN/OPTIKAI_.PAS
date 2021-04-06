program rajzok1;
uses    graph,crt;
var     gd,gm,i,e,x:integer;
begin   detectgraph(gd,gm);
        initgraph(gd,gm,'c:\tp7\bgi');
        randomize;
setcolor(15);
for i:=1 to 4 do begin
                   for e:=1 to 10 do bar(2*e*20+4*i,i*20,2*e*20+4*i+20,i*20+20);
                  end;
for i:=5 to 9 do begin
                   for e:=2 to 11 do bar(2*e*20-4*i,i*20,2*e*20-4*i+20,i*20+20);
                  end;
for i:=10 to 14 do begin
                   for e:=0 to 9 do bar(2*e*20+4*i,i*20,2*e*20+4*i+20,i*20+20);
                  end;
for i:=15 to 19 do begin
                   for e:=3 to 12 do bar(2*e*20-4*i,i*20,2*e*20-4*i+20,i*20+20);
                  end;
setcolor(8);
for i:=1 to 20 do line(0,i*20,500,i*20);




        readkey;
        closegraph;


end.