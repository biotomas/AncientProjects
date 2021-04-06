program feltetel_01;
uses crt;
     var
        szam:integer;
        nev:string;
begin
clrscr;
        writeln('Kerem adja meg a nevet');
        readln(nev);
        if (nev='hello') then begin
        writeln('hmm. Koszontel?');
        end else
        writeln('Udv',nev);
        writeln('Adj meg egy szamot eldontom, negativ-e');
        readln(szam);
        if (szam<0)then writeln('a',szam,'negativ')
        else
        if (szam>0)then writeln('a',szam,'pozitiv')
        else writeln('a',szam,'0 volt');
        readkey;
        end.