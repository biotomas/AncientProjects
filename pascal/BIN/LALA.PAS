uses crt;
const szamok=30;
var a:array[1..szamok] of integer;
    csereltem,i,c:integer;

procedure quicksort(i,j:integer);
var k,l,pivot:integer;
begin
if i=j then exit;
pivot:=a[i];
k:=i;
l:=j;
while (k<l) do
begin
     while a[k] <= pivot do
           inc(k);
     while a[l] >= pivot do
           dec(l);
     c:=a[k];
     a[k]:=a[l];
     a[l]:=c;
end;
quicksort(i,k);
quicksort(l,j);
end;
{}

function factorial(n:integer):integer;
begin
if n=1 then factorial:=1 else
factorial:= n * factorial(n-1);
end;


begin
clrscr;
randomize;
for i:=1 to szamok do a[i]:=random(500);
for i:=1 to szamok do write(a[i],', ');
writeln;
factorial(5);
writeln;
csereltem:=1;
while(csereltem=1) do
begin
     csereltem:=0;
     for i:=1 to szamok-1 do
       if a[i]>a[i+1] then
          begin
          c:=a[i];
          a[i]:=a[i+1];
          a[i+1]:=c;
          csereltem:=1
          end
end;

quicksort(1,szamok);

for i:=1 to szamok do write(a[i],', ');
readln;
end.







var x,i,max,min:integer;
begin
min:=10000;
max:=0;
for i:=1 to 10 do
    begin
    readln(x);
    if x < min then min:=x;
    if x > max then max:=x;
    end;
writeln('min=', min);
writeln('max=', max);
readln;
end.