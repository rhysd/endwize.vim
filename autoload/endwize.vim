let s:cpo_save = &cpo
set cpo&vim

" Functions {{{1

function! s:mysearchpair(beginpat,endpat,synpat)
    let g:endwize_syntaxes = ""
    let s:lastline = line('.')
    call s:synname()
    let line = searchpair(a:beginpat,'',a:endpat,'Wn','<SID>synname() !~# "^'.substitute(a:synpat,'\\','\\\\','g').'$"',line('.')+g:endwize_search_lines)
    return line
endfunction

function! endwize#crend()
    let n = ""
    if !exists("b:endwize_addition") || !exists("b:endwize_words") || !exists("b:endwize_syngroups")
        return n
    end
    let synpat  = '\%('.substitute(b:endwize_syngroups,',','\\|','g').'\)'
    let wordchoice = '\%('.substitute(b:endwize_words,',','\\|','g').'\)'
    if exists("b:endwize_pattern")
        let beginpat = substitute(b:endwize_pattern,'&',substitute(wordchoice,'\\','\\&','g'),'g')
    else
        let beginpat = '\<'.wordchoice.'\>'
    endif
    let lnum = line('.') - 1
    let space = matchstr(getline(lnum),'^\s*')
    let col  = match(getline(lnum),beginpat) + 1
    let word  = matchstr(getline(lnum),beginpat)
    let endpat = substitute(word,'.*',b:endwize_addition,'')
    echo endpat
    let y = n.endpat."\<C-O>O"
    let endpat = '\<'.substitute(wordchoice,'.*',b:endwize_addition,'').'\>'
    if col <= 0 || synIDattr(synID(lnum,col,1),'name') !~ '^'.synpat.'$'
        return n
    elseif getline('.') !~ '^\s*#\=$'
        return n
    endif
    let line = s:mysearchpair(beginpat,endpat,synpat)
    " even is false if no end was found, or if the end found was less
    " indented than the current line
    let even = strlen(matchstr(getline(line),'^\s*')) >= strlen(space)
    if line == 0
        let even = 0
    endif
    if !even && line == line('.') + 1
        return y
    endif
    if even
        return n
    endif
    return y
endfunction

function! s:synname()
    " Checking this helps to force things to stay in sync
    while s:lastline < line('.')
        let s = synIDattr(synID(s:lastline,indent(s:lastline)+1,1),'name')
        let s:lastline = nextnonblank(s:lastline + 1)
    endwhile

    let s = synIDattr(synID(line('.'),col('.'),1),'name')
    let g:endwize_syntaxes = g:endwize_syntaxes . line('.').','.col('.')."=".s."\n"
    let s:lastline = line('.')
    return s
endfunction

" }}}1

let &cpo = s:cpo_save