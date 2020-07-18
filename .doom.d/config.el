;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Gabe Oppenheimer"
      user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
(setq doom-font (font-spec :family "monospace" :size 14))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'colors)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/Documents/Org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)


;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c g k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c g d') to jump to their definition and see how
;; they are implemented.

;For using emacs as a pdf viewer, from https://www.reddit.com/r/emacs/comments/gshn9c/doom_emacs_as_a_pdf_viewer/ hlissner himself
(use-package pdf-view
  :hook (pdf-tools-enabled . hide-mode-line-mode)
  :hook (pdf-tools-enabled . pdf-view-midnight-minor-mode))
  ;; :config (setq pdf-view-midnight-colors '(bgr . fgr)))
  ;; :config (setq bgr (ewal-get-color 'background 0))
  ;; :config (setq fgr (ewal-get-color 'foreground 0))

(define-advice pdf-view-midnight-minor-mode
    (:before (&optional arg) my-recompute-colors)
  "Recompute `pdf-view-midnight-colors'."
  (setq pdf-view-midnight-colors
        (cons (face-attribute 'default :foreground)
              (face-attribute 'default :background))))

(after! doom/reload-theme
  (setq pdf-view-midnight-colors
        (cons (face-attribute 'default :foreground)
              (face-attribute 'default :background)))
  (pdf-view-midnight-minor-mode 0)
  (pdf-view-midnight-minor-mode 1))
  ;; (add-hook 'pdf-view-midnight-minor-mode-hook 'pdf-view-midnight-minor-mode)
  ;; (add-hook 'pdf-view-midnight-minor-mode-hook 'pdf-view-midnight-minor-mode))

;; (after! pdf-view
;;   (setq bgr (ewal-doom-themes-get-color 'background  0))
;;   (setq fgr (ewal-doom-themes-get-color 'foreground  0))
;;   (setq pdf-view-midnight-colors '(bgr . fgr)))

; For consistent borders on pdfs
(add-hook 'pdf-tools-enabled-hook
  (lambda ()
    (set (make-local-variable
         'evil-evilified-state-cursor)
         (list nil))))


(after! org
  (setq org-export-with-toc nil)
  (setq org-export-with-section-numbers nil)
  (setq org-export-headline-levels 3)
  (setq org-latex-default-packages-alist
    '(("AUTO" "inputenc"  t ("pdflatex"))
    ("T1"   "fontenc"   t ("pdflatex"))
    (""     "graphicx"  t)
    (""     "grffile"   t)
    (""     "longtable" nil)
    (""     "wrapfig"   nil)
    (""     "rotating"  nil)
    ("normalem" "ulem"  t)
    (""     "amsmath"   t)
    (""     "textcomp"  t)
    ("hidelinks"     "hyperref"  t)
    (""     "linguex"   t)
    (""     "fancyhdr"   t)
    (""     "tikz"   t)
    (""     "tikz-qtree"   t)
    (""     "tipa"   t)))
  (require 'org-ref)
  (setq org-latex-pdf-process
      '("pdflatex -interaction nonstopmode -output-directory %o %f"
	"bibtex %b"
	"pdflatex -interaction nonstopmode -output-directory %o %f"
	"pdflatex -interaction nonstopmode -output-directory %o %f")))

;; Takes a color string like #ffe0e0 and returns a light
;; or dark foreground color to make sure text is readable.
(defun fg-from-bg (bg)
  (let* ((avg (/ (+ (string-to-number (substring bg 1 3) 16)
                    (string-to-number (substring bg 3 5) 16)
                    (string-to-number (substring bg 5 7) 16)
                    ) 3)))
    (if (> avg 128) "#000000" "#ffffff")
    ))
