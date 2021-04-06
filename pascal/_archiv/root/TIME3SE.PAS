uses graph,dos,crt;
var nh,nm,ns,os,h,m,s,hund:word;
    col,r1,r2,r3,r4,rs,tik,i,gd,gm:integer;
    si:string;
    k:char;

{
r1=20
r2=120
rs=170
r3=30
r4=160
}
procedure dclock;
begin
setcolor(15);
  {hour}
         line(320,240,(320+round(sin(h*pi/6+m*pi/360+pi/6)*r1)),(240-round(cos(h*pi/6+m*pi/360+pi/6)*r1)));
         line(320,240,(320+round(sin(h*pi/6+m*pi/360-pi/6)*r1)),(240-round(cos(h*pi/6+m*pi/360-pi/6)*r1)));
         line((320+round(sin(h*pi/6+m*pi/360)*r2)),(240-round(cos(h*pi/6+m*pi/360)*r2)),
              (320+round(sin(h*pi/6+m*pi/360+pi/6)*r1)),(240-round(cos(h*pi/6+m*pi/360+pi/6)*r1)));
         line((320+round(sin(h*pi/6+m*pi/360)*r2)),(240-round(cos(h*pi/6+m*pi/360)*r2)),
              (320+round(sin(h*pi/6+m*pi/360-pi/6)*r1)),(240-round(cos(h*pi/6+m*pi/360-pi/6)*r1)));
  {sec}
         line(320,240,(320+round(sin(s*pi/30)*rs)),(240-round(cos(s*pi/30)*rs)));
  {min}
         line((320+round(sin(m*pi/30+pi/12)*r3)),(240-round(cos(m*pi/30+pi/12)*r3)),
              (320+round(sin(m*pi/30)*r4)),(240-round(cos(m*pi/30)*r4)));
         line((320+round(sin(m*pi/30-pi/12)*r3)),(240-round(cos(m*pi/30-pi/12)*r3)),
              (320+round(sin(m*pi/30)*r4)),(240-round(cos(m*pi/30)*r4)));
         line(320,240,(320+round(sin(m*pi/30-pi/12)*r3)),(240-round(cos(m*pi/30-pi/12)*r3)));
         line(320,240,(320+round(sin(m*pi/30+pi/12)*r3)),(240-round(cos(m*pi/30+pi/12)*r3)));
end;

procedure cclock;
begin
setcolor(0);
  {hour}
         line(320,240,(320+round(sin(h*pi/6+m*pi/360+pi/6)*r1)),(240-round(cos(h*pi/6+m*pi/360+pi/6)*r1)));
         line(320,240,(320+round(sin(h*pi/6+m*pi/360-pi/6)*r1)),(240-round(cos(h*pi/6+m*pi/360-pi/6)*r1)));
         line((320+round(sin(h*pi/6+m*pi/360)*r2)),(240-round(cos(h*pi/6+m*pi/360)*r2)),
              (320+round(sin(h*pi/6+m*pi/360+pi/6)*r1)),(240-round(cos(h*pi/6+m*pi/360+pi/6)*r1)));
         line((320+round(sin(h*pi/6+m*pi/360)*r2)),(240-round(cos(h*pi/6+m*pi/360)*r2)),
              (320+round(sin(h*pi/6+m*pi/360-pi/6)*r1)),(240-round(cos(h*pi/6+m*pi/360-pi/6)*r1)));
  {sec}
         line(320,240,(320+round(sin(s*pi/30)*rs)),(240-round(cos(s*pi/30)*rs)));
  {min}
         line((320+round(sin(m*pi/30+pi/12)*r3)),(240-round(cos(m*pi/30+pi/12)*r3)),
              (320+round(sin(m*pi/30)*r4)),(240-round(cos(m*pi/30)*r4)));
         line((320+round(sin(m*pi/30-pi/12)*r3)),(240-round(cos(m*pi/30-pi/12)*r3)),
              (320+round(sin(m*pi/30)*r4)),(240-round(cos(m*pi/30)*r4)));
         line(320,240,(320+round(sin(m*pi/30-pi/12)*r3)),(240-round(cos(m*pi/30-pi/12)*r3)));
         line(320,240,(320+round(sin(m*pi/30+pi/12)*r3)),(240-round(cos(m*pi/30+pi/12)*r3)));
end;

begin
tik:=1;
initgraph(gd,gm,'c:\tp7\bgi\');
r1:=15;
r2:=90;

rs:=130;

r3:=22;
r4:=120;

setcolor(15);
for i:=1 to 10 do
    begin
    ellipse(320,240,0,360,171+i*14,185);
    if i mod 2 = 1 then setfillstyle(1,0) else setfillstyle(1,15);
    floodfill(173+i*14,240,15);
    end;
circle(320,240,180);
circle(320,240,140);
{setfillstyle(1,1);
floodfill(320,20,15);
setfillstyle(1,7);
floodfill(320,230,15);}
settextstyle(4,0,2);
for i:=1 to 12 do
    begin
     str(i:2,si);
     moveto(305+round(sin(i*pi/6)*155),225-round(cos(i*pi/6)*155));
     outtext(si);
    end;

for i:=1 to 60 do
    begin
     putpixel(320+round(sin(i*pi/30)*175),240-round(cos(i*pi/30)*175),0);
    end;
{start}

os:=0;
  gettime(h,m,s,hund);
  dclock;
repeat
   gettime(nh,nm,ns,hund);
   if ns<>os then
      begin
       cclock;
       h:=nh;
       m:=nm;
       s:=ns;
       dclock;
        if tik=1 then begin
            sound(1000);
                delay(100);
                    nosound; end;
      end;
if keypressed then
   begin
    k:=readkey;
    if k in ['s','S'] then tik:=1-tik;
   end;
os:=ns;
until ord(k)=27;
closegraph;
end.