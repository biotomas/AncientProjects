uses crt;
var a,m:string;

begin
clrscr;
writeln('Ahoj ja som Duso ako sa volas?');
write('> '); readln(m);
writeln('Dobre ',m,' povedz neco');
repeat
write('> '); readln(a);
if pos('kokot',a)<>0 then writeln('ty si kokot');
until a='konec';
end.