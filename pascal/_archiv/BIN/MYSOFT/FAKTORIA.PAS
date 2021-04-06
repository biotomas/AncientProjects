program faktorial;
uses crt;
var a,x:integer;
s:real;
h:char;
begin
clrscr;
write('Enter a = ');
readln(a);
s:=a;
x:=a;
repeat
x:=x-1;
s:=x*s;
until x=1;
writeln(a,'! = ',s);
writeln;
writeln('Hit Esc to exit.');
h:=readkey;
repeat until ord(h)=27;
end.



