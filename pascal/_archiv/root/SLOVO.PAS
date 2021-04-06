program slova;
uses crt;
var slovo:string;pz,I:integer;
begin
clrscr;
write ('Zadaj slovo: ');readln(slovo);
pz:=length(slovo);write('Slovo odzadu: ');
for I:=0 to (pz-1) do write(slovo[pz-I]);
readln;
end.
