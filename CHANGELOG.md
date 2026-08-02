## Nushell mode 0.2.0

* Refreshed syntax highlighting to match current Nushell (0.113):
  * Updated the keyword list to the commands Nushell reports as
    keywords, adding `const`, `continue`, `break`, `return`, `loop`,
    `match`, `try`/`catch`, `module`, `use`, `hide`, `source`,
    `source-env`, `export-env`, `overlay`, `where`, and `collect`, and
    dropping the removed `def-env` and `let-env`.
  * Split the word-form operators (`and`, `or`, `xor`, `not`, `in`,
    `not-in`, `has`, `not-has`, `starts-with`, `ends-with`, `mod`, and
    the `bit-*` family) into their own category.
  * Added highlighting for literal constants (`true`, `false`, `null`)
    and for type names used in signatures (`int`, `string`, `record`,
    `list`, and so on).
  * Expanded the built-in command list to cover the full set of
    single-word built-ins.
  * Broadened redirection highlighting to include the short forms
    (`o>`, `e>`, `o+e>`, …) and the appending variants (`o>>`, …).
* Removed the broken, unused `nushell-enable-auto-indent` variable and
  the unnecessary `cl-lib`/`subr-x` dependencies.

## Nushell mode 0.1.0

* Initial release.
