sysshep.vim is Vim plugin to navigate System Shepherd web services

Usage:
-------

    put your cursor over a URL and execute the command (or keymapping)

    a navigatable buffer is created from the response body of a curl request

    use n/N to move between URLs
    use u/C-r to step through history

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

Requirements
------------

* Vim
* A Valid System Shepherd Monitoring Portal Account

License
-------

    Copyright (C) 2013 Gino Lucero

    Permission is hereby granted, free of charge, to any person obtaining a
    copy of this software and associated documentation files (the "Software"),
    to deal in the Software without restriction, including without limitation
    the rights to use, copy, modify, merge, publish, distribute, sublicense,
    and/or sell copies of the Software, and to permit persons to whom the
    Software is furnished to do so, subject to the following conditions:

    The above copyright notice and this permission notice shall be included in
    all copies or substantial portions of the Software.

    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
    THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
    FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
    DEALINGS IN THE SOFTWARE.

