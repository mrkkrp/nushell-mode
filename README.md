# Nushell mode

![CI](https://github.com/mrkkrp/nushell-mode/workflows/CI/badge.svg?branch=master)

## Features

- Keyword highlight

## Installation

### Doom Emacs

in `packages.el`

```emacs-lisp
(package! nushell-mode :recipe (:host github :repo "mrkkrp/nushell-mode"))
```

### straight.el

```emacs-lisp
(straight-use-package
 '(nushell-mode :type git :host github :repo "mrkkrp/nushell-mode"))
```

## Credits

- [Tony Wang's Emacs Fish Mode](https://github.com/wwwjfy/emacs-fish)
