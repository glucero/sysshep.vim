" the juicy parts of json highlighting taken from:
"   http://www.vim.org/scripts/script.php?script_id=1945
"
" init syntax
if !exists("main_syntax")
  if version < 600
    syntax clear
  elseif exists("b:current_syntax")
    finish
  endif
  let main_syntax = 'ssj'
endif
" syntax
syn region  ssjString oneline matchgroup=Quote start=/"/ skip=/\\\\\|\\"/ end=/"/ contains=ssjEscape
syn match   ssjEscape "\\["\\/bfnrt]" contained
syn match   ssjEscape "\\u\x\{4}" contained
syn match   ssjNumber "-\=\<\%(0\|[1-9]\d*\)\%(\.\d\+\)\=\%([eE][-+]\=\d\+\)\=\>"
syn keyword ssjNull null
syn keyword ssjBoolean true false
syn match   ssjKeywordMatch /"[^\"\:]\+"\:/ contains=ssjKeywordRegion
syn region  ssjKeywordRegion matchgroup=Quote start=/"/  end=/"\ze\:/ contained
" define the default highlighting.
"    version 5.7 and earlier: only when not done already
if version >= 508 || !exists("did_ssj_syn_inits")
"    version 5.8 and later: only when an item doesn't have highlighting yet
  if version < 508
    let did_json_syn_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif

  HiLink ssjString        String
  HiLink ssjEscape        Special
  HiLink ssjNumber        Number
  HiLink ssjNull          Function
  HiLink ssjBoolean       Boolean
  HiLink ssjKeywordRegion Label

  delcommand HiLink
endif

let b:current_syntax = "ssj"
if main_syntax == 'ssj'
  unlet main_syntax
endif

