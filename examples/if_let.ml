let an_option = Some "hello"

let _ = print_endline @@
  if[%let binding = an_option] then "some" else "none"
(* if true = true (1* [%let binding = an_option] *1) *)
(*   then *)
(*     print_endline binding *)
(*   else *)
(*     print_endline "world" *)
