"  options in :options
"==============================================================
"  1 important
"  2 moving around, searching and patterns
"  3 tags
"  4 displaying text
"  5 syntax, highlighting and spelling
"  6 multiple windows
"  7 multiple tab pages
"  8 terminal
"  9 using the mouse
" 10 GUI
" 11 printing
" 12 messages and info
" 13 selecting text
" 14 editing text
" 15 tabs and indenting
" 16 folding
" 17 diff mode
" 18 mapping
" 19 reading and writing files
" 20 the swap file
" 21 command line editing
" 22 executing external commands
" 23 running make and jumping to errors
" 24 language specific
" 25 multi-byte characters
" 26 various
"==============================================================
"  1 important
"  2 moving around, searching and patterns

	" change to directory of file in buffer
	set acd
	"	ignore case when using a search pattern
	set ic
	" show match for partly typed search command
	set is
	" override 'ignorecase' when pattern has upper case characters
	set scs

"  3 tags
"  4 displaying text

	" number of screen lines to show around the cursor
	set so=3
	" long lines wrap (local to window)
	set wrap
	" wrap long lines at a character in 'breakat' (local to window)
	set lbr
	" preserve indentation in wrapped text (local to window)
	set bri
	" show the line number for each line (local to window)
	set nu

"  5 syntax, highlighting and spelling

	" highlight all matches for the last used search pattern
	set hls
	" highlight the screen column of the cursor (local to window)
	" set cuc
	" highlight the screen line of the cursor (local to window)
	set cul
	" highlight spelling mistakes (local to window)
	set spell
	" list of accepted languages (local to buffer)
	" set spl=en,cn
	"	"dark" or "light"; the background color brightness
	set bg=dark
	colorscheme gruvbox

"  6 multiple windows
"  7 multiple tab pages
"  8 terminal
"  9 using the mouse
" 10 GUI
" 11 printing
" 12 messages and info

	" show (partial) command keys in the status line
	set sc
	" show cursor position below each window
	set ru
	"unnamed" to use the * register like unnamed register
	"autoselect" to always put selected text on the clipboard
	set cb=unnamed
	" automatically save and restore undo history
	set udf
	" 解决startify无法读取viminfo的问题
	set viminfo='100,n$HOME/.vim/files/info/viminfo

" 13 selecting text
" 14 editing text

	" line length above which to break a line (local to buffer)
	set tw=78
	" margin from the right in which to break a line (local to buffer)
	set wm=2
	"	specifies what <BS>, CTRL-W, etc. can do in Insert mode
	set bs=indent,eol,start

" 15 tabs and indenting

	"	number of spaces a <Tab> in the text stands for (local to buffer)
	set ts=2
	"	number of spaces used for each step of (auto)indent (local to buffer)
	set sw=2
	"	a <Tab> in an indent inserts 'shiftwidth' spaces
	set sta
	"	if non-zero, number of spaces to insert for a <Tab> (local to buffer)
	set sts=2
	"	expand <Tab> to spaces in Insert mode (local to buffer)
	set et
	"	automatically set the indent of a new line (local to buffer)
	set ai
	"	do clever autoindenting (local to buffer)
	set si

" 16 folding
" 17 diff mode
" 18 mapping
" 19 reading and writing files
" 20 the swap file
" 21 command line editing
" 22 executing external commands
" 23 running make and jumping to errors
" 24 language specific
" 25 multi-byte characters

	"	character encoding used in Vim: "latin1", "utf-8"
	set enc=utf-8

" 26 various

syntax enable
filetype plugin on
" enable default package for better %
packadd! matchit
packadd! justify	" justifying text.
" open man in new window
:runtime! ftplugin/man.vim

" autocomplete html && css
" autocmd FileType css set omnifunc=csscomplete#CompleteCSS
" autocmd FileType html set omnifunc=htmlcomplete#CompleteTags

" plugins
" plug manager
" automatic install vim-plug
if empty(glob('~/.vim/autoload/plug.vim'))
	silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
		\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
" start using vim-plug

" Specify a directory for plugins
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

" status bar
Plug 'vim-airline/vim-airline'
	" automatically displays all buffers when there's only one tab open
	let g:airline#extensions#tabline#enabled = 1
	let g:airline_powerline_fonts = 1
Plug 'vim-airline/vim-airline-themes'
	let g:airline_theme='gruvbox'

" alignment
Plug 'junegunn/vim-easy-align'
	" Start interactive EasyAlign in visual mode (e.g. vipga)
	xmap ga <Plug>(EasyAlign)
	" Start interactive EasyAlign for a motion/text object (e.g. gaip)
	nmap ga <Plug>(EasyAlign)

" linting
Plug 'vim-syntastic/syntastic'
	set statusline+=%#warningmsg#
	set statusline+=%{SyntasticStatuslineFlag()}
	set statusline+=%*

	let g:syntastic_always_populate_loc_list = 1
	let g:syntastic_auto_loc_list = 1
	let g:syntastic_check_on_open = 1
	let g:syntastic_check_on_wq = 0

" code completion
" auto install YCM
" make sure python support
function! BuildYCM(info)
	" info is a dictionary with 3 fields
	" - name: name of the plugin
	" - status: 'installed', 'updated' or 'unchanged'
	" - force: set on PlugInstall! or PlugUpdate!
	if a:info.status == 'installed' || a:info.force
		!python3 ./install.py
	endif
endfunction

Plug 'Valloric/YouCompleteMe', { 'do': function('BuildYCM') }

	" autocomplete css html
	let g:ycm_semantic_triggers = {
      \   'css': [ 're!^\s{2}', 're!:\s+' ],
      \   'less': [ 're!^\s{2}', 're!:\s+' ],
      \   'scss': [ 're!^\s{2}', 're!:\s+' ],
      \   'sass': [ 're!^\s{2}', 're!:\s+' ],
      \   'vue': [ 're!^\s{2}', 're!:\s+', '</' ],
      \   'html': [ '</' ],
      \ }

" commenters
Plug 'scrooloose/nerdcommenter'

	" Add spaces after comment delimiters by default
	let g:NERDSpaceDelims = 1
	" Use compact syntax for prettified multi-line comments
	let g:NERDCompactSexyComs = 1
	" Allow commenting and inverting empty lines
	let g:NERDCommentEmptyLines = 1
	" Enable trimming of trailing whitespace when uncommenting
	let g:NERDTrimTrailingWhitespace = 1
	" Enable NERDCommenterToggle to check all selected lines is commented or
	" not
	let g:NERDToggleCheckAllLines = 1

	let g:NERDDefaultAlign = 'none'

	map gcc <Leader>cc
	map gcn <Leader>cn
	map gc<SPACE> <Leader>c<SPACE>
	map gcm <Leader>cm
	map gci <Leader>ci
	map gcs <Leader>cs
	map gcy <Leader>cy
	map gc$ <Leader>c$
	map gcA <Leader>cA
	map gca <Leader>ca
	map gcl <Leader>cl
	map gcb <Leader>cb
	map gcu <Leader>cu

  " handle Vue files
  let g:ft = ''
  function! NERDCommenter_before()
    if &ft == 'vue'
      let g:ft = 'vue'
      let stack = synstack(line('.'), col('.'))
      if len(stack) > 0
        let syn = synIDattr((stack)[0], 'name')
        if len(syn) > 0
          exe 'setf ' . substitute(tolower(syn), '^vue_', '', '')
        endif
      endif
    endif
  endfunction
  function! NERDCommenter_after()
    if g:ft == 'vue'
      setf vue
      let g:ft = ''
    endif
  endfunction

" delimiter
Plug 'jiangmiao/auto-pairs'

" fuzzy finder
Plug 'ctrlpvim/ctrlp.vim'

	" toggle CtrlP
	let g:ctrlp_map = '<SPACE>pp'

" grep tools
" make sure you have ack, ag, pt or rg installed
Plug 'dyng/ctrlsf.vim'

	" toggle CtrlSF
	nmap <SPACE>ff <Plug>CtrlSFPrompt

	" grep current word in visual mode
	vmap <SPACE>ff <Plug>CtrlSFVwordPath

	" grep current word in normal mode
	nmap <SPACE>fn <Plug>CtrlSFCwordPath
	nmap <SPACE>fp <Plug>CtrlSFPwordPath

	" open in current buffer

" indent
Plug 'nathanaelkane/vim-indent-guides'

	" enable indent guides by default
	let g:indent_guides_enable_on_vim_startup = 1

	" customize the size of the indent guide
	" only works for soft-tabs(spaces) and not hard-tabs
	let g:indent_guides_guide_size = 1

	" specify a list of filetypes to disable the plugin for
	let g:indent_guides_exclude_filetypes = ['help', 'nerdtree', 'startify', 'gitconfig', 'gitignore']

" file explorer
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'

	" close vim if the only window left open is a NERDTree
	autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

	" toggle NERDTree
	map <SPACE>tt :NERDTreeToggle<CR>

" motion
" Plug 'justinmk/vim-sneak'
Plug 'easymotion/vim-easymotion'

	" move to {char}
	map <SPACE><SPACE>f <Plug>(easymotion-bd-f)
	nmap <SPACE><SPACE>f <Plug>(easymotion-overwin-f)

	" move to {char}{char}
	nmap s <Plug>(easymotion-overwin-f2)

	" move to line
	map <SPACE><SPACE>l <Plug>(easymotion-bd-jk)
	map <SPACE><SPACE>l <Plug>(easymotion-overwin-line)

	" move to word
	map <SPACE><SPACE>w <Plug>(easymotion-bd-w)
	map <SPACE><SPACE>w <Plug>(easymotion-overwin-w)

" class overview
" Plug 'majutsushi/tagbar'

" snippets
" Plug 'SirVer/ultisnips'

" surround
Plug 'tpope/vim-surround'

" taking notes
Plug 'vimwiki/vimwiki'

" testing
" Plug 'janko-m/vim-test'

" text objects
" Plug 'wellle/targets.vim'

" undo history
" Plug 'mbbill/undotree'

" version control
Plug 'airblade/vim-gitgutter'

" misc
" Plug 'terryma/vim-multiple-cursors'
" start up menu
Plug 'mhinz/vim-startify'
" colorscheme
Plug 'morhetz/gruvbox'
" Plug 'ryanoasis/vim-devicons'
" auto remove search highlight
Plug 'haya14busa/is.vim'

" ftplugin
" HTML
Plug 'othree/html5.vim'
" Plug 'mattn/emmet-vim'

" JavaScript
Plug 'pangloss/vim-javascript'
" Plug 'prettier/vim-prettier'

" Vue
Plug 'posva/vim-vue'

  " prevent syntax highlighting from stopping working randomly
  autocmd FileType vue syntax sync fromstart

" Initialize plugin system
call plug#end()
" use :PlugInstall to install plugins.
