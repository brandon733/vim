let g:PaperColor_Theme_Options = {
	\ 'theme': {
	\   'default': {
	\     'transparent_background': 0,
	\     'allow_bold': 1,
	\     'allow_italic': 1
	\   },
	\   'default.light': {
	\     'override' : {
	\       'linenumber_bg' : ['#E9E9E9', '15']
	\     }
	\   }
	\ }
\ }

" little crazy, but for PaperColor ..
" .. startup color
if g:colors_name == "PaperColor"
	color PaperColor
	hi SignColumn guibg=#FFD7FF ctermbg=15
	hi ALEWarningSign term=standout cterm=bold gui=bold guibg=#FFD7FF ctermbg=15 guifg=#00af5f ctermfg=5
	hi ALEErrorSign term=standout cterm=bold gui=bold guibg=#FFD7FF ctermbg=15 guifg=Red ctermfg=9
endif
" .. color changes (error if this is before above)
autocmd ColorScheme PaperColor
	\ | hi SignColumn guibg=#FFD7FF ctermbg=15
	\ | hi ALEWarningSign term=standout cterm=bold gui=bold guibg=#FFD7FF ctermbg=15 guifg=#00af5f ctermfg=5
	\ | hi ALEErrorSign term=standout cterm=bold gui=bold guibg=#FFD7FF ctermbg=15 guifg=Red ctermfg=9
