"---------------------------------
" encoding
"---------------------------------
set termencoding=utf-8
set fileformats=unix
set encoding=utf-8
set fileencodings=utf-8,euc-jp,iso2022-jp,shift-jis,utf-16,ucs-2-internal,ucs-2

"---------------------------------
" Vim general, system
"---------------------------------
" Vi improved
set nocompatible
" set where to place swap files
set directory=~/.swp
" dir to search runtime file 
set runtimepath+=$HOME/.vim,/$HOME/.vim/colors,$HOME/.vim/syntax,$HOME/.vim/,$HOME/.vim/ftpplugin
" when macvim
if has('gui_macvim')
	set transparency=3
	set guifont=Menlo:h21
	set lines=90 columns=200
	set guioptions-=T
endif

if has('vim_starting')
	set runtimepath+=$HOME/.vim/bundle/neobundle.vim/
endif
call neobundle#rc(expand('~/.vim/bundle/'))

"---------------------------------
"  Editor Views
"---------------------------------
" no splash
set shortmess+=I
" show title
set title
" enable mode line
set modeline
" show wildmenu
set wildmenu
" show line numbers
set nu
" print coordinates of cursor at right-bottom
set ruler
"show vim command on status line
set showcmd
" show line under current cursor
set cursorline
" place cursor always on center of screen
set scrolloff=999
" fold every high level indented lines: function, loop e.t.c
set foldlevel=0
" fold by syntax : func, loop, e.t.c
set foldmethod=syntax
" highlight folded
highlight Folded     gui=none guifg=#804030 guibg=#fff0d0 ctermbg=darkgrey  ctermfg=blue  cterm=bold
" DISABLED :  highlight foldcolumn
"highlight FoldColumn gui=none guifg=#6b6b6b guibg=#e7e7e7 ctermfg=black ctermbg=white
" visible TAB/EOL
set list
" char of visible TAB/EOL
set listchars=tab:^_,trail:~
" specify color scheme
colorscheme minecolor
" set background
set background=dark
" set cursorline color
highlight CursorLine ctermfg=Red
cnoremap <expr> /  getcmdtype() == '/' ? '\/' : '/'
cnoremap <expr> ?  getcmdtype() == '?' ? '\?' : '?'

"---------------------------------
"  Searching
"---------------------------------
" care cases in word iff includes upper case
set smartcase
" loops the search
set wrapscan
" enable start search when typing words
set incsearch
" ignore upper/lower-case when searching
set ignorecase
" hilight searched world
set hlsearch
" automatically modify / to \/ when searching


"---------------------------------
"  Syntax, Editing
"---------------------------------
" auto indentation when pressed ENTER key
syntax on
" do smart indent(?) : no effenct when cindent is on
set smartindent
" default shown tab length
set tabstop=8
"set shiftwidth=8
" don't insert spaces as TAB
set noexpandtab
" := indent,eol,start : allow backspacing over autoindent, linebreaks, startofline
set backspace=2
" don't insert space when concatenated japanese lines
set formatoptions+=mM


"---------------------------------
" gtags 
"---------------------------------
" Ctr  + t 	: input Gtags
" Ctrl + h 	: grep current src with indicated word
" Ctrl + i	: List functions in opened file
" Ctrl + j	: Jump to the function indicated
" Ctrl + n	: jump to next search entry
" Ctrl + p	: jump to previous ...
":Gtags funcname	: jump to src defined funcname
":Gtags -r funcname	: jump to src refered funcnam
":Gtags -f filename	: list funcs
"global -c funcname-p	: list funcnames includes partial funcname-p
":Gtags -g word		: grep source code with word
map <C-a> :Gtags
map <C-h> :Gtags -gl<CR>
map <C-i> :Gtags -f %<CR>
map <C-j> :GtagsCursor<CR>
map <C-n> :cn<CR>
map <C-p> :cp<CR>


"---------------------------------
" Language specific
"---------------------------------
filetype on 
filetype indent on
filetype plugin on
"" language spacific settings
" Gauche
autocmd FileType scheme :let is_gauche=1
" ruby
autocmd FileType rb setlocal shiftwidth=2 softtabstop=2  expandtab
autocmd FileType ruby,eruby setlocal softtabstop=2 shiftwidth=2 expandtab
"let g:neocomplcache_omni_patterns.ruby = '[^. *\t]\.\w*\|\h\w*::'
autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
" scala
autocmd FileType scala setlocal softtabstop=2 shiftwidth=2 expandtab
" tex
set shellslash
set grepprg=grep\ -nH\$*
let g:tex_flavor='platex'
let g:Tex_DefaultTargetFormat='pdf'
let g:Tex_CompileRule_pdf='xelatex $*'
let g:Tex_ViewRule_pdf='/usr/bin/open -a /Applications/Preview.app'
" go
au BufRead,BufNewFile *.go set filetype=go


"---------------------------------
" change status line color in INPUT MODE
"---------------------------------
let g:hi_insert = 'highlight StatusLine guifg=darkblue guibg=darkyellow gui=none ctermfg=blue ctermbg=yellow cterm=none'

if has('syntax')
	augroup InsertHook
		autocmd!
		autocmd InsertEnter * call s:StatusLine('Enter')
		autocmd InsertLeave * call s:StatusLine('Leave')
	augroup END
endif

let s:slhlcmd = ''
function! s:StatusLine(mode)
	if a:mode == 'Enter'
		silent! let s:slhlcmd = 'highlight ' . s:GetHighlight('StatusLine')
		silent exec g:hi_insert
	else
		highlight clear StatusLine
		silent exec s:slhlcmd
	endif
endfunction

function! s:GetHighlight(hi)
	redir => hl
	exec 'highlight '.a:hi
	redir END
	let hl = substitute(hl, '[\r\n]', '', 'g')
	let hl = substitute(hl, 'xxx', '', '')
	return hl
endfunction

"---------------------------------
" Show ZENKAKU space
"---------------------------------
function! ZenkakuSpace()
	highlight ZenkakuSpace cterm=underline ctermfg=darkgrey gui=underline guifg=darkgrey
	silent! match ZenkakuSpace /$B!!(B/
endfunction
if has('syntax')
	augroup ZenkakuSpace
		autocmd!
		autocmd VimEnter,BufEnter * call ZenkakuSpace()
	augroup END
endif

"--------------------------------
" highlight > 80 character line
" 	from http://vim-users.jp/2011/05/hack217/
"--------------------------------
set textwidth=80
if exists('&colorcolumn')
	set colorcolumn=+1
endif

"--------------------------------
" plugins
"--------------------------------

"--------------------------------
" Neobundle 
"--------------------------------
NeoBundle 'Shougo/neobundle.vim'
NeoBundle 'Shougo/neocomplcache'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/vinarise'
NeoBundle 'Shougo/vimfiler'
"NeoBundle 'taglist.vim'
"NeoBundle 'Source-Explorer-srcexpl.vim'
"NeoBundle 'scrooloose/syntastic'
NeoBundle 'hail2u/vim-css3-syntax'
NeoBundle 'othree/html5.vim'
NeoBundle 'othree/html5-syntax.vim'
NeoBundle 'pangloss/vim-javascript'
NeoBundle 'tpope/vim-fugitive'

filetype plugin indent on

"---------------------------------
" NeocomplCache
"---------------------------------
" User neocomplcache
let g:neocomplcache_enable_at_startup = 0
" Use smart case : ignore Upper/lower-case till uppercase entered
let g:neocomplcache_enable_smart_case = 1
" use camel case compl
let g:neocomplcache_enable_camel_case_completion = 1
" enable underbar completion
let g:neocomplcache_enable_underbar_completion = 1
" enable fuzzy compl
let g:neocomplcache_enable_fuzzy_completion = 0
" set minimum cached syntax length to 3 (4 by default)
let g:neocomplcache_min_syntax_length = 3
" set auto compl len
let g:neocomplcache_auto_completion_start_length = 2
" set manual compl len
let g:neocomplcache_manual_completion_start_length = 0

" place for snippets file
let g:neocomplcache_snippets_dir = '~/.vim/snippets'
" unknown. maybe ruby?
let g:neocomplcache_omni_patterns = {
			\ 'ruby' : '[^. *\t]\.\w*\|\h\w*::'
			\}
" neocomplcache lang specific dictionary
let g:neocomplcache_dictionary_filetype_lists = {
			\ 'default' : '',
			\ 'ruby' : $HOME . '/.vim/dict/ruby.dict'
			\}

"---------------------------------
" format.vim 
"---------------------------------
let format_allow_over_tw=1

"--------------------------------
" source explorer
"--------------------------------
" refresh rate (msec)
let g:SrcExpl_RefreshTime = 1
" window Height of SrcExpl window
let g:SrcExpl_winHeight = 8
" toggle to srcexpl
nmap <F7> :SrcExplToggle<CR>
" go back from srcexpl
let g:SrcExpl_GoBackMapKey = "<F6>>"
" Set Jump key into exact definition
let g:SrcExpl_jumpKey = "<F5>"
" plugins
 let g:SrcExpl_pluginList = [
         \ "__Tag_List__",
         \ "_NERD_tree_",
         \ "Source_Explorer"
     \ ]
" update tag file
let g:SrcExpl_updateTagsKey = "<F12>"
" local definition search
let g:SrcExpl_searchLocalDef = 1
" ctags
let g:SrcExpl_updateTagsCmd = "exctags --sort=foldcase -R . "


"--------------------------------
" pathogen
"--------------------------------
call pathogen#infect()
syntax on
filetype plugin indent on

"--------------------------------
" syntastic 
"--------------------------------
"let g:syntastic_mode_map = { 'mode': 'active',
"	\ 'active_filetypes': [],
"	\ 'passive_filetypes': ['html', 'less'] }
"let g:syntastic_enable_signs=1
"let g:syntastic_auto_jump=1
"let g:syntastic_auto_loc_list=2
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*

"--------------------------------
" vim-filer
"--------------------------------
let g:vimfiler_as_default_explorer = 1

"---------------------------------
" ctags 
"---------------------------------
" C-\ to jump to definition in vertically split
map <C-\> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>

"---------------------------------
" html5
"---------------------------------
let g:html5_event_handler_attributes_complete = 1
let g:html5_rdfa_attributes_complete = 1
let g:html5_microdata_attributes_complete = 1
let g:html5_aria_attributes_complete = 1
