uses dos,crt;
var h,m,s,hund,day,mon,y,dw:word;

{
info
streda 18.5.2005  Aj 10.55
                  Sj 13.30
                  Im 14.30
stvrtok 19.5.2005 Mt 15.50
piatok  20.5.2005 Fz 10.20
}

begin
getdate(y,mon,day,dw);
gettime(h,m,s,hund);
write('do maturity z Informatiky ti zostava ');
repeat
gotoxy(37,1);
write(17-m,' mesiacov ',
until keypressed;

end.