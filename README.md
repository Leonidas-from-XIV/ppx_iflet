# `ppx_iflet`

A `ppx` syntax extension for OCaml implementing `if-let` from Clojure in OCaml.
Clojure's `if-let` form is a convenient merge of `if` and `let`, evaluating an
expression and seeing whether it is truthy and `let`-binding it to the
specified name.

OCaml does not directly have such an operator, though pattern matching on the
`option` type comes close. This small ppx rewriter extends the `if` syntax to
privide similar `if-let` functionality to OCaml.

## Example

```ocaml
let an_option = Some "Value"

if[%let binding = an_option] then
  print_endline binding
else
  print_endline "Nothing specified"
```

If expands to

```ocaml
match an_option with
| Some binding -> print_endline binding
| None -> print_endline "Nothing specified"
```

## Building

Ensure you have `topkg`, `ocamlbuild` and `ocamlfind` installed.

`topkg -build`

## Usage

### Dump AST

`ocamlc -dparsetree examples/if_let.ml`

### Run

`ocamlfind ppx_tools/rewriter build/src/ppx_iflet.native examples/if_let.ml`

## Further reading

 * [A Guide to Extension Points in OCaml](https://whitequark.org/blog/2014/04/16/a-guide-to-extension-points-in-ocaml/)
 * [ppx\_let](https://github.com/janestreet/ppx_let) which provides `if%map`
   and `match%map` which are supersets of what this module provides.
