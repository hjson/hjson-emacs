# hjson-mode.el - A major mode for editing [hjson](https://github.com/hjson/hjson) files

Currently only allows syntax highlighting.
Use on any file by executing `M-x hjson-mode` once installed.

# Install

<s>`M-x package-install hjson-mode`

You need to have the [MELPA repository](https://melpa.org/) or [MELPA Stable repository](https://stable.melpa.org/) enabled in emacs for this to work.</s>

It may be added to Melpa in the future, but until then execute the following code in the terminal

```bash
cd ~/.emacs.d
wget https://raw.githubusercontent.com/stampyzfanz/hjson-emacs/main/hjson-mode.el
echo "(load-file \"~/.emacs.d/hjson-mode.el\")" >> init.el
echo "(add-to-list 'auto-mode-alist '(\"\\\\\\\\.hjson\\\\\\\\'\" . hjson-mode))" >> init.el
```

# Building

If you would like to build it from scratch, clone this repository and append the following to your init file located at `~/.emacs.d/init.el` 
```lisp
(load-file "[your git repository]/hjson-mode.el")
(add-to-list 'auto-mode-alist '("\\.hjson\\'" . hjson-mode))
```

# Contribution

Contribution is encouraged, please feel free to improve. 

For testing changes, I recomend attaching the following code to `hjson-mode.el`
```lisp
(defun reload ()
  "Reloads `hjson-mode'."
  (interactive)
  (load-file "[your git repository]/hjson-mode.el")
  (hjson-mode))
  ```


