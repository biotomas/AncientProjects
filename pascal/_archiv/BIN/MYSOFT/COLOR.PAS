uses crt, graph;
var gd,gm,x,a,b,col,d  :integer;
        k,out  :char;
begin
 randomize;
 col:=1;
 x:=1;
 d:=1;
 a:=0;
 clrscr;
repeat
 repeat
    repeat
     a:=a+1;
     textcolor(col);
     b:=random(200)+50;
     write(char(178));
     delay(d);
    until a=x;
    a:=0;
    col:=col+1;
    if col=6 then col:=1;
 until keypressed;
k:=readkey;
x:=x+1;

until ord(k)=27;

end.