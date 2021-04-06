  program marek ;
  uses crt;
  var   n,i,p,v  :integer;
        a        :array[1..30] of integer;
  procedure tried;
  begin
  for i:=1 to n do
  begin
  a[i]:=random(100)+1;
  write(a[i]);
  end;
  writeln;
  repeat
  v:=0;
  for i:=1 to n-1 do
  if a[i]>a[i+1] then
  begin
  p:=a[i];
  a[i]:=a[i+1];
  a[i+1]:=p;
  v:=1;
  end;
  until v =0;
  for i:=1 to n do
  write (a[i]:4);
  end;
  tried;
  begin
  clrscr;
  randomize;
  write('n=');
  readln(n);
  readln;
  end;
  end.



