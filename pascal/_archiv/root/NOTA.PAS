uses crt;
type pole=array[1..2] of integer;
var wy,sel,i,n,a,b,d,s:integer;
    f :file of pole;
    rd:pole;
    path:string[20];
    k:char;
    znovu:boolean;
procedure beep(ss,dd:integer);
begin
 sound(ss);
 delay(dd);
 nosound;
end;

procedure nenovy;
begin
reset(f);
writeln('Teraz ti prehram tvoj subor: ',path);
for i:=0 to (filesize(f)-1) do begin
     seek(f,i);
     read(f,rd);
     writeln(rd[1],' ',rd[2]);
    end;

for i:=0 to (filesize(f)-1) do begin
     seek(f,i);
     read(f,rd);
     sound(rd[1]);
     delay(rd[2]);
     nosound;
      end;
close(f);
end;

procedure novy;
begin
close(f);
rewrite(f);
writeln('Vytvoril si novy subor, mozes zadavat tony');
write('Kolko tonov kces zadat? n=');
readln(n);
for i:=0 to (n-1) do
    begin
     write('ton ',(i+1),': ');
     read(s);
     write(' dlzka: ');
     read(d);
     seek(f,i);
     rd[1]:=s;
     rd[2]:=d;
     write(f,rd);
    end;
close(f);
writeln('vyborne, vytvoril si piesen, kces pocut? (a/n)');
k:=readkey;
if (k='a') or (k='A') then nenovy;
end;

begin
textbackground(0);
clrscr;
repeat
writeln('Tvoris novy subor?');
sel:=1;
wy:=wherey;

repeat
k:='r';
gotoxy(2,wy);
textbackground(0);
if sel=0 then textbackground(6) else textbackground(0);
writeln('    Ano    ');
gotoxy(2,wy+1);
if sel=1 then textbackground(6) else textbackground(0);
writeln('    Nie    ');
textbackground(0);
k:=readkey;
if ord(k) in [80,72] then sel:=1-sel;
until ord(k) in [13,27];

write('Zadaj nazov suboru: ');
readln(path);
assign(f,path);
if sel=0 then rewrite(f) else reset(f);
if filesize(f)>0 then nenovy else novy;
Writeln('Chces znovu?');
wy:=wherey;
sel:=0;

repeat
k:='r';
gotoxy(2,wy);
textbackground(0);
if sel=0 then textbackground(6) else textbackground(0);
writeln('    Ano    ');
gotoxy(2,wy+1);
if sel=1 then textbackground(6) else textbackground(0);
writeln('    Nie    ');
textbackground(0);
k:=readkey;
if ord(k) in [80,72] then sel:=1-sel;
until ord(k) in [13,27];

if sel=0 then znovu:=true else znovu:=false;
until znovu=false;
nosound;
end.