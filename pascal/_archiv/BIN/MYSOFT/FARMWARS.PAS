{Pinaneeno Software 2002}
program TheGame;
uses crt,graph;
var ext,y,go,cheat,uc,i,gd,gm,cr1,cr2 : integer;
    s,name1,name2:string;
    sck,c,c11,c12,c13,c14,c15,c21,c22,c23,c24,c25:integer;
    player,lh1,lh2,lf1,lf2:integer;
    menu,win,ender,sc,asc1,asc2,asc3,asc4,asc5:integer;
    k:char;
    house1,house2,field1,field2,farmer1,farmer2,gipsy1,gipsy2,
    usd1,usd2,crop1,crop2,shit1,shit2:integer;

procedure test;
begin
 if shit1<0 then shit1:=0;
 if shit2<0 then shit2:=0;
 if crop1<0 then crop1:=0;
 if crop2<0 then crop2:=0;
 if usd1<0 then usd1:=0;
 if usd2<0 then usd2:=0;
 if farmer1<1 then farmer1:=1;
 if farmer2<1 then farmer2:=1;
 if gipsy1<1 then gipsy1:=1;
 if gipsy2<1 then gipsy2:=1;
 if field1<0 then begin house1:=field1+house1; field1:=0; end;
 if field2<0 then begin house2:=field2+house2; field2:=0; end;
 if (player=1) and (field1+field2>135) then field1:=135-field2;
 if (player=2) and (field1+field2>135) then field2:=135-field1;
 if (house1<21) or (house2>119) then begin
     cleardevice;
     settextstyle(7,0,6);
     setcolor(15);
     outtextxy(20,50,'The winner is');
     setcolor(14);
     outtextxy(120,100,name2);
     settextstyle(7,0,3);
     setcolor(15);
     outtextxy(20,420,'Press any key to exit');
     ender:=1;
     readkey;
     closegraph;
    end;
 if (house2<21) or (house1>119) then begin
     cleardevice;
     settextstyle(7,0,6);
     setcolor(15);
     outtextxy(20,50,'The winner is');
     setcolor(14);
     outtextxy(120,100,name1);
     settextstyle(7,0,3);
     setcolor(15);
     outtextxy(20,420,'Press any key to exit');
     ender:=1;
     readkey;
     closegraph;

    end;
end;

{Cards-------------------------------------------------------------}
procedure gamemenu;
 begin
  cleardevice;
  menu:=1;
  ext:=0;
repeat
  settextstyle(7,0,9);
  setcolor(14);
  outtextxy(20,20,'Farm Wars');
  outtextxy(20,120,'   2002');
  settextstyle(7,0,5);
  repeat
   setcolor(8);
   if menu=1 then setcolor(7);
   outtextxy(100,240,'Start the Show');
   setcolor(8);
   if menu=2 then setcolor(7);
   outtextxy(100,280,'Learn to play');
   setcolor(8);
   if menu=3 then setcolor(7);
   outtextxy(100,320,'Credits');
   setcolor(8);
   if menu=4 then setcolor(7);
   outtextxy(100,360,'Exit');
   k:=readkey;
   case ord(k) of 72: menu:=menu-1;
                  80: menu:=menu+1;
                  end;
   if menu=5 then menu:=1;
   if menu=0 then menu:=4;
  until ord(k)=13;
if menu=2 then
begin
cleardevice;
 settextstyle(7,0,3);
 outtextxy(20,20,'Not yet avaliable');
readkey;
  settextstyle(7,0,5);
cleardevice;
end;
if menu=1 then
  begin
   cleardevice;
  settextstyle(7,0,2);
   repeat
   outtextxy(80,104,'Please enter player1 name: ');
   gotoxy(50,8);
   readln(name1);
   if name1='big floppy donkey dick' then farmer1:=8;
   if name1='Emir Kusturica' then gipsy1:=10;
   if name1='i am the lizard king' then begin house1:=100; house2:=40; field1:=120; field2:=10; end;
   if length(name1)>10 then
   begin
   outtextxy(70,127,'Max 10 characters');
   readkey;
   cleardevice;
   end;
   until length(name1)<11;
   repeat
   outtextxy(80,168,'Please enter player2 name: ');
   gotoxy(50,12);
   readln(name2);
   if name2='big floppy donkey dick' then farmer2:=8;
   if name2='Emir Kusturica' then gipsy2:=10;
   if name2='i am the lizard king' then begin house2:=100; house1:=40; field2:=120; field1:=10; end;
   if length(name2)>10 then
   begin
   outtextxy(70,127,'Max 10 characters');
   readkey;
   cleardevice;
   end;
   until length(name2)<11;
   ext:=1;
end;

if menu=4 then begin ender:=1; ext:=1; end;
if menu=3 then
begin
cleardevice;
 settextstyle(7,0,3);
 outtextxy(20,20,'Top secret!');
readkey;
  settextstyle(7,0,5);
cleardevice;
end;
until ext=1;
 end;

procedure cards(rcard:integer);
 begin
 case rcard of
 1:
 begin
  settextstyle(2,0,4);
  outtextxy(((sc*120)-80),415,'Fire on field');
  outtextxy(((sc*120)-80),450,'   5 Shit');
  outtextxy(((sc*120)-80),460,'   field -15');
  if uc=1 then begin
      uc:=0;
       if player=1 then begin shit1:=shit1-5; field2:=field2-15; if field2<0 then field2:=0; end;
       if player=2 then begin shit2:=shit2-5; field1:=field1-15; if field1<0 then field1:=0; end;
     end;
 end;
 2:
 begin
  settextstyle(2,0,4);
  outtextxy(((sc*120)-80),415,'   Robbery');
  outtextxy(((sc*120)-80),450,'   10 Usd');
  outtextxy(((sc*120)-80),460,'mat. -5 mat. +5');
  if uc=1 then begin
      uc:=0;
       if player=1 then begin usd1:=usd1-10; shit1:=shit1+5; shit2:=shit2-5; usd1:=usd1+5; usd2:=usd2-5;
       crop1:=crop1+5; crop2:=crop2-5; test; end;
       if player=2 then begin usd2:=usd2-10; shit2:=shit2+5; shit1:=shit1-5; usd2:=usd2+5; usd1:=usd1-5;
       crop2:=crop2+5; crop1:=crop1-5; test; end;
     end;
 end;
 3:
 begin
  settextstyle(2,0,4);
  outtextxy(((sc*120)-80),415,' Redneck Party');
  outtextxy(((sc*120)-80),450,'   9 crops');
  outtextxy(((sc*120)-80),460,'   Farmer +1');
  if uc=1 then begin
      uc:=0;
       if player=1 then begin crop1:=crop1-9; farmer1:=farmer1+1; test; end;
       if player=2 then begin crop2:=crop2-9; farmer2:=farmer2+1; test; end;
     end;
 end;
 4:
 begin
  settextstyle(2,0,4);
  outtextxy(((sc*120)-80),415,'small fire ball');
  outtextxy(((sc*120)-80),450,'   2 shit');
  outtextxy(((sc*120)-80),460,'  Attacks 3');
  if uc=1 then begin
      uc:=0;
       if player=1 then begin shit1:=shit1-2; field2:=field2-3; test; end;
       if player=2 then begin shit2:=shit2-5; field1:=field1-3; test; end;
     end;
 end;
 5:
 begin
  settextstyle(2,0,4);
  outtextxy(((sc*120)-80),415,'   Plague');
  outtextxy(((sc*120)-80),450,'   11 shit');
  outtextxy(((sc*120)-80),460,'enemy gipsy -1');
  if uc=1 then begin
      uc:=0;
       if player=1 then begin shit1:=shit1-11; gipsy2:=gipsy2-1; test; end;
       if player=2 then begin shit2:=shit2-11; gipsy1:=gipsy1-1; test; end;
     end;
 end;
 6:
 begin
  settextstyle(2,0,4);
  outtextxy(((sc*120)-80),415,'    AIDS');
  outtextxy(((sc*120)-80),450,'   15 Usd');
  outtextxy(((sc*120)-80),460,'farmer&gipsy -1 ');
  if uc=1 then begin
      uc:=0;
       if player=1 then begin usd1:=usd1-15; gipsy2:=gipsy2-1; farmer2:=farmer2-1; test; end;
       if player=2 then begin usd2:=usd2-15; gipsy1:=gipsy1-1; farmer1:=farmer1-1; test; end;
     end;
 end;
 7:
 begin
  settextstyle(2,0,4);
  outtextxy(((sc*120)-80),415,'  Rise of roma');
  outtextxy(((sc*120)-80),450,'   10 crops');
  outtextxy(((sc*120)-80),460,'   gipsy +1');
  if uc=1 then begin
      uc:=0;
       if player=1 then begin crop1:=crop1-10; gipsy1:=gipsy1+1; test; end;
       if player=2 then begin crop2:=crop2-10; gipsy2:=gipsy2+1; test; end;
     end;
 end;
 8:
 begin
  settextstyle(2,0,4);
  outtextxy(((sc*120)-80),415,' The business');
  outtextxy(((sc*120)-80),450,'   6 crops');
  outtextxy(((sc*120)-80),460,'   Usd +8');
  if uc=1 then begin
      uc:=0;
       if player=1 then begin crop1:=crop1-6; usd1:=usd1+8; test; end;
       if player=2 then begin crop2:=crop2-6; usd2:=usd2+8; test; end;
     end;
 end;
 9:
 begin
  settextstyle(2,0,4);
  outtextxy(((sc*120)-80),415,'Medium Fireball');
  outtextxy(((sc*120)-80),450,'   6 shit');
  outtextxy(((sc*120)-80),460,' attacks 10');
  if uc=1 then begin
      uc:=0;
       if player=1 then begin shit1:=shit1-6; field2:=field2-10; test; end;
       if player=2 then begin shit2:=shit2-6; field1:=field1-10; test; end;
     end;
 end;
 10:
 begin
  settextstyle(2,0,4);
  outtextxy(((sc*120)-80),415,'   Building');
  outtextxy(((sc*120)-80),450,'    3 Usd');
  outtextxy(((sc*120)-80),460,'  granary +2');
  if uc=1 then begin
      uc:=0;
       if player=1 then begin usd1:=usd1-3; house1:=house1+2; test; end;
       if player=2 then begin usd2:=usd2-3; house2:=house2+2; test; end;
     end;
 end;
 11:
 begin
  settextstyle(2,0,4);
  outtextxy(((sc*120)-80),415,'  Trebuchet');
  outtextxy(((sc*120)-80),450,'   20 Usd');
  outtextxy(((sc*120)-80),460,' Granary -25');
  if uc=1 then begin
      uc:=0;
       if player=1 then begin usd1:=usd1-20; house2:=house2-25; test; end;
       if player=2 then begin usd2:=usd2-20; house1:=house1-25; test; end;
     end;
 end;
 12:
 begin
  settextstyle(2,0,4);
  outtextxy(((sc*120)-80),415,'   Seed');
  outtextxy(((sc*120)-80),450,' 2 crops');
  outtextxy(((sc*120)-80),460,' field +3');
  if uc=1 then begin
      uc:=0;
       if player=1 then begin crop1:=crop1-2; field1:=field1+3; test; end;
       if player=2 then begin crop2:=crop2-2; field2:=field2+3; test; end;
     end;
 end;
 13:
 begin
  settextstyle(2,0,4);
  outtextxy(((sc*120)-80),415,'  Curse');
  outtextxy(((sc*120)-80),450,'  25 Usd');
  outtextxy(((sc*120)-80),460,'all -1, all+1');
  if uc=1 then begin
      uc:=0;
       if player=1 then begin usd1:=usd1-25; field2:=field2-1; gipsy2:=gipsy2-1;
       farmer2:=farmer2-1; house2:=house2-1; shit2:=shit2-1; usd2:=usd2-1; crop2:=crop2-1;
       field1:=field1+1; gipsy1:=gipsy1+1; farmer1:=farmer1+1; house1:=house1+1; shit1:=shit1+1;
       usd1:=usd1+1; crop1:=crop1+1; test; end;
       if player=2 then begin usd2:=usd2-25; field1:=field1-1; gipsy1:=gipsy1-1;
       farmer1:=farmer1-1; house1:=house1-1; shit1:=shit1-1; usd1:=usd1-1; crop1:=crop1-1;
       field2:=field2+1; gipsy2:=gipsy2+1; farmer2:=farmer2+1; house2:=house2+1; shit2:=shit2+1;
       usd2:=usd2+1; crop2:=crop2+1; test; end;
     end;
 end;
 14:
 begin
  settextstyle(2,0,4);
  outtextxy(((sc*120)-80),415,'  Export');
  outtextxy(((sc*120)-80),450,' 15 crops');
  outtextxy(((sc*120)-80),460,'  Usd +20');
  if uc=1 then begin
      uc:=0;
       if player=1 then begin usd1:=usd1+20; crop1:=crop1-15; test; end;
       if player=2 then begin crop2:=crop2-15; usd2:=usd2+20; test; end;
     end;
 end;
 15:
 begin
  settextstyle(2,0,4);
  outtextxy(((sc*120)-80),415,'  Fertility ');
  outtextxy(((sc*120)-80),450,'   8 shit');
  outtextxy(((sc*120)-80),460,'  crop +15');
  if uc=1 then begin
      uc:=0;
       if player=1 then begin shit1:=shit1-8; crop1:=crop1+15; test; end;
       if player=2 then begin shit2:=shit2-8; crop2:=crop2+15; test; end;
     end;
end;
 16:
 begin
  settextstyle(2,0,4);
  outtextxy(((sc*120)-80),415,'Seeding machine');
  outtextxy(((sc*120)-80),450,'   10 usd');
  outtextxy(((sc*120)-80),460,'  field +15');
  if uc=1 then begin
      uc:=0;
       if player=1 then begin usd1:=usd1-10; field1:=field1+15; test; end;
       if player=2 then begin usd2:=usd2-10; field2:=field2+15; test; end;
     end;
end;
 17:
 begin
  settextstyle(2,0,4);
  outtextxy(((sc*120)-80),415,' Graspingness ');
  outtextxy(((sc*120)-80),450,'   6 shit');
  outtextxy(((sc*120)-80),460,' enemy usd -10');
  if uc=1 then begin
      uc:=0;
       if player=1 then begin shit1:=shit1-6; usd2:=usd2-10; test; end;
       if player=2 then begin shit2:=shit2-6; usd1:=usd1-10; test; end;
     end;
end;
 18:
 begin
  settextstyle(2,0,4);
  outtextxy(((sc*120)-80),415,' Graspingness ');
  outtextxy(((sc*120)-80),450,'   6 shit');
  outtextxy(((sc*120)-80),460,'enemy crops -10');
  if uc=1 then begin
      uc:=0;
       if player=1 then begin shit1:=shit1-6; crop2:=crop2-10; test; end;
       if player=2 then begin shit2:=shit2-6; crop1:=crop1-10; test; end;
     end;
end;
 19:
 begin
  settextstyle(2,0,4);
  outtextxy(((sc*120)-80),415,' Graspingness ');
  outtextxy(((sc*120)-80),450,'   6 shit');
  outtextxy(((sc*120)-80),460,' enemy shit -10');
  if uc=1 then begin
      uc:=0;
       if player=1 then begin shit1:=shit1-6; shit2:=shit2-10; test; end;
       if player=2 then begin shit2:=shit2-6; shit1:=shit1-10; test; end;
     end;
end;
 20:
 begin
  settextstyle(2,0,4);
  outtextxy(((sc*120)-80),415,'   Enginer ');
  outtextxy(((sc*120)-80),450,'   15 usd');
  outtextxy(((sc*120)-80),460,' Granary +18');
  if uc=1 then begin
      uc:=0;
       if player=1 then begin usd1:=usd1-15; house1:=house1+18; test; end;
       if player=2 then begin usd2:=usd2-15; house2:=house2+18; test; end;
     end;
end;
 21:
 begin
  settextstyle(2,0,4);
  outtextxy(((sc*120)-80),415,' field care');
  outtextxy(((sc*120)-80),450,'   6 crops');
  outtextxy(((sc*120)-80),460,' field +10');
  if uc=1 then begin
      uc:=0;
       if player=1 then begin crop1:=crop1-6; field1:=field1+10; test; end;
       if player=2 then begin crop2:=crop2-6; field2:=field2+10; test; end;
     end;
end;
 22:
 begin
  settextstyle(2,0,4);
  outtextxy(((sc*120)-80),415,' Come to mama');
  outtextxy(((sc*120)-80),450,'   15 crops');
  outtextxy(((sc*120)-80),460,' farmer -1, +1');
  if uc=1 then begin
      uc:=0;
       if player=1 then begin crop1:=crop1-15; farmer1:=farmer1+1; farmer2:=farmer2-1; test; end;
       if player=2 then begin crop2:=crop2-15; farmer2:=farmer2+1; farmer1:=farmer1-1; test; end;
     end;
end;
 23:
 begin
  settextstyle(2,0,4);
  outtextxy(((sc*120)-80),415,'  Catapult');
  outtextxy(((sc*120)-80),450,'   10 shit');
  outtextxy(((sc*120)-80),460,'  attack 17');
  if uc=1 then begin
      uc:=0;
       if player=1 then begin shit1:=shit1-10; field2:=field2-17; test; end;
       if player=2 then begin shit2:=shit2-10; field1:=field1-17; test; end;
     end;
end;
 24:
 begin
  settextstyle(2,0,4);
  outtextxy(((sc*120)-80),415,'  Buy shit');
  outtextxy(((sc*120)-80),450,'   7 usd');
  outtextxy(((sc*120)-80),460,'  shit +10');
  if uc=1 then begin
      uc:=0;
       if player=1 then begin usd1:=usd1-7; shit1:=shit1+10; test; end;
       if player=2 then begin usd2:=usd2-7; shit2:=shit2+10; test; end;
     end;
end;
 25:
 begin
  settextstyle(2,0,4);
  outtextxy(((sc*120)-80),415,'  Buy crops');
  outtextxy(((sc*120)-80),450,'   7 usd');
  outtextxy(((sc*120)-80),460,'  crops +7');
  if uc=1 then begin
      uc:=0;
       if player=1 then begin usd1:=usd1-7; crop1:=crop1+7; test; end;
       if player=2 then begin usd2:=usd2-7; crop2:=crop2+7; test; end;
     end;
end;
 26:
 begin
  settextstyle(2,0,4);
  outtextxy(((sc*120)-80),415,' We pay more');
  outtextxy(((sc*120)-80),450,'   17 crops');
  outtextxy(((sc*120)-80),460,' gipsy -1, +1');
  if uc=1 then begin
      uc:=0;
       if player=1 then begin crop1:=crop1-17; gipsy1:=gipsy1+1; gipsy2:=gipsy2-1; test; end;
       if player=2 then begin crop2:=crop2-17; gipsy2:=gipsy2+1; gipsy1:=gipsy1-1; test; end;
     end;
end;
 27:
 begin
  settextstyle(2,0,4);
  outtextxy(((sc*120)-80),415,'  The Family');
  outtextxy(((sc*120)-80),450,'   16 crops');
  outtextxy(((sc*120)-80),460,'gipsy,farmer +1');
  if uc=1 then begin
      uc:=0;
       if player=1 then begin crop1:=crop1-16; gipsy1:=gipsy1+1; farmer1:=farmer1+1; test; end;
       if player=2 then begin crop2:=crop2-16; gipsy2:=gipsy2+1; farmer2:=farmer2+1; test; end;
     end;
end;
 28:
 begin
  settextstyle(2,0,4);
  outtextxy(((sc*120)-80),415,'  Transport');
  outtextxy(((sc*120)-80),450,'   12 usd');
  outtextxy(((sc*120)-80),460,'granary -12,+10');
  if uc=1 then begin
      uc:=0;
       if player=1 then begin usd1:=usd1-12; house1:=house1+10; house2:=house2-12; test; end;
       if player=2 then begin usd2:=usd2-12; house2:=house2+10; house1:=house1-12; test; end;
     end;
end;
 29:
 begin
  settextstyle(2,0,4);
  outtextxy(((sc*120)-80),415,' let`s eat');
  outtextxy(((sc*120)-80),450,'   4 crop');
  outtextxy(((sc*120)-80),460,'  shit +6');
  if uc=1 then begin
      uc:=0;
       if player=1 then begin crop1:=crop1-4; shit1:=shit1+6; test; end;
       if player=2 then begin crop2:=crop2-4; shit2:=shit2+6; test; end;
     end;
end;
 30:
 begin
  settextstyle(2,0,4);
  outtextxy(((sc*120)-80),415,'SuperShitball');
  outtextxy(((sc*120)-80),450,'   20 shit');
  outtextxy(((sc*120)-80),460,'  attack 27');
  if uc=1 then begin
      uc:=0;
       if player=1 then begin shit1:=shit1-20; field2:=field2-27; test; end;
       if player=2 then begin shit2:=shit2-20; field1:=field1-27; test; end;
     end;
end;

end; end;

procedure cleancards;
  begin
   setfillstyle(2,0);
   floodfill(310,450,5);
  end;

procedure round;
  begin
if player=2 then usd1:=usd1+gipsy1;
if player=1 then usd2:=usd2+gipsy2;
if player=2 then shit1:=shit1+farmer1;
if player=1 then shit2:=shit2+farmer2;
if player=2 then crop1:=crop1+1;
if player=1 then crop2:=crop2+1;
      if player=2 then begin
      cr1:=field1+1;
      repeat
      cr1:=cr1-1;
      until (cr1 mod 10=0) or (cr1<9);
      if cr1>9 then crop1:=crop1+(cr1 div 10);
      end;
      if player=1 then begin
      cr2:=field2+1;
      repeat
      cr2:=cr2-1;
      until (cr2 mod 10=0) or (cr2<9);
      if cr2>9 then crop2:=crop2+(cr2 div 10);
      end;
  end;

procedure check(check:integer);
  begin
   case check of
   1: begin
       if (player=1) and (shit1>4) then setcolor(14);
       if (player=2) and (shit2>4) then setcolor(14);
      end;
   2: begin
       if (player=1) and (usd1>9) then setcolor(14);
       if (player=2) and (usd2>9) then setcolor(14);
      end;
   3: begin
       if (player=1) and (crop1>8) then setcolor(14);
       if (player=2) and (crop2>8) then setcolor(14);
      end;
   4: begin
       if (player=1) and (shit1>1) then setcolor(14);
       if (player=2) and (shit2>1) then setcolor(14);
      end;
   5: begin
       if (player=1) and (shit1>10) then setcolor(14);
       if (player=2) and (shit2>10) then setcolor(14);
      end;
   6: begin
       if (player=1) and (usd1>14) then setcolor(14);
       if (player=2) and (usd2>14) then setcolor(14);
      end;
   7: begin
       if (player=1) and (crop1>9) then setcolor(14);
       if (player=2) and (crop2>9) then setcolor(14);
      end;
   8: begin
       if (player=1) and (crop1>5) then setcolor(14);
       if (player=2) and (crop2>5) then setcolor(14);
      end;
   9: begin
       if (player=1) and (shit1>5) then setcolor(14);
       if (player=2) and (shit2>5) then setcolor(14);
      end;
   10: begin
       if (player=1) and (usd1>2) then setcolor(14);
       if (player=2) and (usd2>2) then setcolor(14);
      end;
   11: begin
       if (player=1) and (usd1>19) then setcolor(14);
       if (player=2) and (usd2>19) then setcolor(14);
      end;
   12: begin
       if (player=1) and (crop1>1) then setcolor(14);
       if (player=2) and (crop2>1) then setcolor(14);
      end;
   13: begin
       if (player=1) and (usd1>24) then setcolor(14);
       if (player=2) and (usd2>24) then setcolor(14);
      end;
   14: begin
       if (player=1) and (crop1>14) then setcolor(14);
       if (player=2) and (crop2>14) then setcolor(14);
      end;
   15: begin
       if (player=1) and (shit1>7) then setcolor(14);
       if (player=2) and (shit2>7) then setcolor(14);
      end;
   16: begin
       if (player=1) and (usd1>9) then setcolor(14);
       if (player=2) and (usd2>9) then setcolor(14);
      end;
   17: begin
       if (player=1) and (shit1>5) then setcolor(14);
       if (player=2) and (shit2>5) then setcolor(14);
      end;
   18: begin
       if (player=1) and (shit1>5) then setcolor(14);
       if (player=2) and (shit2>5) then setcolor(14);
      end;
   19: begin
       if (player=1) and (shit1>5) then setcolor(14);
       if (player=2) and (shit2>5) then setcolor(14);
      end;
   20: begin
       if (player=1) and (usd1>14) then setcolor(14);
       if (player=2) and (usd2>14) then setcolor(14);
      end;
   21: begin
       if (player=1) and (crop1>5) then setcolor(14);
       if (player=2) and (crop2>5) then setcolor(14);
      end;
   22: begin
       if (player=1) and (crop1>14) then setcolor(14);
       if (player=2) and (crop2>14) then setcolor(14);
      end;
   23: begin
       if (player=1) and (shit1>9) then setcolor(14);
       if (player=2) and (shit2>9) then setcolor(14);
      end;
   24: begin
       if (player=1) and (usd1>6) then setcolor(14);
       if (player=2) and (usd2>6) then setcolor(14);
      end;
   25: begin
       if (player=1) and (usd1>6) then setcolor(14);
       if (player=2) and (usd2>6) then setcolor(14);
      end;
   26: begin
       if (player=1) and (crop1>16) then setcolor(14);
       if (player=2) and (crop2>16) then setcolor(14);
      end;
   27: begin
       if (player=1) and (crop1>15) then setcolor(14);
       if (player=2) and (crop2>15) then setcolor(14);
      end;
   28: begin
       if (player=1) and (usd1>11) then setcolor(14);
       if (player=2) and (usd2>11) then setcolor(14);
      end;
   29: begin
       if (player=1) and (crop1>3) then setcolor(14);
       if (player=2) and (crop2>3) then setcolor(14);
      end;
   30: begin
       if (player=1) and (shit1>19) then setcolor(14);
       if (player=2) and (shit2>19) then setcolor(14);
      end;

  end;
  end;

{--------------------------------------------------------------------}
procedure usecard(usc:integer);
  begin
   uc:=1;
   if player=1 then begin
       case sc of 1: cards(c11);
                  2: cards(c12);
                  3: cards(c13);
                  4: cards(c14);
                  5: cards(c15);
                  end;  end;
   if player=2 then begin
       case sc of 1: cards(c21);
                  2: cards(c22);
                  3: cards(c23);
                  4: cards(c24);
                  5: cards(c25);
                  end;  end;
  end;

procedure space;
  begin
   if player=1 then begin
       case sc of 1: c11:=random(30)+1;
                  2: c12:=random(30)+1;
                  3: c13:=random(30)+1;
                  4: c14:=random(30)+1;
                  5: c15:=random(30)+1;
                     end;
     end;
   if player=2 then begin
       case sc of 1: c21:=random(30)+1;
                  2: c22:=random(30)+1;
                  3: c23:=random(30)+1;
                  4: c24:=random(30)+1;
                  5: c25:=random(30)+1;
                     end;
     end;
  end;

procedure enter;
  begin
   case sc of
   1: begin
       if asc1=14 then begin
                        usecard(sc);
                        if player=1 then c11:=random(30)+1;
                        if player=2 then c21:=random(30)+1;
                        go:=1;
                       end;
       if asc1<>14 then begin sound(220); delay(50); nosound; end;
      end;
   2: begin
       if asc2=14 then begin
                        usecard(sc);
                        if player=1 then c12:=random(30)+1;
                        if player=2 then c22:=random(30)+1;
                        go:=1;
                       end;
       if asc2<>14 then begin sound(220); delay(50); nosound; end;
      end;
   3: begin
       if asc3=14 then begin
                        usecard(sc);
                        if player=1 then c13:=random(30)+1;
                        if player=2 then c23:=random(30)+1;
                        go:=1;
                       end;
       if asc3<>14 then begin sound(220); delay(50); nosound; end;
      end;
   4: begin
       if asc4=14 then begin
                        usecard(sc);
                        if player=1 then c14:=random(30)+1;
                        if player=2 then c24:=random(30)+1;
                        go:=1;
                       end;
       if asc4<>14 then begin sound(220); delay(50); nosound; end;
      end;
   5: begin
       if asc5=14 then begin
                        usecard(sc);
                        if player=1 then c15:=random(30)+1;
                        if player=2 then c25:=random(30)+1;
                        go:=1;
                       end;
       if asc5<>14 then begin sound(220); delay(50); nosound; end;
      end;
end;
end;

procedure display;
  begin

if player=1 then begin
    setfillstyle(1,14);
    floodfill(260,110,15);
    setfillstyle(1,0);
    floodfill(380,110,15);
   end;
if player=2 then begin
    setfillstyle(1,0);
    floodfill(260,110,15);
    setfillstyle(1,14);
    floodfill(380,110,15);
   end;

             {A nehai Cleand}
             setfillstyle(1,0);
             floodfill(637,3,5);
             floodfill(63,3,5);

   setcolor(7);
   settextstyle(2,0,5);
                                  {Player1}
moveto(1,3);
outtext('Farmer: '); str(farmer1,s); moveto(63,3); outtext(s);
moveto(1,18);
outtext('Shit:'); str(shit1,s); moveto(63,18); outtext(s);
moveto(1,33);
outtext('Gipsy:'); str(gipsy1,s); moveto(63,33); outtext(s);
moveto(1,48);
outtext('USD:'); str(usd1,s); moveto(63,48); outtext(s);
moveto(1,63);
outtext('Crops:'); str(crop1,s); moveto(63,63); outtext(s);
moveto(1,93);
outtext('Granary:'); str((house1-20),s); moveto(63,93); outtext(s);
moveto(1,108);
outtext('Fields:'); str(field1,s); moveto(63,108); outtext(s);
                                {Player2}
moveto(545,3);
outtext('Farmer: '); str(farmer2,s); moveto(610,3); outtext(s);
moveto(545,18);
outtext('Shit:'); str(shit2,s); moveto(610,18); outtext(s);
moveto(545,33);
outtext('Gipsy:'); str(gipsy2,s); moveto(610,33); outtext(s);
moveto(545,48);
outtext('USD:'); str(usd2,s); moveto(610,48); outtext(s);
moveto(545,63);
outtext('Crops:'); str(crop2,s); moveto(610,63); outtext(s);
moveto(545,93);
outtext('Granary:'); str((house2-20),s); moveto(610,93); outtext(s);
moveto(545,108);
outtext('Fields:'); str(field2,s); moveto(610,108); outtext(s);
  end;


procedure map;
   begin
     setfillstyle(1,0);
     {Clear Houses}
   if house1<>lh1 then floodfill(40,395,0);
   if house1<lh1 then begin setcolor(5); line(105,401,105,125); floodfill(10,350,5);
   setcolor(0); line(105,401,105,125);  end;
   if house2<>lh2 then floodfill(550,395,0);
   if house2<lh2 then begin setcolor(5); line(535,401,535,125); floodfill(540,350,5);
   setcolor(0); line(535,401,535,125);  end;
    {Clear Fields}
   if field1<>lf1 then floodfill(111,398,0);
   if field2<>lf2 then floodfill(529,397,0);

     {House1}
     setlinestyle(0,0,1);
     setcolor(8);
     setfillstyle(1,8);
     rectangle(30,400,100,(405-(house1*2)));
     floodfill(35,396,8);
     circle(65,(405-(house1*2)),35);
     floodfill(65,(400-(house1*2)),8);
  setcolor(7);
  rectangle(29,400,101,370);
  line(29,380,101,380);
  line(29,390,101,390);
  line(47,370,47,380);
  line(47,390,47,400);
  line(65,370,65,380);
  line(65,390,65,400);
  line(83,370,83,380);
  line(83,390,83,400);
  line(38,380,38,390);
  line(56,380,56,390);
  line(74,380,74,390);
  line(92,380,92,390);
     setcolor(0);
     setfillstyle(1,4);
     line(30,(400-(house1*2)),100,(400-(house1*2)));
     floodfill(65,(395-(house1*2)),0);
      {Windows on 1}
     y:=(400-(house1*2));
     win:=3;
      if house1>24 then begin
      repeat
     rectangle(60,y+5,70,y+15);
     line(60,y+10,70,y+10);
     line(65,y+5,65,y+15);
     rectangle(40,y+5,50,y+15);
     line(40,y+10,50,y+10);
     line(45,y+5,45,y+15);
     rectangle(80,y+5,90,y+15);
     line(80,y+10,90,y+10);
     line(85,y+5,85,y+15);
     win:=win+10;
     y:=y+20;
      until win>=(house1-20); end;

     {Field1}
     setcolor(14);
     setfillstyle(1,14);
     rectangle(110,400,(111+(field1*3)),395);
     floodfill(111,397,14);
     {House2}
     setlinestyle(0,0,1);
     setcolor(8);
     setfillstyle(1,8);
     rectangle(610,400,540,(405-(house2*2)));
     floodfill(608,397,8);
     circle(575,(405-(house2*2)),35);
     floodfill(575,(400-(house2*2)),8);
  setcolor(7);
  rectangle(611,400,539,370);
  line(539,380,611,380);
  line(539,390,611,390);
  line(557,370,557,380);
  line(557,390,557,400);
  line(575,370,575,380);
  line(575,390,575,400);
  line(593,370,593,380);
  line(593,390,593,400);
  line(548,380,548,390);
  line(566,380,566,390);
  line(584,380,584,390);
  line(602,380,602,390);
     setcolor(0);
     setfillstyle(1,4);
     line(610,(400-(house2*2)),540,(400-(house2*2)));
     floodfill(575,(395-(house2*2)),0);
     y:=(400-(house2*2));
     {Windows on 2}
     win:=3;
      if house2>24 then begin
      repeat
     rectangle(550,y+5,560,y+15);
     line(550,y+10,560,y+10);
     line(555,y+5,555,y+15);
     rectangle(570,y+5,580,y+15);
     line(570,y+10,580,y+10);
     line(575,y+5,575,y+15);
     rectangle(590,y+5,600,y+15);
     line(590,y+10,600,y+10);
     line(595,y+5,595,y+15);
     win:=win+10;
     y:=y+20;
      until win>=(house2-20); end;
     {Field2}
     setcolor(14);
     setfillstyle(1,14);
     rectangle(530,400,(640-(111+(field2*3))),395);
     floodfill(529,397,14);
     {Loging}
     lh1:=house1;
     lh2:=house2;
     lf1:=field1;
     lf2:=field2;
    end;

procedure card;
  begin
    setfillstyle(2,0);
    floodfill(2,438,5);
   sck:=3;
   repeat
   if player=1 then begin
       setcolor(8); check(c11);
       sc:=1; cards(c11); asc1:=getcolor;
       setcolor(8); check(c12);
       sc:=2; cards(c12); asc2:=getcolor;
       setcolor(8); check(c13);
       sc:=3; cards(c13); asc3:=getcolor;
       setcolor(8); check(c14);
       sc:=4; cards(c14); asc4:=getcolor;
       setcolor(8); check(c15);
       sc:=5; cards(c15); asc5:=getcolor;
       sc:=1;
      end;
   if player=2 then begin
       setcolor(8); check(c21);
       sc:=1; cards(c21); asc1:=getcolor;
       setcolor(8); check(c22);
       sc:=2; cards(c22); asc2:=getcolor;
       setcolor(8); check(c23);
       sc:=3; cards(c23); asc3:=getcolor;
       setcolor(8); check(c24);
       sc:=4; cards(c24); asc4:=getcolor;
       setcolor(8); check(c25);
       sc:=5; cards(c25); asc5:=getcolor;
       sc:=1;
      end;

   sc:=sck;
   setcolor(8);
   if (sc=1)  then  setcolor(15);
   rectangle(30,475,130,410);
   setcolor(8);
   if (sc=2)  then  setcolor(15);
   rectangle(150,475,250,410);
   setcolor(8);
   if (sc=3)  then  setcolor(15);
   rectangle(270,475,370,410);
   setcolor(8);
   if (sc=4)  then  setcolor(15);
   rectangle(390,475,490,410);
   setcolor(8);
   if (sc=5) then  setcolor(15);
   rectangle(510,475,610,410);
   k:=readkey;
     if ord(k)=75 then sc:=sc-1;
     if ord(k)=77 then sc:=sc+1;
     if sc=0 then sc:=5;
     if sc=6 then sc:=1;
     sck:=sc;
     go:=0;
   if ord(k)=13 then enter;
   if ord(k)=32 then space;
   until (ord(k)=32) or (ord(k)=27) or (go=1);
  end;

procedure envi;
  begin
   setcolor(15);
   circle(270,110,35);
   circle(370,110,35);
   line(130,110,270,145);
   line(130,110,270,75);
   line(510,110,370,145);
   line(510,110,370,75);
setfillstyle(1,8);
floodfill(140,110,15);
floodfill(500,110,15);
setcolor(5);
   setlinestyle(0,0,3);
   rectangle(150,0,490,30);
     settextstyle(7,0,2);
     outtextxy(170,40,name1);
     outtextxy(355,40,name2);
   line(0,125,110,125);
   line(530,125,640,125);
   line(530,125,490,30);
   line(150,30,110,125);
   line(0,125,0,402);
   line(640,125,640,402);
   line(320,30,320,178);
   line(320,178,110,125);
   line(320,178,530,125);
   moveto(230,5);
   settextstyle(1,0,1);
   outtext('  Farm Wars 2002');
   setlinestyle(0,0,1);
   line(0,402,640,402);
  end;
begin
house1:=50;
house2:=50;
field1:=20;
field2:=20;
farmer1:=2;
farmer2:=2;
gipsy1:=2;
gipsy2:=2;
usd1:=6;
usd2:=6;
crop1:=6;
crop2:=6;
shit1:=6;
shit2:=6;
ender:=0;
  gd:=detect;
  initgraph(gd,gm,'c:\tp7\bgi');
  if graphresult<>grok then halt;
gamemenu;
if ender<>1 then begin
cleardevice;
randomize;
     {A nehai Seed}
    c11:=random(30)+1;
    c12:=random(30)+1;
    c13:=random(30)+1;
    c14:=random(30)+1;
    c15:=random(30)+1;
    c21:=random(30)+1;
    c22:=random(30)+1;
    c23:=random(30)+1;
    c24:=random(30)+1;
    c25:=random(30)+1;
player:=1;
uc:=0;
{Start login}
lh1:=house1;
lh2:=house2;
lf1:=field1;
lf2:=field2;
sc:=1;
envi;
repeat
 display;
 map;
 card;
 if player=1 then player:=2 else player:=1;
 round;
until (ord(k)=27) or (ender=1);
end;
end.