" VIM configuration

" show line numbers
set number

" highlight search
set hlsearch

" status line settings
set laststatus=2      
set noruler           
set showmode          
" status line format  
"   black background  
"set statusline=%1*   
"   filename and number of lines in it
set statusline+=%f\ +%l\ (%L\ lines)  
"   print amount of selected area if it is
set statusline+=\ %{VisualSelectionSize()}
"   rest print on right part of screen    
set statusline+=%=                        
"   line, column, percent in file         
set statusline+=%l\,%c\ (%p%%)            
"   back to default background            
"set statusline+=%*                       

" config indent for C sources
if has("autocmd")
 filetype on
 filetype indent on
 au FileType c,cpp,h setlocal ts=4 sts=4 sw=4 et cindent
 au FileType c,cpp,h inoremap #d #define
 au FileType c,cpp,h inoremap #e #endif<Esc>%y<End>''A /* <Esc>pA */<Esc>
 au FileType c,cpp,h inoremap #" #include ""<Esc>i
 au FileType c,cpp,h inoremap #< #include <><Esc>i
 au FileType c,cpp,h inoremap " ""<Left>
 au FileType c,cpp,h inoremap ' ''<Left>
 au FileType c,cpp,h inoremap ( ()<Left>
 au FileType c,cpp,h inoremap [ []<Left>
 au FileType c,cpp,h inoremap { {<Return>}<Up><Return>
endif

" function for counting lines/chars/blocks selected
function! VisualSelectionSize()                    
        if mode() == "v"                           
                " Exit and re-enter visual mode, because the marks
                " ('< and '>) have not been updated yet.
                exe "normal \<ESC>gv"
                if line("'<") != line("'>")
                        return '(selected ' . (line("'>") - line("'<") + 1) . ' l)'
                else
                        return '(selected ' . (col("'>") - col("'<") + 1) . ' c)'
                endif
        elseif mode() == "V"
                exe "normal \<ESC>gv"
                return '(selected ' . (line("'>") - line("'<") + 1) . ' l)'
        elseif mode() == "\<C-V>"
                exe "normal \<ESC>gv"
                return '(selected ' . (line("'>") - line("'<") + 1) . 'x' . (abs(col("'>") - col("'<")) + 1) . ')'
        else
                return ''
        endif
endfunction
