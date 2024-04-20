" vimrc ------------------------------------------------------------------------
"
" NOTE: vim9 requires spaces around `=` (for assignment)
"
" See README.md for setup and basic history
"
" tips:
"  http://rayninfo.co.uk/vimtips.html (copied locally)
"  https://github.com/romainl/idiomatic-vimrc/blob/master/idiomatic-vimrc.vim
"  https://stevelosh.com/blog/2010/09/coming-home-to-vim/
"  https://begriffs.com/posts/2012-09-10-bespoke-vim.html
"  https://github.com/mhinz/vim-galore
"
" nice digraph help page:
"  :help digraph-table
"
" 🔒 🔑 ◄ ► ◅ ▻ ◀ ▶ ▲ ▼ ⯇ ⯈ ⯅ ⯆

filetype off
"packloadall " normally done after loading vimrc, uncomment to load earlier
filetype plugin indent on
syntax on

let mapleader=','
let maplocalleader=','

if !exists('g:os')
    if has('win64') || has('win32') || has('win16')
        let g:os='Windows'
    else
        let g:os=substitute(system('uname'), '\n', '', '')
    endif
endif

" base options, see `:options {{{
"  1 important
set nocompatible
"  2 moving around, searching and patterns
set wrap
set incsearch
set ignorecase
set smartcase
"  3 tags
set tags+=tags;/
"  4 displaying text
set scrolloff=5
set nolinebreak
set showbreak=↵
set sidescroll=1
set sidescrolloff=10
set lazyredraw
set list
set listchars=tab:\ \ ,trail:⌴,precedes:❮,extends:❯
"set listchars=tab:\ \ ,trail:_,precedes:❮,extends:❯
set listchars+=tab:⋮\ 
set nonumber
set norelativenumber
"  5 syntax, highlighting and spelling
set synmaxcol=333
set hlsearch
set colorcolumn=+1
let &spellfile=$HOME."/.dict.utf-8.add,.dict.utf-8.add"
"  6 multiple windows
set laststatus=2
set hidden " buffers hidden when abandoned
set splitbelow
set splitright
"  7 multiple tab pages
"  8 terminal
set ttyfast
set title
set titleold=
"  9 using the mouse
" 10 printing
" 11 messages and info
" don't give |ins-completion-menu| messages
set shortmess+=c
set showcmd
set noshowmode " lightline makes this redundant
set ruler
set visualbell
" 12 selecting text
set clipboard=unnamed
" 13 editing text
set undofile
set undodir=~/.tmp/undo/
set undoreload=20000 " save the reload unless > #lines
set textwidth=90
set backspace=indent,eol,start
set formatoptions=cqrn1j
"set dictionary=/usr/share/dict/words
set showmatch
set matchtime=3
" 14 tabs and indenting
set tabstop=4
set shiftwidth=4
set softtabstop=4
set shiftround
set expandtab
set autoindent
" 15 folding
set foldmethod=marker
set foldmarker={{{,}}}
" 16 diff mode
" 17 mapping
" time out on key codes but not mappings
set notimeout
set ttimeout
set ttimeoutlen=10
" 18 reading and writing files
set modelines=2
set backup
set fileformat=unix
set backupskip=/tmp/*,/private/tmp/*,~/.tmp/*
set backupdir=~/.tmp/backup/
set autowriteall
set noautoread
" 19 the swap file
set directory=~/.tmp/swap/
set swapfile
" default (4000ms) is too long and noticeable
set updatetime=1000
" 20 command line editing
set history=9999
set wildmode=full
set wildignore+=.hg,.git,.svn
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg
set wildignore+=*.class,*.jar,*.war
set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest
set wildignore+=*.spl
set wildignore+=*.sw?
set wildignore+=*.DS_Store
set wildignore+=*.pyc
set wildmenu
" 21 executing external commands
" 22 running make and jumping to errors
" 23 language specific
" 24 multi-byte characters
" 25 various
set virtualedit+=block
set gdefault
set viminfo=%,'999,/99,:999
" }}}

" behavior ---------------------------------------------------------------------

" make sure vim returns to the same line when you reopen a file
augroup line_return
    au!
    au BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   execute 'normal! g`"zvzz' |
    \ endif
augroup END

" save all buffers when focus is lost
au FocusLost * :silent! wa

" treat buffers from stdin (e.g.: echo foo | vim -) as scratch
au StdinReadPost * :set buftype=nofile

" the . to execute once for each line of a visual selection, also see repeat plugin
vnoremap . :normal .<CR>
" and same for macros
vnoremap <Leader>@ :normal @

" don't move on first *
nnoremap <silent> * :let stay_star_view=winsaveview()<CR>*:call winrestview(stay_star_view)<CR>

" resize panes when window/terminal gets resize
au VimResized * :wincmd =

" folding ambilvalence
set foldlevelstart=99


" mappings ---------------------------------------------------------------------

" if you have a macbook w/o escape key, see karabiner solution (in specifict config)
" briefly: grave_accent_and_tilde -> esc
"          fn/ctl + grave_accent_and_tilde -> grave_accent_and_tilde
" also, this always works for escape in VIM: <C-[> or <C-c>

" toggle options
nnoremap <Leader>S :setlocal spell!<CR>
nnoremap <Leader>N :setlocal number!<CR>
nnoremap <Leader>P :set paste!<CR>

" center next
"nnoremap n nzzzv
"noremap N Nzzzv
" center changelist
nnoremap g; g;zz
nnoremap g, g,zz

" line movement
noremap H ^
noremap L $
vnoremap L g_
" note in insert/command mode
inoremap <C-a> <Esc>I
inoremap <C-e> <Esc>A
cnoremap <C-a> <home>
cnoremap <C-e> <end>

" natural move
nnoremap <down> gj
nnoremap <up> gk

" open all folds from parent rather than current fold
nnoremap zO zczO
" switch fold
nnoremap <Space> za

" keep the cursor in place while joining lines
nnoremap J mzJ`z
" split line (sister to [J]oin lines)
nnoremap S i<CR><Esc>^mwgk:silent! s/\v +$//<CR>:noh<CR>`w

" add to local dictionary (see spellfile setting, the #2 is the local)
nnoremap zG 2zg

" display the number of matches for the last search
nmap <Leader>/ :%s:<C-R>/::gn<CR>

" half/double spaces, clear trailing spaces
noremap <Leader>W1 mz:%s;^\(\s\+\);\=repeat('   ', len(submatch(0))/2);<CR>:%s/\s\+$//<CR>:let @/=''<CR>`z
noremap <Leader>W2 mz:%s;^\(\s\+\);\=repeat('   ', len(submatch(0))*2);<CR>:%s/\s\+$//<CR>:let @/=''<CR>`z
noremap <Leader>W0 mz:set ts=4 sts=4 et<CR>:retab<CR>:set ts=8 sts=2 noet<CR>:%s;^\(\s\+\);\=repeat('   ', len(submatch(0))/2);<CR>:%s/\s\+$//<CR>:let @/=''<CR>`z

" clean trailing whitespace in entire file
nnoremap <Leader>WW mz:%s/\s\+$//<CR>:let @/=''<CR>`z

" zip right, this should preserve your last yank/delete as well
nnoremap zl :let @z=@"<CR>x$p:let @"=@z<CR>

" underline the current line
nnoremap <Leader>1 yypVr=
nnoremap <Leader>2 yypVr-

" uppercase word in insert mode
inoremap <C-u> <Esc>mzgUiw`za

" panic
nnoremap <F12> mzggg?G`z

" show syntax group(s)
nmap <Leader>ss :call <SID>SynStack()<CR>
" show highlight group(s)
nnoremap <Leader>sh :echo 'hi<'
    \ . synIDattr(synID(line('.'),col('.'),1),'name') . '> trans<'
    \ . synIDattr(synID(line('.'),col('.'),0),'name') . '> lo<'
    \ . synIDattr(synIDtrans(synID(line('.'),col('.'),1)),'name') . '>'<CR>

" listchars
nnoremap <Leader>I :set listchars+=tab:⋮\ <CR>
nnoremap <Leader>i :set listchars-=tab:⋮\ <CR>

" select (charwise) the contents of the current line, excluding indentation.
nnoremap vv ^vg_

" copy/paste using tmp file
vmap <Leader>C :w! ~/.tmp/.pbuf<CR>
nmap <Leader>V :r ~/.tmp/.pbuf<CR>

" quickfix/location list, for nav mappings, see unimpaired
noremap <Leader>cq :ccl<CR>
noremap <Leader>cl :lcl<CR>
" open qf and loc full width
autocmd filetype qf wincmd J

" tags https://github.com/grassdog/dotfiles/blob/master/files/.ctags

" buffer nav
nnoremap <Leader><Space> <C-^>

" mkdir dir(s) that contains the file in the current buffer
nnoremap <Leader>MD :!mkdir -p %:p:h<CR>

" encodings
" also see https://github.com/tpope/vim-unimpaired/

" base64
vnoremap [b c<C-r>=system('base64', @")<Esc>
vnoremap ]b c<C-r>=system('base64 --decode', @")<Esc>
nnoremap [B vi"c<C-r>=system('base64', @")<Esc>
nnoremap ]B vi"c<C-r>=system('base64 --decode', @")<Esc>

" pretty print

" JSON formating: jq is fast and leaves key order, py is slower and sorts the keys
" underscore is compact and has lots of options: https://github.com/ddopson/underscore-cli
vnoremap <Leader>ppjq :!jq '.'<CR>
vnoremap <Leader>ppjr :!jq -r '.'<CR>
vnoremap <Leader>ppjp :!python3 -mjson.tool<CR>
vnoremap <Leader>ppju :!underscore print<CR>
" XML formatting
vnoremap <Leader>ppx :!python3 -c 'import sys;import xml.dom.minidom;s=sys.stdin.read();print(xml.dom.minidom.parseString(s).toprettyxml())'<CR>
" graphql formatting
vnoremap <Leader>ppg :!prettier --parser graphql<CR>
" python formatting
vnoremap <Leader>ppp :!black -q -<CR>


" Insert Abbreviations
iabbrev <buffer> :mdash: —
iabbrev <buffer> :shrug: ¯\_(ツ)_/¯


" functions --------------------------------------------------------------------

function! <SID>SynStack()
    echo join(map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")'), " > ")
endfunc

function! RemoveFancyCharacters()
    let typo={}
    let typo['“"]='"'
    let typo['”']='"'
    let typo['‘']="'"
    let typo['’']="'"
    let typo['–']='--'
    let typo['—']='---'
    let typo["…']='...'
    :exe ":%s/".join(keys(typo), '\|').'/\=typo[submatch(0)]/ge'
endfunction
command! RemoveFancyCharacters :call RemoveFancyCharacters()

" abbrev helpers

function! EatChar(pat)
    let c=nr2char(getchar(0))
    return (c =~ a:pat) ? '' : c
endfunction

" delete the space after, so: abbrev<space> -> expansion
function! MakeSpacelessIabbrev(from, to) " global
    execute "iabbrev <silent> ".a:from." ".a:to."<C-R>=EatChar('\\s')<CR>"
endfunction
function! MakeSpacelessBufferIabbrev(from, to) " buffer local
    execute "iabbrev <silent> <buffer> ".a:from." ".a:to."<C-R>=EatChar('\\s')<CR>"
endfunction


" https://stackoverflow.com/a/5519588
function! DiffLineWithNext()
    let f1=tempname()
    let f2=tempname()

    exec ".write " . f1
    exec ".+1write " . f2

    exec "tabedit " . f1
    exec "vert diffsplit " . f2
endfunction


" https://stackoverflow.com/a/5519588
function! DiffLineWithNext()
    let f1=tempname()
    let f2=tempname()

    exec ".write " . f1
    exec ".+1write " . f2

    exec "tabedit " . f1
    exec "vert diffsplit " . f2
endfunction


" settings/plugins -------------------------------------------------------------

" windows movements
nmap <silent> <C-h> :wincmd h<CR>
nmap <silent> <C-l> :wincmd l<CR>
nmap <silent> <C-j> :wincmd j<CR>
nmap <silent> <C-k> :wincmd k<CR>

" windows redraw
nnoremap <Leader>l :call popup_clear()<CR>:redraw!<CR>

" completions
set complete=.,w,b,u,t,i
set completeopt=menuone,popup

" complete-functions ins-completion
inoremap <C-]> <C-x><C-]>
" http://tilvim.com/2015/01/06/fzf.html
imap <C-l> <Plug>(fzf-complete-line)

" supertab
let g:SuperTabDefaultCompletionType="context"
let g:SuperTabMappingForward="<c-n>"
let g:SuperTabMappingBackward="<c-p>"
let g:SuperTabClosePreviewOnPopupClose=1

" see: help ft-syntax-omni
au Filetype *
    \ if &omnifunc == "" |
    \   setlocal omnifunc=syntaxcomplete#Complete |
    \ endif
" chain supertab
au Filetype *
    \ if &omnifunc != '' |
    \   call SuperTabChain(&omnifunc, "<c-p>") |
    \ endif

" --- fzf {{{ https://github.com/junegunn/fzf.vim
let g:fzf_preview_window=[]
set rtp+=~/bin/.fzf/bin
nmap <Leader>, :Buffers<CR>
nmap <Leader>fc :Colors<CR>
nmap <Leader>ff :Files<CR>
nmap <Leader>fb :Lines<CR>
nmap <Leader>fg :Rg<CR>
nmap <Leader>ft :Tags<CR>

command! -bang -nargs=* GGrep
    \ call fzf#vim#grep(
    \   'git grep --line-number -- '.fzf#shellescape(<q-args>),
    \   fzf#vim#with_preview({'dir': systemlist('git rev-parse --show-toplevel')[0]}), <bang>0)

" Mapping selecting mappings
nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)

" Insert mode completion
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-l> <plug>(fzf-complete-line)

" Path completion with custom source command
inoremap <expr> <c-x><c-f> fzf#vim#complete#path('fd')
inoremap <expr> <c-x><c-f> fzf#vim#complete#path('rg --files')

" Word completion with custom spec with popup layout option
inoremap <expr> <c-x><c-k> fzf#vim#complete#word({'window': { 'width': 0.2, 'height': 0.9, 'xoffset': 1 }})

" Replace the default dictionary completion with fzf-based fuzzy completion
inoremap <expr> <c-x><c-k> fzf#vim#complete('cat /usr/share/dict/words')

" Custom statusline
function! s:fzf_statusline()
  " Override statusline as you like
  highlight fzf1 ctermfg=161 ctermbg=251
  highlight fzf2 ctermfg=23 ctermbg=251
  highlight fzf3 ctermfg=237 ctermbg=251
  setlocal statusline=%#fzf1#\ >\ %#fzf2#fz%#fzf3#f
endfunction

autocmd! User FzfStatusLine call <SID>fzf_statusline()
" -- }}}

" highlighter
let HiFindTool="rg -H --color=never --no-heading --column --iglob"

" ack
let g:ackprg='rg --vimgrep --smart-case --no-heading'
let g:ack_apply_qmappings=1
let g:ackhighlight=1
nnoremap <Leader>G :Ack!<Space>""<left>
xnoremap <Leader>G y:Ack!<Space>"<C-r>""
xnoremap <silent> <Leader>g y:Ack!<Space>"<C-r>"" -w<CR>

"netrw
" The directory for bookmarks and history (.netrwbook, .netrwhist)
let g:netrw_home=$HOME.'/.tmp'
let g:netrw_list_hide='\(^\|\s\s\)\zs\.\S\+'

" Kwbd
nmap <Leader>Q :up<CR><Plug>Kwbd

" `%%` is (command mode) abbrev for current directory
cabbr <expr> %% expand('%:p:h')

" sneak
let g:sneak#label=1

" clam
let g:clam_autoreturn=1
let g:clam_debug=1
let g:clam_winpos='botright'

nnoremap ! :Clam<Space>
vnoremap ! :ClamVisual<Space>

" fugitive
au BufNewFile,BufRead .git/index setlocal nolist

" polyglot
let g:polyglot_disabled=['sensible']

" --- ALE {{{
let g:ale_sign_error='▶'
let g:ale_sign_warning='▷'
let g:ale_echo_msg_format='[%linter%] %code: %%s'

let g:ale_virtualtext_cursor='current'

let g:ale_disable_lsp=1
" ALE provides an omni-completion function you can use for triggering completion manually with <C-x><C-o>
"set omnifunc=ale#completion#OmniFunc

let g:ale_linters_ignore={
    \ 'java': ['javac'],
    \ 'kotlin': ['kotlinc'],
\ }

let g:ale_fixers={
    \ 'javascript': ['prettier', 'eslint'],
    \ 'kotlin': ['ktlint'],
    \ 'python': ['ruff', 'pyrefly'],
\ }

let g:ale_lint_on_text_changed=0
let g:ale_lint_on_insert_leave=1
let g:ale_kotlin_ktlint_options='--verbose'

"If you don't wish to run linters while you type, you can disable that behavior. Set
"g:ale_lint_on_text_changed to never. You won't get as frequent error checking, but ALE
"shouldn't block your ability to edit a document after you save a file, so the
"asynchronous nature of the plugin will still be an advantage.

nmap <Leader>X <Plug>(ale_toggle_buffer)
" https://www.vimfromscratch.com/articles/vim-and-language-server-protocol/
"nmap gd <Plug>(ale_go_to_definition)
"nmap gr <Plug>(ale_find_references)
nmap <F5> <Plug>(ale_hover)
nmap <F8> <Plug>(ale_fix)
" }}}


" filetype/plugins -------------------------------------------------------------

" local vimrc
" set in ~/.vimrc.local if desired: let g:localvimrc_ask=1
let g:localvimrc_name=[".vimrc.local"]

" highlight VCS conflict markers
match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'

au Filetype qf setlocal number colorcolumn=0 nolist nowrap textwidth=0 scrolloff=1

augroup ft_diff
    au FileType diff setlocal foldmethod=expr foldexpr=DiffFoldLevel()
augroup END

" https://github.com/sgeb/vim-diff-fold/ without the extra settings crap. Ie just the folding expr
function! DiffFoldLevel()
    let l:line=getline(v:lnum)

    if l:line =~# '^\(diff\|Index\)' " file
        return '>1'
    elseif l:line =~# '^\(@@\|\d\)' " hunk
        return '>2'
    elseif l:line =~# '^\*\*\* \d\+,\d\+ \*\*\*\*$' " context: file1
        return '>2'
    elseif l:line =~# '^--- \d\+,\d\+ ----$' " context: file2
        return '>2'
    else
        return '='
    endif
endfunction

augroup ft_java
    au!
    au FileType java setlocal tw=100 sts=4 sw=4
    au FileType java setlocal foldmethod=marker
    au FileType java setlocal foldmarker={{{,}}}

    " abbreviations
    "au FileType java iabbrev <buffer> :implog: import org.apache.logging.log4j.Logger;import org.apache.logging.log4j.LogManager;<esc><down>
    "au FileType java iabbrev <buffer> :imppre: import static com.google.common.base.Preconditions.checkArgument;import static com.google.common.base.Preconditions.checkNotNull;import static com.google.common.base.Preconditions.checkState;<esc><down>
    "au FileType java iabbrev <buffer> :tostr:  @Overridepublic String toString() {return ReflectionToStringBuilder.toString(this, ToStringStyle.SHORT_PREFIX_STYLE);<esc><down>
augroup END

augroup ft_kotlin
    au!
    au FileType kotlin setlocal tw=100 sts=4 sw=4
    au FileType kotlin set makeprg=gw

    au FileType kotlin call MakeSpacelessBufferIabbrev('pr>', 'println(">>>>> $")<left><left>')
    au FileType kotlin call MakeSpacelessBufferIabbrev('LOG>', 'LOGGER.info(">>>>> ${}")<left><left><left>')
    au FileType kotlin call MakeSpacelessBufferIabbrev('log>', 'LOGGER.info("${}")<left><left><left>')
augroup END

augroup ft_javascript
    au!
    au FileType javascript setlocal textwidth=99 sts=2 sw=2
    au FileType javascript setlocal foldmethod=syntax

    au FileType javascript call MakeSpacelessBufferIabbrev('pr>', 'console.log(">>>>>", );<left><left>')
augroup END

augroup ft_python
    au!
    au FileType python setlocal textwidth=99
    au FileType python setlocal foldmethod=indent

    au FileType python nnoremap <localleader>e :up<CR>:Clam python %:p<CR>
    au FileType python nnoremap <localleader>E :up<CR>:Clam python <C-R>=expand("%:p")<CR>

    "au FileType python setlocal define=^\s*\\(def\\\\|class\\)
    au FileType python call MakeSpacelessBufferIabbrev('pr>', 'print(f">>>>> {}")<left><left><left>')
    au FileType python call MakeSpacelessBufferIabbrev('log>', 'LOGGER.info(f">>>>> {}")<left><left><left>')

    au FileType python nnoremap <F8> :!black %<CR>
augroup END


" go
let g:go_fmt_command='goimports'
let g:go_fmt_experimental=1
let g:go_doc_keywordprg_enabled=0

augroup ft_go
    au!
    au FileType go setlocal foldmethod=syntax
    au FileType go nnoremap <buffer> <silent> M :GoDoc<CR>
    " this language is incredible
    au FileType go iabbrev <buffer> ernil if err != nil {<CR>return nil, err<esc>jA
    " }
augroup END

augroup ft_text
    set dictionary+=/usr/share/dict/words
augroup END

augroup ft_markdown
    au!
    au Filetype markdown setlocal spell

    " Linkify selected text inline to contents of pasteboard.
    au Filetype markdown vnoremap <buffer> <localleader>l <esc>`>a]<esc>`<i[<esc>`>lla()<esc>"+P

    if g:os == 'Darwin'
        "au Filetype markdown nnoremap <buffer> <localleader>p :up<CR>:!gfm % \|hcat<CR>
        "au Filetype markdown nnoremap <buffer> <localleader>p :up<CR>:silent !gfm % >~/Public/%:t.html<CR>
        "   \ :silent redraw!<CR>
        "   \ :silent !open http://localhost:8088/~$USER/%:t.html<CR>
        "   \ :silent !open ~/Public/%:t.html<CR>
    "else
        "au Filetype markdown nnoremap <buffer> <localleader>p :up<CR>:silent !gfm % >~/public_html/%:t.html<CR>
        "   \ :silent redraw!<CR>
        "   \ :echom "Open http://".system('hostname')[:-2]."/~".$USER."/".expand('%:t').".html"<CR>
        au Filetype markdown nnoremap <buffer> <localleader>p :up<CR>
            \ :silent !gfm --unsafe % >~/Public/%:t.html<CR>
            \ :silent !open ~/Public/%:t.html<CR>
            \ :silent redraw!<CR>
        au Filetype markdown nnoremap <buffer> <localleader>P :up<CR>
            \ :silent !gfm --unsafe % >~/Public/%:t.html<CR>
            \ :silent redraw!<CR>
            \ :echom "Open file:///Users/".$USER."/Public/".expand('%:t').".html"<CR>
    else
        au Filetype markdown nnoremap <buffer> <localleader>p :up<CR>
            \ :silent !gfm --unsafe % >~/public_html/%:t.html<CR>
            \ :silent !gfm --unsafe % >~/public_html/tmp.html<CR>
            \ :silent redraw!<CR>
            \ :echom "Open http://".system('hostname -s')[:-2]."/~".$USER."/".expand('%:t').".html"<CR>
    endif
augroup END

augroup ft_json
    au!
    au FileType json setlocal softtabstop=2 shiftwidth=2
    au FileType json setlocal formatprg=jq\ '.'
augroup END

augroup ft_vim
    au!
    au FileType vim inoremap <C-n> <C-x><C-n>
augroup END

augroup ft_sh
    au!
augroup END
let g:is_bash=1

augroup ft_xml
    au!
    au FileType xml setlocal softtabstop=2 shiftwidth=2

    au FileType xml setlocal foldmethod=manual
    " use <localleader>F to fold the current tag
    au FileType xml nnoremap <buffer> <localleader>F Vatzf
    " Indent tag
    au FileType xml nnoremap <buffer> <localleader>= Vat=
augroup END

augroup ft_yaml
    au!
    au FileType yaml setlocal softtabstop=2 shiftwidth=2
augroup END

augroup ft_html
    au!
    au FileType html setlocal softtabstop=2 shiftwidth=2
    au Filetype html nnoremap <buffer> <localleader>p :up<CR>:!open %<CR>
    au FileType jinja.html setlocal softtabstop=2 shiftwidth=2
    au Filetype jinja.html nnoremap <buffer> <localleader>p :up<CR>:!open %<CR>
augroup END

au BufRead,BufNewFile *.pebble set filetype=twig

augroup ft_vue
    au!
    au FileType vue setlocal textwidth=99 sts=2 sw=2
augroup END

augroup ft_css
    au!
    au FileType css setlocal textwidth=99 sts=2 sw=2
augroup END

augroup ft_make
    au!
    au FileType make setlocal noexpandtab
augroup END

augroup ft_sql
    au!
augroup END
let g:sql_type_default="pgsql"
" dadbod
" using popup menu to select databases, `add(g:dadbods, ..)` in ~/.vimrc.local see:
" https://habamax.github.io/2019/09/02/use-vim-dadbod-to-query-databases.html
command! DBSelect :call popup_menu(map(copy(g:dadbods), {k,v -> v.name}), { "callback": "DBSelected" })

func! DBSelected(id, result)
    if a:result != -1
        let b:db=g:dadbods[a:result-1].url
        echomsg 'DB ' . g:dadbods[a:result-1].name . ' is selected.'
    endif
endfunc

xnoremap <expr> <Plug>(DBExe)     db#op_exec()
nnoremap <expr> <Plug>(DBExe)     db#op_exec()
nnoremap <expr> <Plug>(DBExeLine) db#op_exec() . '_'
xmap <Leader>db  <Plug>(DBExe)
nmap <Leader>db  <Plug>(DBExe)
omap <Leader>db  <Plug>(DBExe)
nmap <Leader>dbb <Plug>(DBExeLine)


" clojure/fireplace/paredit -----

let g:clojure_fold_extra=[
    \ 'defgauge',
    \ 'defsketch'
\ ]

let g:fireplace_no_maps=1

let g:paredit_smartjump=1
let g:paredit_shortmaps=0
let g:paredit_electric_return=1

let g:paredit_matchlines=200
let g:paredit_disable_lisp=1
let g:paredit_disable_clojure=1

augroup ft_clojure
    au!

    au BufNewFile,BufRead *.edn set filetype=clojure

    au FileType clojure silent! call TurnOnClojureFolding()
    au FileType clojure compiler clojure
    au FileType clojure setlocal isk-=.

    au FileType clojure iabbrev <buffer> defun defn

    " Things that should be indented 2-spaced
    au FileType clojure setlocal lispwords+=when-found,defform,when-valid,try,while-let,try+,throw+

    "au FileType clojure RainbowParenthesesActivate
    "au syntax clojure RainbowParenthesesLoadRound

    " Paredit
    au FileType clojure call EnableParedit()
    au FileType clojure nnoremap <buffer> <localleader>( :call PareditToggle()<CR>
    " )

    " Duplicate
    au FileType clojure nnoremap <buffer> [] :call DuplicateLispForm()<CR>

    " Indent top-level form.
    au FileType clojure nmap <buffer> gi mz99[(v%='z
augroup END

function! EnableParedit()
    call PareditInitBuffer()

    " Quit fucking with my split-line mapping, paredit.
    nunmap <buffer> S

    " Also quit fucking with my save file mapping.
    nunmap <buffer> s

    " Please just stop
    nunmap <buffer> <Leader>W
    nunmap <buffer> <Leader>O
    nunmap <buffer> <Leader>S

    " Oh my god will you fuck off already
    " nnoremap <buffer> dp :diffput<CR>
    " nnoremap <buffer> do :diffobtain<CR>

    " Eat shit
    nunmap <buffer> [[
    nunmap <buffer> ]]

    " Better mappings
    noremap <buffer> () :<C-u>call PareditWrap('(', ')')<CR>
    noremap <buffer> )( :<C-u>call PareditSplice()<CR>
    noremap <buffer> (( :<C-u>call PareditMoveLeft()<CR>
    noremap <buffer> )) :<C-u>call PareditMoveRight()<CR>
    noremap <buffer> (j :<C-u>call PareditJoin()<CR>
    noremap <buffer> (s :<C-u>call PareditSplit()<CR>
    noremap <buffer> )j :<C-u>call PareditJoin()<CR>
    noremap <buffer> )s :<C-u>call PareditSplit()<CR>
    " ))
endfunction


" ------------------------------------------------------------------------------
" ui

" try: `:h sign`

augroup CursorLine
    au!
    au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
    au WinLeave * setlocal nocursorline
augroup END
"nnoremap <Leader>c :set cursorline! cursorcolumn!<CR>

" show trailing spaces in non-insert mode
augroup trailing
    au!
    au InsertEnter * :set listchars-=trail:⌴
    au InsertLeave * :set listchars+=trail:⌴
augroup END

" -- lightline {{{
let g:lightline={
    \ 'colorscheme': 'myscheme',
    \ 'separator': { 'left': '', 'right': '' },
    \ 'subseparator': { 'left': '│', 'right': '⋮' },
    \ 'active': {
    \   'left': [ [ 'mode', 'paste' ],
    \             [ 'currentfunction', 'readonly', 'filename', 'modified' ] ]
    \ },
\ }
if has('gui_running')
    let g:lightline.colorscheme='gruvbox8'
endif

function! s:set_lightline_colorscheme(name) abort
    let g:lightline.colorscheme=a:name
    call lightline#init()
    call lightline#colorscheme()
    call lightline#update()
endfunction

function! s:lightline_colorschemes(...) abort
    return join(map(
        \ globpath(&rtp,"autoload/lightline/colorscheme/*.vim",1,1),
        \ "fnamemodify(v:val,':t:r')"),
        \ "\n")
endfunction

command! -nargs=1 -complete=custom,s:lightline_colorschemes LightlineColorscheme
        \ call s:set_lightline_colorscheme(<q-args>)
" }}}

" tmux, see :h xterm-true-color
"let &t_8f="\<Esc>[38:2:%lu:%lu:%lum"
"let &t_8b="\<Esc>[48:2:%lu:%lu:%lum"
if !has('gui_running')
    set t_Co=256
endif

" italics, check if your terminal supports italics: echo -e "\e[3mfoo\e[23m"
" https://www.reddit.com/r/vim/comments/24g8r8/italics_in_terminal_vim_and_tmux/
" https://apple.stackexchange.com/a/267261
set t_ZH=[3m
set t_ZR=[23m

" http://vim.wikia.com/wiki/Change_cursor_shape_in_different_modes
" DECSCUSR 1/2 (block), 3/4 (underline), 5/6 (bar) [blinking/steady]
let &t_SI="\e[5 q"
let &t_EI="\e[2 q"

" gui options
set guicursor=n-c:block-Cursor-blinkon0
set guicursor+=v:block-blinkon0
set guicursor+=i-ci:ver20
" default windows (new term): n-v-c:block-Cursor/lCursor,ve:ver35-Cursor,o:hor50-Cursor,i-ci:ver25-Cursor/lCursor,r-cr:hor20-Cursor/lCursor,sm:block-Cursor-blinkwait175-blinkoff150-blinkon175
"set guioptions=e
" default windows (new term): aegimrLtT
set guioptions=egm

if has('transparency')
    set blurradius=15
    au FocusLost * :set transparency=15
    au FocusGained * :set transparency=0
endif

if has('gui_running')
    set mouse=a
endif

" gui opts
" set guifont in ~/.vimrc, eg:

if g:os == 'Linux'
    set clipboard=unnamedplus
elseif g:os == 'Windows'
    set guioptions+=a
endif

" https://vi.stackexchange.com/questions/12376/vim-on-wsl-synchronize-system-clipboard-set-clipboard-unnamed
let s:clip='/mnt/c/Windows/System32/clip.exe'
if executable(s:clip)
    augroup WSLYank
        autocmd!
        autocmd TextYankPost * :call system(s:clip, @")
    augroup END

    "map <silent> =p ma:r !powershell.exe -Command Get-Clipboard<cr>'a
    "map! <silent> <c-r>= :r !powershell.exe -Command Get-Clipboard<cr>
    "noremap "+p :exe 'norm a'.system('/mnt/c/Windows/System32/WindowsPowerShell/v1.0/powershell.exe -Command Get-Clipboard')<CR>
end

" --- colors
" color names: https://codeyarns.github.io/tech/2011-07-29-vim-chart-of-color-names.html
" See http://vim.wikia.com/wiki/Xterm256_color_names_for_console_Vim

" colorscheme settings
let g:ayu_italic_comment=1
let g:ayu_sign_contrast=1
let g:gruvbox_bold=1
let g:gruvbox_filetype_hi_groups=1
let g:gruvbox_italicize_strings=1
let g:gruvbox_italics=1
let g:gruvbox_plugin_hi_groups=1
let g:gruvbox_transp_bg=1
let g:nord_italic=1

" https://gist.github.com/romainl/379904f91fa40533175dfaec4c833f2f
" NonText for [eol, extends, precedes]; SpecialKey for [nbsp, tab, trail]
augroup my_colors
    au!
    au ColorScheme nord
        \   hi LineNr guibg=#434c5e
        \ | hi SignColumn guibg=#434c5e
        \ | hi ALEErrorSign guibg=#434c5e guifg=Red
        \ | hi ALEWarningSign guibg=#434c5e guifg=Blue
    au ColorScheme iceberg
        \   hi ErrorMsg guifg=#161821 guibg=#e27878
        \ | hi SpecialKey guifg=#444b71
        \ | hi NonText guifg=#89b8c2
    au ColorScheme Tomorrow-Night-Blue
        \   hi SignColumn guibg=Black
        \ | hi SpecialKey ctermfg=67 guifg=#7285b7
        \ | hi NonText ctermfg=14 guifg=Yellow
        \ | hi LineNr ctermbg=19 ctermfg=67 guifg=#7285b7
    au ColorScheme gruvbox
        \   hi LineNr ctermbg=223 guibg=#ebdbb2
        \ | hi Folded ctermbg=14 guifg=Black guibg=#fff7cd
        \ | hi CocInlayHint guifg=#076678 guibg=#ebdbb2 ctermfg=23 ctermbg=NONE cterm=italic gui=italic
    au ColorScheme gruvbox8_soft
        \   hi LineNr ctermbg=223 guibg=#ebdbb2
        \ | hi SignColumn ctermbg=251
        \ | hi Folded ctermbg=14 guifg=Black guibg=#fff7cd
        \ | hi EndOfBuffer ctermfg=6 guifg=#bdae93
augroup END

" set the initial color/background
set background=light
color gruvbox8_soft

" override for console in ~/.vimrc: if !has('gui_running') ..
if &diff
    set nocursorline
    " not sure why nocur doesn't work, just unset colors
    hi CursorLine cterm=NONE ctermbg=NONE guibg=NONE
endif

if $TERM =~# 'kitty'
    set termguicolors
elseif !has('gui_running')
    " console
    set notermguicolors " only 256 colors for mac terminal.app :(
    hi Normal ctermbg=NONE
endif

hi Comment gui=italic cterm=italic
hi SpellBad cterm=undercurl,italic guifg=#d33682

" 117 matches lightline (also can use 24, 31)
au InsertEnter * hi ColorColumn ctermbg=117 guibg=#87dfff
" for dark bg, use 236, #eee8d5/254
au InsertLeave * hi ColorColumn ctermbg=250 guibg=#ebdbb2
" iceberg: au InsertLeave * hi ColorColumn ctermbg=253 guibg=#dcdfe7

" ALE colors
hi ALEVirtualTextError ctermbg=Magenta guibg=Pink cterm=italic gui=italic
hi ALEVirtualTextWarning ctermbg=Cyan guibg=#87dfff cterm=italic gui=italic

" GitGutter gruvbox
hi GitGutterAdd ctermbg=223 guifg=#79740e guibg=#ebdbb2
hi GitGutterChange ctermbg=223 guifg=#426b58 guibg=#ebdbb2
hi GitGutterDelete ctermbg=223 guifg=#9d0006 guibg=#ebdbb2
