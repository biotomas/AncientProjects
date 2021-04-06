uses crt;

var f:file of string;
    s:string;

begin
 clrscr;
 assign(f,'snickers.txt');
 reset(f);
 repeat
  read(f,s);
  writeln(s);
 until eof(f);
 readln;
end.