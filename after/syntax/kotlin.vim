"if exists("b:current_syntax")
"  finish
"endif

" disable current syntax temporarily
let saved_syntax = b:current_syntax
unlet! b:current_syntax

syntax include @SQL syntax/sql.vim

" highlight: @Query(\_[^"]*"""\zs\_.\{-}\ze"""
"syn match SqlQueryEmbedded /@Query([^"]*"""\_.\{-}"""/ contained contains=@SQL
syn region ktSqlEmbedded start=/@Query(\n\? *"""/ end=/"""\n\? *)/ contains=@SQL

" restore original syntax
let b:current_syntax = saved_syntax
unlet! saved_syntax
