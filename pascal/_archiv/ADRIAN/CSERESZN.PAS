uses graph;
const piros=4;
      szurke=8;
procedure cseresznye;
var x,y:integer;
    gd,gm:integer;
begin
     detectgraph(gd,gm);
     initgraph(gd,gm,'d:\bp\bgi');

                       {fa:}      setfillstyle(1,6);
                                  bar(285,200,325,400);
                                  setfillstyle(1,2);
                                  pieslice(300,200,0,360,150);

     x:=220+random(200);
     y:=70+random(200);
     setfillstyle(1,piros);
     pieslice(x-5,y+12,0,360,5);
     pieslice(x+5,y+12,0,360,5);
     setcolor(szurke);
     line(x,y,x-5,y+10);
     line(x,y,x+5,y+10);

readln;

end;

var i,gd,gm:integer;

    begin

         randomize;
         for i:= 1 to 3 do cseresznye;
         readln;
         closegraph;
         end.