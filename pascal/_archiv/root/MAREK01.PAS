program marek;
uses crt;
type ovocie=record
nazov,krajina  :  string;
cena           :  integer;
end;
var f:file of ovocie;
udaje:ovocie;
n,i,s:integer;

procedure naz;
begin
write ('nazov ovocia:');
readln (udaje.nazov);
write('krajina:');
readln(udaje.krajina);
write('cena ovocia:');
readln(udaje.cena);
seek(f,s);
write(f,udaje);
s:=s+1;
end;


begin
writeln('zadaj pocet udajov,ktore chces vlozit');
readln(n);
assign(f,'udaje.dat');
reset(f);
s:=filesize(f);
for i:=1 to n do naz;

end.

