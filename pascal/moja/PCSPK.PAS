uses crt;
const f=500;
begin
repeat
sound(f);
delay(500);
nosound;
delay(500);
until keypressed;
end.