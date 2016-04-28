"---------------- should be in first line
execute pathogen#infect()

"------------------------ vim specific settings
set nocompatible	" Vim Mode
set backspace=indent,eol,start " backspace over everything in VIM
if has("vms")
	set nobackup	" do not keep a backup file, use versions instead
else
	set backup		" keep a backup file
endif
set history=550		" keep 550 lines of command line history
set ruler			" show button ruler
set showcmd			" display incomplete commands

" CTRL-U in insert mode deletes a lot. Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
" Otherwise the whole inserted test would be undone by 'u'.
" Recover_from_accidental_Ctrl-U
inoremap <C-U> <C-G>u<C-U>

if has('mouse')
	set mouse=a
endif

if has("autocmd")
	filetype plugin indent on
	augroup vimrcEx
		au!
		autocmd FileType text setlocal textwidth=78
		" When editing a file, always jump to the last known cursor position.
		autocmd BufReadPost *
					\ if line("'\"") > 1 && line("'\"") <= line("$") |
					\   exe "normal! g`\"" |
					\ endif
	augroup END
else
	set autoindent		" autoindenting on (keeps indent across lines when pressing enter)
endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
if !exists(":DiffOrig")
	command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
				\ | wincmd p | diffthis
endif

" ============================================== My stuff
set virtualedit=all				" cursor virtuell überall
set hidden						" allow hidden buffers
set wildmenu                    " menu tab completion
set wildmode=longest,list,full  " how to do tab completion
"set wildmode=full				" might also be a valid option to try
set nu                          " line numbers
if has("gui_running")
	colorscheme SlateDark
else
	colorscheme SlateDark
endif
"let g:molokai_original = 0

syntax on           " syntax highlighting
set nocursorline
set ignorecase      " search ignore case
set smartcase       " search respect case if Uppercase
set incsearch		" do incremental searching
set hlsearch

"--------------------- command history with c-p and c-n
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>

"--------------------- clear hlsearch
" Use <C-S> to clear the highlighting of :set hlsearch.
if maparg('<C-S>', 'n') ==# ''
	nnoremap <silent> <C-S> :nohlsearch<CR><C-S>
endif

"---------------- fungitive (git)
autocmd BufReadPost fugitive://* set bufhidden=delete
set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P

autocmd User fugitive
			\ if fugitive#buffer().type() =~# '^\%(tree\|blob\)$' |
			\   nnoremap <buffer> .. :edit %:h<CR> |
			\ endif
set diffopt+=vertical

"---------------- matchit plugin
runtime macros/matchit.vim

"--------------- repeat q macro
nnoremap Q @q

"------------------- path for :find
set path+=~/Dropbox/**
set path+=~/wrk/**

"------------ completion
set completeopt=longest,menuone
" inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" inoremap <expr> <C-n> pumvisible() ? '<C-n>' :
"   \ '<C-n><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'

" inoremap <expr> <M-,> pumvisible() ? '<C-n>' :
"   \ '<C-x><C-o><C-n><C-p><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'

"----------------------- ultisnip
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

"--------------------------- leader key
let mapleader=','
noremap \ ,
"set timeoutlen=2000

"--------------------------------- tag list
"nnoremap <silent> <F4> :TlistToggle<CR>

"--------------------- switch backtick and tick
"nnoremap ' `
"nnoremap ` '

"------------------------- ctags
noremap <F8> :!ctags -R<CR>

"----------------------- eng keyboard keys
nmap ü <C-]>
nmap <leader>ü g<C-]>
nmap ö [
nmap ä ]
nmap Ö {
nmap Ä }

omap ü <C-]>
omap <leader>ü g<C-]>
omap ö [
omap ä ]
omap Ö {
omap Ä }

xmap ü <C-]>
xmap <leader>ü g<C-]>
xmap ö [
xmap ä ]
xmap Ö {
xmap Ä }

"----------- text bubbling 2: only works with unimpaired plugin
"Bubble single lines
nmap <A-Up> [e
nmap <A-Down> ]e
" Bubble multiple lines
vmap <A-Up> [egv
vmap <A-Down> ]egv

"------------------ linewise up down but keep cursor
nmap <C-Up> <C-y>
nmap <C-Down> <C-e>

"-------------------------- select text again when copy paste
" Visually select the text that was last edited/pasted
nmap gV `[v`]

"---------------------------- tabularize
let mapleader=','
if exists(":Tabularize")
	nmap <Leader>a= :Tabularize /=<CR>
	vmap <Leader>a= :Tabularize /=<CR>
	nmap <Leader>a: :Tabularize /:\zs<CR>
	vmap <Leader>a: :Tabularize /:\zs<CR>
endif

"------------------------------- gundo
nnoremap <F5> :GundoToggle<CR>

"------------------------------ vimrc
nmap <leader>v :tabedit $MYVIMRC<CR>
" Source the vimrc file after saving it
if has("autocmd")
	autocmd bufwritepost vimrc source $MYVIMRC
endif

" ------------------------------------------- tabstops and indent
set ts=4 sts=4 sw=4 noexpandtab
set cino=N-s   "do not indent namespace when auto indent

" Set tabstop, softtabstop and shiftwidth to the same value
command! -nargs=* Stab call Stab()
function! Stab()
	let l:tabstop = 1 * input('set tabstop = softtabstop = shiftwidth = ')
	if l:tabstop > 0
		let &l:sts = l:tabstop
		let &l:ts = l:tabstop
		let &l:sw = l:tabstop
	endif
	call SummarizeTabs()
endfunction

function! SummarizeTabs()
	try
		echohl ModeMsg
		echon 'tabstop='.&l:ts
		echon ' shiftwidth='.&l:sw
		echon ' softtabstop='.&l:sts
		if &l:et
			echon ' expandtab'
		else
			echon ' noexpandtab'
		endif
	finally
		echohl None
	endtry
endfunction

"--------------------- substitue (repeat sub with same parameters)
nnoremap & :&&<CR>
xnoremap & :&&<CR>

"----------------------------------- wrapping and linebreaks
command! -nargs=* Wrap set wrap linebreak nolist

"----------------------------------- remove white spaces and indent file
function! Preserve(command)
	" Preparation: save last search, and cursor position.
	let _s=@/
	let l = line(".")
	let c = col(".")
	" Do the business:
	execute a:command
	" Clean up: restore previous search history, and cursor position
	let @/=_s
	call cursor(l, c)
endfunction
nmap _$ :call Preserve("%s/\\s\\+$//e")<CR>
nmap _= :call Preserve("normal gg=G")<CR>

"------------------------------- ident with ctrl+cursor keys
nmap <C-Left> <<
nmap <C-Right> >>
vmap <C-Left> <gv
vmap <C-Right> >gv

"----------------------------------------------------- gui
if has("gui_running")
	" Maximize gvim window
	set lines=999 columns=999
	set guioptions -=T    " no toolbar
endif

"-------------------------------------- spell checking
set spelllang=de_de

"--------------------------------------- window movement
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

"------------------------------ wrapped lines (display lines)
vnoremap <Down> gj
vnoremap <Up> gk
"vmap <C-4> g$
"vmap <C-6> g^
"vmap <C-0> g^
nnoremap <Down> gj
nnoremap <Up> gk
"nmap <C-4> g$
"nmap <C-6> g^
"nmap <C-0> g^

"-------------------------------------------------- tabs
" for linux and windows users (using the control key)
map <C-S-]> gt
map <C-S-[> gT
map <C-1> 1gt
map <C-2> 2gt
map <C-3> 3gt
map <C-4> 4gt
map <C-5> 5gt
map <C-6> 6gt
map <C-7> 7gt
map <C-8> 8gt
map <C-9> 9gt
map <C-0> :tablast<CR>

"-------------------------------- fuzzy file ctrl-p
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
map <A-b> :CtrlPBuffer<CR>
let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
let g:ctrlp_working_path_mode = 'rw'
"let g:ctrlp_working_path_mode = 0

"------------------------------- wildignore
"set wildignore+=*/.git/*,*/.hg/*,*/.svn/*

"------------------------------- clipboard interaction
if has('unnamedplus')
	set clipboard=unnamed,unnamedplus
endif

" NERDTree File explorere
"map <C-n> :NERDTreeToggle<CR>
map <F2> :NERDTreeToggle<CR>
map <F3> :NERDTreeFind<CR>
"map <A-.> :NERDTree %:p:h<CR>
"changes cwd each time we set a new root node in NERDTree
"let g:NERDTreeChDirMode = 2
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif "close if last window is nerdtree

"let NERDTreeHijackNetrw=1

"-------------------- path to current file
"autocmd bufenter * silent! lcd %:p:h
map <leader>. :lcd %:p:h<CR>

"------------------------------------- open in current dir
cnoremap %% <C-R>=fnameescape(expand('%:h')).'/'<cr>
map <leader>ew :e %%
map <leader>es :sp %%
map <leader>ev :vsp %%
map <leader>et :tabe %%

"----------------------------------------- tags
set tags=~/wrk/tags
set tags+=~/mira
set tags+=~/mira-pkg

" Use the same symbols as TextMate for tabstops and EOLs
set listchars=tab:▸\ ,eol:¬

"-------------- folding
" toggles current folding
nnoremap <Space> za

"--------------------- ultisnippet
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

""----------------------------------- LATEX
"set grepprg=grep\ -nH\ $*
"let g:tex_flavor='latex'
"set iskeyword+=:
"
""au BufEnter *.tex set autowrite
"let g:Tex_DefaultTargetFormat = 'pdf'
"let g:Tex_MultipleCompileFormats = 'pdf'
"let g:Tex_CompileRule_pdf = 'pdflatex -interaction=nonstopmode $*'
"let g:Tex_GotoError = 0
"let g:Tex_ViewRule_pdf = 'evince'
"let g:Tex_SmartQuoteOpen = '"`'
"let g:Tex_SmartQuoteClose = "\"'"
""let g:Tex_AutoFolding = 0
""let g:Tex_Folding=0

"--------------------------- omni complete
set omnifunc=syntaxcomplete#Complete
set guifont=Monospace\ 14
" set guifont=Source\ Code\ Pro\ Medium\ 14

"let g:miniBufExplMapWindowNavVim = 1
"let g:miniBufExplMapWindowNavArrows = 1
"let g:miniBufExplMapCTabSwitchBufs = 1
"let g:miniBufExplModSelTarget = 1
