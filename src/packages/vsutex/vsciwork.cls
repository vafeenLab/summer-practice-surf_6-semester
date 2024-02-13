% !TEX TS-program = lualatex
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{vsciwork}[2024/01/11 1.0.0 Science work template for VSU]

% Passtrow all options for class to extarticle class
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{extarticle}}
\ProcessOptions\relax

% Set A4 paper
\LoadClass[a4paper]{extarticle}

% Set Russian as main document language
\RequirePackage[english, russian]{babel}

% Set page padding
\RequirePackage[left=3cm, right=1.5cm, top=2cm, bottom=2cm]{geometry}

% Set Times New Roman font
\RequirePackage{fontspec}
\setmainfont{Times New Roman}

% Set 0pt space after paragraphs
\RequirePackage{parskip}
\setlength{\parskip}{0pt}

% Set first line 1.25cm indent
\RequirePackage{indentfirst}
\setlength{\parindent}{1.25cm}

% Set line 1.5pt line spacing
\RequirePackage{setspace}
\onehalfspacing

% Set dynamic spaces between words
\sloppy

% Set section styles
\RequirePackage{titlesec}
\titleformat{\section}{\normalfont\normalsize\centering\bfseries}{\thesection. }{0pt}{}
\titleformat{\subsection}{\normalfont\normalsize\centering\bfseries}{\thesubsection. }{0pt}{}
\titleformat{\subsubsection}{\normalfont\normalsize\centering\bfseries}{\thesubsubsection. }{0pt}{}
\let\sectionbreak\clearpage

% Set toc styles
\RequirePackage{titletoc}
\titlecontents{section}[0pt]{\normalfont\normalsize}{\thecontentslabel. }{}{\dotfill\contentspage}
\titlecontents{subsection}[0pt]{\normalfont\normalsize}{\thecontentslabel. }{}{\dotfill\contentspage}
\titlecontents{subsubsection}[0pt]{\normalfont\normalsize}{\thecontentslabel. }{}{\dotfill\contentspage}

% Add hyperrefs to the document
\RequirePackage{hyperref}

% Replace : to . in captions
\RequirePackage[labelsep=period]{caption}

% Set gost style for bibliography
\bibliographystyle{pugost2008}

% Add bibliography to toc and ignore hbadness
\makeatletter
\let\@oldbibliography\bibliography
\renewcommand{\bibliography}[1]{%
    \cleardoublepage
    \phantomsection\addcontentsline{toc}{section}{\refname}
    \let\@oldhbadness\hbadness
    \hbadness 10000
    \@oldbibliography{#1}
    \let\hbadness\@oldhbadness
    \let\@oldhbadness\undefine
}
\makeatother

% Define sections without number in toc
% \nolabel{section}{name}
\newcommand{\nolabel}[2]{%
    \csname #1\endcsname*{\phantomsection #2}\addcontentsline{toc}{#1}{#2}
}

% Internal packages
\RequirePackage{environ}

% Set title style
\RequirePackage{titling}
\makeatletter

% Set current year by default
\renewcommand{\@date}{\the\year}

% Set head of department
\newcommand{\headdep}[1]{\newcommand{\@headdep}{#1}}

% Set head of department grade
\newcommand{\@headdepgrade}[0]{\hspace{3cm}}
\newcommand{\headdepgrade}[1]{\renewcommand{\@headdepgrade}{#1}}

% Set scientific adviser
\newcommand{\sciadv}[1]{\newcommand{\@sciadv}{#1}}

% Set scientific adviser grade
\newcommand{\@sciadvgrade}[0]{\hspace{3cm}}
\newcommand{\sciadvgrade}[1]{\renewcommand{\@sciadvgrade}{#1}}

% Set department
\newcommand{\@department}[0]{\PackageError{vsciwork}{Set department before the using maketitle}}
\newcommand{\department}[1]{\renewcommand{\@department}{#1}}

% Set title description
\newcommand{\@titledesc}[0]{\PackageError{vsciwork}{Set titledesc before the using maketitle}}
\newcommand{\titledesc}[1]{\renewcommand{\@titledesc}{#1}}

% Set direction
\newcommand{\@direction}[0]{\PackageError{vsciwork}{Set direction before the using maketitle}}
\newcommand{\direction}[1]{\renewcommand{\@direction}{#1}}

% Set profile
\newcommand{\@profile}[0]{\PackageError{vsciwork}{Set profile before the using maketitle}}
\newcommand{\profile}[1]{\renewcommand{\@profile}{#1}}

% Set author grade
\newcommand{\@authorgrade}[0]{\hspace{3cm}}
\newcommand{\authorgrade}[1]{\renewcommand{\@authorgrade}{#1}}

% Patch maketitle command and ignore hbox
\long\def\@maketitle{%
    \let\@oldhfuzz\hfuzz
    \hfuzz 10000pt
    \begin{titlingpage}
        \begin{center}
            МИНОБРНАУКИ  РОССИИ \\
            ФЕДЕРАЛЬНОЕ  ГОСУДАРСТВЕННОЕ  БЮДЖЕТНОЕ \\
            ОБРАЗОВАТЕЛЬНОЕ  УЧРЕЖДЕНИЕ  ВЫСШЕГО  ОБРАЗОВАНИЯ \\
            <<ВОРОНЕЖСКИЙ  ГОСУДАРСТВЕННЫЙ  УНИВЕРСИТЕТ>> \\
            (ФГБОУ ВО <<ВГУ>>) \vspace{1em}

            Факультет прикладной математики, информатики и механики \vspace{1em}

            \@department\vfill

            \begin{doublespace}
                \textbf{\@title}\vspace{1em}
            \end{doublespace}

            \@titledesc\vspace{1em}

            \@direction\vspace{1em}

            \@profile\vfill

            \renewcommand{\arraystretch}{1.5}%
            \setlength\tabcolsep{0.4cm}
            \begin{tabular}{c c c c}
                \ifdefined\@headdep
                Зав. кафедрой & \underline{\hspace{3cm}} & \@headdepgrade{} & \@headdep \\
                \fi
                Обучающийся   & \underline{\hspace{3cm}} & \@authorgrade{}  & \@author  \\
                \ifdefined\@sciadv
                Руководитель  & \underline{\hspace{3cm}} & \@sciadvgrade{}  & \@sciadv  \\
                \fi
            \end{tabular}\vfill

            Воронеж, \@date
        \end{center}
    \end{titlingpage}
    \setcounter{page}{2}
    \let\hfuzz\@oldhfuzz
    \let\@oldhfuzz\undefine
}
\makeatother

% Add images
\RequirePackage{graphicx}

% Add dummy images
\RequirePackage{duckuments}
\makeatletter

% Set image width by default
\newlength{\imagewidth}
\setlength{\imagewidth}{0.8\textwidth}

% Add image with ref
% \image[image parameters]{caption}{filepath}{ref}
\newcommand{\@image}[4][width=\imagewidth]{%
    \begin{figure}[!ht]
        \centering
        \includegraphics[#1]{#3}
        \caption{#2}
        \label{fig:#4}
    \end{figure}}

% Add image without ref
% \image[image parameters]{caption}{filepath}
\newcommand{\@@image}[3][width=\imagewidth]{%
    \begin{figure}[!ht]
        \centering
        \includegraphics[#1]{#3}
        \caption{#2}
    \end{figure}}

% Add dummy image with ref
% \dimage[image parameters]{caption}{ref}
\newcommand{\@dimage}[3][width=\imagewidth]{\@image[#1]{#2}{example-image-duck}{#3}}

% Add dummy image without ref
% \dimage[image parameters]{caption}
\newcommand{\@@dimage}[2][width=\imagewidth]{\@@image[#1]{#2}{example-image-duck}}

% Internal command
\long\def\image{\@ifstar\@@image\@image}
\long\def\dimage{\@ifstar\@@dimage\@dimage}

% Add ref to image in the text
\newcommand{\refimage}[1]{рис. \ref{fig:#1}.}
\makeatother

% Add tables
\RequirePackage{tabularx}
\makeatletter

% Set table width by default
\newlength{\dfwidth}
\setlength{\dfwidth}{0.8\textwidth}

% Add new column types
\newcolumntype{L}{>{\raggedright\arraybackslash}X}
\newcolumntype{C}{>{\centering\arraybackslash}X}
\newcolumntype{R}{>{\raggedleft\arraybackslash}X}

% Add table with ref
% \begin{df}[width]{columns}{t, m, b}{caption}{ref}
\NewEnviron{df}[5][\dfwidth]{%
    \begin{table}[!ht]
        \centering
        \let\@oldtabularxcolumn\tabularxcolumn
        \renewcommand\tabularxcolumn[1]{#3{##1}}
        \begin{tabularx}{#1}{#2}
            \BODY
        \end{tabularx}
        \let\tabularxcolumn\@oldtabularxcolumn
        \caption{#4}
        \label{table:#5}
    \end{table}
}

% Add table without ref
% \begin{df*}[width]{columns}{t, m, b}{caption}
\NewEnviron{df*}[4][\dfwidth]{%
    \begin{table}[!ht]
        \centering
        \let\@oldtabularxcolumn\tabularxcolumn
        \renewcommand\tabularxcolumn[1]{#3{##1}}
        \begin{tabularx}{#1}{#2}
            \BODY
        \end{tabularx}
        \let\tabularxcolumn\@oldtabularxcolumn
        \caption{#4}
    \end{table}
}

% Add ref to table in the text
\newcommand{\refdf}[1]{табл. \ref{table:#1}.}
\makeatother
