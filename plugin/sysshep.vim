"
" Name:                 sysshep.vim
" Description:          System Shepherd Vim Plugin
" Version:              0.1

" default settings
if !exists('g:sysshep_auth')
  let g:sysshep_auth = []
endif

if !exists('g:sysshep_open_target')
  let g:sysshep_open_target = 'horiz'
endif

if !exists('g:sysshep_reuse_buffer')
  let g:sysshep_reuse_buffer = 1
endif

if !exists('g:sysshep_service_descriptor_header')
  let g:sysshep_service_descriptor_header = 1
endif

" plugin source
function! s:AskForUserInput(message)
  call inputsave()
  let user_input = input(a:message)
  call inputrestore()

  return l:user_input
endfunction

function! s:FindSysShepAuth(fqdn)
  for sysshep_auth in g:sysshep_auth
    if sysshep_auth['fqdn'] == a:fqdn
      return sysshep_auth
    endif
  endfor

  let user = s:AskForUserInput('Enter System Shepherd Username: ')
  let pass = s:AskForUserInput('Enter System Shepherd Password: ')
  let auth = { 'user': l:user, 'pass': l:pass, 'fqdn': a:fqdn }

  " cache auth for this vim session
  call add(g:sysshep_auth, auth)

  return l:auth
endfunction

function! s:ReplaceVariables(url)
  let variable = matchstr(a:url, '{\w\+\(_\w\+\)\?}')

  if l:variable == ''
    " no more variables, return the final url
    return a:url
  else
    let replacement = s:AskForUserInput('Enter replacement for ' . l:variable . ' : ')
    let url = substitute(a:url, l:variable, l:replacement, '')

    return s:ReplaceVariables(l:url)
  endif
endfunction

function! s:BuildSysShepCurlCommand(url)
  let sysshep = '\(core\|alarm\|synops\|config\|webwalkui\|chrome\).\([^\/]\+\)'
  let curl = 'curl -s0'
  let url = s:ReplaceVariables(a:url)

  let fqdn = matchlist(l:url, l:sysshep)
  if len(l:fqdn) > 2 && l:fqdn[2] != ''
    let auth = s:FindSysShepAuth(l:fqdn[2])

    if matchstr(url, 'xml')
      let accept = "application/vnd.absperf.ssac1+xml'"
    else
      let accept = 'application/vnd.absperf.sskj1+json,' .
                 \ 'application/vnd.absperf.ssmj1+json,' .
                 \ 'application/vnd.absperf.ssaj1+json,' .
                 \ 'application/vnd.absperf.sscj1+json,' .
                 \ "application/vnd.absperf.sswj1+json'"
    endif

    let curl = l:curl .
             \ ' --anyauth  -u ' .
             \ shellescape(l:auth['user']) . ':' .
             \ shellescape(l:auth['pass']) .
             \ " -H 'Accept: " . l:accept
  endif

  return l:curl . ' ' . shellescape(l:url)
endfunction

function! s:OpenSysShepBuffer()
  if g:sysshep_open_target == 'tab'
    tabnew
  elseif g:sysshep_open_target == 'horiz'
    new
  elseif g:sysshep_open_target == 'vert'
    vnew
  endif

  set filetype=sysshep
endfunction

function! s:ClearCurrentSysShepBuffer()
  " delete the text in a way that preserves the history.
  execute 'silent! normal! GVggd'
endfunction

function! s:DrawServiceDescriptorHeader(url)
  let application = matchlist(a:url, '\(https\?\)://\(core\|alarm\|synops\|config\|webwalkui\|chrome\).\([^\/]\+\)')

  if len(l:application) > 3
    let home = l:application[1] . '://core.' . l:application[3] . '/service_descriptors'
    let header = '{ "Home": "' . l:home . '" }'
    execute "silent! normal! i\t\t" . l:header . "\n"
  endif
endfunction

function! sysshep#SysShepURLRequest()
  let href = 'https\?://[^ >,;\"]\+'
  let url = matchstr(getline('.'), l:href)

  if l:url != ""
    if &filetype == 'sysshep' && g:sysshep_reuse_buffer > 0
      call s:ClearCurrentSysShepBuffer()
    else
      call s:OpenSysShepBuffer()
    endif

    if g:sysshep_service_descriptor_header > 0
      call s:DrawServiceDescriptorHeader(url)
    endif

    " execute curl command and print to current buffer
    let curl = s:BuildSysShepCurlCommand(l:url)
    execute 'r! ' . l:curl
    execute 'silent! normal! GG'

    " start a search for URLs
    let @/ = l:href
  else
    echo 'SysShep: No URL found.'
  endif
endfunction

" create command

" 'silent! normal! n' is appended to the end of the :SysShepURLRequest command
" to activate search highlighting and move to the first URL
command! -nargs=0 SysShepURLRequest call sysshep#SysShepURLRequest() | silent! normal! n

