program mind2;
uses crt;
var col,a,b,c,d,e,a1,b1,c1,d1,ch,ch2 :integer;
k:char;
begin
randomize;
repeat
clrscr;
textbackground(7);
clrscr;
textcolor(0);
writeln;
writeln;
writeln;{123456789012345678901234567890123456789012345678901234567890123456}
writeln('                  ÚÄÄÄÄÄÄ¿ ÚÄÄÄÄÄÄ¿ ÚÄÄÄÄÄÄ¿ ÚÄÄÄÄÄÄ¿ ÚÄÄÄÄÄÄ¿     ');
writeln('                  ³      ³ ³      ³ ³      ³ ³      ³ ³      ³     ');
writeln('                  ³      ³ ³      ³ ³      ³ ³      ³ ³      ³     ');
writeln('                  ³      ³ ³      ³ ³      ³ ³      ³ ³      ³     ');
writeln('                  ÀÄÄÄÄÄÄÙ ÀÄÄÄÄÄÄÙ ÀÄÄÄÄÄÄÙ ÀÄÄÄÄÄÄÙ ÀÄÄÄÄÄÄÙ     ');

col:=random(2)+1;
if col=1 then textcolor(4) else textcolor(0);
a:=random(18)+2;
repeat b:=random(18)+2; until b<>a;
repeat c:=random(18)+2; until (c<>a) and (c<>b);
repeat d:=random(18)+2; until (d<>a) and (d<>b) and (d<>c);
repeat e:=random(18)+2; until (e<>a) and (e<>b) and (e<>c) and (e<>d);
repeat a1:=random(18)+2; until (a1<>a) and (a1<>b) and (a1<>c) and (a1<>d) and (a1<>e);
repeat b1:=random(18)+2; until (b1<>a) and (b1<>b) and (b1<>c) and (b1<>d) and (b1<>e) and (b1<>a1);
repeat c1:=random(18)+2; until (c1<>a) and (c1<>b) and (c1<>c) and (c1<>d) and (c1<>e) and (c1<>a1) and (c1<>b1);
repeat d1:=random(18)+2; until (d1<>a) and (d1<>b) and (d1<>c) and (d1<>d) and (d1<>e) and (d1<>a1) and (d1<>b1) and (d1<>c1);

if col=1 then begin ch:=3; ch2:=4; end;
if col=2 then begin ch:=5; ch2:=6; end;

gotoxy(20,5);
if a<11 then begin write(char(ch)); write(a);     end;
if a>10 then begin write(char(ch2)); write(a-9);  end;

gotoxy(29,5);
if b<11 then begin write( char(ch)); write(b);    end;
if b>10 then begin write( char(ch2)); write(b-9); end;

gotoxy(38,5);
if c<11 then begin write( char(ch)); write(c);    end;
if c>10 then begin write( char(ch2)); write(c-9); end;

gotoxy(47,5);
if d<11 then begin write( char(ch)); write(d);    end;
if d>10 then begin write( char(ch2)); write(d-9); end;

gotoxy(56,5);
if e<11 then begin write( char(ch)); write(e);    end;
if e>10 then begin write( char(ch2)); write(e-9); end;

gotoxy(2,12);
textcolor(0);
writeln('                Most valaszthatsz egy kartyat a sorbol. ');
writeln(' Mutas meg nekem az ujaddal melyket valasztottad es nyomj le egy gombot ');
k:=readkey;
clrscr;
textbackground(0);
clrscr;
textcolor(7);
writeln;
writeln;
writeln;
writeln(' Tudtad-e hogy a kepernyodon nyomas erzekelo van ?') ;
k:=readkey;
clrscr;
textbackground(7);
clrscr;
textcolor(0);
writeln;
writeln;
writeln;{123456789012345678901234567890123456789012345678901234567890123456}
writeln('                    ÚÄÄÄÄÄÄ¿ ÚÄÄÄÄÄÄ¿ ÚÄÄÄÄÄÄ¿ ÚÄÄÄÄÄÄ¿     ');
writeln('                    ³      ³ ³      ³ ³      ³ ³      ³     ');
writeln('                    ³      ³ ³      ³ ³      ³ ³      ³     ');
writeln('                    ³      ³ ³      ³ ³      ³ ³      ³     ');
writeln('                    ÀÄÄÄÄÄÄÙ ÀÄÄÄÄÄÄÙ ÀÄÄÄÄÄÄÙ ÀÄÄÄÄÄÄÙ     ');

if col=1 then textcolor(4) else textcolor(0);

gotoxy(22,5);
if a1<11 then begin write( char(ch)); write(a1);    end;
if a1>10 then begin write( char(ch2)); write(a1-9); end;

gotoxy(31,5);
if b1<11 then begin write( char(ch)); write(b1);    end;
if b1>10 then begin write( char(ch2)); write(b1-9); end;

gotoxy(40,5);
if c1<11 then begin write( char(ch)); write(c1);    end;
if c1>10 then begin write( char(ch2)); write(c1-9); end;

gotoxy(49,5);
if d1<11 then begin write( char(ch)); write(d1);    end;
if d1>10 then begin write( char(ch2)); write(d1-9); end;

gotoxy(2,12);
textcolor(0);
writeln('   Latod most azt a kartyat amelykre ramutattal elvettem a sorbol');
writeln('                     Jo mi ?       nyomj egy gombot.');
writeln('            Ha megegyszer megakarod probalni nyomd az ENTERt');
k:=readkey;
until ord(k)<>(13);
writeln;
writeln;
writeln;
writeln('                                  Szevasz') ;

end .











