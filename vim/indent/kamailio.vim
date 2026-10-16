if exists("b:did_indent")
  finish
endif
let b:did_indent = 1

setlocal indentexpr=GetKamailioIndent()
setlocal indentkeys=0{,0},0),0],:,0#,!^F,o,O,e

let b:undo_indent = "setlocal indentexpr< indentkeys<"

if exists("*GetKamailioIndent")
  finish
endif

" cindent() handles the C-like route code, but would put '#' lines (comments
" and directives) in column 0 as C pre-processor lines; indent those like the
" code around them instead
function GetKamailioIndent() abort
  if getline(v:lnum) !~ '^\s*#'
    return cindent(v:lnum)
  endif
  let lnum = prevnonblank(v:lnum - 1)
  if lnum == 0
    return 0
  endif
  let prev = getline(lnum)
  if prev =~ '^\s*#'
    return indent(lnum)
  endif
  return indent(lnum) + (prev =~ '{\s*\(\(#\|//\).*\)\=$' ? shiftwidth() : 0)
endfunction
