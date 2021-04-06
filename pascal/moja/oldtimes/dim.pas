unit dim;
interface
   procedure egerke(mx,my,c:integer);
   procedure drectangle(x1,y1,z1,x3,y3,z3:integer);
   procedure dcircle(x1,y1,z1,r:integer);
   procedure redim(rx,ry,rz:integer);
   procedure dline(x1,y1,z1,x2,y2,z2:integer);
   procedure cube(x1,y1,z1,x2,y2,z2:integer);
   procedure setcentre(x,y:integer);
   procedure screen;

implementation
uses graph,crt;
var scr,cex,cey,cx,cy:integer;
    x,y:array[1..8] of integer;

procedure screen;
   begin
    setactivepage(scr);
    scr:=1-scr;
    setvisualpage(scr);
    delay(20);
    cleardevice;
   end;

procedure setcentre(x,y:integer);
   begin
    cex:=x;
    cey:=y;
   end;

procedure redim(rx,ry,rz:integer);
   begin
   cx:=round(cex-0.866*rz+rx*0.866);
   cy:=round(cey+0.5*rz+ry+rx*0.5);
   end;

procedure credim(rx,ry,rz,i:integer);
   begin
   x[i]:=round(cex-0.866*rz+rx*0.866);
   y[i]:=round(cey+0.5*rz+ry+rx*0.5);
   end;

procedure dcircle(x1,y1,z1,r:integer);
   begin
   redim(x1,y1,z1);
   circle(cx,cy,r);
   end;

procedure dline(x1,y1,z1,x2,y2,z2:integer);
   begin
   redim(x1,y1,z1);
   moveto(cx,cy);
   redim(x2,y2,z2);
   lineto(cx,cy);
   end;

procedure drectangle(x1,y1,z1,x3,y3,z3:integer);
   var x2,y2,z2,x4,y4,z4:integer;
   begin
   x2:=x3;
   y2:=y1;
   z2:=z3;
   x4:=x1;
   y4:=y3;
   z4:=z1;
   dline(x1,y1,z1,x2,y2,z2);
   dline(x3,y3,z3,x2,y2,z2);
   dline(x3,y3,z3,x4,y4,z4);
   dline(x1,y1,z1,x4,y4,z4);
   end;

procedure cube(x1,y1,z1,x2,y2,z2:integer);
  begin
   credim(x1,y1,z1,1);
   credim(x2,y1,z1,2);
   credim(x2,y2,z1,3);
   credim(x1,y2,z1,4);
   credim(x1,y1,z2,5);
   credim(x2,y1,z2,6);
   credim(x2,y2,z2,7);
   credim(x1,y2,z2,8);
   line(x[1],y[1],x[2],y[2]);
   line(x[2],y[2],x[3],y[3]);
   line(x[3],y[3],x[4],y[4]);
   line(x[4],y[4],x[1],y[1]);
   line(x[5],y[5],x[6],y[6]);
   line(x[6],y[6],x[7],y[7]);
   line(x[7],y[7],x[8],y[8]);
   line(x[8],y[8],x[5],y[5]);
   line(x[1],y[1],x[5],y[5]);
   line(x[2],y[2],x[6],y[6]);
   line(x[3],y[3],x[7],y[7]);
   line(x[4],y[4],x[8],y[8]);
  end;

procedure egerke(mx,my,c:integer);
  var i:integer; col: array [1..15] of byte;
  begin
  if c<40 then begin
   for i:=1 to 8 do begin
                     col[i]:=getpixel(mx,my-1+i);
                     putpixel(mx,my-1+i,c);
                    end;
   for i:=9 to 15 do begin
                     col[i]:=getpixel(mx+i-8,my+i-8);
                     putpixel(mx+i-8,my+i-8,c);
                    end;
  delay(100);

   for i:=1 to 8 do putpixel(mx,my-1+i,col[i]);
   for i:=9 to 15 do putpixel(mx+i-8,my+i-8,col[i]);
  end else begin
   for i:=1 to 8 do putpixel(mx,my-1+i,c-50);
   for i:=9 to 15 do putpixel(mx+i-8,my+i-8,c-50);
   end;
  end;



begin
scr:=1;
end.