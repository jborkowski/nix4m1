
filetype plugin indent on
set backspace=indent,eol,start
"set backup
"set backupdir=~/.vim/.backup//
set dir=~/.vim/.swp//
set encoding=utf-8
set expandtab
set exrc
set history=50
set hlsearch
set incsearch
set laststatus=2
set nocompatible
set number
set ruler
set shiftwidth=2
set showcmd
set showmatch
set autoindent
set nocindent
set smartindent
set softtabstop=2
set t_Co=256
set ts=2
syntax enable
set encoding=utf-8
set nocompatible
set clipboard=unnamed
set clipboard+=unnamedplus

colorscheme nord

" let g:doom_one_terminal_colors = v:true

let mapleader=","
let g:org_export_emacs="~/.nix-profile/bin/emacs"
let g:rg_command = 'rg --vimgrep -S'

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
let g:airline_powerline_fonts = 1
let g:airline_theme = 'nord'
let g:airline#extensions#tabline#buffer_idx_mode = 1

if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

nnoremap <leader>h  :History<CR>
nnoremap <leader>m  :Marks<CR>
nnoremap <leader>S  :Snippets<CR>

nmap <leader>1 <Plug>AirlineSelectTab1
nmap <leader>2 <Plug>AirlineSelectTab2
nmap <leader>3 <Plug>AirlineSelectTab3
nmap <leader>4 <Plug>AirlineSelectTab4
nmap <leader>5 <Plug>AirlineSelectTab5
nmap <leader>6 <Plug>AirlineSelectTab6
nmap <leader>7 <Plug>AirlineSelectTab7
nmap <leader>8 <Plug>AirlineSelectTab8
nmap <leader>9 <Plug>AirlineSelectTab9
nmap <leader>h <Plug>AirlineSelectPrevTab
nmap <leader>l <Plug>AirlineSelectNextTab
nmap <leader><left> <Plug>AirlineSelectPrevTab
nmap gt <Plug>AirlineSelectPrevTab
nmap <leader><right> <Plug>AirlineSelectNextTab
nmap gT <Plug>AirlineSelectNextTab


"Standard vimrc stuff
"-------------------------

"Convenience
"-------------------------
"Make ";" synonymous with ":" to enter commands
nmap ; :

let mapleader=","

" vv to generate new vertical split
" nnore map <silent> vv <C-w>v

"Open tag in vertical split
map <leader>] :vsp <CR>:exec("tag ".expand("<cword>"))<CR>
map <leader>w :%s/\s\+$//e<CR>
"C-x as a shortcut for exiting Goyo, save the file and exit Vim altogether
:map <C-X> <ESC>:x<CR>:x<CR>


function! GotoJump()
  jumps
  let j = input("Please select your jump: ")
  if j != ''
    let pattern = '\v\c^\+'
    if j =~ pattern
      let j = substitute(j, pattern, '', 'g')
      execute "normal " . j . "\<c-i>"
    else
      execute "normal " . j . "\<c-o>"
    endif
  endif
endfunction
nmap <Leader>j :call GotoJump()<CR>


set mouse=a
if !has('nvim')
  set ttymouse=sgr
endif

"Escape
"-------------------------
if has('nvim')
  set ttimeoutlen=10
endif

"Ctrl-O/P to open files
"-------------------------
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'Files'
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_lazy_update = 10
nnoremap <C-o> :CtrlPBuffer<CR>
inoremap <C-o> <Esc>:CtrlPBuffer<CR>


"Use ag/silver-searcher for faster and more configurable search
if executable('ag')
  set grepprg=ag\ --nogroup\ --nocolor\ --smart-case
  let g:ctrlp_user_command = 'ag %s -i --nocolor --nogroup --hidden --smart-case
                              \ --ignore .git
                              \ --ignore .svn
                              \ --ignore .hg
                              \ --ignore amazonka
                              \ --ignore="*.dyn_hi"
                              \ --ignore="*.dyn_o"
                              \ --ignore="*.p_hi"
                              \ --ignore="*.p_o"
                              \ --ignore="*.hi"
                              \ --ignore="*.o"
                              \ -g ""'
endif

cnoreabbrev Ag Ag!
nnoremap <Leader>a :Ag!<Space>

"Use a custom <CR> handler
"inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
" function! s:my_cr_function()
  " return neocomplcache#smart_close_popup() . "\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? neocomplcache#close_popup() : "\<CR>"
" endfunction

"<TAB>: completion.
  inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

"Close popup
" inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
" inoremap <expr><C-y>  neocomplcache#close_popup()
" inoremap <expr><C-e>  neocomplcache#cancel_popup()
" <BS>: delete backword char
" inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"

" NERDTree
"-------------------------
map <leader>\ :NERDTreeToggle<CR>
let NERDTreeIgnore = [ '\.js_dyn_o', '\.js_hi', '\.js_o', '\.js_dyn_hi', '\.dyn_hi', '\.dyn_o', '\.hi', '\.o', '\.p_hi', '\.p_o' ]
"Automatically close if NERDTree is the only buffer left
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" FZF Hoogle
"-------------------------
let g:hoogle_fzf_cache_file = '~/.cache/fzf-hoogle/cache.json'
nnoremap <leader>h :Hoogle <CR>

" vim-which-key
"-------------------------
nnoremap <silent> <leader> :WhichKey ','<CR>

"Saving
"-------------------------
" If the current buffer has never been saved, it will have no name,
" call the file browser to save it, otherwise just save it.
command -nargs=0 -bar Update if &modified
                          \|    if empty(bufname('%'))
                          \|        browse confirm write
                          \|    else
                          \|        confirm write
                          \|    endif
                          \|endif
"<C-s> to save
nnoremap <silent> <C-s> :<C-u>Update<CR>
inoremap <C-s> <C-o>:Update<CR>

"TODO
"-------------------------
" Add TODO highlighting for all filetypes
augroup HiglightTODO
    autocmd!
        autocmd WinEnter,VimEnter * :silent! call matchadd('Todo', 'TODO', -1)
        augroup END
