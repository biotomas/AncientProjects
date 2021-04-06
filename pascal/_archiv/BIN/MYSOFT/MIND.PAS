program mindscanner;
uses crt;
var a,b,c,d,e,a1,b1,c1,d1,r :integer;
        k   :char;
begin
randomize;
a:=0;
b:=0;
c:=0;
d:=0;
e:=0;
a1:=0;
b1:=0;
c1:=0;
d1:=0;
clrscr;
textbackground(7);












clrscr;
textbackground(7);
textcolor(0);
writeln;
writeln;
writeln;{123456789012345678901234567890123456789012345678901234567890123456}
writeln('                 ÚÄÄÄÄÄÄ¿ ÚÄÄÄÄÄÄ¿ ÚÄÄÄÄÄÄ¿ ÚÄÄÄÄÄÄ¿ ÚÄÄÄÄÄÄ¿     ');
writeln('                 ³      ³ ³      ³ ³      ³ ³      ³ ³      ³     ');
writeln('                 ³      ³ ³      ³ ³      ³ ³      ³ ³      ³     ');
writeln('                 ³      ³ ³      ³ ³      ³ ³      ³ ³      ³     ');
writeln('                 ÀÄÄÄÄÄÄÙ ÀÄÄÄÄÄÄÙ ÀÄÄÄÄÄÄÙ ÀÄÄÄÄÄÄÙ ÀÄÄÄÄÄÄÙ     ');
r:=random(16)+1;
a:=r;
repeat r:=random(16)+1; until r<>a; b:=r;
repeat r:=random(16)+1; until (r<>a) and (r<>b); c:=r;
repeat r:=random(16)+1; until (r<>a) and (r<>b) and (r<>c); d:=r;
repeat r:=random(16)+1; until (r<>a) and (r<>b) and (r<>c) and (r<>d); e:=r;
if a<9 then textcolor(4) else textcolor(0);
gotoxy(20,5);
if a=1 then write(char(4),'A');
if a=2 then write(char(3),'A');
if a=3 then write(char(4),'K');
if a=4 then write(char(3),'K');
if a=5 then write(char(4),'Q');
if a=6 then write(char(3),'Q');
if a=7 then write(char(4),'J');
if a=8 then write(char(3),'J');

if a=9 then write(char(6),'A');
if a=10 then write(char(5),'A');
if a=11 then write(char(6),'K');
if a=12 then write(char(5),'K');
if a=13 then write(char(6),'Q');
if a=14 then write(char(5),'Q');
if a=15 then write(char(6),'J');
if a=16 then write(char(5),'J');


if b<9 then textcolor(4) else textcolor(0);
gotoxy(29,5);
if b=1 then write(char(4),'A');
if b=2 then write(char(3),'A');
if b=3 then write(char(4),'K');
if b=4 then write(char(3),'K');
if b=5 then write(char(4),'Q');
if b=6 then write(char(3),'Q');
if b=7 then write(char(4),'J');
if b=8 then write(char(3),'J');

if b=9 then write(char(6),'A');
if b=10 then write(char(5),'A');
if b=11 then write(char(6),'K');
if b=12 then write(char(5),'K');
if b=13 then write(char(6),'Q');
if b=14 then write(char(5),'Q');
if b=15 then write(char(6),'J');
if b=16 then write(char(5),'J');


if c<9 then textcolor(4) else textcolor(0);
gotoxy(38,5);
if c=1 then write(char(4),'A');
if c=2 then write(char(3),'A');
if c=3 then write(char(4),'K');
if c=4 then write(char(3),'K');
if c=5 then write(char(4),'Q');
if c=6 then write(char(3),'Q');
if c=7 then write(char(4),'J');
if c=8 then write(char(3),'J');

if c=9 then write(char(6),'A');
if c=10 then write(char(5),'A');
if c=11 then write(char(6),'K');
if c=12 then write(char(5),'K');
if c=13 then write(char(6),'Q');
if c=14 then write(char(5),'Q');
if c=15 then write(char(6),'J');
if c=16 then write(char(5),'J');


if d<9 then textcolor(4) else textcolor(0);
gotoxy(47,5);
if d=1 then write(char(4),'A');
if d=2 then write(char(3),'A');
if d=3 then write(char(4),'K');
if d=4 then write(char(3),'K');
if d=5 then write(char(4),'Q');
if d=6 then write(char(3),'Q');
if d=7 then write(char(4),'J');
if d=8 then write(char(3),'J');

if d=9 then write(char(6),'A');
if d=10 then write(char(5),'A');
if d=11 then write(char(6),'K');
if d=12 then write(char(5),'K');
if d=13 then write(char(6),'Q');
if d=14 then write(char(5),'Q');
if d=15 then write(char(6),'J');
if d=16 then write(char(5),'J');


if e<9 then textcolor(4) else textcolor(0);
gotoxy(56,5);
if e=1 then write(char(4),'A');
if e=2 then write(char(3),'A');
if e=3 then write(char(4),'K');
if e=4 then write(char(3),'K');
if e=5 then write(char(4),'Q');
if e=6 then write(char(3),'Q');
if e=7 then write(char(4),'J');
if e=8 then write(char(3),'J');

if e=9 then write(char(6),'A');
if e=10 then write(char(5),'A');
if e=11 then write(char(6),'K');
if e=12 then write(char(5),'K');
if e=13 then write(char(6),'Q');
if e=14 then write(char(5),'Q');
if e=15 then write(char(6),'J');
if e=16 then write(char(5),'J');

gotoxy(5,10);
textcolor(0);

writeln('No most valszthatsz magadnak egy lapot. Ha Ok akkor nyomj be egy gombot.');
k:=readkey;

textbackground(0);
clrscr;

clrscr;
textcolor(7);
gotoxy(5,10);
Writeln('Na es most zard be a szemed es gondolj a kartyadra, nyomj egy gombot ha Ok');
k:=readkey;


clrscr;
textbackground(7);
clrscr;
textbackground(7);
textcolor(0);
writeln;
writeln;
writeln;{123456789012345678901234567890123456789012345678901234567890123456}
writeln('                    ÚÄÄÄÄÄÄ¿ ÚÄÄÄÄÄÄ¿ ÚÄÄÄÄÄÄ¿ ÚÄÄÄÄÄÄ¿     ');
writeln('                    ³      ³ ³      ³ ³      ³ ³      ³     ');
writeln('                    ³      ³ ³      ³ ³      ³ ³      ³     ');
writeln('                    ³      ³ ³      ³ ³      ³ ³      ³     ');
writeln('                    ÀÄÄÄÄÄÄÙ ÀÄÄÄÄÄÄÙ ÀÄÄÄÄÄÄÙ ÀÄÄÄÄÄÄÙ     ');
a1:=a;
b1:=b;
c1:=c;
d1:=d;
repeat a1:=a1+1; if a1=17 then a1:=1; until (a1<>a) and (a1<>b) and (a1<>c) and (a1<>d) and (a1<>e);
repeat b1:=b1+1; if b1=17 then b1:=1; until (b1<>a) and (b1<>b) and (b1<>c) and (b1<>d) and (b1<>e) and (b1<>a1);
repeat c1:=c1+1; if c1=17 then c1:=1; until (c1<>a) and (c1<>b) and (c1<>c) and (c1<>d) and (c1<>e) and (c1<>a1) and (c1<>b1);
repeat d1:=d1+1; if d1=17 then d1:=1; until (d1<>a) and (d1<>b) and (d1<>c) and (d1<>d) and (d1<>e) and
(d1<>a1) and (d1<>b1) and (d1<>c1);


if a1<9 then textcolor(4) else textcolor(0);
gotoxy(22,5);
if a1=1 then write(char(4),'A');
if a1=2 then write(char(3),'A');
if a1=3 then write(char(4),'K');
if a1=4 then write(char(3),'K');
if a1=5 then write(char(4),'Q');
if a1=6 then write(char(3),'Q');
if a1=7 then write(char(4),'J');
if a1=8 then write(char(3),'J');

if a1=9 then write(char(6),'A');
if a1=10 then write(char(5),'A');
if a1=11 then write(char(6),'K');
if a1=12 then write(char(5),'K');
if a1=13 then write(char(6),'Q');
if a1=14 then write(char(5),'Q');
if a1=15 then write(char(6),'J');
if a1=16 then write(char(5),'J');


if b1<9 then textcolor(4) else textcolor(0);
gotoxy(31,5);
if b1=1 then write(char(4),'A');
if b1=2 then write(char(3),'A');
if b1=3 then write(char(4),'K');
if b1=4 then write(char(3),'K');
if b1=5 then write(char(4),'Q');
if b1=6 then write(char(3),'Q');
if b1=7 then write(char(4),'J');
if b1=8 then write(char(3),'J');

if b1=9 then write(char(6),'A');
if b1=10 then write(char(5),'A');
if b1=11 then write(char(6),'K');
if b1=12 then write(char(5),'K');
if b1=13 then write(char(6),'Q');
if b1=14 then write(char(5),'Q');
if b1=15 then write(char(6),'J');
if b1=16 then write(char(5),'J');


if c1<9 then textcolor(4) else textcolor(0);
gotoxy(40,5);
if c1=1 then write(char(4),'A');
if c1=2 then write(char(3),'A');
if c1=3 then write(char(4),'K');
if c1=4 then write(char(3),'K');
if c1=5 then write(char(4),'Q');
if c1=6 then write(char(3),'Q');
if c1=7 then write(char(4),'J');
if c1=8 then write(char(3),'J');

if c1=9 then write(char(6),'A');
if c1=10 then write(char(5),'A');
if c1=11 then write(char(6),'K');
if c1=12 then write(char(5),'K');
if c1=13 then write(char(6),'Q');
if c1=14 then write(char(5),'Q');
if c1=15 then write(char(6),'J');
if c1=16 then write(char(5),'J');


if d1<9 then textcolor(4) else textcolor(0);
gotoxy(49,5);
if d1=1 then write(char(4),'A');
if d1=2 then write(char(3),'A');
if d1=3 then write(char(4),'K');
if d1=4 then write(char(3),'K');
if d1=5 then write(char(4),'Q');
if d1=6 then write(char(3),'Q');
if d1=7 then write(char(4),'J');
if d1=8 then write(char(3),'J');

if d1=9 then write(char(6),'A');
if d1=10 then write(char(5),'A');
if d1=11 then write(char(6),'K');
if d1=12 then write(char(5),'K');
if d1=13 then write(char(6),'Q');
if d1=14 then write(char(5),'Q');
if d1=15 then write(char(6),'J');
if d1=16 then write(char(5),'J');



textcolor(0);
gotoxy(1,10);
writeln('   Na most fiam az tortent hogy en elvettem azt a kartyat a sorbol amelyket te');
gotoxy(1,11);
writeln('     gondoltad. Jo mi ? Ha erdekel hogy honnan tudtam mejk kartyara gondolsz, ');
gotoxy(1,12);
writeln('   akkor szett fogol robbani amig magadtol ra nem josz mert bizony en nemtudom');
gotoxy(1,17);
writeln(' Nyomj egy gombot !');

k:=readkey;


end.