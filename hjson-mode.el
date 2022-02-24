;;; hjson-mode.el --- Major mode for editing hjson files.            -*- lexical-binding: t; -*-

;; Copyright (C) 2021 Stampyzfanz

;; Author: Stampyzfanz <theorderofthestoneathopscotch@gmail.com>
;; Created: 1 Jan 2022
;; URL: https://hjson.github.io/
;; Version: 1.0.0
;; Keywords: hjson

;;
;; This file is NOT part of GNU Emacs.
;;

;; License: MIT

;;; Commentary:

;; syntax highlights hjson files

;;; Code:

(defvar hjson-mode-syntax-table nil "Syntax table for `hjson-mode'.")

(setq hjson-mode-syntax-table
      (let ( (synTable (make-syntax-table)))
        ;; /* comment */
        (modify-syntax-entry ?\/ ". 14" synTable)
        (modify-syntax-entry ?* ". 23" synTable)
        ;; the ;;" is because some syntax highlighters don't recognise that
        ;; a string is not created
        ;; stop " meaning string because it could be a key
        (modify-syntax-entry ?" "w" synTable)  ;;"

        synTable))

;; BEGIN ''' code
;; https://emacs.stackexchange.com/a/13383
(defconst hjson-mode-triple-quoted-string-regex
  (rx "'''"))

(defun hjson-mode-stringify-triple-quote ()
  "Put `syntax-table' property on triple-quoted strings."
  (let* ((string-end-pos (point))
         (string-start-pos (- string-end-pos 3))
         (ppss (prog2
                   (backward-char 3)
                   (syntax-ppss)
                 (forward-char 3))))
    (unless (nth 4 (syntax-ppss)) ;; not inside comment
      (if (nth 8 (syntax-ppss))
          ;; We're in a string, so this must be the closing triple-quote.
          ;; Put | on the last " character.
          (put-text-property (1- string-end-pos) string-end-pos
                             'syntax-table (string-to-syntax "|"))
        ;; We're not in a string, so this is the opening triple-quote.
        ;; Put | on the first " character.
        (put-text-property string-start-pos (1+ string-start-pos)
                           'syntax-table (string-to-syntax "|"))))))

(defconst hjson-mode-syntax-propertize-function
  (syntax-propertize-rules
   (hjson-mode-triple-quoted-string-regex
    (0 (ignore (hjson-mode-stringify-triple-quote))))))

;; END ''' code

(setq hjson-mode-highlights
      '(
        ;; make sure there is no colons preceeding it to fix 
        ;; https://github.com/hjson/hjson/issues/112
        ;; any amount of keylike characters that don't start with "
        ;; \\(?:[^][(){},\s]\\)+
        ;; " then any non string ending character then "
        ;; It also allows escaping a double quote by /"
        ;; \"\\(?:[^\"\\]\\|\\\\.\\)*\"
        ;; whitespace before colon
        ;; \s*:
        ;; the whole thing other than the colon is wrapped in a group so 
        ;; it doesn't colour the colon
        ;; keys
        ("^[^:]*?\\(\\(?:\\(?:[^][(){}:,\s]\\)+\\|\"\\(?:[^\"\\]\\|\\\\.\\)*\"\\)\s*\\):" . (1 font-lock-variable-name-face))

        ;; any // or /* at start of line, after end of "value" in quotes, 
        ;; or after constant or number and whitespace
        ("\\(?:^\\|\"\\|true\\|false\\|null\\|[][{}]\\|\
-?\\(?:0\\|[1-9][0-9]*\\)\\(?:\\(?:\\.[0-9]+\\)?\\(?:[eE][+-]?[0-9]+\\)?\\)?\
\\)\s*\\(\\(//\\|#\\).*\\)" . (1 font-lock-comment-face))

        ;; for key: "values" strings
        ("\"\\(?:[^\"\\\n]\\|\\\\.\\)*\"" . 'font-lock-string-face)

        ("true\\|false\\|null" . 'font-lock-constant-face)

        ;; numbers
        ("-?\\(0\\|[1-9][0-9]*\\)\\(\\(\\.[0-9]+\\)?\\([eE][+-]?[0-9]+\\)?\\)?" . 'font-lock-constant-face)

        ;; for *key: values* strings
        ("[:[]\s*\\([^\"\n]*$\\)" . (1 font-lock-string-face))
      ))


;;;###autoload
(define-derived-mode hjson-mode fundamental-mode "hjson"
  "Major mode for editing hjson files."

  ;; code for syntax highlighting
  (setq font-lock-defaults '(hjson-mode-highlights nil nil)) ;; https://emacs.stackexchange.com/a/26264
  (set (make-local-variable #'syntax-propertize-function)
       hjson-mode-syntax-propertize-function))


;; add the mode to the `features' list
(provide 'hjson-mode)

(add-to-list 'auto-mode-alist '("\\.hjson\\'" . hjson-mode))

;;; hjson-mode.el ends here 