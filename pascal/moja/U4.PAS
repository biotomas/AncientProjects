{Martin Boros I-37}
program u4;

var p:array [1..20] of byte;
    i,n,a,b,s:byte;

begin
writeln('Zadaj pocet prvkov permutovanej mnoziny');
read(n);
writeln('Zadaj permutaciu');
for i:=1 to n do read(p[i]);
repeat dec(i) until (i=0) or (p[i]<p[i+1]);
if i=0 then writeln('Tato permutacia uz nema nasledovnika...') else
begin
 a:=i; b:=n; inc(a);
 while a<b do
             begin
              s:=p[a]; p[a]:=p[b]; p[b]:=s;
              inc(a); dec(b);
             end;
 for a:=i+1 to n do if p[i]<p[a] then
                                     begin
                                      s:=p[i]; p[i]:=p[a]; p[a]:=s; break;
                                     end;
 writeln('Nasledujuca permutacia je: ');
 for i:=1 to n do write(p[i],' ');
end;
end.