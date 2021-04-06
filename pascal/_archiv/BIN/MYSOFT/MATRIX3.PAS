program matrix3;
uses crt;
var a,b,c,d,e,f,l,x,y:integer;
    h:char;
begin
randomize;
c:=0;
clrscr;
l:=10;
    repeat
    if c mod 2 = 0 then begin  e:=random(40)+1;
    x:=2*e;
    for y:=1 to random(20)+4 do begin
    gotoxy(x,y);
    write('0');
    delay(l);           end; end else begin
           d:=random(40)+1;
           x:=2*d;
           for y:=1 to random(20)+4 do begin
           gotoxy(x,y);
           write('I');
           delay(l);
           end;         end;

    c:=c+1;
    until keypressed;




end.