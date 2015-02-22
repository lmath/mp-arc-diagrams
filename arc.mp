%first, compile metapost file: mpost pathway.mp
%this produces two figures: pathway.1 and pathway.2
%use document.tex to display the figures: latex document.tex 
%then convert the .dvi to a .pdf or a .ps (dvipdf or dvips)

input boxes;
input TEX;

% distance between bases
u=0.5cm;
%set pen sizes
slt=0.5bp;
tlt=1.0bp;
spt=2bp;

%a,b are the bases that share the arc, d is the angle
%of the arc, t is the thickness of the pen
vardef bp(expr a, b, d, t) =
  pickup pencircle scaled t;
  draw (a*u,0){dir d}..{dir -d}(b*u,0);
  pickup pencircle scaled spt;
  draw (a*u,0); draw (b*u,0);
  pickup pencircle scaled slt;
enddef;

%this is a version of bp that draws the arc only (no dots for its bases)
vardef bpja(expr a,b,d,t) =
  pickup pencircle scaled t;
  draw (a*u,0){dir d}..{dir -d}(b*u,0);
  pickup pencircle scaled spt;
enddef;  

%draws an arc between a and b above the line, and circles at both a and b
def bpu(expr a, b) =
  bp(a,b,60,slt);
enddef;

%draws an arc between a and b below the line, and circles at both a and b
def bpd(expr a, b) =
  bp(a,b,-60,slt);
enddef;

%draws an arc between a and b above the line
def bpuja(expr a, b) =
  bpja(a,b,60,slt);
enddef;

%draws an arc between a and b below the line
def bpdja(expr a, b) =
  bpja(a,b,-60,slt)
enddef;

%intended for labeling one base at the specified position in diagrams 
%with arcs below the line only (label appears above the line)
def bpdl(expr a)(text l) =
  label.top(l, (a*u,0*v) );
enddef;

%intended for labeling one base at the specified position in diagrams
%with arcs above the line only (label appears below the line)
def bpul(expr a)(text l) =
  label.bot(l, (a*u,0*v));
enddef;

%draws a base pair down and allows for labelled bases
def bpdul(expr a, b) =
  pickup pencircle scaled slt;
  draw (a*u,-1*u){dir -60}..{dir 60}(b*u,-1*u);
  pickup pencircle scaled spt;
enddef;

def thickbpu(expr a, b) =
  bp(a,b,45,tlt);
enddef;

def thickbpd(expr a, b) =
  bp(a,b,-45,tlt);
enddef;

vardef initfold(expr a, b)(text l) =
  pickup pencircle scaled slt;
  draw(a,0)--(b*u,0);
  label.lft(l, (a,0));
enddef;

vardef initfoldb(expr a,b)(text l) =
  pickup pencircle scaled slt;
  draw(a,0)--(b*u,0);
  label.lft(l, (a,0));

  pickup pencircle scaled spt;
  for i=a upto b:
    draw(i*u,0);
  endfor;
  pickup pencircle scaled slt;
enddef;

%a is the length, l is the sequence. Bases must be separated by spaces.
def initfoldseq(text l) =
  n:=length l;
  pickup pencircle scaled slt;
  draw(-0.5*u,0)--((n-0.5)*u,0);
  
  for i=0 upto n:
    label.bot(substring(i,i+1) of l,(i*u,0));
  endfor;
enddef;  

def initfoldseqd(text l) =
  n=length l;
  pickup pencircle scaled slt;
  draw(-0.5*u,0)--((n-0.5)*u,0);
  
  for i=0 upto n:
    label.bot(substring(i,i+1) of l,(i*u,0));
  endfor;

  draw(-0.5*u,-1*u)--((n-0.5)*u,-1*u);
enddef;

beginfig(1)
  initfoldb(0,23,"");
  bpu(6,9); bpu(7,8); bpu(13,21); bpu(14,20); bpu(15,19); bpu(16,18);
  bpd(0,16); bpd(1,7); bpd(2,6); bpd(8,15); bpd(9,14); bpd(10,13);
endfig;

beginfig(2)
  initfoldseq("ACTGCACACCTCCAGG");
  bpu(2,5); bpu(3,4); bpuja(8,15); bpuja(9,14);
  bpuja(10,13);
endfig;

beginfig(3)
  initfold(0,15,"");
  bpu(3,4); bpu(2,5); bpuja(8,15); 
  bpuja(9,14); bpuja(10,13);

  bpul(2, btex T etex); bpul(3,"G"); bpul(4,"C"); bpul(5,"A");
  bpul(8,"C"); bpul(9,"C"); bpul(10,"T");
  bpul(13,"A"); bpul(14,"G"); bpul(15,"G");  
endfig;

beginfig(4)
  initfold(0,15, "");
  bpu(3,4); bpu(2,5); bpu(8,15); 
  bpu(9,14); bpu(10,13);

 % bpul(2, btex T etex); bpul(3,"G"); bpul(4,"C"); bpul(5,"A");
 % bpul(8,"C"); bpul(9,"C"); bpul(10,"T");
 % bpul(13,"A"); bpul(14,"G"); bpul(15,"G"); 
  bpd(2,7); bpd(3,6); bpd(0,10); 
  bpd(11,15); bpd(12,14);
  label.lft(btex$a_1$etex,(u*3,u*1));
  label.lft(btex$a_2$etex,(u*4,u*0.5));
  label.lft(btex$a_3$etex,(u*9,u*1.2));
  label.lft(btex$a_4$etex,(u*10,u*1));
  label.lft(btex$a_5$etex,(u*10.8,u*0.7));
  label.lft(btex$b_1$etex,(u*4,u*-0.7));
  label.lft(btex$b_2$etex,(u*4.6,u*-1.7));
  label.lft(btex$b_3$etex,(u*5.2,u*-3.25));
  label.lft(btex$b_4$etex,(u*13,u*-0.7));
  label.lft(btex$b_5$etex,(u*14,u*-1.5));
    
endfig;

beginfig(5)
   initfoldseq("ACUGCACACCUCCAGG"); 
   bpuja(2,5); bpuja(3,4); bpuja(8,15); bpuja(9,14); bpuja(10,13);
   bpdul(0,10); bpdul(2,7); bpdul(3,5); bpdul(11,15); bpdul(12,14);
endfig;

end;