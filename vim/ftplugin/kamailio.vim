if exists("b:did_ftplugin")
  finish
endif
let b:did_ftplugin = 1

setlocal noexpandtab
setlocal commentstring=#\ %s
setlocal comments=s1:/*,mb:*,ex:*/,://,:#
setlocal foldmethod=syntax
setlocal foldlevel=99

" % between #!ifdef/#!ifndef/#!ifexp, #!else and #!endif (needs matchit)
let b:match_words = '[#!]!\%(ifn\=def\|ifexp\)\>:[#!]!else\>:[#!]!endif\>'

let b:undo_ftplugin = "setlocal expandtab< commentstring< comments< foldmethod< foldlevel<"
      \ . " | unlet! b:match_words"
