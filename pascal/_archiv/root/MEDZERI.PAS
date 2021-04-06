program p;
uses crt;
var a:string;b,i,medzeri,poc:integer;
begin
clrscr;
write ('Napis vetu: ');readln(a);
b:=length(a);
for i:=1 to b do begin
if a[i]='x' then poc:=poc+1;
if a[i]=' ' then medzeri:=medzeri+1;
end;
if medzeri>0 then writeln('Ma viac slov (',medzeri+1,')');
if medzeri=0 then writeln('Ma jedno slovo');
write('Je tu ',poc,' x');
readkey;
end.