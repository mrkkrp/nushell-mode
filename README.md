# Nushell mode

[![License GPL 3](https://img.shields.io/badge/license-GPL_3-green.svg)](http://www.gnu.org/licenses/gpl-3.0.txt)
[![MELPA](https://melpa.org/packages/nushell-mode-badge.svg)](https://melpa.org/#/nushell-mode)
![CI](https://github.com/mrkkrp/nushell-mode/workflows/CI/badge.svg?branch=master)

## Features

- Keyword highlight

## Installation

### MELPA

The package is available via MELPA, so you can just type `M-x
package-install RET nushell-mode RET`.

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

## License

Copyright © 2023–present Mark Karpov\
Copyright © 2022 Azzam S.A

Distributed under GNU GPL, version 3.
