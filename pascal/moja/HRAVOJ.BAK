uses crt;
const hrac:array[1..5] of string = ('Tammas','Voytex','Gejzarado','Maco','GGyula');
var body:array[1..5] of byte;
    q:char;
    a,b,i:byte;
    delaj,vysl:integer;
begin
randomize;
clrscr;
i:=0;
repeat
inc(i);
writeln('Hrac ',hrac[i],' ide');
if i = 6 then i:=1;
delaj:=13;
a:=random(100)+1;
b:=random(20)+1;
write(a,' x ',b,' = ');
delay(500);
repeat
dec(delaj);
delay(1000);
clrscr;
writeln('mas uz len ',delaj,' sekund ty ',hrac[i]);
until (delaj = 0) or keypressed;
readln(vysl);
if vysl = a*b then
   begin
   inc(body[i]);
   writeln('Pekne ty ',hrac[i]);
   end
              else
   writeln('Ti jebe ti ',hrac[i], ' ?');
delay(1000);
until ord(q) = 27;
clrscr;
for i:=1 to 5 do
    writeln('Hrac ',hrac[i],' mas ', body[i],' bodov.');
end.