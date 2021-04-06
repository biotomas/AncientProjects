uses crt;
type puc=record meno:string[20];
                priez:string[20];
                vek: integer;
                cis: integer; end;
var f:file of puc;
    rad:puc;
    i,j,n:integer;
    k:char;

procedure view;
begin
reset(f);
clrscr;
for j:=0 to (filesize(f)-1) do
    begin
     seek(f,j);
     read(f,rad);
     gotoxy(1,j+1);
     write(rad.cis,'.');
     gotoxy(5,j+1);
     write('Meno: ',rad.meno);
     gotoxy(25,j+1);
     write('Priezvisko: ',rad.priez);
     gotoxy(50,j+1);
     write('Vek: ',rad.vek);
    end;
close(f);
end;

procedure add;
var fs:integer;
begin
reset(f);
fs:=filesize(f);
i:=0;
repeat
seek(f,fs+i);
writeln;
writeln;
write('      Meno= '); readln(rad.meno);
if length(rad.meno)>0 then
   begin
     write('Priezvisko= '); readln(rad.priez);
     write('       Vek= '); readln(rad.vek);
     rad.cis:=(fs+i+1);
     write(f,rad); writeln(' data added OK ');
     i:=i+1;
     view;
   end;
reset(f);
until length(rad.meno)=0;
close(f);
view;
end;

begin
assign(f,'datab.ase');
clrscr;
view;
add;
readkey;
end.