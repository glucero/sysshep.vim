Usage:
-------

create an http request for the URL under the cursor and open the response body

    :SysShepURLRequest

create a key map to make it easier

    nnoremap SS :SysShepURLRequest<CR>

navigation

    use n/N to move between URLs
    use u/C-r to step through history

urls with {variable} strings will prompt the user for a replacement

Configuration:
-------

store your information for each portal if you don't want to be prompted for a username and password on each request

    default: g:sysshep_auth is an empty array

    let g:sysshep_auth = [
      \ { 'user': 'local_user', 'pass': 'local_pass', 'fqdn': 'ssbe.localhost'         },
      \ { 'user': 'dev_user',   'pass': 'dev_pass',   'fqdn': 'dev.ssbe.url'           },
      \ { 'user': 'prod_user',  'pass': 'prod_user',  'fqdn': 'production.sysshep.com' }]

open System Shepherd request in new tab, horizontal split or vertical split

    default: 'horiz' (horizontal split)

    let g:sysshep_open_target = 'horiz'
    let g:sysshep_open_target = 'vert'
    let g:sysshep_open_target = 'tab'

reuse the current sysshep buffer when printing the response body. turning this off will create a new buffer for each request.

    default: 1 (on)

    let g:sysshep_reuse_buffer = 0
    let g:sysshep_reuse_buffer = 1

create a link for the current System Shepherd portal's service descriptors at the top of the buffer

    default: 1 (on)

    let g:sysshep_service_descriptor_header = 0
    let g:sysshep_service_descriptor_header = 1

Requirements:
------------

* Vim
* A Valid System Shepherd Monitoring account

