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
\LoadClass{article}

% Load some packages that will be needed
\RequirePackage{geometry}
\RequirePackage{fancyhdr}
\RequirePackage{xcolor}
\RequirePackage[quiet]{fontspec}
  \defaultfontfeatures{Ligatures=TeX}
\RequirePackage{xifthen}
\RequirePackage{fontawesome}

\RequirePackage[hidelinks]{hyperref}
  \hypersetup{%
    pdftitle={},
    pdfauthor={},
    pdfsubject={},
    pdfkeywords={}
  }

% TODO: Add
% \RequirePackage{etoolbox}
% \RequirePackage{array}
% \RequirePackage{enumitem}
% \RequirePackage{ragged2e}
% \RequirePackage{ifxetex}
% \RequirePackage{setspace}
% \RequirePackage[math-style=TeX,vargreek-shape=unicode]{unicode-math}
% \RequirePackage{parskip}


% Configure layout
\geometry{
    left     = 2.0cm,
    top      = 2.0cm,
    right    = 2.0cm,
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
\definecolor{highlight}{HTML}{DC3522}

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

% Set the default font
\AtBeginDocument{\bodyfontlight}

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
\def\vitae@header@name@delim{\space}
\def\vitae@header@after@name@skip{0.7mm}
\def\vitae@header@after@position@skip{0.7mm}
\def\vitae@header@after@address@skip{0.6mm}
\def\vitae@icon@delim{~}

% Style
\def\vitae@header@firstname@style{\fontsize{32pt}{1em}\headerfontlight\color{greytext}}
\def\vitae@header@lastname@style{\fontsize{32pt}{1em}\headerfont\bfseries\color{text}}
\def\vitae@header@position@style{\fontsize{7.6pt}{1em}\bodyfont\scshape\color{highlight}}
\def\vitae@header@address@style{\fontsize{8pt}{1em}\headerfont\itshape\color{lighttext}}
\def\vitae@header@social@style{\fontsize{6.8pt}{1em}\headerfont\color{text}}

% Separators
\newbox\vitae@social@sep@box
\def\vitae@social@sep@macro{\quad\textbar\quad}
\def\vitae@social@sep{%
  \discretionary{}{}{\copy\vitae@social@sep@box}%
}

% Commands to typeset the data above
\newcommand*\makeheader{{%
  \begin{center}
    \typeset@name
    \typeset@position
    \typeset@address
    \typeset@social
  \end{center}
}}

\newcommand*\typeset@name{{
  \vitae@header@firstname@style\@firstname
  \vitae@header@name@delim
  \vitae@header@lastname@style\@lastname
  \par
  \vspace{\vitae@header@after@name@skip}
}}

\newcommand*\typeset@position{{\if@position
  \vitae@header@position@style\@position\par
  \vspace{\vitae@header@after@position@skip}
\fi}}

\newcommand*\typeset@address{{\if@address
  \vitae@header@address@style\@address\par
  \vspace{\vitae@header@after@address@skip}
\fi}}

% This \if is to make sure the separator is not placed before the first social handle
\newif\if@firstsocial

\newcommand*\typeset@social{{%
  \vitae@header@social@style
  \@firstsocialtrue
  \if@mobile\social@sep\faMobile\vitae@icon@delim\@mobile\fi
  \if@email\social@sep\faEnvelope\vitae@icon@delim\href{mailto:\@email}{\@email}\nobreak\fi
  \if@homepage\social@sep\faHome\vitae@icon@delim\href{\@homepage}{\@homepage}\nobreak\fi
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
  \tracingparagraphs=2
  \par
}}

\newcommand*\social@sep{%
  \if@firstsocial
    \setbox\vitae@social@sep@box=\hbox{\vitae@social@sep@macro}%
  \else
    \nobreak\vitae@social@sep\nobreak
  \fi
  \@firstsocialfalse
}

\def\@sectioncolor#1#2#3{{%
  \color{highlight}#1#2#3%
}}




% Auxlliary commands

% Use to align an element of tabular table
%\newcolumntype{L}[1]{>{\raggedright\let\newline\\\arraybackslash\hspace{0pt}}m{#1}}
%\newcolumntype{C}[1]{>{\centering\let\newline\\\arraybackslash\hspace{0pt}}m{#1}}
%\newcolumntype{R}[1]{>{\raggedleft\let\newline\\\arraybackslash\hspace{0pt}}m{#1}}

% Use to draw horizontal line with specific thickness
\def\vhrulefill#1{\leavevmode\leaders\hrule\@height#1\hfill \kern\z@}

% Use to execute conditional statements by checking empty string
\newcommand*{\ifempty}[3]{\ifthenelse{\isempty{#1}}{#2}{#3}}
