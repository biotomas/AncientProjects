program rw;

uses crt;

label xy;

const mag:array[1..11] of char=('a','e','i','o','u','a','e','i','o','u',#8);
      mas:array[1..23] of char=('b','c','d','f','g','h','j','k','l','m','n','p','q','r','s','t','v','w','x','y','z',#8,'`');

var x,i,j,l,m:word;
    s:string;
    s1,key:char;
    f:file of string;

begin
 clrscr;
 randomize;
 goto xy;
 xy:
 l:=random(10)+5;
 m:=random(2);
 s:='';
 for i:=1 to l do begin
  if (m=0)and(i mod 2=0) then s1:=mas[random(23)+1];
  if (m=0)and(i mod 2=1) then s1:=mag[random(11)+1];
  if (m=1)and(i mod 2=0) then s1:=mag[random(11)+1];
  if (m=1)and(i mod 2=1) then s1:=mas[random(23)+1];
  s:=s+s1;
 end;
 writeln(s);
 key:=readkey;
 if key=#32 then goto xy;
 if key=#13 then begin
  assign(f,'snickers.txt');
  {$I-}
  reset(f);
  {$I+}
  if ioresult<>0 then rewrite(f) else seek(f,filesize(f));
  write(f,s);
  close(f);
  goto xy;
 end;
end.