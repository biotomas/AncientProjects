type    uk=^saso;
        saso= record
                info:char;
                p,n:uk;
                end;
        more=file of char;

var     infile:more;
        znak,par:char;
        z,k,n:uk;
        poradie:longint;

begin
        assign(infile,'posloupnost.in');
        reset(infile);

        z:=nil;
        k:=nil;
        n:=nil;
        poradie:=1;

        while ((not(seekeof(infile))) or (not(seekeoln(infile)))) do
                begin
                        read(infile,znak);

                        if ((znak='(') or (znak='[') or (znak='{') or (znak='<')) then
                                begin
                                        new(n);
                                        n^.info:=znak;
                                        n^.n:=nil;
                                        if (z = nil) then
                                                begin
                                                        z:=n;
                                                        k:=n;
                                                        n^.p:=nil;
                                                end
                                        else
                                                begin
                                                        k^.n:=n;
                                                        n^.p:=k;
                                                        k:=n;
                                                end;
                                end;

                        if ((znak=')') or (znak=']') or (znak='}') or (znak='>')) then
                                begin
                                        if (z = nil) then
                                                begin
                                                        write(poradie);
                                                        halt;
                                                end;

                                        if (znak = ')') then par:='(';
                                        if (znak = ']') then par:='[';
                                        if (znak = '}') then par:='{';
                                        if (znak = '>') then par:='<';

                                        if (k^.info = par) then
                                                begin
                                                        if (k^.p = nil) then
                                                                begin
                                                                        dispose(k);
                                                                        z:=nil;
                                                                        k:=nil;
                                                                end
                                                        else
                                                                begin
                                                                        n:=k;
                                                                        k:=k^.p;
                                                                        dispose(n);
                                                                        k^.n:=nil;
                                                                end;
                                                end
                                        else
                                                begin
                                                        write(poradie);
                                                        while (not(z=nil)) do
                                                                begin
                                                                        k:=z^.n;
                                                                        dispose(z);
                                                                        z:=k;
                                                                end;
                                                        halt;
                                                end;
                                end;

                        inc(poradie);
                end;
        if (z=nil) then
                write('0')
        else
                begin
                        while not(z=nil) do
                                begin
                                        k:=z^.n;
                                        dispose(z);
                                        z:=k;
                                end;
                        write(poradie);
                end;
        close(infile);
end.