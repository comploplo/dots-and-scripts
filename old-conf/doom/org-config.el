(require 'org)
(after! org
  (setq org-export-with-toc nil)
  (setq org-export-with-section-numbers nil)
  (setq org-export-headline-levels 3)
  (setq org-latex-default-packages-alist
  '(
    ;; ("utf8" "inputenc"  t ("pdflatex"))
    ;; ("T1"   "fontenc"   t ("pdflaex"))
    ;; (""     "geometry"  t)
    ;; (""     "graphicx"  t)
    ;; (""     "grffile"   t)
    ;; (""     "longtable" nil)
    ;; (""     "wrapfig"   nil)
    ;; (""     "rotating"  nil)
    ;; ("normalem" "ulem"  t)
    ;; (""     "amsmath"   t)
    ;; (""     "textcomp"  t)
    ;; ("hidelinks"     "hyperref"  t)
    ;; (""     "linguex"   t)
    ;; (""     "fancyhdr"  t)
    ;; (""     "tikz"      t)
    ;; (""     "tikz-qtree" t)
    ;; (""     "tipa"      t)
    ;; (""     "linguex"   t)
    ))
  (with-eval-after-load 'ox-latex
    (setq org-latex-compiler "xelatex"
          org-latex-pdf-process '("latexmk --shell-escape -pdf -xelatex %f")))
  ;; (setq org-latex-pdf-process
      ;; '("pdflatex -interaction nonstopmode -output-directory %o %f"
	;; "bibtex %b"
	;; "pdflatex -interaction nonstopmode -output-directory %o %f"
	;; "pdflatex -interaction nonstopmode -output-directory %o %f"))

  ;; (unless (boundp 'org-export-latex-classes)
  ;; (setq org-export-latex-classes nil))

 (add-to-list 'org-latex-classes

  '("510"
     "\\documentclass[11pt]{article}\n
      \\usepackage{tipa}\n
      \\usepackage{fontspec}\n
      \\usepackage{geometry}\n
      \\usepackage{xunicode}\n
      \\usepackage{xltxtra}\n
      \\usepackage{graphicx}\n
      \\usepackage{wrapfig}\n
      \\usepackage{rotating}\n
      \\usepackage[normalem]{ulem}\n
      \\usepackage{amsmath}\n
      \\usepackage{textcomp}\n
      \\usepackage[hidelinks]{hyperref}\n
      \\usepackage{fancyhdr}\n
      \\usepackage{tikz}\n
      \\usepackage{tikz-qtree}\n
      \\usepackage{linguex}\n
      \\linespread{1.1}\n
      \\geometry{a4paper, textwidth=5.5in, marginparsep=7pt, marginparwidth=.6in}\n
      \\setlength\\parindent{0in}\n
      \\defaultfontfeatures{Mapping=tex-text} % converts LaTeX specials (``quotes'' --- dashes etc.) to unicode\n
      \\setsansfont[Scale=1.22]{Fira Sans}\n
      \\pagestyle{fancy}\n
      \\setmainfont[Ligatures=TeX,Scale=1.1]{Times New Roman}\n
      \\newcommand{\\assig}[1]{\\rhead{\\textsf{LING510 F20 \\textbf{A#1}}}}\n
      \\renewcommand{\\headrulewidth}{0pt}\n
      \\renewcommand{\\footrulewidth}{0pt}\n
      \\voffset=1cm\n
"
     ("\\section{\\textsf{%s}}" . "\\section*{\\textsf{%s}}")
     ("\\subsection{\\textsf{%s}}" . "\\subsection*{\\textsf{%s}}")
     ("\\subsubsection{\\textsf{%s}}" . "\\subsubsection*{\\textsf{%s}}")
     ("\\paragraph{%s}" . "\\paragraph*{%s}")
     ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))

 (add-to-list 'org-latex-classes

  '("601"
     "\\documentclass[11pt]{article}\n
      \\usepackage{tipa}\n
      \\usepackage{fontspec}\n
      \\usepackage{geometry}\n
      \\usepackage{xunicode}\n
      \\usepackage{xltxtra}\n
      \\usepackage{graphicx}\n
      \\usepackage{wrapfig}\n
      \\usepackage{rotating}\n
      \\usepackage[normalem]{ulem}\n
      \\usepackage{amsmath}\n
      \\usepackage{textcomp}\n
      \\usepackage[hidelinks]{hyperref}\n
      \\usepackage{fancyhdr}\n
      \\usepackage{tikz}\n
      \\usepackage{tikz-qtree}\n
      \\usepackage{linguex}\n
      \\geometry{a4paper, textwidth=5.5in, marginparsep=7pt, marginparwidth=.6in}\n
      \\setmainfont[Ligatures=TeX,Scale=1.1]{Times New Roman}\n
      \\setlength\\parindent{0in}\n
      \\pagestyle{fancy}\n
"
     ("\\section{\\textsf{%s}}" . "\\section*{\\textsf{%s}}")
     ("\\subsection{\\textsf{%s}}" . "\\subsection*{\\textsf{%s}}")
     ("\\subsubsection{\\textsf{%s}}" . "\\subsubsection*{\\textsf{%s}}")
     ("\\paragraph{%s}" . "\\paragraph*{%s}")
     ("\\subparagraph{%s}" . "\\subparagraph*{%s}"))))
