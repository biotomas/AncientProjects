uses crt;
type cl=record
                  meno:string[120];
                  priez:string[120];
                  vek:integer; end;
var f:file of cl;
    clovek:cl;
    pos,i,j:integer;
    k:char;

procedure zobraz;
begin
end;

procedure pridaj;
begin
end;

procedure edit;
begin
end;

procedure order;
begin
end;


begin
assign(f,'datab.ase');
pos:=1;
repeat
clrscr;
if pos=1 then textbackground(3) else textbackground(0);
writeln('     Zobrazit subor      ');
if pos=2 then textbackground(3) else textbackground(0);
writeln('     Pridat udaj         ');
if pos=3 then textbackground(3) else textbackground(0);
writeln('     Zmenit udaj         ');
if pos=4 then textbackground(3) else textbackground(0);
writeln('     Usporiadj udaje     ');
if pos=5 then textbackground(3) else textbackground(0);
writeln('     Nuluj subor         ');
if pos=6 then textbackground(3) else textbackground(0);
writeln('     Koniec              ');
textbackground(0);
k:=readkey;
if ord(k)=80 then pos:=pos+1;
if ord(k)=72 then pos:=pos-1;
if pos=0 then pos:=6;
if pos=7 then pos:=1;
until ord(k)=13;
case pos of
5: begin rewrite(f); close(f); end;
1: zobraz;
4: order;
2: pridaj;
3: edit; end;

end.