" 基础配置
let USER_NAME = $USER
let USER_EMAIL = 'elonkou@ktime.cc'

"" 显示行号 语法高亮
set encoding=utf-8
set nu
syntax on
set foldenable
set foldmethod=manual
set completeopt=preview,menu 
set clipboard+=unnamed
set nobackup
set hlsearch
" 自动缩进
set autoindent
" set cindent
" Tab键的宽度
set tabstop=4
" 统一缩进为4
set softtabstop=4
set shiftwidth=4
set expandtab
set mouse=a
set selection=exclusive
set selectmode=mouse,key
if has("mouse")
    set mouse-=a
endif

autocmd BufNewFile *.hh,*.cpp,*.hpp,*.[ch],*.sh,*.cu,*.cc exec ":call SetTitle()" 
""定义函数SetTitle，自动插入文件头 
func SetTitle()
    if expand("%:e") == 'cpp' || expand("%:e") == 'cc'
        call setline(1         , "/*================================================================") 
        call append(line(".")  , "*  Copyright (C)2019 All rights reserved.") 
        call append(line(".")+1, "*  FileName : ".expand("%")) 
        call append(line(".")+2, "*  Author   : ".g:USER_NAME)
        call append(line(".")+3, "*  Email    : ".g:USER_EMAIL)
        call append(line(".")+4, "*  Date     : ".strftime("%c"))
        call append(line(".")+5, "================================================================*/") 
        call append(line(".")+6, "")
        call append(line(".")+7, "#include <iostream>")
        call append(line(".")+8, "using namespace std;")
        call append(line(".")+9, "")
        call append(line(".")+10, "int main(int argc, char *argv[]){")
        call append(line(".")+11, "    cout << \"Hello,elonkou!\";")
        call append(line(".")+12, "    return 0;")
        call append(line(".")+13, "}")
    endif
    if expand("%:e") == 'c'
        call setline(1         , "/*================================================================") 
        call append(line(".")  , "*  Copyright (C)2019 All rights reserved.") 
        call append(line(".")+1, "*  FileName : ".expand("%")) 
        call append(line(".")+2, "*  Author   : ".g:USER_NAME)
        call append(line(".")+3, "*  Email    : ".g:USER_EMAIL)
        call append(line(".")+4, "*  Date     : ".strftime("%c"))
        call append(line(".")+5, "================================================================*/") 
        call append(line(".")+6, "")
        call append(line(".")+7, "#include <stdio.h>")
        call append(line(".")+8, "")
        call append(line(".")+9, "int main(int argc, char *argv[]){")
        call append(line(".")+10, "    printf(\"Hello,elonkou!\");")
        call append(line(".")+11, "    return 0;")
        call append(line(".")+12, "}")
    endif
    if expand("%:e") == 'cu'
        call setline(1         , "/*================================================================") 
        call append(line(".")  , "*  Copyright (C)2019 All rights reserved.") 
        call append(line(".")+1, "*  FileName : ".expand("%")) 
        call append(line(".")+2, "*  Author   : ".g:USER_NAME)
        call append(line(".")+3, "*  Email    : ".g:USER_EMAIL)
        call append(line(".")+4, "*  Date     : ".strftime("%c"))
        call append(line(".")+5, "================================================================*/") 
        call append(line(".")+6, "")
        call append(line(".")+7, "#include <stdio.h>")
        call append(line(".")+8, "")
        call append(line(".")+9, "__global__ void func(){")
        call append(line(".")+10, "    printf(\"id:%d\\n\", threadIdx.x);")
        call append(line(".")+11, "}")
        call append(line(".")+12, "")
        call append(line(".")+13, "int main(int argc, char *argv[]){")
        call append(line(".")+14, "    func<<<1, 10>>>();")
        call append(line(".")+15, "    return 0;")
        call append(line(".")+16, "}")
    endif
    if expand("%:e") == 'h' || expand("%:e") == 'hh'
        call setline(1         , "#pragma once") 
    endif
    if expand("%:e") == 'hpp'
        call setline(1         , "/*================================================================") 
        call append(line(".")  , "*  Copyright (C)2019 All rights reserved.") 
        call append(line(".")+1, "*  FileName : ".expand("%")) 
        call append(line(".")+2, "*  Author   : ".g:USER_NAME)
        call append(line(".")+3, "*  Email    : ".g:USER_EMAIL)
        call append(line(".")+4, "*  Date     : ".strftime("%c"))
        call append(line(".")+5, "================================================================*/") 
        call append(line(".")+6, "#ifndef _".toupper(expand("%:t:r"))."_H")
        call append(line(".")+7, "#define _".toupper(expand("%:t:r"))."_H") 
        call append(line(".")+8, "#ifdef __cplusplus") 
        call append(line(".")+9, "extern \"C\"") 
        call append(line(".")+10, "{") 
        call append(line(".")+11, "#endif") 
        call append(line(".")+12, "") 
        call append(line(".")+13, "#ifdef __cplusplus") 
        call append(line(".")+14, "}") 
        call append(line(".")+15, "#endif") 
        call append(line(".")+16, "#endif //".toupper(expand("%:t:r"))."_H")
    endif
    if expand("%:e") == 'sh'
        call setline(1, "#!/bin/bash") 
    endif
    autocmd BufNewFile * normal G
endfunc 


"C，C++ 按F5编译运行
map <F5> :call CompileRunGcc()<CR>
func! CompileRunGcc()
    exec "w"
    if &filetype == 'c'
        exec "!g++ % -o %<"
        exec "! ./%<"
    elseif &filetype == 'cpp'
        exec "!g++ % -o %< -std=c++11"
        exec "! ./%<"
    elseif &filetype == 'sh'
        :!./%
    elseif &filetype == 'cu'
        exec "!nvcc % -o %<"
        exec "! ./%<"
    endif
endfunc
