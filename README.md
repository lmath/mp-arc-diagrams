## Arc Diagrams with MetaPost ##
Several years ago, I made some extensions to code (from Chris Thachuk and Jano Manuch) 
for drawing arc diagrams useful for discussing RNA folding pathways. When I 
later took down my academic website, the tutorial went with it, so I 
decided to put it up on Github. 

### From Metapost file to diagram ###
You are going to need the MetaPost interpreter. This usually comes with a TeX distribution, 
which makes sense since you'll likely be including your diagrams in TeX files. 
Let's call the MetaPost file we're dealing with foo.mp, and the .tex file we're using 
to display the figures display.tex. If we've made two figures, then running 
` mpost foo.mp ` will produce two output files, foo.1 and foo.2. From here, 
you can stick these in directly your .tex with the graphics or graphicx package. 
These directions assume that you want to look at display.tex as a .pdf. 
Note that you can't just use pdflatex because pdflatex can't handle .eps files directly.

#### On OS X or GNU/Linux ####
If you're making MetaPost files in the first place, you probably already have a TeX 
distribution installed, and if that TeX distribution is [TeXLive](http://www.tug.org/texlive/), 
you should have everything you need.

This means that once you've navigated to the directory containing your file, you can run:
`mpost foo.mp && latex display.tex && dvipdf display.dvi & `

#### On Windows ####
I've only tested with Windows 7 and [TeXworks](https://www.tug.org/texworks/). Try running:
`mpost foo.mp && latex display.tex && dvipdfm display.dvi & `

If you find that the pdf produced doesn't actually contain your figures, try converting to postscript first:
`mpost foo.mp && latex display.tex && dvips display.dvi && pstopdf display.ps & `

### To the diagrams! ###

The code for all of the diagrams in this section can be found in the file arc.mp. 

Check out a demo of what kind of diagrams you can make with the macros in arc.mp by opening 
up arcs_demo.pdf. 

####Macro details ####


I wrote the macros `initfoldb`, `initfoldseq`, `initfoldseqd`, `bpuja`, `bpdja`, `bpdul`, `bpul`, 
and `bpdl` to make it easier to label the bases, and control which bases are represented with circles. 

Here are some details on each of the macros:


%Represents removing a base pair. Causes the pen to move forward 1 unit and up
%1 unit. Also labels the line segment with string l. If the label requires
%\LaTeX, you must call like so: rem(btex$-a_1$etex);
rem(text l);

%Represents adding a base pair. Causes the pen to move forward 1 unit and down
%1 unit. Also labels the line segment with string l. If you need LaTeX, follow
%directions above.
add(text l);

%A macro used in bpu(expr a,b) and bpd(expr a,b). Draws an arc between a and b.
%The arc starts at direction d, and has pen thickness t. Also draws two circles
%at a and b to represent base pairs. ("base pair")
bp(expr a, b, d, t);

%Provides the same functionality as bp(expr a, b, d, t) except does not draw the
%circles at a and b to represent base pairs. ("base pair just arc")
bpja(expr a, b, d, t);

%Draws an arc above the line with that will also have circles for each base in
%the pair ("base pair up")
bpu(expr a, b);

%Draws an arc below the line with that will also have circles for each base in
%the pair ("base pair down")
bpd(expr a, b);

%Draws an arc above the line. Does not add circles for base pairs.
%("base pair up just arc")
bpuja(expr a, b);

%Draws an arc below the line. Does not add circles for base pairs.
%("base pair down just arc")
bpdja(expr a, b);

%A version of base pair down that allows space for labelled bases
%("base pair down under label")
bpdul(expr a, b);

%Labels one base below the line for a specified base and position. Intended
%for diagrams that use arcs above the line only. ("base pair up label")
bpul(expr a)(text l);

%Labels one base above the line for a specified base and position. Intended
%for diagrams that use arcs below the line only. ("base pair down label")
bpdl(expr a)(text l);

%Draws the initial line for the sequence. No circles to represent the base pair
%are added. Takes a label as a string. If you don't want a label, use the
%empty string.
initfold(expr a,b)(text l);

%Draws the initial line for the sequence. Circles are drawn to represent each
%base pair. Takes a label as a string.If you don't want a label, use an
%empty string.
initfoldb(expr a, b)(text l);

%Draws the initial line for the sequence, and adds labels for every base in the
%sequence. Takes only the sequence as a string.
initfoldseq(text l);

%The same as initfoldseq, except draws a line below the bases in the sequence.
initfoldseqd(text l); 