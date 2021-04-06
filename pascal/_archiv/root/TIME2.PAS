uses graph,dos,crt;
var nh,nm,ns,os,h,m,s,hund:word;
    tik,i,gd,gm:integer;
    si:string;
    k:char;

procedure dclock;
begin
setcolor(8);
  {hour} setlinestyle(0,1,8);
         line(320,240,(320+round(sin(h*pi/6+m*pi/360+pi/6)*20)),(240-round(cos(h*pi/6+m*pi/360+pi/6)*20)));
         line(320,240,(320+round(sin(h*pi/6+m*pi/360-pi/6)*20)),(240-round(cos(h*pi/6+m*pi/360-pi/6)*20)));
         line((320+round(sin(h*pi/6+m*pi/360)*120)),(240-round(cos(h*pi/6+m*pi/360)*120)),
              (320+round(sin(h*pi/6+m*pi/360+pi/6)*20)),(240-round(cos(h*pi/6+m*pi/360+pi/6)*20)));
         line((320+round(sin(h*pi/6+m*pi/360)*120)),(240-round(cos(h*pi/6+m*pi/360)*120)),
              (320+round(sin(h*pi/6+m*pi/360-pi/6)*20)),(240-round(cos(h*pi/6+m*pi/360-pi/6)*20)));
  {sec}  setlinestyle(0,1,2);
         line(320,240,(320+round(sin(s*pi/30)*170)),(240-round(cos(s*pi/30)*170)));
  {min}  setlinestyle(0,1,3);
         line((320+round(sin(m*pi/30+pi/12)*30)),(240-round(cos(m*pi/30+pi/12)*30)),
              (320+round(sin(m*pi/30)*160)),(240-round(cos(m*pi/30)*160)));
         line((320+round(sin(m*pi/30-pi/12)*30)),(240-round(cos(m*pi/30-pi/12)*30)),
              (320+round(sin(m*pi/30)*160)),(240-round(cos(m*pi/30)*160)));
         line(320,240,(320+round(sin(m*pi/30-pi/12)*30)),(240-round(cos(m*pi/30-pi/12)*30)));
         line(320,240,(320+round(sin(m*pi/30+pi/12)*30)),(240-round(cos(m*pi/30+pi/12)*30)));
end;

procedure cclock;
begin
setcolor(7);
  {hour} setlinestyle(0,1,8);
         line(320,240,(320+round(sin(h*pi/6+m*pi/360+pi/6)*20)),(240-round(cos(h*pi/6+m*pi/360+pi/6)*20)));
         line(320,240,(320+round(sin(h*pi/6+m*pi/360-pi/6)*20)),(240-round(cos(h*pi/6+m*pi/360-pi/6)*20)));
         line((320+round(sin(h*pi/6+m*pi/360)*120)),(240-round(cos(h*pi/6+m*pi/360)*120)),(320+round(sin(h*pi/6+m*pi/360+
         pi/6)*20)),(240-round(cos(h*pi/6+m*pi/360+pi/6)*20)));
         line((320+round(sin(h*pi/6+m*pi/360)*120)),(240-round(cos(h*pi/6+m*pi/360)*120)),(320+round(sin(h*pi/6+m*pi/360-
         pi/6)*20)),(240-round(cos(h*pi/6+m*pi/360-pi/6)*20)));
  {sec}  setlinestyle(0,1,2);
         line(320,240,(320+round(sin(s*pi/30)*170)),(240-round(cos(s*pi/30)*170)));
  {min}  setlinestyle(0,1,3);
         line((320+round(sin(m*pi/30+pi/12)*30)),(240-round(cos(m*pi/30+pi/12)*30)),
              (320+round(sin(m*pi/30)*160)),(240-round(cos(m*pi/30)*160)));
         line((320+round(sin(m*pi/30-pi/12)*30)),(240-round(cos(m*pi/30-pi/12)*30)),
              (320+round(sin(m*pi/30)*160)),(240-round(cos(m*pi/30)*160)));
         line(320,240,(320+round(sin(m*pi/30-pi/12)*30)),(240-round(cos(m*pi/30-pi/12)*30)));
         line(320,240,(320+round(sin(m*pi/30+pi/12)*30)),(240-round(cos(m*pi/30+pi/12)*30)));
end;

begin
tik:=1;
initgraph(gd,gm,'c:\tp7\bgi\');
setcolor(8);
for i:=0 to 48 do line(0,i*10,640,i*10);
for i:=0 to 64 do line(i*10,0,i*10,480);
setcolor(15);
circle(320,240,230);
circle(320,240,180);
setfillstyle(1,1);
floodfill(320,20,15);
setfillstyle(1,7);
floodfill(320,230,15);
settextstyle(4,0,4);
for i:=1 to 12 do
    begin
     str(i:2,si);
     moveto(295+round(sin(i*pi/6)*200),220-round(cos(i*pi/6)*200));
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