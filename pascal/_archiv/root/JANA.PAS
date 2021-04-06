program beziacitext;
uses crt;
var  slovo:string;I:integer;
begin
randomize;
clrscr;
write('zadaj slovo: ');readln(slovo);
for I:=1 to 5 do begin delay(1000);
 writeln(slovo,' je ',random(200),' namalovana kocka');
 end;
readkey;
end.