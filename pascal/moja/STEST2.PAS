uses crt;
var sinuses:array[-100..100] of shortint;
    i:integer;

function cosinus(var uhel:integer):real;
begin
   if uhel > 100 then dec(uhel, 200)
   else
   if uhel < -100 then inc(uhel, 200);

   cosinus:=sinuses[uhel+50]/100
end;

function sinus(var uhel:integer):real;
begin
   if uhel > 100 then dec(uhel, 200)
   else
   if uhel < -100 then inc(uhel, 200);

   sinus:=sinuses[uhel];
end;

begin
for i:=-100 to 100 do sinuses[i]:=round(100*sin(pi/100*i));
clrscr;
writeln(sin(pi/100*-123));
writeln(sinus(-123));

writeln(cos(pi/100*121));
writeln(cosinus(121));

readkey;
end.