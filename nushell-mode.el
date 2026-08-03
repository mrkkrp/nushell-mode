;;; nushell-mode.el --- Major mode for Nushell scripts  -*- lexical-binding: t; -*-

;; Copyright (C) 2023–2026 Mark Karpov
;; Copyright (C) 2022 Azzam S.A

;; Author: Azzam S.A <vcs@azzamsa.com>
;; Homepage: https://github.com/mrkkrp/nushell-mode
;; Keywords: languages, unix

;; Package-Version: 0.2.0
;; Package-Requires: ((emacs "24.4"))

;; SPDX-License-Identifier: GPL-3.0-or-later

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; A very basic version of major mode for Nushell shell scripts.

;; DEPRECATED: This package is deprecated in favor of `nushell-ts-mode'
;; (https://github.com/herbertjones/nushell-ts-mode), which uses
;; Tree-sitter and is a functional superset of this package: it adds
;; indentation, imenu, structural navigation, completion-at-point, and
;; Org Babel support on top of more accurate syntax highlighting.  On
;; Emacs 29+ with the `nu' Tree-sitter grammar installed, prefer it.
;;
;; `nushell-mode' remains available as a lightweight, zero-dependency
;; option (Emacs 24.4+, syntax highlighting only) and receives
;; maintenance updates only; no new features are planned.

;;; Code:

(defgroup nushell nil
  "Nushell shell support."
  :group 'languages
  :tag "Nushell"
  :prefix "nushell-"
  :link '(url-link :tag "GitHub" "https://github.com/mrkkrp/nushell-mode"))

(defcustom nushell-indent-offset 4
  "Default indentation offset for Nushell."
  :group 'nushell
  :type 'integer
  :safe 'integerp)

(defconst nushell-keywords
  '("alias"
    "break"
    "collect"
    "const"
    "continue"
    "def"
    "else"
    "export"
    "export-env"
    "extern"
    "for"
    "hide"
    "if"
    "let"
    "loop"
    "match"
    "module"
    "mut"
    "overlay"
    "return"
    "source"
    "source-env"
    "try"
    "catch"
    "use"
    "where"
    "while")
  "Nushell keywords.

It is difficult to tell whether a certain word should be
considered a built-in or a keyword in Nushell.  We follow the
principle that keywords define the structure and organization of
a program to a certain extent and thus deserve special highlighting
in order to aid reading.  Highlighting every built-in command as
a keyword would result in visual noise.

The list mirrors the commands that Nushell itself reports with a
command type of \"keyword\" (see the output of \"help commands\"),
plus \"else\" and \"catch\", which are part of the \"if\" and \"try\"
control structures.")

(defconst nushell-operators
  '("and"
    "bit-and"
    "bit-or"
    "bit-shl"
    "bit-shr"
    "bit-xor"
    "ends-with"
    "has"
    "in"
    "mod"
    "not"
    "not-has"
    "not-in"
    "or"
    "starts-with"
    "xor")
  "Nushell word-form operators.

These are the operators that are spelled as words rather than as
punctuation and thus need to be highlighted by matching them as
identifiers.")

(defconst nushell-constants
  '("true"
    "false"
    "null")
  "Nushell literal constants.")

(defconst nushell-types
  '("any"
    "binary"
    "bool"
    "cell-path"
    "closure"
    "datetime"
    "duration"
    "error"
    "filesize"
    "float"
    "glob"
    "int"
    "list"
    "nothing"
    "number"
    "range"
    "record"
    "string"
    "table")
  "Nushell type names as used in command signatures.")

(defconst nushell-builtins
  '("all"
    "ansi"
    "any"
    "append"
    "ast"
    "attr"
    "bits"
    "bytes"
    "cal"
    "cd"
    "char"
    "chunk-by"
    "chunks"
    "clear"
    "columns"
    "commandline"
    "compact"
    "complete"
    "config"
    "cp"
    "date"
    "debug"
    "decode"
    "default"
    "describe"
    "detect"
    "do"
    "drop"
    "du"
    "each"
    "echo"
    "encode"
    "enumerate"
    "error"
    "every"
    "exec"
    "exit"
    "explain"
    "explore"
    "fill"
    "filter"
    "find"
    "first"
    "flatten"
    "format"
    "from"
    "generate"
    "get"
    "glob"
    "grid"
    "group-by"
    "hash"
    "headers"
    "help"
    "hide-env"
    "histogram"
    "history"
    "http"
    "ignore"
    "input"
    "insert"
    "inspect"
    "interleave"
    "into"
    "is-admin"
    "is-empty"
    "is-not-empty"
    "is-terminal"
    "items"
    "job"
    "join"
    "keybindings"
    "kill"
    "last"
    "length"
    "lines"
    "load-env"
    "ls"
    "math"
    "merge"
    "metadata"
    "mkdir"
    "mktemp"
    "move"
    "mv"
    "nu-check"
    "nu-highlight"
    "open"
    "panic"
    "par-each"
    "parse"
    "path"
    "plugin"
    "port"
    "prepend"
    "print"
    "ps"
    "query"
    "random"
    "reduce"
    "reject"
    "rename"
    "reverse"
    "rm"
    "roll"
    "rotate"
    "run-external"
    "save"
    "schema"
    "scope"
    "select"
    "seq"
    "shuffle"
    "skip"
    "sleep"
    "slice"
    "sort"
    "sort-by"
    "split"
    "start"
    "stor"
    "str"
    "sys"
    "table"
    "take"
    "tee"
    "term"
    "timeit"
    "to"
    "touch"
    "transpose"
    "tutor"
    "ulimit"
    "umask"
    "uname"
    "uniq"
    "uniq-by"
    "update"
    "upsert"
    "url"
    "values"
    "version"
    "view"
    "watch"
    "which"
    "whoami"
    "window"
    "with-env"
    "wrap"
    "zip")
  "Nushell built-in commands.

This list mirrors the single-word commands that Nushell reports
with a command type of \"built-in\" (see the output of \"help
commands\").  Multi-word subcommands such as \"str join\" or \"path
basename\" are highlighted via their leading word.")

(defface nushell-pay-attention-face
  '((t :inverse-video t :inherit font-lock-preprocessor-face))
  "Face used to display elements that should attract attention.")

(defconst nushell-font-lock-keywords
  `(

    ;; Keywords
    (,(regexp-opt nushell-keywords 'symbols) . font-lock-keyword-face)

    ;; Word-form operators
    (,(regexp-opt nushell-operators 'symbols) . font-lock-keyword-face)

    ;; Constants
    (,(regexp-opt nushell-constants 'symbols) . font-lock-constant-face)

    ;; Types
    (,(regexp-opt nushell-types 'symbols) . font-lock-type-face)

    ;; Builtins
    (,(regexp-opt nushell-builtins 'symbols) . font-lock-builtin-face)

    ;; Variables
    ("\\$[[:word:]_\\.-]+" . font-lock-variable-name-face)

    ;; String interpolation (beginning of string)
    ("\\$" . 'nushell-pay-attention-face)

    ;; Redirections (long and short forms, plus appending variants)
    ("\\(?:out\\|err\\|o\\|e\\)\\(?:\\+\\(?:out\\|err\\|o\\|e\\)\\)?>>?"
     . 'nushell-pay-attention-face)

    ;; Using system binaries instead of Nushell built-ins
    ("\\(\\^\\)\\(?:[[:word:]_-]+\\)" 1 'nushell-pay-attention-face)))

(defvar nushell-mode-syntax-table
  (let ((table (make-syntax-table text-mode-syntax-table)))
    (modify-syntax-entry ?\# "<" table)
    (modify-syntax-entry ?\n ">" table)
    (modify-syntax-entry ?\" "\"" table)
    (modify-syntax-entry ?\' "\"'" table)
    (modify-syntax-entry ?\\ "\\" table)
    (modify-syntax-entry ?$ "'" table)
    table)
  "Syntax table for `nushell-mode'.")

;;;###autoload
(define-derived-mode nushell-mode prog-mode "Nushell"
  "Major mode for editing nushell shell files."
  :syntax-table nushell-mode-syntax-table
  (setq-local font-lock-defaults '(nushell-font-lock-keywords))
  (setq-local comment-start "# ")
  (setq-local comment-start-skip "#+[\t ]*"))

;;;###autoload
(add-to-list 'auto-mode-alist '("\\.nu\\'" . nushell-mode))

;;;###autoload
(add-to-list 'interpreter-mode-alist '("nu" . nushell-mode))

(provide 'nushell-mode)

;;; nushell-mode.el ends here
