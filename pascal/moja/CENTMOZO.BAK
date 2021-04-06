{rozhovor s centralnim mozkem}
uses crt;
var  ton:array[1..20] of integer;
     C:integer;
     Y:real;
     i:byte;
begin
Y:=exp(ln(2)/12);
C:=trunc(220*Y);
for i:=1 to 20 do
    ton[i]:=trunc(C*exp((i-1)*ln(Y)));
repeat
sound(ton[1]);
delay(50);
sound(ton[5]);
delay(50);
sound(ton[8]);
delay(50);
sound(ton[5]);
delay(50);
sound(ton[8]);
delay(50);
sound(ton[12]);
delay(50);
sound(ton[1]);
delay(50);
sound(ton[12]);
delay(50);




nosound;
until keypressed;
end.