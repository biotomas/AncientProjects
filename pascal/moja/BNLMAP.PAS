unit bnlmap;

interface
         const numberofmaps=5;
         type  boolf=array[1..7] of boolean;
         var minex:array[1..10] of boolean;
             kill: array[1..2]  of boolean;
         procedure drawmap(map:byte);
         procedure initmines;
         function  getminekills:byte;
         procedure mines(map:byte);
         procedure setkills;

implementation
uses graph;

function getminekills:byte;
var b:byte;
begin
if kill[1] then b:=1
else
if kill[2] then b:=2
else b:=0;
getminekills:=b;
end;

procedure setkills;
begin
kill[1]:=false;
kill[2]:=false;
end;

procedure initmines;
var i:byte;
begin
 for i:=1 to 10 do minex[i]:=true;
end;

{########################################################################}

procedure mines(map:byte);
var i:byte;
  procedure mine(x,y:integer);
  begin
    if minex[i] then
       begin
         setcolor(13);
         circle(x,y,4);
         setcolor(14);
         circle(x,y,2);
         minex[i]:=false;
         if getpixel(x,y) = red then kill[1]:=true
         else if getpixel(x,y) = green then kill[2]:=true
         else minex[i]:=true
       end;
    inc(i);
  end;
begin
i:=1;
case map of
     1: begin
         mine(150,250);
         mine(350,310);
         mine(450,90);
         mine(550,200);
        end;
     2: begin
         mine(315,125);
         mine(315,225);
         mine(500,100);
         mine(500,300);
         mine(100,100);
         mine(100,300);
        end;
     3: begin
         mine(200,270);
         mine(325,270);
         mine(450,270);
         mine(325,75);
         mine(525,150);
         mine(100,150);
        end;
     4: begin
         mine(200,75);
         mine(400,325);
         mine(350,150);
         mine(350,210);
         mine(285,150);
         mine(285,210);
        end;
     5: begin
         mine(200,275);
         mine(450,275);
         mine(150,150);
         mine(500,150);
         mine(320,75);
        end;
     end; {of case}
end;

procedure drawmap(map:byte);
begin
  setcolor(5);
  setfillstyle(1,5);
  rectangle(1,1,639,50);
  rectangle(5,5,635,45);
  floodfill(2,2,5);

case map of
      1:begin
          bar(450,120,455,280);
          bar(639,50,634,280);
          bar(350,344,639,349);
          bar(100,100,105,200);
          bar(100,100,200,105);
          bar(200,105,195,200);
        end;
      2:begin
          bar(150,150,300,155);
          bar(150,250,300,255);
          bar(350,150,500,155);
          bar(350,250,500,255);
          bar(150,155,155,250);
          bar(634,50,639,349);
        end;
      3:begin
          bar(100,300,550,305);
          bar(250,250,255,100);
          bar(255,100,400,105);
          bar(400,100,405,250);
        end;
      4:begin
          bar(1,50,6,349);
          bar(5,344,639,349);
          bar(634,50,639,344);
          bar(200,100,205,250);
          bar(400,150,405,300);
        end;
      5:begin
          bar(100,100,105,300);
          bar(100,300,550,305);
          bar(550,305,555,100);
          bar(200,250,205,100);
          bar(205,100,450,105);
          bar(450,100,455,250);
        end;
      end;
end;


begin
end.