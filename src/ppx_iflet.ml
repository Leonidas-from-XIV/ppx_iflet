open Ast_mapper
open Asttypes
open Parsetree

let build_pattern loc desc =
  { ppat_attributes = [];
    ppat_loc = loc;
    ppat_desc = desc }

let build_case lhs rhs =
  { pc_lhs = lhs;
    pc_rhs = rhs;
    pc_guard = None }

let iflet_mapper argv =
  { default_mapper with
    expr = fun mapper expr ->
      match expr with
      | { pexp_desc =
        Pexp_ifthenelse ({ pexp_desc = Pexp_extension ({ txt = "let"; loc}, pstr)},
                         iftrue,
                         Some iffalse)} ->
          (match pstr with
          | PStr [{ pstr_desc =
                    Pstr_eval ({ pexp_loc = loc;
                                 pexp_desc = Pexp_apply ({ pexp_desc = Pexp_ident ({ txt = Longident.Lident "="})},
                                                         [(_, { pexp_desc = Pexp_ident { txt = Longident.Lident src} });
                                                          (_, ({ pexp_desc = Pexp_ident _ } as source))])}, _)}] ->
            let none_case = build_pattern loc @@ Ppat_construct ({ txt = Longident.Lident "None";
                                                                   loc = loc;}, None) in
            let some_case = build_pattern loc @@ Ppat_construct ({ txt = Longident.Lident "Some";
                                                                    loc = loc;}, Some (build_pattern loc @@ Ppat_var { txt = src;
                                                                                                                       loc = loc;})) in
            { expr with
              pexp_desc = Pexp_match (source, [build_case some_case iftrue;
                                               build_case none_case iffalse])}
          | _ ->
            raise (Location.Error (
              Location.error ~loc "[%let] reqyures a binding form e.g. [%let unpacked = option_val]")))
      | x -> default_mapper.expr mapper x; }

let main () =
  register "let" iflet_mapper

let () =
  main ()
