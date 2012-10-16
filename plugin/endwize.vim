" endwize.vim
" OriginalAuthor:   Tim Pope <vimNOSPAM@tpope.info>
" Reformer:         rhysd <lin90162@yahoo.co.jp>

" Distributable under the same terms as Vim itself (see :help license)

if (exists("g:loaded_endwize") && g:loaded_endwize) || &cp
    finish
endif
let g:loaded_endwize = 1

let s:cpo_save = &cpo
set cpo&vim

let g:endwize_search_lines = get(g:, 'endwize_search_lines', 50)

augroup endwize " {{{1
    au!
    autocmd FileType ruby
                \ let b:endwize_addition = '\=submatch(0)=="{" ? "}" : "end"' |
                \ let b:endwize_words = 'module,class,def,if,unless,case,while,until,begin,do' |
                \ let b:endwize_pattern = '^\s*\zs\%(module\|class\|def\|if\|unless\|case\|while\|until\|for\|\|begin\)\>\%(.*[^.:@$]\<end\>\)\@!\|\<do\ze\%(\s*|.*|\)\=\s*$' |
                \ let b:endwize_syngroups = 'rubyModule,rubyClass,rubyDefine,rubyControl,rubyConditional,rubyRepeat'
    autocmd FileType vim
                \ let b:endwize_addition = 'end&' |
                \ let b:endwize_words = 'fu\%[nction],wh\%[ile],if,for,try' |
                \ let b:endwize_syngroups = 'vimFuncKey,vimNotFunc,vimCommand'
    autocmd FileType sh,zsh
                \ let b:endwize_addition = '\=submatch(0)==#"if" ? "fi" : submatch(0)==#"case" ? "esac" : "done"' |
                \ let b:endwize_words = 'if,case,do' |
                \ let b:endwize_syngroups = 'shConditional,zshConditional'
augroup END " }}}1

" Maps {{{1

if maparg("<Plug>DiscretionaryEnd") == ""
    inoremap <silent> <SID>DiscretionaryEnd <C-R>=endwize#crend()<CR>
    imap    <script> <Plug>DiscretionaryEnd <SID>DiscretionaryEnd
endif

" }}}1


let &cpo = s:cpo_save

" vim:set ft=vim ff=unix ts=8 sw=4 sts=4:
