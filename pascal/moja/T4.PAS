uses crt;
var vstup, vystup:text;
    rvstup, rvystup, slovo:string;
    sirka,i,j,k:integer;

procedure hotovyriadok(var rvystup:string);
var a,b:byte;
begin
b:=1;
a:=1;
if rvystup[length(rvystup)]=' ' then rvystup[0]:=char(length(rvystup)-1);
while length(rvystup) < sirka do
  begin
    if rvystup[a]=' 'then
       begin
       insert(' ',rvystup,a);
       inc(a,b);
       end;
  inc(a);
  if a >= length(rvystup) then
    begin
    a:=1; inc(b);
    end;
  end; {of while}

writeln(vystup,rvystup);
rvystup:='';
end;

procedure hotovo(var slovo:string);
begin
 if length(slovo) <= sirka - length(rvystup) then rvystup:=rvystup+slovo+' '
 else
     begin
     hotovyriadok(rvystup);
     if length(slovo) <= sirka then rvystup:=slovo
     else
     begin
     while length(slovo) > sirka do
       begin
       rvystup:='';
       rvystup:=copy(slovo,1, sirka);
       slovo:=copy(slovo,sirka+1,255);
       slovo[0]:=char(length(slovo)-sirka); {finta na zmenu dlzky}
       writeln(vystup,rvystup);
       end;
     rvystup:=slovo+' ';
     end;
end;
slovo:='';
end;

begin
assign(vstup,'esej.txt');
assign(vystup,'n.x');
sirka:=30;
reset(vstup);
rewrite(vystup);

while not eof(vstup) do
  begin
   readln(vstup,rvstup);
   rvstup:=rvstup+' ';
   slovo:='';
   for i:=1 to length(rvstup) do
    begin
    if rvstup[i]<>' ' then slovo:=slovo+rvstup[i]
    else if length(slovo) > 0 then hotovo(slovo);
    end;
  writeln(vystup,rvystup);
  rvystup:='';
  end;

close(vstup);
close(vystup);
end.