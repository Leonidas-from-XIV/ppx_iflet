open Ast_mapper

let iflet_mapper argv =
  { default_mapper with
    expr = fun mapper expr ->
      match expr with
      | x -> default_mapper.expr mapper x; }

let main () =
  register "let" iflet_mapper

let () =
  main ()
