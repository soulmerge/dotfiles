" Vim syntax file
" Language:     jirawl
" Maintainer:   nostromo
" Last Change:  Mon  5 May 09:01:39 2014
" Version:      1
 
if exists("b:current_syntax")
  finish
endif
 
setlocal iskeyword+=:
syn case ignore
 
syn match jiracomment   "^\s*#.*"
syn match jiradate   "^\d\{4}-\d\{2}-\d\{2}[^#]*"
syn match jiraline_e "^[^#*-]\(\d\|_\)\{2}:\(\d\|_\)\{2} - \(\d\|_\)\{2}:\(\d\|_\)\{2}.*[^#]*"
syn match jiraline_l "^[^#\d]\s\+\(\d\|_\)\{2}:\(\d\|_\)\{2} - \(\d\|_\)\{2}:\(\d\|_\)\{2}.*[^#]*"
syn match jiraline_u "^\(\d\|_\)\{2}:\(\d\|_\)\{2} - \(\d\|_\)\{2}:\(\d\|_\)\{2}.*"
 
highlight link jiracomment Comment
highlight link jiradate    Constant
highlight link jiraline_e  Error
highlight link jiraline_l  Type
highlight link jiraline_u  Special
 
let b:current_syntax = "jirawl"
