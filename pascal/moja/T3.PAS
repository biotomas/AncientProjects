program textformat;
uses crt;
const maxdelka=1200;                        {constanta}
type    cislo=0..maxdelka;
        ztring=record
          s:array [1..maxdelka] of char;
          l:cislo;                        {l je delka slova}
          end;
var ifile, ofile: text;         {input / output soubory}
    iline, slovo, oline: ztring; {slovo a radek I a O suboru}
    k:            char;         {jenom proste znak}
    sirka,h,i,j:  cislo;        {sirka radku a nejake premenne}
    erc:integer;                {error code}
    tmp:longint;
    bool:boolean;
{*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-}
procedure zapis(oline:ztring); {zapise argument do vystup. sub.}
var i:cislo;
begin
for i:=1 to oline.l do write(ofile,oline.s[i]);
writeln(ofile);
end; {of procedure zapis}
{*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-}
procedure HotovyJe(var oline:ztring); {tato proc. doplni mezeri a zapise riadok}
var i,j,k: cislo;              {do vystupneho suboru, aj ho nuluje}
begin
j:=1;
k:=0;
for i:=1 to sirka do if oline.s[i]=' ' then k:=1;
i:=1;

if k=1 then
while oline.l < sirka do
 begin
 if oline.s[i]=' ' then {ak nasel mezeru}
    begin
     for k:=oline.l+1 downto i+1 do oline.s[k]:=oline.s[k-1]; {posun cely radek}
     inc(oline.l);
     inc(i,j); {aby sa mezeri davali rovnomerne}
    end; {of if oline=' '}
 inc(i);
 if i > sirka then begin i:=1; inc(j); end;
 end; {of while}
zapis(oline);
oline.l:=0;
end; {of procedure HotovyJe}
{*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-}
procedure sum(var oline,slovo:ztring); {funguje ako plus pre string}
var l1,l2,i:cislo;               {vysledok je s1+s2 ulozeny v s1}
begin                            {este aj nuluje s2 a da mezeru}
l1:=oline.l;       {dlzky scitancov s1 a s2}
l2:=slovo.l;
if l1>0 then begin oline.s[l1+1]:=' '; inc(l1); end;
for i:=l1 to l1+l2-1 do
    oline.s[1+i]:=slovo.s[i-l1+1];
oline.l:=(l1+l2);
slovo.l:=0;
end; {of proc sum}
{*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-}
begin
if paramcount < 3 then
 begin
  writeln('Zadaj(te) prosim 3 parametre, sirku riadku, vstupny subor a vystupny subor.');
  halt;
 end;
val(paramstr(1),tmp,erc);
if (erc <> 0) or (tmp >= maxdelka) or (tmp<1) then
 begin
  writeln('Prvy parameter - sirka musi byt cislo medzi 1 a ',maxdelka);
  halt;
 end;
sirka:=tmp;
{$I-}
assign(ifile,paramstr(2));
assign(ofile,paramstr(3));
reset(ifile);
close(ifile);
{$I+}
if (IOResult <> 0) then
 begin
  writeln('Vstupny subor nebyl nalezen, skus(te) este raz.');
  halt;
 end;

reset(ifile);
rewrite(ofile);
slovo.l:=0; {inicializace dlzek slov}
oline.l:=0;
iline.l:=0;
while not eof(ifile) do
begin
i:=0;
while not eoln(ifile) do {nacte riadok, aj trosku upravy}
 begin
  read(ifile,k);
  if k=#9 then k:=' '; {tabulator nahrad mezerou}
  if k=' ' then if (i > 0) and (iline.s[i]<>' ') then
     begin                  {toto je preto, aby nebralo, mezeri na zac.}
      inc(i);               {riadku, ani posebe iduce mezeri }
      iline.s[i]:=k;
     end else read(ifile,k);
  if k<>' ' then begin inc(i); iline.s[i]:=k; end;
 end;
 if i>0 then begin
    iline.s[i+1]:=' ';
    inc(i); end;
 iline.l:=i; {nastav dlzku riadku}
 i:=1;

 if (iline.l = 0) and (oline.l > 0) then
    begin
    zapis(oline);                {cisty riadok -> odstavec}
    oline.l:=0;
    end
 else
 while i <= iline.l do
  begin
   j:=1;
   while iline.s[j+i-1] <> ' ' do {vyrobime slovo}
    begin
     slovo.s[j]:=iline.s[j+i-1];
     inc(j);
    end;
   slovo.l:=j-1; {dlzka slova }
   inc(i,j);

   if slovo.l < sirka - oline.l then sum(oline, slovo)
   else {ak sa slovo nezmesti do riadku}
    begin
     if oline.l > 0 then hotovyje(oline);
     if slovo.l <= sirka then sum(oline,slovo);
     bool:=false;
     while slovo.l > sirka do
      begin
       bool:=true;
       for j:=1 to sirka do oline.s[j]:=slovo.s[j];
       oline.l:=sirka;
       zapis(oline);
       for j:=sirka+1 to slovo.l do slovo.s[j-sirka]:=slovo.s[j];
       dec(slovo.l,sirka);
      end;
     if bool then
        begin
         oline.l:=0;
         sum(oline,slovo);
        end;
    end; {of else}

  end; {of while}
read(ifile,k);
read(ifile,k);
end; {of the main while}
zapis(oline);
close(ofile);
close(ifile);
writeln('Hotovo.');
end.