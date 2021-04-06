program str;
uses crt;
var a:array[1..140] of real;i,j,poc,n:integer;b:array[1..30] of longint;
    pr,hr,r:string;
begin;
randomize;
clrscr;
poc:=0;
write('Zadaj pocet kodov: ');readln(n);
     for i:=1 to n do a[i]:=random*900000+100000;
         for i:=1 to n do begin b[i]:=trunc(a[i]);
         write (b[i]);
             for j:=0 to 9 do
             begin
             str z(b[i],hr);
             str (j,pr);
             r:=pr+pr;
             if pos (r,hr)>0 then poc:=poc+1;
             end;
        end;
readkey;
end.