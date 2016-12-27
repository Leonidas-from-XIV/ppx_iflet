# `ppx_iflet`

A `ppx` syntax extension for OCaml implementing `if-let` from Clojure in OCaml.

## Example

```ocaml
if[%let binding = an_option] then
  (* code which has binding set to the unwrapped Some value *)
else
  (* if an_option was None *)
```

If expands to

```ocaml
match an_option with
| Some binding -> (* code which has binding set to unwrapped Some value *)
| None -> (* an_option was None *)
```

## Usage

### Dump AST

`ocamlc -dparsetree examples/if_let.ml`

### Build

`ocamlbuild -use-ocamlfind src/ppx_iflet.native`

### Run

`ocamlfind ppx_tools/rewriter ./ppx_iflet.native examples/if_let.ml`
