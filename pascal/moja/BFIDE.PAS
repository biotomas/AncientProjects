uses crt;

{
var M: array[1..25{50},1..80] of
         record znak:char; attr:byte end
         absolute $B800:0;
begin
TextMode(C80);{TextMode(C80+Font8x8);}
clrscr;
M[13,40].znak:='X';
M[13,40].attr:=Yellow+Blue*16+Blink;
readln;
end.
{}

procedure setscreen;
var i:byte;
begin
clrscr;
textbackground(7);
textcolor(0);
write  ('  File  Debug   Help                                                            ');
textbackground(0);
textcolor(7);
writeln(' ษออWATCHอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป');
writeln(' บ                                                                            บ');
writeln(' ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ');
for i:=1 to 18 do writeln;
writeln(' ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป');
writeln(' บ F2 Save  F3 Open  F4 Stop  F5 Run  F7 Compile  F8 Step  F9 Trace  F10 Exit บ');
write  (' ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ');
gotoxy(2,5);
end;

var a:string;
    k:char;
    mx,my,mb:integer;
begin
setscreen;
{window(2,5,79,22);{}
repeat
asm
 mov ax,3
 int 33h
 mov mx,cx
 mov my,dx
 mov mb,bx
end;
mx:=mx div 8 + 1;
my:=my div 8 + 1;
if (my=25) and (mx=80) then mx:=79;
gotoxy(mx, my);
write(char(25));
pointer

if keypressed then k:=readkey;
until ord(k)=68;
end.