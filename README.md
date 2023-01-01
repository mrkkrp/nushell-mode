<div align="center">
  <h1>Emacs Nushell</h1>

Emacs major mode for Nushell scripts.

</div>

---

## Features

- Keyword highlight

## Installation

### Doom Emacs

in `packages.el`

``` commonlisp
(package! nushell-mode :recipe (:host github :repo "azzamsa/emacs-nushell"))
```

### straight.el

``` commonlisp
(straight-use-package
 '(nushell-mode :type git :host github :repo "azzamsa/emacs-nushell"))
```

## Credits

- [Tony Wang's Emacs Fish Mode](https://github.com/wwwjfy/emacs-fish)
