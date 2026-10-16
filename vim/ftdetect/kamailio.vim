" Match by shebang, by kamailio*.cfg name, or (for include_file'd snippets
" without a shebang) by route/loadmodule/modparam statements near the top.
autocmd BufRead,BufNewFile *.cfg
    \ if getline(1) =~# '^#!\(KAMAILIO\|OPENSER\|SER\|MAXCOMPAT\|ALL\)\>' ||
    \    expand('<afile>:t') =~# '^kamailio' ||
    \    match(getline(1, 100), '^\s*\(\(\l\+_\)\=route\>\s*[[{]\|\(loadmodule\|modparam\)x\=\>\)') >= 0 |
    \   setlocal filetype=kamailio |
    \ endif
