uses dos,crt;
var mx,my,mb:integer;
    h,m,s1,s2,hd1,hd2:word;
begin
clrscr;
gettime(h,m,s1,hd1);
delay(2000);
gettime(h,m,s2,hd2);
writeln(s1,':',hd1,' - ',s2,':',hd2);
readkey;
end.