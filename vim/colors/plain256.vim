" Initialization {{{
	set background=dark

	hi clear
	if exists('syntax_on')
		syntax reset
	endif

	let g:colors_name = 'plain256'

	if ! has('gui_running') && ! &termguicolors
		echoe 'The ' . g:colors_name . ' color scheme requires gvim or ''termguicolors'''

		finish
	endif
" }}}
" Palette {{{
	let s:palette_file = expand('~/.palette.conf')

	if ! filereadable(s:palette_file)
		echoe 'The ' . g:colors_name . ' color scheme requires ' . s:palette_file

		finish
	endif

	let s:palette = {}
	for s:line in readfile(s:palette_file)
		let s:match = matchlist(s:line, '^set-option -g @\(\w\+\) "\(#\x\{6}\)"')
		if ! empty(s:match)
			let s:palette[s:match[1]] = s:match[2]
		endif
	endfor
" }}}
" Color dictionary parser {{{
	function! s:ColorDictParser(color_dict)
		for [group, group_colors] in items(a:color_dict)
			exec 'hi ' . group
				\ . ' guifg=' . (group_colors[0] == '' ? 'NONE' : s:palette[group_colors[0]])
				\ . ' guibg=' . (group_colors[1] == '' ? 'NONE' : s:palette[group_colors[1]])
				\ . '   gui=' . (group_colors[2] == '' ? 'NONE' :            group_colors[2])
				\ . ' cterm=' . (group_colors[2] == '' ? 'NONE' :            group_colors[2])
		endfor
	endfunction
" }}}

"	   | Highlight group                |               FG |               BG |      Attributes |
"	   |--------------------------------|------------------|------------------|-----------------|
call s:ColorDictParser({
	\   'Normal'                      : [         'GREY_FF',         'GREY_00',               '']
	\ , 'Visual'                      : [         'GREY_58',         'GREY_DA',               '']
	\
	\ , 'Cursor'                      : [         'GREY_FF',      'ORANGE_RED',               '']
	\ , 'lCursor'                     : [         'GREY_FF',       'BLUE_PALE',               '']
	\
	\ , 'CursorLine'                  : [                '',         'GREY_00',           'bold']
	\ , 'CursorLineNr'                : [         'GREY_FF',         'GREY_58',               '']
	\ , 'CursorColumn'                : [         'GREY_FF',         'GREY_3A',               '']
	\
	\ , 'Folded'                      : [         'GREY_B2',         'GREY_1C',               '']
	\ , 'FoldColumn'                  : [         'GREY_76',         'GREY_1C',               '']
	\ , 'SignColumn'                  : [         'GREY_FF',         'GREY_12',           'bold']
	\ , 'ColorColumn'                 : [                '',         'GREY_12',               '']
	\
	\ , 'StatusLine'                  : [         'GREY_FF',                '',           'bold']
	\ , 'StatusLineNC'                : [         'GREY_80',                '',               '']
	\
	\ , 'LineNr'                      : [         'GREY_76',         'GREY_26',               '']
	\ , 'VertSplit'                   : [         'GREY_58',         'GREY_1C',               '']
	\
	\ , 'WildMenu'                    : [         'GREY_1C',         'GREY_FF',               '']
	\ , 'Directory'                   : [           'OLIVE',                '',           'bold']
	\ , 'Underlined'                  : [           'BROWN',                '',               '']
	\
	\ , 'Question'                    : [        'BLUE_SKY',                '',           'bold']
	\ , 'MoreMsg'                     : [           'AMBER',                '',           'bold']
	\ , 'WarningMsg'                  : [   'ORANGE_BRIGHT',                '',           'bold']
	\ , 'ErrorMsg'                    : [      'RED_BRIGHT',                '',           'bold']
	\
	\ , 'Comment'                     : [         'GREY_76',         'GREY_12',               '']
	\ , 'vimCommentTitleLeader'       : [         'GREY_BC',         'GREY_12',               '']
	\ , 'vimCommentTitle'             : [         'GREY_BC',         'GREY_12',               '']
	\ , 'vimCommentString'            : [         'GREY_8A',         'GREY_12',               '']
	\
	\ , 'TabLine'                     : [         'GREY_FF',         'GREY_44',               '']
	\ , 'TabLineSel'                  : [         'GREY_EE',                '',           'bold']
	\ , 'TabLineFill'                 : [         'GREY_58',         'GREY_44',               '']
	\ , 'TabLineNumber'               : [             'RED',         'GREY_44',           'bold']
	\ , 'TabLineClose'                : [         'GREY_8A',         'GREY_44',           'bold']
	\
	\ , 'SpellCap'                    : [         'GREY_FF',       'BLUE_TEAL',           'bold']
	\
	\ , 'SpecialKey'                  : [         'GREY_4E',                '',               '']
	\ , 'NonText'                     : [        'RED_DARK',                '',               '']
	\ , 'MatchParen'                  : [         'GREY_FF',            'BLUE',           'bold']
	\
	\ , 'Constant'                    : [             'TAN',                '',           'bold']
	\ , 'Special'                     : [       'LIME_PALE',                '',               '']
	\ , 'Identifier'                  : [       'TEAL_GREY',                '',           'bold']
	\ , 'Statement'                   : [           'KHAKI',                '',           'bold']
	\ , 'PreProc'                     : [         'GREY_9E',                '',               '']
	\ , 'Type'                        : [      'BLUE_STEEL',                '',           'bold']
	\ , 'String'                      : [           'OLIVE',                '',               '']
	\ , 'Number'                      : [          'SALMON',                '',               '']
	\ , 'Define'                      : [          'SALMON',                '',               '']
	\ , 'Error'                       : [    'ORANGE_LIGHT',        'RED_DEEP',               '']
	\ , 'Function'                    : [            'GOLD',                '',               '']
	\ , 'Include'                     : [          'SALMON',                '',               '']
	\ , 'PreCondit'                   : [          'SALMON',                '',               '']
	\ , 'Keyword'                     : [          'SALMON',                '',               '']
	\ , 'Search'                      : [         'GREY_FF',       'RED_MUTED',               '']
	\ , 'Title'                       : [         'GREY_FF',                '',               '']
	\ , 'Delimiter'                   : [         'GREY_94',                '',               '']
	\ , 'StorageClass'                : [           'BEIGE',                '',               '']
	\ , 'Operator'                    : [       'TAN_LIGHT',                '',               '']
	\
	\ , 'TODO'                        : [    'YELLOW_LIGHT',      'BROWN_DARK',           'bold']
	\
	\ , 'SyntasticWarning'            : [     'GOLD_BRIGHT',      'BROWN_DARK',               '']
	\ , 'SyntasticError'              : [   'ORANGE_BRIGHT',          'MAROON',               '']
	\
	\ , 'Pmenu'                       : [         'GREY_A8',         'GREY_58',               '']
	\ , 'PmenuSel'                    : [         'GREY_DA',         'GREY_8A',               '']
	\ , 'PmenuSbar'                   : [         'GREY_DA',         'GREY_A8',               '']
	\
	\ , 'phpEOL'                      : [         'GREY_8A',                '',               '']
	\ , 'phpStringDelim'              : [      'BROWN_DARK',                '',               '']
	\ , 'phpDelimiter'                : [             'RED',                '',               '']
	\ , 'phpFunctions'                : [     'YELLOW_WARM',                '',           'bold']
	\ , 'phpBoolean'                  : [          'ORANGE',                '',           'bold']
	\ , 'phpOperator'                 : [           'PEACH',                '',               '']
	\ , 'phpMemberSelector'           : [      'ROSE_DUSTY',                '',           'bold']
	\ , 'phpParent'                   : [          'YELLOW',                '',               '']
	\
	\ , 'PHPClassTag'                 : [         'GREY_DA',                '',               '']
	\ , 'PHPInterfaceTag'             : [         'GREY_DA',                '',               '']
	\ , 'PHPFunctionTag'              : [     'YELLOW_SAND',                '',           'bold']
	\
	\ , 'pythonDocString'             : [         'GREY_58',         'GREY_12',               '']
	\ , 'pythonDocStringTitle'        : [         'GREY_8A',         'GREY_12',               '']
	\ , 'pythonRun'                   : [     'GREEN_MUTED',                '',               '']
	\ , 'pythonBuiltinObj'            : [      'BLUE_STEEL',                '',           'bold']
	\ , 'pythonSelf'                  : [         'GREY_BC',                '',           'bold']
	\ , 'pythonFunction'              : [            'GOLD',                '',           'bold']
	\ , 'pythonClass'                 : [     'YELLOW_WARM',                '',           'bold']
	\ , 'pythonExClass'               : [           'BROWN',                '',               '']
	\ , 'pythonException'             : [           'BROWN',                '',           'bold']
	\ , 'pythonOperator'              : [           'KHAKI',                '',               '']
	\ , 'pythonPreCondit'             : [       'CYAN_PALE',                '',           'bold']
	\ , 'pythonDottedName'            : [     'ORANGE_DARK',                '',               '']
	\ , 'pythonDecorator'             : [        'RED_DEEP',                '',           'bold']
	\
	\ , 'PythonInterfaceTag'          : [       'TEAL_PALE',                '',               '']
	\ , 'PythonClassTag'              : [     'YELLOW_WARM',                '',               '']
	\ , 'PythonFunctionTag'           : [       'TEAL_PALE',                '',               '']
	\ , 'PythonVariableTag'           : [         'GREY_DA',                '',               '']
	\ , 'PythonMemberTag'             : [         'GREY_AF',                '',               '']
	\
	\ , 'CTagsImport'                 : [       'TEAL_PALE',                '',               '']
	\ , 'CTagsClass'                  : [     'YELLOW_WARM',                '',               '']
	\ , 'CTagsFunction'               : [       'TEAL_PALE',                '',               '']
	\ , 'CTagsGlobalVariable'         : [         'GREY_DA',                '',               '']
	\ , 'CTagsMember'                 : [         'GREY_AF',                '',               '']
	\
	\ , 'xmlTag'                      : [            'LIME',                '',           'bold']
	\ , 'xmlTagName'                  : [         'GREY_BC',                '',               '']
	\ , 'xmlEndTag'                   : [   'SALMON_BRIGHT',                '',           'bold']
	\
	\ , 'cssImportant'                : [     'ORANGE_DARK',                '',           'bold']
	\
	\ , 'DiffAdd'                     : [    'GREEN_BRIGHT',      'GREEN_DARK',               '']
	\ , 'DiffChange'                  : [     'GOLD_BRIGHT',      'BROWN_DARK',               '']
	\ , 'DiffDelete'                  : [             'RED',                '',               '']
	\ , 'DiffText'                    : [     'GOLD_BRIGHT',      'BROWN_DARK',   'reverse,bold']
	\
	\ , 'diffLine'                    : [ 'BLUE_CORNFLOWER',                '',           'bold']
	\ , 'diffFile'                    : [         'GREY_6C',                '',               '']
	\ , 'diffNewFile'                 : [         'GREY_6C',                '',               '']
\ })

hi link htmlTag            xmlTag
hi link htmlTagName        xmlTagName
hi link htmlEndTag         xmlEndTag

hi link phpCommentTitle    vimCommentTitle
hi link phpDocTags         vimCommentString
hi link phpDocParam        vimCommentTitle

hi link diffAdded          DiffAdd
hi link diffChanged        DiffChange
hi link diffRemoved        DiffDelete
