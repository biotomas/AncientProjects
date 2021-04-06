uses crt;
const pcifer=2400;
type verylongnumber=record                {+3 na naraznik}
                          n: array[1..pcifer+3] of 0..9;
                          l: 1..pcifer;
                          end;
var a,b,c:verylongnumber;

procedure overflow;
begin
write('Pretieklo to');
readkey;
halt;
end;


procedure inc(var x:verylongnumber);
var i:word;
    go:boolean;
begin
i:=pcifer;
go:=false;
repeat
x.n[i]:=((x.n[i]+1) mod 10);
if x.n[i]=0 then
   begin
   dec(i);
   go:=false;
   end
   else go:=true;
until go;
if i < x.l then x.l:=i;
if x.n[1] > 0 then overflow;
end;

procedure pis(const x:verylongnumber);
var i:word;
begin
for i:=x.l to pcifer do write(x.n[i]);
writeln;
end;

procedure mul(const a,b:verylongnumber; var c:verylongnumber);
{nasobicka, kde a je velke cislo a b je nanajvys 3 ciferne}
var i,z,h:word;
begin
if a.l-3 < 1 then overflow;
z:=0;
for i:=pcifer downto a.l-3 do
 begin
 h:= z + a.n[i]*b.n[pcifer] + a.n[i+1]*b.n[pcifer-1] + a.n[i+2]*b.n[pcifer-2];
 c.n[i]:= h mod 10;
 z:= trunc(h/10);
 end;
if c.n[i] > 0 then c.l:=i
else
if c.n[i+1] > 0 then c.l:=i+1
else
if c.n[i+2] > 0 then c.l:=i+2
else
if c.n[i+3] > 0 then c.l:=i+3;

end;

var f,i:word;

begin
fillchar(b.n,pcifer+3,0);
fillchar(a.n,pcifer+3,0);
fillchar(c.n,pcifer+3,0);
a.l:=pcifer;
a.n[pcifer]:=1;
b.l:=pcifer;
b.n[pcifer]:=1;

clrscr;
write('Faktorial ake cisla by si kcel vediet? zadaj ho: ');
readln(f);

for i:=1 to f do
 begin
 mul(a,b,c);
 a:=c;
 inc(b);
 end;

write(f,'! = ');
pis(a);
writeln(pcifer-a.l+1);
readkey;
end.