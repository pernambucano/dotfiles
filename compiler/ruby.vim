if exists('current_compiler')
  finish
endif
let current_compiler = 'ruby'

CompilerSet makeprg=bin/rspec

CompilerSet errorformat=
    \%f:%l:\ %tarning:\ %m,
    \%E%.%#:in\ `load':\ %f:%l:%m,
    \%E%f:%l:in\ `%*[^']':\ %m,
    \%-Z\ \ \ \ \ %\\+\#\ %f:%l:%.%#,
    \%E\ \ \ \ \ Failure/Error:\ %m,
    \%E\ \ \ \ \ Failure/Error:,
    \%C\ \ \ \ \ %m,
    \%C%\\s%#,
    \%-G%.%#
