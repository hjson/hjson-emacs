# hjson-mode.el - A major mode for editing [hjson](https://github.com/hjson/hjson) files

Currently only allows syntax highlighting.
Use on any file by executing `M-x hjson-mode` once installed.

# Install

`M-x package-install hjson-mode`

You need to have the [MELPA repository](https://melpa.org/) or [MELPA Stable repository](https://stable.melpa.org/) enabled in emacs for this to work.

# Building

If you would like to build it from scratch, clone this repository and append the following to your init file located at `~/.emacs.d/init.el` 
```
(load-file "[your git repository]/hjson-mode.el")
(add-to-list 'auto-mode-alist '("\\.hjson\\'" . hjson-mode))
```

# Contribution

Contribution is encouraged, please feel free to improve. 

For testing changes, I recomend attaching the following code to `hjson-mode.el`
```(defun reload ()
  "Reloads `hjson-mode'."
  (interactive)
  (load-file "[your git repository]/hjson-mode.el")
  (hjson-mode))```


