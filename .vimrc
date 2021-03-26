" __   _(_)_ __ ___  _ __ ___
" \ \ / / | '_ ` _ \| '__/ __|
"  \ V /| | | | | | | | | (__
"   \_/ |_|_| |_| |_|_|  \___|

" Standarts and sensibles {{{
let mapleader =" "

" Some basics
set nocompatible
filetype plugin on
syntax on
set encoding=utf-8
set number
set relativenumber
set cursorline

" make vim use zsh
set shell=zsh

" vim sensible
set autoindent
set backspace=indent,eol,start
set smarttab
set laststatus=2 " get a window last status (2=always)
set incsearch " show matches wile searchgin
set formatoptions+=j " Delete comment character when joining commented lines
set autoread " update content automatically when a file has been modified externaly
set history=1000 " command history
set tabpagemax=50
set nrformats-=octal " what vim will consider numbers when <C-a>(<C-i> in this vimrc case) or <C-x>
" Allow color schemes to do bright colors without forcing bold.
if &t_Co == 8 && $TERM !~# '^linux\|^Eterm'
  set t_Co=16
endif

" Splits open at the bottom and right, which is non-retarded, unlike vim defaults (larbs.xyz)
set splitbelow
set splitright

" Replace all is aliased to S.
nnoremap S :%s//g<Left><Left>

" Interpret .md files, etc. as .markdown
let g:vimwiki_ext2syntax = {'.Rmd': 'markdown', '.rmd': 'markdown','.md': 'markdown', '.markdown': 'markdown', '.mdown': 'markdown'}

" Make calcurse notes markdown compatible:
autocmd BufRead,BufNewFile /tmp/calcurse*,~/.calcurse/notes/* set filetype=markdown

" Readmes autowrap text:
autocmd BufRead,BufNewFile *.md set tw=79

" Get line, word and character counts with F3:
map <F3> :!wc %<CR>

" Spell-check set to F6:
map <F6> :setlocal spell! spelllang=en_us<CR>

" Automatically deletes all tralling whitespace on save.
autocmd BufWritePre * %s/\s\+$//e

" When shortcut files are updated, renew bash and ranger configs with new material:
autocmd BufWritePost ~/.key_directories,~/.key_files !bash ~/.scripts/tools/shortcuts

" Disables automatic commenting on newline:
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Allow to change buffers without writing
set hidden

" Error bells
set noerrorbells

" Increment/decrement alternatives
" C-a is a tmux custom reserved shortcut
nnoremap <C-i> <C-a>

" Use dot (.) with visual mode
vnoremap . :norm.<CR>

" Set to nolazyredraw in order to have faster buffer change time
set nolazyredraw

" Toggle paste
nnoremap p\ :set paste<CR>
nnoremap p/ :set nopaste<CR>

" Paste (with pbpaste)
nnoremap v\ :.!pbpaste<CR>

" Enable scrolling
set mouse=a

" Be more verbose about stuff generally
set showcmd

set undofile

" Change default directories
set backupdir=~/.vim/backup//
set directory=~/.vim/swap//
set undodir=~/.vim/undo//

" Use spaces
set shiftwidth=2
set softtabstop=2

" Autoload vimrc changes
augroup myvimrc
  au!
  au BufWritePost .vimrc so $MYVIMRC | if has('gui_running') | so $MYGVIMRC | endif
augroup END

" Allow saving of files as sudo when forgot to start vim using sudo.
cmap w!! w !sudo tee > /dev/null %

" No shift to enter commands, use semicolon
nnoremap ; :
vnoremap ; :

" Disable scratch preview window on autocomplete
set completeopt=longest,menuone,preview

" set completeopt-=preview
set pumheight=15

" Modelines
" Modelines are special comments somewhere in a file that can can declare
" certain Vim settings to be used only for that file.
set modelines=1

" Map Esc to jk
inoremap jk <Esc>

" Don't split left nor above
set splitright
set splitbelow

" Next and previous files in buffer
nmap <silent> <leader>, :bp<CR>
nmap <silent> <leader>. :bn<CR>

" Search default
set complete=.,b,u,]               " In the above example it will pull from keywords in the current file, other buffers (closed or still open), and from the current tags file
set wildmode=longest,list:longest  " Read https://robots.thoughtbot.com/vim-you-complete-me
set completeopt=menu,preview       " Default menu
imap <Tab> <C-P>

" search down into subfolders
" provides tab-completion for all file-related tasks
set path+=**

" Display all matching files when we tab complete
set wildmenu
set backupcopy=yes
" }}}
" Languages {{{
" JSX {{{
" highlight jsx in regular .js files
let g:jsx_ext_required = 0
" }}}
" JSON {{{
let g:vim_json_syntax_conceal = 0 " disable quotes hiding
let g:vim_json_warnings=1         " error warnings

" Format JSON with python json.tool
function FormatJSON(...)
  let code="\"
        \ var i = process.stdin, d = '';
        \ i.resume();
        \ i.setEncoding('utf8');
        \ i.on('data', function(data) { d += data; });
        \ i.on('end', function() {
        \     console.log(JSON.stringify(JSON.parse(d), null,
        \ " . (a:0 ? a:1 ? a:1 : 2 : 2) . "));
        \ });\""
  execute "%! node -e " . code
endfunction

" Map FormatJSON function to f-j
nmap <leader>fj :<C-U>call FormatJSON(v:count)<CR>
" }}}
" JsDoc {{{
let g:jsdoc_enable_es6=1
" }}}
" ES6 mjs {{{
au BufNewFile,BufRead *.mjs set filetype=javascript
" }}}
" Syntaxes for unknown or new file extensions {{{
autocmd BufNewFile,BufRead *.php set syntax=php
autocmd BufNewFile,BufRead *.prisma set syntax=graphql
autocmd BufNewFile,BufRead *.mdx set syntax=markdown
autocmd BufNewFile,BufRead *.todos set syntax=todos
" }}}
" }}}
" UX {{{
" Toggle line numbers
nnoremap n\ :set number relativenumber<CR>
nnoremap n/ :set nonumber norelativenumber<CR>

" Show vertical line
augroup ColorcolumnOnlyInInsertMode
  autocmd!
  autocmd InsertEnter * setlocal colorcolumn=80
  autocmd InsertLeave * setlocal colorcolumn=0
augroup END

" Briefly highlight matching brackets on close/open
set showmatch

" No wrapping
set nowrap

" In case there is wrapping; break lines with correct indentation
set breakindent

" Allow scrolling past the bottom of the document
set scrolloff=1

" Set color for folded text, see chart
" https://upload.wikimedia.org/wikipedia/en/1/15/Xterm_256color_chart.svg
hi Folded ctermbg=236

" Don't break mid word
set linebreak

" Spell visual config
highlight SpellBad      ctermfg=Red         term=Reverse        guisp=Red gui=undercurl   ctermbg=Black
highlight SpellCap      ctermfg=Green       term=Reverse        guisp=Green gui=undercurl   ctermbg=Black
highlight SpellLocal    ctermfg=Cyan        term=Underline      guisp=Cyan gui=undercurl   ctermbg=Black
highlight SpellRare     ctermfg=Magenta     term=underline      guisp=Magenta gui=undercurl   ctermbg=Black
" }}}
"Colors {{{
" General
syntax enable
set t_Co=256

" Color scheme
let g:enable_bold_font = 1
set background:dark
colorscheme dracula

" fix dracula Pmenu (https://github.com/dracula/vim/issues/14)
hi Pmenu ctermfg=NONE ctermbg=236 cterm=NONE guifg=NONE guibg=#64666d gui=NONE
hi PmenuSel ctermfg=NONE ctermbg=24 cterm=NONE guifg=NONE guibg=#204a87 gui=NONE
" Visual selection colors
hi Visual term=reverse cterm=reverse guibg=Grey
" Search selection colors
hi Search ctermbg=yellow ctermfg=black
" }}}
" IdleHighlight {{{
" Highlight all instances of word under cursor, when idle.
" Useful when studying strange source code.
" Type z/ to toggle highlighting on/off.
nnoremap z/ :if AutoHighlightToggle()<Bar>set hls<Bar>endif<CR>
function! AutoHighlightToggle()
  let @/ = ''
  if exists('#auto_highlight')
    au! auto_highlight
    augroup! auto_highlight
    setl updatetime=4000
    echo 'Highlight current word: off'
    return 0
  else
    augroup auto_highlight
      au!
      au CursorHold * let @/ = '\V\<'.escape(expand('<cword>'), '\').'\>'
    augroup end
    setl updatetime=500
    echo 'Highlight current word: ON'
    return 1
  endif
endfunction
" }}}
" Fold {{{
" Mappings to foldmethod
nnoremap fms :set foldmethod=syntax<CR>
nnoremap fmm :set foldmethod=manual<CR>
" }}}
" Macros {{{
" git
let @r="3j0wy$3kP" " set tag version => for git fow
let @j="0gg4j$2T-y$gg0o #p0gU$O" " For finding and adding the branch's ticket code
" for cleaning up an import statement (removing both src/ and .js ocurences)
let @k="V:s#src/##gV:s/\.js\//gz/z/"
" }}}
" Navigation {{{
let g:netrw_banner = 0
let g:netrw_liststyle = 3
" }}}
" Search {{{
" control search highlight
nnoremap s\ :set hlsearch<CR>
nnoremap s/ :nohlsearch<CR>

set incsearch  " search as characters are entered
set ignorecase " search ignores case
set hlsearch   " highlight matches"
" }}}
" Plugin options {{{
" Ale linter {{{
let g:ale_completion_enabled = 0
let g:ale_linter_aliases = {'jsx': ['css', 'javascript']}
let g:ale_linters = {
\  'jsx': ['stylelint', 'eslint'],
\  'tsx': ['stylelint', 'eslint'],
\  'ts': ['stylelint', 'eslint']
\}
let g:ale_sign_column_always = 1

let g:ale_sign_error = '✖'
let g:ale_sign_warning = '»'

highlight ALEErrorSign ctermbg=red
highlight ALEWarning ctermbg=DarkMagenta

let g:ale_fixers = {
\   'javascript': ['prettier'],
\   'css': ['prettier'],
\}

let g:ale_fix_on_save = 1

" use ctrl-k and ctrl-j for navigating between errors
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

" disable highlight colors
let g:ale_set_highlights = 0
" }}}
" CtrlP {{{
 let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']
" }}}
" Coc {{{
" if hidden is not set, TextEdit might fail.
set hidden

" Some server have issues with backup files, see #649
set nobackup
set nowritebackup

" Better display for messages
set cmdheight=2

" Smaller updatetime for CursorHold & CursorHoldI
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> for trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> for confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[c` and `]c` for navigate diagnostics
nmap <silent> [o <Plug>(coc-diagnostic-prev)
nmap <silent> ]o <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K for show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if &filetype == 'vim'
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
vmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
vmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Use `:Format` for format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` for fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Using CocList
" Show all diagnostics
nnoremap <silent> <space>oa  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>oe  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>oc  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>oo  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>os  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>oj  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>ok  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>op  :<C-u>CocListResume<CR>

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

" To open coc-explorer
nmap <leader>e :CocCommand explorer<CR>

"Reveal to current buffer for closest coc-explorer
nnoremap <Leader>er :call CocAction('runCommand', 'explorer.doAction', 'closest', ['reveal:0'], [['relative', 0, 'file']])<CR>
" }}}
" Emmet {{{
let g:user_emmet_leader_key='<C-E>' " c-e-,
let g:user_emmet_settings = {
\  'javascript.jsx' : {
\      'extends' : 'jsx',
\  },
\}
" }}}
" FastFold {{{
let g:markdown_folding = 1
let g:javaScript_fold = 1
let g:sh_fold_enabled= 7
" }}}
" fzf {{{
nnoremap <C-f> :Rg<CR>
nnoremap <C-p> :Rg<CR>
nnoremap <Leader>/ :Buffers<CR>
" [Buffers] Jump to the existing window if possible
let g:fzf_buffers_jump = 1
" Mapping selecting mappings
nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)

" Insert mode completion
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)

" Advanced customization using Vim function
inoremap <expr> <c-x><c-k> fzf#vim#complete#word({'left': '15%'})

" Search for notes on notes/
map <silent> <leader>nn :FZF ~/notes<cr>
" }}}
" JsDoc{{{
let g:jsdoc_allow_input_prompt = 1
let g:jsdoc_input_description = 1
let g:jsdoc_returno = 1
let g:jsdoc_return_type = 1
let g:jsdoc_enable_es6 = 1
" }}}
" Ledger{{{
let g:ledger_fold_blanks = 1
let g:ledger_decimal_sep = ','
" au FileType ledger nnoremap <Tab> :call ledger#align_amount_at_cursor()<CR>

au FileType ledger inoremap <silent> <Tab> <C-r>=ledger#autocomplete_and_align()<CR>
au FileType ledger vnoremap <silent> <Tab> :LedgerAlign<CR>

au FileType ledger set foldmethod=syntax
" }}}
" MiniBufferExplorer {{{
" map ctrl-l to toggle MiniBufferExplorer
nmap <silent> <leader>l :MBEToggle<CR>
" }}}
" Mundo {{{
nmap <silent> <leader>m :MundoToggle<CR>
" }}}
" Ranger {{{
map \ :Ranger<CR>
map <leader>r :RangerWorkingDirectory<CR>
" open ranger when vim open a directory
let g:ranger_replace_netrw = 1
" }}}
" Rooter {{{
nnoremap <Leader>h :Rooter<CR>
" }}}
" Startify {{{
let g:startify_custom_header = []
nnoremap <Leader>s :Startify<CR>
" }}}
" gitgutter {{{
let g:gitgutter_async = 0
autocmd BufWritePost * GitGutter
" }}}
" git blame {{{
nnoremap <Leader>b :<C-u>call gitblame#echo()<CR>
" }}}
" tig {{{
nnoremap <Leader>t :TigOpenProjectRootDir<CR>
nnoremap <Leader>T :TigOpenCurrentFile<CR>
" }}}
" vim-javascript {{{
" enable jsdoc syntax
let g:javascript_plugin_jsdoc = 1
" }}}
" UtilSnips {{{
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-m>"
let g:UltiSnipsJumpBackwardTrigger="<c-,>"
" }}}
"}}}

" vim:foldmethod=marker:foldlevel=0
