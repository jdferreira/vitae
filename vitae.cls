% This is vitae.cls, a latex class used to typeset modern, clean and
% good-looking CV and Résumés.

% Author:
% João D. Ferreira <jotomicron@gmail.com>
% http://www.jdferreira.net

% This class is based on awesome-cv (https://github.com/posquit0/Awesome-CV) by
% Claud D. Park <posquit0.bj@gmail.com>

% Identification
\ProvidesClass{vitae}[2016/05/11 v0.1 Vitae Class for modern CV]
\NeedsTeXFormat{LaTeX2e}

% Inherit from article.cls, passing all options to that class
\DeclareOption*{%
  \PassOptionsToClass{\CurrentOption}{article}
}
\ProcessOptions\relax
\LoadClass[11pt,a4paper]{article}

% Load some packages that will be needed
\RequirePackage{microtype}
\RequirePackage{array}
\RequirePackage{enumitem}
\RequirePackage{geometry}
\RequirePackage{fancyhdr}
\RequirePackage{xcolor}
\RequirePackage{colortbl}
\RequirePackage[quiet]{fontspec}
  \defaultfontfeatures{Ligatures=TeX}
\RequirePackage{xifthen}
\RequirePackage{booktabs}
\RequirePackage{fontawesome}
\RequirePackage{lastpage}
\RequirePackage[explicit]{titlesec}
\RequirePackage[defernumbers=true,sorting=ydnt,backend=biber]{biblatex}
\RequirePackage{xparse}
\RequirePackage[math-style=TeX,vargreek-shape=unicode]{unicode-math}

\RequirePackage[hidelinks]{hyperref}
  \hypersetup{%
    pdftitle={},
    pdfauthor={},
    pdfsubject={},
    pdfkeywords={}
  }

% TODO: Add
% \RequirePackage{etoolbox}
% \RequirePackage{ragged2e}
% \RequirePackage{ifxetex}
% \RequirePackage{setspace}
% \RequirePackage[math-style=TeX,vargreek-shape=unicode]{unicode-math}
% \RequirePackage{parskip}


% Configure layout
\geometry{
  left     = 2.5cm,
  top      = 2.0cm,
  right    = 2.5cm,
  bottom   = 2.0cm,
  footskip = 0.5cm
}

% Header and footer
\fancyhfoffset{0em} % Set offset to each header and footer
\renewcommand{\headrulewidth}{0pt} % Remove head rule
\fancyhf{} % Clear all header & footer fields
\pagestyle{fancy} % Make header or footer using fancyhdr

% Define some colors
\definecolor{text}{HTML}{333333}
\definecolor{greytext}{HTML}{5D5D5D}
\definecolor{lighttext}{HTML}{999999}
\definecolor{darktext}{HTML}{414141}
\definecolor{highlight}{HTML}{DC3522}
\definecolor{ruler}{HTML}{5D5D5D}

% Link some fonts
\newfontfamily\headerfont[
  Path=fonts/,
  UprightFont=*-Regular,
  ItalicFont=*-Italic,
  BoldFont=*-Bold,
  BoldItalicFont=*-BoldItalic,
]{Roboto}

\newfontfamily\headerfontlight[
  Path=fonts/,
  UprightFont=*-Thin,
  ItalicFont=*-ThinItalic,
  BoldFont=*-Medium,
  BoldItalicFont=*-MediumItalic,
]{Roboto}

\newfontfamily\footerfont[
  Path=fonts/,
  UprightFont=*-Regular,
  ItalicFont=*-It,
  BoldFont=*-Bold
]{SourceSansPro}

\newfontfamily\bodyfont[
  Path=fonts/,
  UprightFont=*-Regular,
  ItalicFont=*-It,
  BoldFont=*-Bold,
  BoldItalicFont=*-BoldIt
]{SourceSansPro}

\newfontfamily\bodyfontlight[
  Path=fonts/,
  UprightFont=*-Light,
  ItalicFont=*-LightIt,
  BoldFont=*-Semibold,
  BoldItalicFont=*-SemiboldIt
]{SourceSansPro}

\setmainfont[
  Path=fonts/,
  UprightFont=*-Light,
  ItalicFont=*-LightIt,
  BoldFont=*-Semibold,
  BoldItalicFont=*-SemiboldIt
]{SourceSansPro}

\setmonofont[
  Path=fonts/,
  Scale=0.9,
  UprightFont=*-Regular,
  SmallCapsFont=*-Regular
]{Lekton}

% Commands to set personal information
\def\make@command#1{
    \expandafter\let\csname @\expandafter\@gobble\string#1\endcsname\relax
    \def#1##1{\expandafter\def\csname @\expandafter\@gobble\string#1\endcsname{##1}}
    \expandafter\def\csname if@\expandafter\@gobble\string#1\endcsname{%
        \expandafter\ifx\csname @\expandafter\@gobble\string#1\endcsname\relax\else
    }
}

\make@command\firstname        % The first name (plus middle initials)
\make@command\lastname         % The last (family) name
\make@command\address          % Address, will be typeset as a single line
\make@command\position         % Current position; separate more than one with commas
\make@command\mobile           % Mobile number
\make@command\email            % Principal email address
\make@command\homepage         % Homepage
\make@command\github           % Github handle
\make@command\stackoverflow    % Stackoverflow handle, with format ID/name
\make@command\linkedin         % LinkedIn handle
\make@command\researchgate     % ResearchGate handle
\make@command\orcid            % ORCID
\make@command\twitter          % Twitter handle
\make@command\skype            % Skype handler
\make@command\reddit           % Reddit handler
\make@command\extrainfo        % More information to typeset in the header
\make@command\quote            % A quote to typeset between header and CV
\make@command\recipientname    % The recipient's name (for the cover letter)
\make@command\recipientaddress % The recipient's address (for the cover letter)
\make@command\lettertitle      % Title of the cover letter
\make@command\letterdate       % Date to include in the cover letter
\make@command\letteropening    % Opening of the cover letter
\make@command\letterclosing    % Closing of the cover letter
\make@command\letterextra      % Any extra information to typeset after closing (PS etc)

% Spacing
\def\vitae@header@after@name@skip{0.7mm}
\def\vitae@header@after@position@skip{0.7mm}
\def\vitae@header@after@address@skip{0.6mm}
\def\vitae@section@top@skip{3mm}

% Delimiters
\def\vitae@header@name@delim{\space}
\def\vitae@icon@delim{~}


% Style
\def\vitae@header@firstname@style{\fontsize{32pt}{1em}\headerfontlight\color{greytext}}
\def\vitae@header@lastname@style{\fontsize{32pt}{1em}\headerfont\bfseries\color{text}}
\def\vitae@header@position@style{\fontsize{7.6pt}{1em}\bodyfont\scshape\color{highlight}}
\def\vitae@header@address@style{\fontsize{8pt}{1em}\headerfont\itshape\color{lighttext}}
\def\vitae@header@social@style{\fontsize{6.8pt}{1em}\headerfont\color{text}}
\def\vitae@footer@style{\fontsize{8pt}{1em}\footerfont\scshape\color{lighttext}}
\def\vitae@sub@style{\fontsize{8pt}{1em}\bodyfontlight\itshape\color{highlight}\quad}
\def\vitae@entry@title@style{\fontsize{12pt}{1em}\bodyfont\bfseries\color{darktext}}
\def\vitae@entry@date@style{\fontsize{11pt}{1em}\bodyfontlight\slshape\color{highlight}}
\def\vitae@entry@extra@style{\fontsize{10pt}{1em}\bodyfont\scshape\color{greytext}}

% Colors for the sections are part of the \section (et al.) commands, and not
% part of the style directly, because if they were in here that would disrupt
% the page breaking algorithm
\def\vitae@section@style{\fontsize{18pt}{1em}\bodyfont\bfseries}
\def\vitae@subsection@style{\fontsize{15pt}{1em}\bodyfont\bfseries}
\def\vitae@subsubsection@style{\fontsize{13pt}{1em}\bodyfont}

\AtBeginDocument{\color{text}}

% Separators
\newbox\vitae@social@sep@box
\def\vitae@social@sep@macro{\quad\textbar\quad}
\def\vitae@social@sep{%
  \discretionary{}{}{\copy\vitae@social@sep@box}%
}

\newcommand*{\typeset@name}{{
  \vitae@header@firstname@style\@firstname
  \vitae@header@name@delim
  \vitae@header@lastname@style\@lastname
  \par
  \vspace{\vitae@header@after@name@skip}
}}

\newcommand*{\typeset@position}{{\if@position
  \vitae@header@position@style\@position\par
  \vspace{\vitae@header@after@position@skip}
\fi}}

\newcommand*{\typeset@address}{{\if@address
  \vitae@header@address@style\@address\par
  \vspace{\vitae@header@after@address@skip}
\fi}}

% This \if is to make sure the separator is not placed before the first social handle
\newif\if@firstsocial

\newcommand*{\typeset@social}{{%
  \vitae@header@social@style
  \@firstsocialtrue
  \if@mobile\social@sep\faMobile\vitae@icon@delim\@mobile\fi
  \if@email\social@sep\faEnvelope\vitae@icon@delim\href{mailto:\@email}{\@email}\nobreak\fi
  \if@homepage\social@sep\faHome\vitae@icon@delim{\renewcommand\UrlFont{\headerfont}\url{\@homepage}}\nobreak\fi
  \@firstsocialtrue\break
  \if@researchgate\social@sep \textbf{R\textsuperscript{G}}\vitae@icon@delim\href{https://www.researchgate.net/profile/\@researchgate}{\@researchgate}\nobreak\fi
  \if@orcid\social@sep\textbf{ORCID}\vitae@icon@delim\href{https://orcid.org/\@orcid}{\@orcid}\nobreak\fi
  \if@github\social@sep\faGithubSquare\vitae@icon@delim\href{https://github.com/\@github}{\@github}\nobreak\fi
  \if@stackoverflow{%
      \def\\##1/##2\\{\def\@a{##1}\def\@b{##2}}%
      \expandafter\\\@stackoverflow\\%
      \social@sep\faStackOverflow\vitae@icon@delim\href{https://stackoverflow.com/users/\@a}{\@b}%
  }\nobreak\fi
  \if@linkedin\social@sep\faLinkedinSquare\vitae@icon@delim\href{https://www.linkedin.com/in/\@linkedin}{\@linkedin}\nobreak\fi
  \if@twitter\social@sep\faTwitter\vitae@icon@delim\href{https://twitter.com/\@twitter}{\@twitter}\nobreak\fi
  \if@skype\social@sep\faSkype\vitae@icon@delim\@skype\fi
  \if@reddit\social@sep\faReddit\vitae@icon@delim\href{https://www.reddit.com/user/\@reddit}{\@reddit}\nobreak\fi
  \par
}}

\newcommand*{\social@sep}{%
  \if@firstsocial
    \setbox\vitae@social@sep@box=\hbox{\vitae@social@sep@macro}%
  \else
    \nobreak\vitae@social@sep\nobreak
  \fi
  \@firstsocialfalse
}

% Commands to typeset the header and footer
\newcommand*{\makeheader}{{%
  \begin{center}
    \typeset@name
    \typeset@position
    \typeset@address
    \typeset@social
  \end{center}
}}

\fancyfoot{}
\fancyfoot[L]{\vitae@footer@style{\today}}
\fancyfoot[C]{\vitae@footer@style{\@firstname~\@lastname\quad$\cdot$\quad Curriculum Vitae}}
\fancyfoot[R]{\vitae@footer@style{\thepage/\pageref{LastPage}}}


% Sections
\renewcommand{\thesection}{\Alph{section}}
\titleformat{\section}%
  {\vitae@section@style}%
  {\hbox to 0pt{\hss\color{highlight}\thesection\hspace{0.5em}}}%
  {0pt}%
  {#1\hspace{0.5em}{\color{ruler}\vhrulefill{0.9pt}}}

\titleformat{\subsection}%
  {\vitae@subsection@style}%
  {\hbox to 0pt{\hss\color{highlight}\thesubsection\hspace{0.5em}}}%
  {0pt}%
  {#1\hspace{0.5em}{\color{ruler}\vhrulefill{0.3pt}}}

\titleformat{\subsubsection}%
  {\vitae@subsubsection@style}%
  {}%
  {0pt}%
  {\@sectioncolor#1}


% Use to draw horizontal line with specific thickness
\def\vhrulefill#1{\leavevmode\leaders\hrule\@height#1\hfill \kern\z@}

\def\@sectioncolor#1#2#3{{%
  \color{highlight}#1#2#3%
}}


% Other typographical considerations

\parindent0pt
\raggedbottom


% Items
\newcolumntype{L}[1]{>{\raggedright\let\newline\\\arraybackslash\hspace{0pt}}m{#1}}
\newcolumntype{C}[1]{>{\centering\let\newline\\\arraybackslash\hspace{0pt}}m{#1}}
\newcolumntype{R}[1]{>{\raggedleft\let\newline\\\arraybackslash\hspace{0pt}}m{#1}}

\DeclareDocumentCommand{\entry}{oom}{
  \IfValueTF{#1}{
    \begingroup
    \setlength\tabcolsep{0pt}
    \setlength{\extrarowheight}{0pt}
    \begin{tabular*}{\textwidth}{@{\extracolsep{\fill}} L{\textwidth - 4.5cm} R{4.5cm}}
      \vitae@entry@title@style #3 & \vitae@entry@date@style #1 \\
      \IfValueT{#2}{\vitae@entry@extra@style #2 \\}
    \end{tabular*}%
    \endgroup
  }{
    {\vitae@entry@title@style #3\par}
    \IfValueT{#2}{{\vitae@entry@extra@style #2}}
  }
}


\setlist{noitemsep}
\setlist[itemize]{leftmargin=*}
\setlist[itemize,1]{label=\bullet,topsep=1mm,after=\vspace{5mm}}
\setlist[itemize,2]{topsep=0mm}

% Publciation lists

\newcommand*{\authorhash}[1]{\edef\vitae@author@hash{\detokenize{#1}}}
\authorhash{}

\renewcommand*{\mkbibnamefirst}[1]{%
  \iffieldequals{hash}{\vitae@author@hash}{\mkbibbold{#1}}{#1}
}
\renewcommand*{\mkbibnamelast}[1]{%
  \iffieldequals{hash}{\vitae@author@hash}{\mkbibbold{#1}}{#1}
}

\AtBeginBibliography{\setcounter{maxnames}{99}}
\let\fullciteorig\fullcite
\preto\fullcite{\AtNextCite{\defcounter{maxnames}{99}}}


% Table-like entries
\def\fullentry{%
  \let\vitae@old@title\title
  \let\vitae@old@title\subtitle
  \let\vitae@old@title\location
  \let\vitae@old@title\date
  %
  \def\title{vitae@title}%
  \def\subtitle{vitae@subtitle}%
  \def\location{vitae@location}%
  \def\date{vitae@date}%
  %
  \def\fullentry@title{\relax}%
  \def\fullentry@subtitle{\relax}%
  \def\fullentry@location{\relax}%
  \def\fullentry@date{\relax}%
  %
  \@fullentry
}
\def\@fullentry{%
  \futurelet\vitae@next\@@fullentry
}

\def\@@fullentry{%
  \ifx\vitae@next\title
    \def\vitae@reserved\title{\fullentry@set@title}%
  \else\ifx\vitae@next\subtitle
    \def\vitae@reserved\subtitle{\fullentry@set@subtitle}%
  \else\ifx\vitae@next\location
    \def\vitae@reserved\location{\fullentry@set@location}%
  \else\ifx\vitae@next\date
    \def\vitae@reserved\date{\fullentry@set@date}%
  \else
    \def\vitae@reserved{\fullentry@process}%
  \fi\fi\fi\fi
  \vitae@reserved
}

\def\fullentry@set@title#1{%
  \def\fullentry@title{#1}%
  \@fullentry
}
\def\fullentry@set@subtitle#1{%
  \def\fullentry@subtitle{#1}%
  \@fullentry
}
\def\fullentry@set@location#1{%
  \def\fullentry@location{#1}%
  \@fullentry
}
\def\fullentry@set@date#1{%
  \def\fullentry@date{#1}%
  \@fullentry
}

\def\fullentry@process{%
  {%
    \setbox0=\hbox{\ifx\fullentry@location\relax\else\vitae@location@style\fullentry@location\fi}%
    \setbox1=\hbox{\ifx\fullentry@date\relax\else\vitae@date@style\fullentry@date\fi}%
    \setbox2=\vbox{\leftskip=0pt plus 1fill\box0\box1}%
    \vbox to 0pt{\hbox to \hsize{\hfill\box2}\vss}%
    \nointerlineskip
  }%
  \ifx\fullentry@title\relax\else Title: \fullentry@title\par\fi
  \ifx\fullentry@subtitle\relax\else Subtitle: \fullentry@subtitle\par\fi
  %
  \let\title\vitae@old@title
  \let\subtitle\vitae@old@subtitle
  \let\location\vitae@old@location
  \let\date\vitae@old@date
}

\newlength\year@length
\newenvironment{yeartable}[1][0000--0000]{
  \settowidth\year@length{#1\hskip1em}
  \begin{tabular*}{\textwidth}{@{\extracolsep{\fill}} >{\bfseries}L{\year@length} L{\textwidth - \year@length}}
}{
  \end{tabular*}
}



% Auxlliary commands

% Use to align an element of tabular table
%\newcolumntype{L}[1]{>{\raggedright\let\newline\\\arraybackslash\hspace{0pt}}m{#1}}
%\newcolumntype{C}[1]{>{\centering\let\newline\\\arraybackslash\hspace{0pt}}m{#1}}
%\newcolumntype{R}[1]{>{\raggedleft\let\newline\\\arraybackslash\hspace{0pt}}m{#1}}


% Use to execute conditional statements by checking empty string
\newcommand*{\ifempty}[3]{\ifthenelse{\isempty{#1}}{#2}{#3}}



