uses crt;
type tah=array[1..7] of byte;
     tyzden=record
     t1,t2:tah;
     datum:string[6];
     end;
var f:file of tyzden;
    tzd:tyzden;
    k:char;

procedure readtah(var t:tah);
var i,j,x:byte;
    s:string;
    label 1;
begin
1:
readln(s);
s:=s+' ';
i:=1;
x:=0;
for j:=1 to length(s) do
    begin
    if s[j] in ['0'..'9'] then x:=10*x + (ord(s[j]) - ord('0'))
    else if x>0 then
        begin
        t[i]:=x;
        x:=0;
        inc(i);
        if i>8 then break;
        end;
    end;
if i<8 then begin writeln('zadali ste malo cisel, skuste znovu.'); goto 1; end;
end;

procedure pridavanie;
begin
reset(f);
seek(f,filesize(f));
repeat
write('zadaj datum: ');
readln(tzd.datum);
write('zadaj cisla prveho tahu: ');
readtah(tzd.t1);
write('zadaj cisla druheho tahu: ');
readtah(tzd.t2);
write(f,tzd);
write('koniec? (a/n) ');
k:=readkey;
writeln;
until k='a';
close(f);
end;

procedure vypis;
var t:tyzden;
    i:byte;
begin
reset(f);
while not eof(f) do
      begin
      read(f,t);
      writeln('dna ',t.datum,' boli vyzrebovane tieto cisla: ');
      for i:=1 to 7 do write(t.t1[i]:2,', ');
      writeln;
      for i:=1 to 7 do write(t.t2[i]:2,', ');
      writeln;
      end;
close(f);
end;


begin
assign(f,'sportka.dat');
pridavanie;
vypis;
readln;
end.