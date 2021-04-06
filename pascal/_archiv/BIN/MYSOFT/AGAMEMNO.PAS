program agamemnon;
uses crt;
var a,b,c,z:integer;
h:char;
begin
writeln;
writeln('===============');
writeln(' ==MEGASOFT===');
writeln('===============');
repeat
writeln;
writeln('Zadaj a');
readln(a);
writeln('Zadaj b');
readln(b);
writeln('Zadaj c');
readln(c);
writeln;
if (a=b) or (a=c) or (c=b) then writeln('Hej ! Nezadavaj rovnake cisla ! ');
until (a<>b) and (a<>c) and (b<>c);
if a>b then
   if a>c then
      if b>c then writeln(a,' > ',b,' > ',c) else writeln(a,' > ',c,' > ',b)
   else writeln(c,' > ',a,' > ',b)
else
    if b>c then
       if a>c then writeln(b,' > ',a,' > ',c) else writeln(b,' > ',c,' > ',a)
    else writeln(c,' > ',b,' > ',a);
writeln;
writeln('Stlacte Esc');
repeat
h:=readkey;
until ord(h)=27;
end.
