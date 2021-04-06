program sportka;
uses crt;
var f:text;
    i,j,ind,n,c:integer;
    a:array [1..50] of integer;
begin
randomize;
clrscr;
write('Zadaj pocet tahov:');readln(n);
assign(f,'hihi.txt');
rewrite(f);

for i:=1 to n do begin
    for j:=1 to 6 do begin a[j]:=random(49)+1;
    write(a[j],',');end;
    writeln;
       repeat
        ind:=0;
        for j:=1 to 5 do begin
        if a[j]>a[j+1] then begin
        c:=a[j]; a[j]:=a[j+1]; a[j+1]:=c;
        ind:=1;end;end;
       until ind=0;

             for j:=1 to 6 do write (f,a[j]:3);
             writeln(f);
end; {of for}
close(f);
readkey;
end.
