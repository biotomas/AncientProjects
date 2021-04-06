{n nahod 6cif cisel, kolko takych kde zaradom 2 rovnakecifry}
uses crt;
var cis: array [1..30] of string[6];
    j,i,a,b,n:integer;
    c:longint;
    w:boolean;

begin
randomize;
clrscr;
write('Zadaj kolko cisel mam vymysliet n=');
readln(n);
for i:=1 to n do
    begin
     c:=(100000*(random(9)+1))+(10000*(random(9)+1))+(1000*(random(9)+1))
        +(100*(random(9)+1))+(10*(random(9)+1))+((random(9)+1));
     str(c,cis[i]);
    end;
for i:=1 to n do writeln(cis[i]);
writeln;
writeln;

for i:=1 to n do
    begin
     for j:=1 to 5 do
         begin
          if cis[i,j]=cis[i,j+1] then w:=true;
         end;
    if w=true then a:=a+1;
    if w=true then write(cis[i]:8);
    w:=false;
    end;

writeln;
if a=1 then write ('Vyhovuje ',a,' cislo');
if (a<5) and (a>1) then write('Vyhovuju ',a,' cisla');
if a>4 then write ('Vyhovuju ',a,' cisel');
if a=0 then write ('Nevyhovuje ziadne cislo');
readkey;
end.