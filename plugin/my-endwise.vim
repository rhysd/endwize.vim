" endwise.vim - EndWise
" Author:       Tim Pope <vimNOSPAM@tpope.info>
" Version:      1.0

" Distributable under the same terms as Vim itself (see :help license)

" Exit quickly when:
" - this plugin was already loaded (or disabled)
" - when 'compatible' is set
if (exists("g:loaded_endwise") && g:loaded_endwise) || &cp
    finish
endif
let g:loaded_endwise = 1


let s:cpo_save = &cpo
set cpo&vim

augroup endwise " {{{1
    au!
    autocmd FileType ruby
                \ let b:endwise_addition = '\=submatch(0)=="{" ? "}" : "end"' |
                \ let b:endwise_words = 'module,class,def,if,unless,case,while,until,begin,do' |
                \ let b:endwise_pattern = '^\s*\zs\%(module\|class\|def\|if\|unless\|case\|while\|until\|for\|\|begin\)\>\%(.*[^.:@$]\<end\>\)\@!\|\<do\ze\%(\s*|.*|\)\=\s*$' |
                \ let b:endwise_syngroups = 'rubyModule,rubyClass,rubyDefine,rubyControl,rubyConditional,rubyRepeat'
    autocmd FileType vim
                \ let b:endwise_addition = 'end&' |
                \ let b:endwise_words = 'fu\%[nction],wh\%[ile],if,for,try' |
                \ let b:endwise_syngroups = 'vimFuncKey,vimNotFunc,vimCommand'
augroup END " }}}1

" Maps {{{1


if maparg("<Plug>DiscretionaryEnd") == ""
    inoremap <silent> <SID>DiscretionaryEnd <C-R>=my_endwise#crend(0)<CR>
    imap    <script> <Plug>DiscretionaryEnd <SID>DiscretionaryEnd
endif

" }}}1


let &cpo = s:cpo_save

" vim:set ft=vim ff=unix ts=8 sw=4 sts=4:
