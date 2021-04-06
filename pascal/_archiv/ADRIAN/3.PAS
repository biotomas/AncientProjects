uses graph;
var gd,gm:integer;
function veletlen_kozott(a,f:integer):integer;
begin
     veletlen_kozott:=a+random(f-a+1);
end;
var i,kor,magassag,suly:integer;
begin
     randomize;
     for i := 1 to 12 do begin
         kor:= veletlen_kozott (18,26);
         magassag:=veletlen_kozott(170,180);
         suly:= veletlen_kozott(55,65);
         write ('a(z)',i,'. dontos ',kor,' eves,');
         writeln(' magassaga ',magassag,' cm,sulya pedis ', suly,'kg.');
     end;
end.