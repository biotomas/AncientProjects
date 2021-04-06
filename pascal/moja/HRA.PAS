uses games,crt;
var x,y:word;
    k:char;
    a,b,c,d:shortint;
begin
initnewkeyint;
a:=scanof('s');
b:=scanof('a');
c:=scanof('s');
d:=scanof('d');
x:=40;
y:=12;

repeat
clrscr;

if keydown[a] then inc(y);
if keydown[b] then dec(y);
if keydown[c] then dec(x);
if keydown[d] then inc(x);
{
if keydown[scanof('w')] then inc(y);
if keydown[scanof('s')] then dec(y);
if keydown[scanof('d')] then dec(x);
if keydown[scanof('a')] then inc(x);
}

gotoxy(x,y);
write('*');
delay(120);
until wasdown[escscan];
setoldkeyint;
end.