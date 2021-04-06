unit bnltpu;
interface
         uses graph, crt;
         var sinuses:array[-100..100] of shortint;
             sini:shortint;
         procedure drawmap;
         procedure drawb(x,y:integer; angle,col:shortint);
         procedure move(dir:boolean; var x,y,angle:integer);
         function sinus(uhel:shortint):real;
         function cosinus(uhel:shortint):real;

implementation

function sinus(uhel:shortint):real;
begin
   sinus:=sinuses[uhel]/100
end;

function cosinus(uhel:shortint):real;
begin
   if uhel > 50 then
   cosinus:=sinuses[100-uhel]/100
   else
   cosinus:=sinuses[uhel+50]/100
end;


procedure move(dir:boolean; var x,y,angle:integer);
begin
if dir then
  begin
    x:=x+round(3*cosinus(angle));
    y:=y+round(3*sinus(angle));
  end else
  begin
    x:=x-round(1*cos(pi/100*angle));
    y:=y-round(1*sin(pi/100*angle));
  end;
end;

procedure drawb(x,y:integer; angle,col:shortint);
var tcol:byte;
begin
  tcol:=getcolor;
  setcolor(col);
    setlinestyle(0,0,1);
  moveto(x+round(15*cos(pi/100*(angle-20))),y+round(10*sin(pi/100*(angle-20))));
  lineto(x+round(15*cos(pi/100*(angle+20))),y+round(10*sin(pi/100*(angle+20))));
  lineto(x+round(15*cos(pi/100*(angle+70))),y+round(10*sin(pi/100*(angle+70))));
  lineto(x+round(15*cos(pi/100*(angle-70))),y+round(10*sin(pi/100*(angle-70))));
  lineto(x+round(15*cos(pi/100*(angle-20))),y+round(10*sin(pi/100*(angle-20))));
  setfillstyle(1,col);
  floodfill(x,y,col);
  moveto(x+round(15*cos(pi/100*(angle))),y+round(15*sin(pi/100*(angle))));
    setcolor(15);
    setlinestyle(0,0,2);
  lineto(x,y);
  setcolor(tcol);
end;


procedure drawmap;
begin
  setcolor(5);
  setfillstyle(1,5);

  rectangle(1,1,639,50);
  rectangle(5,5,635,45);
  floodfill(2,2,5);

  rectangle(450,120,455,280);
  floodfill(451,121,5);
  rectangle(639,50,634,280);
  floodfill(638,121,5);

  rectangle(350,344,639,349);
  floodfill(351,345,5);

  rectangle(100,100,105,200);
  rectangle(100,100,200,105);
  rectangle(200,105,195,200);
  floodfill(101,101,5);
  floodfill(110,101,5);
  floodfill(101,111,5);
  floodfill(196,121,5);
end;

begin
for sini:=-100 to 100 do sinuses[sini]:=round(100*sin(pi/100*sini));
end.