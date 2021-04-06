uses crt;
var slovo,inp:string;
    sl: array [1..25] of string[10];
    a,zs,s,i,j:integer;
    k:boolean;
procedure zorad;
begin
repeat
k:=true;
for i:=1 to (s-1) do
    begin
     if sl[i+1]<sl[i] then
        begin
         slovo:=sl[i];
         sl[i]:=sl[i+1];
         sl[i+1]:=slovo;
         k:=false;
        end;
    end;
until k=true;
end;

procedure mksl;
begin
a:=1;
for j:=zs to i-1 do
    begin
     sl[s,a]:=inp[j];
     a:=a+1;
    end;
s:=s+1;
zs:=i+1;
end;

begin
clrscr;
for i:=1 to 25 do sl[i]:=('           ');
s:=1;
zs:=1;
write('Napis veticku: ');
readln(inp);
for i:=1 to length(inp) do if inp[i]=' ' then mksl;
i:=i+1;
mksl;
for i:=1 to s do write(sl[i]);
writeln;
writeln;
writeln('Tato veta ma ',(s-1),' slov');
writeln('Tu su slova v ABC poradi:');
zorad;
writeln;
for i:=2 to s do write(sl[i]);
readkey;
end.