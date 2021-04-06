var l,c1,c2,c3,c4,c5,c6:longint;
    a:integer;
begin
randomize;
c1:=0;
c2:=0;
c3:=0;
c4:=0;
c5:=0;
c6:=0;

for l:=1 to 6000000 do begin
 a:=random(6)+1;
 case a of 1: c1:=c1+1;
           2: c2:=c2+1;
           3: c3:=c3+1;
           4: c4:=c4+1;
           5: c5:=c5+1;
           6: c6:=c6+1;
          end;
end;
 writeln('1: ',c1,'  ',(1000000-c1));
 writeln('2: ',c2,'  ',(1000000-c2));
 writeln('3: ',c3,'  ',(1000000-c3));
 writeln('4: ',c4,'  ',(1000000-c4));
 writeln('5: ',c5,'  ',(1000000-c5));
 writeln('6: ',c6,'  ',(1000000-c6));
readln;
end.