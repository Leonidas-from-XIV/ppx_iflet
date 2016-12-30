#!/usr/bin/env ocaml
#use "topfind"
#require "topkg"
open Topkg

let () =
  Pkg.describe
    "ppx_iflet" @@ fun c ->
  Ok [ Pkg.libexec "src/ppx_iflet" ]
