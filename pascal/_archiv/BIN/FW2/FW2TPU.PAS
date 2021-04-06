unit fw2tpu;
interface
uses graph,crt;
var i,j,a,b:integer;
    mx,my,mb,x1,y1,xx,yy,scr:integer;
    r,x,y:real;
    s:string;

procedure test;
procedure mouse;

implementation

procedure mouse;
begin
 setcolor(14);
 line(mx,my,mx,my+10);
 line(mx,my,mx+8,my+10);
 line(mx,my+10,mx+2,my+6);
 line(mx+8,my+10,mx+2,my+6);
 setfillstyle(1,14);
 floodfill(mx+1,my+3,14);
end;

procedure test;
begin
  if (x1<>x)or(y1<>y) then begin
   xx:=abs(x1-round(x));
   yy:=abs(y1-round(y));
   if (y1<>y)and(xx<yy) then r:=(xx/yy)*2;
   if (x1<>x)and(xx>yy) then r:=(yy/xx)*2;
   if xx<yy then begin
    if (y1>=y)and(x1>x) then begin
     y:=y+2;
     x:=x+r;
    end;
    if (y1<y)and(x1>x) then begin
     y:=y-2;
     x:=x+r;
    end;
    if (y1>y)and(x1<x) then begin
     y:=y+2;
     x:=x-r;
    end;
    if (y1<y)and(x1<x) then begin
     y:=y-2;
     x:=x-r;
    end;
   end;
   if xx>yy then begin
    if (y1>y)and(x1>x) then begin
     y:=y+r;
     x:=x+2;
    end;
    if (y1<y)and(x1>x) then begin
     y:=y-r;
     x:=x+2;
    end;
    if (y1>y)and(x1<x) then begin
     y:=y+r;
     x:=x-2;
    end;
    if (y1<y)and(x1<x) then begin
     y:=y-r;
     x:=x-2;
    end;
   end;
  end;
end;

begin
end.