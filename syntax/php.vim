" Vim syntax file
" Language:     PHP 4/5
" Maintainer:   Peter Hodge <toomuchphp-vim@yahoo.com>
" Last Change:  May 7, 2008
"
" URL:      http://www.vim.org/scripts/script.php?script_id=1571
" Version:  0.9.7
"
" ================================================================
"
" Note: If you are having speed issues loading or editting PHP files, try
"       disabling some of the options.  In your .vimrc, try adding:
"         :let php_folding = 0
"         :let php_strict_blocks = 0
"
"       Also, there is a 'large file' mode which can disable certain options
"       if a PHP file is too big (see php_large_file below).
"
" ================================================================
"
" Note: If you are using a colour terminal with a dark background, you will
"       probably find the 'elflord' colorscheme will give you the most
"       distinctive colors.
"
" ================================================================
"
" OPTIONS:
"
"    Many of these default to 1 (On), so you would need to set
"	 them to 0 to turn them off. E.g., in your .vimrc file:
"      let php_special_vars = 0
"      let php_special_functions = 0
"      let php_alt_comparisons = 0
"      etc.
"    If the variables do not exist, the default value will be used.
"
"
"    All options can be set globally or on a per-file basis by using
"    global or buffer-local variables.  For example, you could turn on
"    automatic folding for all PHP scripts in your .vimrc:
"      let g:php_folding = 3
"
"    Then you could turn it off in only one file using this command:
"
"      :let b:php_folding = 0 | setfiletype php
"
"
"   -- PHP FEATURES --
"
"         let php_sql_query = 1/0  [default 0]
"             ... for SQL syntax highlighting inside strings
"
"         let php_htmlInStrings = 1/0  [default 0]
"             ... for HTML syntax highlighting inside strings
"
"         let php_baselib = 1/0  [default 0]
"             ... for highlighting baselib functions
"
"         let php_special_vars = 1/0  [default 1]
"             ... to highlight superglobals like $_GET, $_SERVER, etc.
"               * always on if using php_oldStyle
"
"         let php_special_functions = 1/0  [default 1]
"             ... to highlight functions with special behaviour
"                 e.g., unset(), extract()
"
"         let php_alt_comparisons = 1/0  [default 1]
"             ... to highlight comparison operators in an alternate colour
"               * always on if using php_oldStyle
"
"         let php_alt_assignByReference = 1/0  [default 1]
"             ... to highlight '=&' in '$foo =& $bar' in an alternate colour.
"                 This also applies to a function which returns by-reference,
"                 as well as a function argument which is by-reference.
"
"         let php_smart_members = 1/0  [default 0]
"             ... syntax works out whether -> indicates a property or method.
"                 Otherwise method colours may be used on properties, for
"                 example:
"                   $object->__get[] = true;
"                 '__get' would be highlighted as a special method, even
"                 thought it is clearly a property in this context.
"                 Note: turning this OFF can improve the highlighting speed on
"                 object-oriented code
"
"         let php_alt_properties = 1/0  [default 0]
"             ... use a different color for '->' based on whether it is used
"                 for property access, method access, or dynamic access (using
"                 '->{...}')
"               * requires php_smart_members
"
"         let php_highlight_quotes = 1/0  [default 0]
"             ... makes quote characters the same colour as the string
"                 contents, like in C syntax.
"
"         let php_show_semicolon = 1/0  [default 1]
"             ... to make the semicolon (;) more visible
"
"         let php_smart_semicolon = 1/0  [default 1]
"             ... semicolon adopts the color of a 'return' or 'break' keyword
"               * requires php_show_semicolon
"                 Note: this also includes the ':' or ';' which follows a
"                 'case' or 'default' inside a switch
"
"         let php_alt_blocks = 1/0  [default 1]
"             ... colorize { and } around class/function/try/catch bodies
"                 according to the type of code block.
"               * requires php_strict_blocks
"
"         let php_alt_arrays = 0/1/2  [default 1]
"             ... to colorize ( and ) around an array body, as well as '=>'
"               * requires php_strict_blocks
"                 Setting this to '2' will highlighting the commas as well.
"                 Commas are not highlighted by default because it's too much
"                 color.
"
"         let php_alt_construct_parents = 0/1  [default 0]
"             ... to colorize the ( and ) around an if, while, foreach, or switch
"                 body.
"               * requires ... what?
"                 TODO: work out dependencies, code them correctly
"
"         let php_show_spl = 1/0  [default 1]
"             .. to colorize methods which are defined by PHP default interfaces
"                TODO: work out what these interfaces are part of: SPL or just
"                PHP
"
"         let php_show_pcre = 1/0  [default 1]
"                 (was: 'php_show_preg')
"             ... to highlight regular expression patterns inside calls
"                 to preg_match(), preg_replace(), etc.
"
"
"   -- FINDING ERRORS --
"
"         let php_parent_error_close = 1/0  [default 1]
"             ... for highlighting parent error ] or ) or }
"               * requires php_strict_blocks
"
"         let php_parent_error_open = ?
"             ... for skipping a php end tag, if there exists an
"                 open ( or [ without a closing one
"                 Note: this option is now enabled permanently (unless
"                 php_strict_blocks is disabled).
"               * requires php_strict_blocks
"
"         let php_empty_construct_error = 0/1  [default 1]
"             ... highlights ';' as an error if it comes immediately after
"                 an if/else/while/for/foreach/switch statement (the
"                 logical constructs should have a body).
"               * requires php_strict_blocks

"         let php_show_semicolon_error = 1/0  [default 1]
"             ... highlights certain cases when ';' is followed by an
"                 operator such as '+'.
"               * requires php_show_semicolon
"
"         let php_nested_functions = 0/1  [default 0]
"             ... Whether or not to allow contiaining one function inside
"                 another.  This option is mostly for speeding up syntax
"                 highlighting - { } blocks can by inserted much faster while
"                 editting a large class.
"                 Note: this is the only option which might break valid PHP
"                 code, although only if you define one function inside
"                 another, which is usually discouraged.
"               * only relevant when using php_strict_blocks
"
"   -- OTHER OPTIONS --
"
"         let php_large_file = 0/?  [ default 3000 ]
"             ... If a PHP script has more lines than this limit (e.g., more
"                 than 3000 lines), some options are automatically turned off
"                 to help it load faster.  These options are:
"                   php_strict_blocks = 0
"                   php_smart_members = 0
"                   php_smart_semicolon = 0
"                   php_show_pcre = 0
"                   php_folding = 0
"                 Note: If you set this option to '0', then this feature will
"                 be disabled; thus you can use:
"                   :let b:php_large_file = 0 | setfiletype php
"                 to reload the current file with the disabled syntax options
"                 re-activated.
"
"         let php_strict_blocks = 1/0  [default 1]
"             ... to match together all {} () and [] blocks correctly. This is
"                 required by some of the other options for finding errors and
"                 applying correct colors to { } blocks, etc.  However, it may
"                 cause Vim to slow down on large files.
"
"         let php_asp_tags = 1/0  [default 0]
"             ... for highlighting ASP-style short tags: <% %>
"
"         let php_noShortTags = 1/0  [default 1]
"             ... don't sync <? ?> as php
"               * This has been deprecated in favour of php_short_tags (which
"                 has the opposite meaning)
"
"         let php_short_tags = 1/0  [default 1]
"             ... highlight <?...?> blocks as php. If this is OFF, you need to
"                 use the longer <?php...?>
"
"         let php_oldStyle = 1
"             ... for using old colorstyle
"
"         let php_folding = 1/2/3  [default 0]
"             ... 1: for folding classes and functions
"                 2: for folding all { } regions
"                 3: for folding only functions
"                 TODO: documentation for php_folding_manual
"
"         let php_fold_arrays = 0/1  [default 0]
"             ... To fold arrays as well.
"               * requires php_folding, php_strict_blocks, php_alt_arrays
"
"         let php_fold_heredoc = 0/1  [default 0]
"             ... Fold heredoc blocks ($string = <<<ENDOFSTRING)
"               * requires php_folding
"
"         let php_sync_method = x
"             ... x = -1 to sync by search (default)
"                 x > 0  to sync at least x lines backwards
"                 x = 0  to sync from start
"
"
" ================================================================
"
" TODO LIST:
"
" PRIORITY:
"   - document the phpControlParent feature, make sure it works fully, or not
"     at all
"   - what to do about 'iskeyword' containing '$'?
"   - test syntax against older Vims (6.4, 6.0, 5.7)
"   - concat rid of lines beginning with '\'
"   - allow turning off all semicolon errors
"   - fix bug in highlighting of pattern: /[\\\]/ and /[\\]]/
"   - fix bug in highlighting of pattern: "/\$/" should make the '$' match the
"     end-of-pattern
"   - case/default syntax items don't work inside a switch/endswitch
"     although it's still OK using {...}
"
" PHP Syntax:
"   - review support for PHP built-in superglobals:
"     - ensure all PHP 5.2 superglobals are recognized
"   - review support for PHP built-in constants, make sure I've got them all
"   - make support for PHP built-in class methods optional.
"   - review highlight links to ensure maximum readability on GUI
"     and color terminal using colorschemes 'elflord' and 'default'
"   - new group phpReservedFunction, because some parts of
"     phpSpecialFunction can be used as a method name.
"   - what is php_oldStyle? is it still needed?
"   - use 'nextgroup' to highlight errors when a ']' or ')' is followed by
"     a constant/variable or function call.  This will also help find when
"     a closing ')' is missing.
"   - Review syncing searches, see if there is anything we can add to help the
"     syncing process.
"   - make ';' on the end of a while() NOT a problem unless it is followed by
"     a '{'
"
" PCRE Syntax:
"   - fix problem: in regex "/(...)\1/", '\1' does NOT refer to a backreference!
"     this is caused by incorrect matching of escape sequences in
"     double-quoted strings where the double-quote escape sequences should
"     take precedence
"   - fix problem: this line breaks folding
"   		preg_match("#^require MODULES_PATH \. (['\"])main\.inc\.php\\1;$#m", '', $m))
"
"   - decide on terminology: 'PCRE' or 'PREG'
"   - Review effects of paired delimiters when combined with other
"     PCRE complex atoms using those symbols
"   - decide on better colors for the
"     (?(?=lookahead/lookbehind)conditional|sub-pattern)
"
"
" Future Plans:
"   - option to choose PHP4 or PHP5 compatibility
"   - differentiate between an interface block and a class block
"   - add ability to highlight user-defined functions and keywords
"     using any of the following means:
"       1) a comma-separated string of user functions
"       2) a file containing user functions
"       3) using names from the tags file(s)
"           (this may be better as a separate plugin)
"   - add support for phpDocumentor comment blocks and tags
"   - add support for POSIX Regex patterns
"   - allow easy embedding of the PHP syntax using 'contains=@phpClTop' or
"     'syn region phpRegion ...'
"   - automatically select best colors by examining the colorscheme
"   - check to see if 'baselib' needs to be highlighted still
"   - Add support 2nd parameter to preg_replace and highlight
"     "\1" and other confusing sequences as errors ("\1" is "\x01")
"   - Add support for class constants (foo::bar)
"
" Difficult To Implement:
"   - Highlight expressions without operators or commas, such as:
"       echo $a $b;
"     These expressions are *really* difficult to find efficiently.
"   - Folding around 'case' blocks.
"
"
"
" ================================================================
"
" Note:
" - syntax case is 'ignore' unless explicitly set to 'match'
"   for a single item.

" For version 5.x: Clear all syntax items
" For version 6.x: Quit when a syntax file was already loaded
if version < 600
  syn clear
elseif exists("b:current_syntax")
  finish
endif

if !exists("main_syntax")
  let main_syntax = 'php'
endif

" TODO: what's all this about?
if version < 600
  unlet! php_folding
  if exists("php_sync_method") && !php_sync_method
    let php_sync_method=-1
  endif
  so <sfile>:p:h/html.vim
else
  runtime! syntax/html.vim
  unlet b:current_syntax
endif

" accept old options
if !exists("php_sync_method")
  if exists("php_minlines")
    let php_sync_method=php_minlines
  else
    let php_sync_method=-1
  endif
endif

function! s:ChooseValue(name, default)
  if exists('b:' . a:name)
    return b:{a:name}
  elseif exists('g:' . a:name)
    return g:{a:name}
  else
    return a:default
  endif
endfunction

" set up variables based on global or buffer variables {{{1
  " Is it a large file? (s:large_file) {{{2
  let s:large_file_limit = s:ChooseValue('php_large_file', 3000)
  let s:large_file = (s:large_file_limit == 0) ? 0 : (line('$') >= s:large_file_limit)

  if s:large_file
    echohl WarningMsg
    echomsg printf('WARNING: Large PHP File (%d lines); some syntax options have been disabled.', line('$'))
    echohl None
  endif

  " Strict Blocks (s:strict_blocks) {{{2
  let s:strict_blocks = s:large_file ? 0 : s:ChooseValue('php_strict_blocks', 1)

  " Fold Level (s:folding) {{{2
  let s:folding = s:large_file ? 0 : s:ChooseValue('php_folding', 0)

  " Fold manually (s:fold_manual) {{{2
  let s:fold_manual = s:large_file ? 0 : s:ChooseValue('php_fold_manual', s:folding ? 1 : 0)

  " Fold arrays (s:fold_arrays) {{{2
  let s:fold_arrays = (s:folding && s:ChooseValue('php_fold_arrays', 0))

  " Fold heredoc strings (s:fold_heredoc) {{{2
  let s:fold_heredoc = (s:folding && s:ChooseValue('php_fold_heredoc', 0))

  " Allow nested functions (s:nested_functions) {{{2
  let s:nested_functions = s:ChooseValue('php_nested_functions', 1)

  " Allow ASP-style <% %> tags (s:asp_tags) {{{2
  let s:asp_tags = s:ChooseValue('php_asp_tags', 0)

  " Only allow long tags '<?php' (s:long_tags) {{{2
  let s:long_tags = !s:ChooseValue('php_short_tags', !s:ChooseValue('php_noShortTags', 1))

  " SQL in strings (s:show_sql) {{{2
  let s:show_sql = s:ChooseValue('php_sql_query', 0)

  " HTML in strings (s:show_html_in_strings) {{{2
  let s:show_html_in_strings = s:ChooseValue('php_htmlInStrings', 0)

  " Highlight the PHP baselib (s:show_baselib) {{{2
  let s:show_baselib = s:ChooseValue('php_baselib', 0)

  " Highlight superglobals (s:special_vars) {{{2
  let s:special_vars = s:ChooseValue('php_special_vars', s:ChooseValue('php_special_variables', s:ChooseValue('php_oldStyle', 1)))

  " Highlight special functions (s:special_functions) {{{2
  let s:special_functions = s:ChooseValue('php_special_functions', 1)

  " Highlight quotes around strings (s:show_quotes) {{{2
  let s:show_quotes = s:ChooseValue('php_highlight_quotes', 0)

  " Highlight PCRE patterns (s:show_pcre) {{{2
  let s:show_pcre = s:large_file ? 0 : s:ChooseValue('php_show_pcre', s:ChooseValue('php_show_preg', 1))

  " Highlight ';' (s:show_semicolon) {{{2
  let s:show_semicolon = s:ChooseValue('php_show_semicolon', 1)

  " Highlight ';' errors (s:show_semicolon_error) {{{2
  let s:show_semicolon_error = (s:show_semicolon && s:ChooseValue('php_show_semicolon_error', 1))

  " Highlight parent error ) ] or } (s:parent_error_close) {{{2
  let s:parent_error_close = (s:strict_blocks && s:ChooseValue('php_parent_error_close', 1))

  " Highlight invalid ';' after if/while/foreach (s:no_empty_construct) {{{2
  let s:no_empty_construct = (s:strict_blocks && s:ChooseValue('php_empty_construct_error', 1))

  " Alt colors for {} around class/func/try/catch blocks (s:alt_blocks) {{{2
  let s:alt_blocks = (s:strict_blocks && s:ChooseValue('php_alt_blocks', 1))

  " Alt color for by-reference operators (s:alt_refs) {{{2
  let s:alt_refs = s:ChooseValue('php_alt_assignByReference', 1)

  " Alt color for control structure parents (s:alt_control_parents) {{{2
  let s:alt_control_parents = s:ChooseValue('php_alt_construct_parents', 0)

  " Alt color for array syntax (s:alt_arrays) {{{2
  " * requires strict_blocks
  let s:alt_arrays = (s:strict_blocks ? s:ChooseValue('php_alt_arrays', 1) : 0)

  " Alt color for comparisons (s:alt_comparisons) {{{2
  let s:alt_comparisons = s:ChooseValue('php_alt_comparisons', s:ChooseValue('php_oldStyle', 1))

  " Alt colors for ';' after return/break (s:smart_semicolon) {{{2
  let s:smart_semicolon = s:large_file ? 0 : (s:show_semicolon && s:ChooseValue('php_smart_semicolon', 1))

  " Alt colors for '->' (s:smart_members / s:alt_properties) {{{2
  let s:smart_members = s:large_file ? 0 : s:ChooseValue('php_smart_members', 0)
  let s:alt_properties = (s:smart_members && s:ChooseValue('php_alt_properties', 0))

  " Syncing method (s:sync) {{{2
  let s:sync = s:ChooseValue('php_sync_method', -1)

" }}}1

delfunction s:ChooseValue

syn cluster htmlPreproc add=phpRegion,phpRegionAsp,phpRegionSc

" need to source the SQL syntax file in case we encounter
" heredoc containing SQL
if version < 600
  syn include @sqlTop <sfile>:p:h/sql.vim
else
  syn include @sqlTop syntax/sql.vim
endif

syn sync clear
unlet b:current_syntax
syn cluster sqlTop remove=sqlString,sqlComment
if s:show_sql
  syn cluster phpClShowInStrings contains=@sqlTop
endif

if s:show_html_in_strings
  syn cluster phpClShowInStrings add=@htmlTop
endif

" NOTE: syntax case should be 'ignore' for all items (in keeping
" with PHP's case insensitive behaviour).  If an item MUST be case
" sensitive, 'syntax case match' should precede that item and
" 'syntax case ignore' must follow IMMEDIATELY after so that there
" can be no confusion over the value of 'syntax case' for most items
" syntax matches and regions may use '\C' to utilize case sensitivity
syn case ignore

" PHP syntax: clusters {{{1

  " these represent a single value in PHP
  syn cluster phpClValues add=@phpClConstants

  syn cluster phpClValues add=phpIdentifier,phpIdentifierComplex,phpMethodsVar

  " TODO: add class constants (foo::BAR)

  " these can go anywhere an expression is valid inside PHP code
  syn cluster phpClExpressions add=@phpClValues
  syn cluster phpClExpressions add=phpRelation,phpList
  syn cluster phpClExpressions add=phpParent,phpParentError
  syn cluster phpClExpressions add=phpObjectOperator

  " these are the control statements - they shouldn't contain each other
  syn cluster phpClCode add=@phpClExpressions
  syn cluster phpClCode add=phpLabel
  syn cluster phpClCode add=phpFoldTry,phpFoldCatch

  " TODO: what is phpStorageClass class exactly? it needs a more descriptive
  " name so I know where to include it.  Maybe it should be broken up
  syn cluster phpClCode add=phpStorageClass

  " code which is inside a function/method/class or global scope
  syn cluster phpClInFunction add=@phpClCode
  syn cluster phpClInMethod add=@phpClCode
  syn cluster phpClInClass add=@phpClValues,phpAssign,phpSemicolon
  syn cluster phpClTop add=@phpClCode

  " This cluster contains matches to find where an expression follows another
  " expression without a comma or operator inbetween
  " TODO: is this even possible to do?
  syn cluster phpClExprNotSeparated add=NONE

  " Note: there is one cluster here each for:
  "  - constants
  "  - functions
  "  - classes
  "  - interfaces
  "  - structures (classes and interfaces combined)
  "  - methods
  "  - properties
  "  - members (things which are a method and a property)
  syn cluster phpClConstants add=NONE
  syn cluster phpClFunctions add=NONE

  syn cluster phpClClasses add=NONE
  syn cluster phpClInterfaces add=NONE
  syn cluster phpClStructures add=@phpClClasses,@phpClInterfaces

  syn cluster phpClMethods add=@phpClMembers
  syn cluster phpClProperties add=@phpClMembers
  syn cluster phpClMembers add=NONE

  " these are the things which can be matched inside an identifier
  syn cluster phpClIdentifier add=NONE

  " Note: the next clusters contains all the regions or matches that can
  " contain a class or interface name
  syn cluster phpClClassHere add=phpStructureHere
  syn cluster phpClInterfaceHere add=phpStructureHere
  syn cluster phpClStructureHere add=@phpClClassHere,@phpClStructureHere

  syn cluster phpClMethodHere add=phpMemberHere,phpMethodHere
  syn cluster phpClPropertyHere add=phpMemberHere,phpPropertyHere
  syn cluster phpClMemberHere add=@phpClMethodHere,@phpClPropertyHere

  " also, some very basic matches for these place-holders
  syn match phpStructureHere /\h\w*/ contained display
  syn match phpMemberHere /\h\w*/ contained display
  syn match phpMethodHere /\h\w*/ contained display
  syn match phpPropertyHere /\h\w*/ contained display

  " what to include at the top level?
  if ! s:strict_blocks
    " if not strict blocks, we must also allow matching of things from inside
    " functions/methods/classes
    syn cluster phpClTop add=@phpClInFunction,@phpClInMethod,@phpClInClass
  endif

  " Note: these are the old clusters ... they are deprecated now, but still
  " here just in case someone is using them elsewhere
  syn cluster phpClInside add=@phpClExpressions
  syn cluster phpClConst add=@phpClExpressions
  syn cluster phpClFunction add=@phpClCode

" PHP syntax: comments {{{1

  syn cluster phpClValues add=phpComment
  syn cluster phpClInClass add=phpComment

  syn region phpComment start="/\*" end="\*/" contained extend contains=@Spell
  if version >= 600
    syn match phpComment "#.\{-}\(?>\|$\)\@="  contained extend contains=@Spell
    syn match phpComment "//.\{-}\(?>\|$\)\@=" contained extend contains=@Spell
  else
    syn match phpComment "#.\{-}$"         contained
    syn match phpComment "#.\{-}?>"me=e-2  contained
    syn match phpComment "//.\{-}$"        contained
    syn match phpComment "//.\{-}?>"me=e-2 contained
  endif

" PHP syntax: Operators: + - * / && || (etc) {{{1

  " NOTE: these need to come before the numbers (so that floats work)
  syn cluster phpClExpressions add=phpAssign
  syn match phpAssign /==\@!/ contained display
  hi link phpAssign phpOperator

  syn cluster phpClExpressions add=phpOperator
  syn match   phpOperator contained display /[%^|*!.~]/
  " & can't be preceded by a '=' or ',' or '('
  syn match   phpOperator contained display /\%([=,(]\_s*\)\@<!&/
  " + can't be followed by a number or '.'
  " - can't be followed by a number or '.' or '>'
  syn match   phpOperator contained display /+[.0-9]\@!/
  syn match   phpOperator contained display /-[.>0-9]\@!/
  syn match   phpOperator contained display /[-+*/%^&|.]=/
  syn match   phpOperator contained display /\/[*/]\@!/
  syn match   phpOperator contained display /&&/
  syn match   phpOperator contained display /||/
  syn match   phpOperator contained display />>/
  " Note: how the shift-left operator can't be followed by another '<' (that
  " would make it a Heredoc syntax)
  syn match   phpOperator contained display /<<<\@!/
  syn keyword phpOperator	contained and or xor

  " allow a ':' on its own - this may be after an 'else:' or something like that
  syn match phpOperator contained display /::\@!/

  syn cluster phpClExpressions add=phpTernaryRegion
  syn region phpTernaryRegion matchgroup=phpOperator start=/?/ end=/::\@!/
        \ transparent keepend extend display
        \ contained matchgroup=Error end=/[;)\]}]/


" PHP syntax: null/true/false/numbers {{{1

  syn cluster phpClValues add=phpNull
  syn keyword phpNull contained null

  syn cluster phpClValues add=phpBoolean
  syn keyword phpBoolean contained true false

  syn cluster phpClValues add=phpNumber
  syn match phpNumber contained display /\<[1-9]\d*\>/
  syn match phpNumber contained display /-[1-9]\d*\>/
  syn match phpNumber contained display /+[1-9]\d*\>/
  syn match phpNumber contained display /\<0x\x\{1,8}\>/
  syn match phpNumber contained display /\<0\d*\>/ contains=phpOctalError
  syn match phpOctalError contained display /[89]/

  " Note: I've split float into 3 matches which each have a fixed starting
  " character
  syn cluster phpClValues add=phpFloat
  syn match phpFloat contained display /\.\d\+\>/
  syn match phpFloat contained display /\<\d\+\.\d\+\>/
  syn match phpFloat contained display /-\d*\.\d\+\>/
  syn match phpFloat contained display /+\d*\.\d\+\>/

" PHP syntax: dynamic strings {{{1

  " single-quoted strings are always the same
  " TODO: work out a good name for an option which will add 'display' option
  " to these strings
  syn cluster phpClValues add=phpStringSingle
  syn region phpStringSingle matchgroup=phpQuoteSingle   start=/'/ skip=/\\./ end=/'/
        \ contained keepend extend contains=@phpClShowInStrings

  " Note: this next version of the php double-quoted string can't contain
  " variables, because a few parts of PHP code require strings without
  " variables.  There is another string match later which takes precedence
  " over this one in most circumstances where a string containing variables IS
  " allowed
  syn cluster phpClValues add=phpStringDoubleConstant
  syn region phpStringDoubleConstant contained keepend extend
        \ matchgroup=phpQuoteSingle start=/"/ end=/"/ skip=/\\./
        \ contains=@phpClShowInStrings,phpSpecialChar

  " Note: this version of the double-quoted string also contains
  " @phpClStringIdentifiers, which means variables can go inside the string
  syn cluster phpClExpressions add=phpStringDouble
  syn region phpStringDouble matchgroup=phpQuoteDouble   start=/"/ skip=/\\./ end=/"/
        \ contained keepend extend
        \ contains=@phpClShowInStrings,phpSpecialChar,@phpClStringIdentifiers

  " backticks
  syn cluster phpClExpressions add=phpBacktick
  syn region phpBacktick matchgroup=phpQuoteBacktick start=/`/ skip=/\\./ end=/`/
        \ contained keepend extend
        \ contains=phpSpecialChar,@phpClStringIdentifiers

  " this cluster contains only strings which accept things like \n or \x32
  " inside them
  syn cluster phpClStringsWithSpecials add=phpStringDoubleConstant,@phpClStringsWithIdentifiers

  " this cluster contains strings which accept things like {$foo} inside them
  syn cluster phpClStringsWithIdentifiers add=phpStringDouble,phpBacktick,phpHereDoc

  " HereDoc {{{
  if version >= 600
    syn cluster phpClExpressions add=phpHereDoc
    syn case match
"    syn keyword phpHereDoc contained foobar
    if s:folding && s:fold_heredoc
      syn region phpHereDoc keepend extend contained
            \ matchgroup=phpHereDocDelimiter end=/^\z1\%(;\=$\)\@=/
            \ start=/<<<\s*\z(\h\w*\)$/
            \ contains=phpSpecialChar
            \ fold

      " always match special Heredocs which state what type of content they have
      syn region phpHereDoc keepend extend contained
            \ matchgroup=phpHereDocDelimiter end=/^\z1\%(;\=$\)\@=/
            \ start=/\c<<<\s*\z(\%(\h\w*\)\=html\)$/
            \ contains=@htmlTop,phpSpecialChar
            \ fold
      syn region phpHereDoc keepend extend contained
            \ matchgroup=phpHereDocDelimiter end=/^\z1\%(;\=$\)\@=/
            \ start=/\c<<<\s*\z(\%(\h\w*\)\=sql\)$/
            \ contains=@sqlTop,phpSpecialChar
            \ fold
      syn region phpHereDoc keepend extend contained
            \ matchgroup=phpHereDocDelimiter end=/^\z1\%(;\=$\)\@=/
            \ start=/\c<<<\s*\z(\%(\h\w*\)\=javascript\)$/
            \ contains=@htmlJavascript,phpSpecialChar
            \fold
    else
      syn region phpHereDoc keepend extend contained
            \ matchgroup=phpHereDocDelimiter end=/^\z1\%(;\=$\)\@=/
            \ start=/<<<\s*\z(\h\w*\)$/
            \ contains=phpSpecialChar

      " always match special Heredocs which state what type of content they have
      syn region phpHereDoc keepend extend contained
            \ matchgroup=phpHereDocDelimiter end=/^\z1\%(;\=$\)\@=/
            \ start=/\c<<<\s*\z(\%(\h\w*\)\=html\)$/
            \ contains=@htmlTop,phpSpecialChar
      syn region phpHereDoc keepend extend contained
            \ matchgroup=phpHereDocDelimiter end=/^\z1\%(;\=$\)\@=/
            \ start=/\c<<<\s*\z(\%(\h\w*\)\=sql\)$/
            \ contains=@sqlTop,phpSpecialChar
      syn region phpHereDoc keepend extend contained
            \ matchgroup=phpHereDocDelimiter end=/^\z1\%(;\=$\)\@=/
            \ start=/\c<<<\s*\z(\%(\h\w*\)\=javascript\)$/
            \ contains=@htmlJavascript,phpSpecialChar
    endif

    syn case ignore
  endif " }}}


" PHP syntax: strings: special sequences {{{1

  " match an escaped backslash inside any type of string
  syn match phpStringLiteral /\\\\/ contained display
        \ containedin=phpStringSingle,@phpClStringsWithSpecials

  " match an escaped quote in each type of string
  syn match phpStringLiteral /\\`/ contained display containedin=phpBacktick
  syn match phpStringLiteral /\\'/ contained display containedin=phpStringSingle
  syn match phpStringLiteral /\\"/ contained display
        \ containedin=phpStringDouble,phpStringDoubleConstant

  " highlighting for an escaped '\$' inside a double-quoted string
  syn match phpStringLiteral /\\\$/ contained display containedin=@phpClStringsWithSpecials

  " match \{ as regular string content so that it stops \{$var} from
  " highlighting the { } region
  syn match phpStringRegular /\\{/ contained display containedin=@phpClStringsWithSpecials
  hi link phpStringRegular phpStringDouble

  " match an \r\n\t or hex or octal sequence
  " TODO: these should also be available in PCRE pattern strings
  " TODO: what were all these extra escape sequences???
  syn match phpSpecialChar contained display /\\[nrt]/
  syn match phpSpecialChar contained display /\\\o\{1,3}/
  syn match phpSpecialChar contained display /\\x\x\x\=/

  " create an identifier match for inside strings:
  syn match phpIdentifierInString /\$\h\w*/ contained display
        \ nextgroup=phpPropertyInString,phpPropertyInStringError,@phpClIdentifierIndexInString
        \ contains=phpIdentifier
        \ containedin=@phpClStringsWithIdentifiers

  " match an index [bar] [0] [$key] after a variable inside a string {{{2

    " First: match the [ and ] which would appear in the index (they're
    " contained int the following items)
    syn match phpBracketInString /[[\]]/ contained display
    hi link phpBracketInString phpSpecialChar

    " Second: match a single '[' as an error
    syn cluster phpClIdentifierIndexInString add=phpBracketInStringFalseStart
    syn match phpBracketInStringFalseStart /\[\]\=/ contained display
    hi link phpBracketInStringFalseStart Error

    " Third: match any other [] region which is completed, but doesn't have a
    " valid key
    syn cluster phpClIdentifierIndexInString add=phpIdentifierIndexInString
    syn match phpIdentifierIndexInString /\[[^"]\{-1,}\]/
          \ contains=phpBracketInString,phpIdentifierIndexInStringError
          \ contained display

      " error on a bracket which is inside another bracket
      syn match phpIdentifierIndexInStringError /\[[$_a-z0-9]*\[/ contained display
      hi link phpIdentifierIndexInStringError Error

      " any character which isn't a valid index character
      syn match phpIdentifierIndexInStringError /[^$a-z0-9_[\]]\+/ contained display

      " a number *must not* be preceded by the '[' and followed by a \w
      syn match phpIdentifierIndexInStringError /\[\@<=\d\+\w\@=/ contained display

      " a dollar sign *must* be preceded by the '['
      syn match phpIdentifierIndexInStringError /\[\@<!\$/ contained display
            \ containedin=phpIdentifierIndexInStringError

    " Fourth: match a complete '[]' region properly

      " 1) an index containing a number
      syn match phpIdentifierIndexInString /\[\d\+\]/ contained display
            \ contains=phpBracketInString

      " 2) a word or variable
      syn match phpIdentifierIndexInString /\[\$\=\h\w*\]/ contained display
            \ contains=phpBracketInString,phpVarSelector
      hi link phpIdentifierIndexInString Identifier

  " }}}2

  " match an property after a variable inside a string
  syn cluster phpClPropertyHere add=phpPropertyInString
  syn match phpPropertyInString /->\h\w*/ contained display extend
        \ contains=phpPropertySelector,@phpClProperties

  " it's sometimes easy to get it wrong
  syn match phpPropertyInStringError contained display /->\%([^a-z0-9_"\\]\|\\.\)/
        \ contains=phpPropertySelector
  syn match phpPropertyInStringError contained display /->"\@=/
  hi! link phpPropertyInStringError Error

  syn region phpIdentifierInStringComplex matchgroup=phpSpecialChar
        \ start=/{\$\@=/ start=/\${\w\@!/ end=/}/
        \ contained extend keepend contains=@phpClExpressions
        \ containedin=@phpClStringsWithIdentifiers

  syn region phpIdentifierInStringErratic contained extend
        \ matchgroup=phpSpecialChar start=/\${\w\@=/ end=/}/
        \ containedin=@phpClStringsWithIdentifiers
        \ contains=phpIdentifierErratic

  syn match phpIdentifierErratic /{\@<=\h\w*/ contained
        \ nextgroup=phpErraticBracketRegion
        \ nextgroup=phpIdentifierInStringErraticError skipwhite skipempty
  syn region phpErraticBracketRegion contained keepend extend contains=@phpClExpressions
        \ matchgroup=phpParent start=/\[/ end=/\]/ display
        \ matchgroup=Error end=/;/
        \ nextgroup=phpIdentifierInStringErraticError skipwhite skipempty

  syn match phpIdentifierInStringErraticError contained /[^ \t\r\n}]\+/
        \ nextgroup=phpIdentifierInStringErraticError skipwhite skipempty
  hi link phpIdentifierInStringErraticError Error


" PHP syntax: variables/identifiers ($foo) {{{1

  " one $
  syn match phpVarSelector      contained display /\$/
  " two $$
  syn match phpVarSelectorDeref contained display /\$\$/
  syn match phpVarSelectorError contained display /\$\$\$\+/

  " match a regular variable
  syn cluster phpClExpressions add=phpIdentifier
  syn match phpIdentifier /\$\h\w*/ contained display
        \ contains=phpVarSelector,@phpClIdentifier

  " match a dereference-variable ($$variable)
  syn match phpIdentifier /\$\$\+\h\w*/ contained display
        \ contains=@phpClIdentifier,phpVarSelectorDeref,phpVarSelectorError,phpDerefInvalid

  " you can't dereference these variables:
  syn match phpDerefInvalid contained display
        \ /\C\$\$\ze\%(this\|arg[cv]\|GLOBALS\)\>/
  syn match phpDerefInvalid contained display
        \ /\C\$\$\ze_\%(GET\|POST\|REQUEST\|COOKIE\|SESSION\|SERVER\|ENV\)\>/
  hi link phpDerefInvalid Error

  if s:special_vars

    syn case match

    " Superglobals: {{{2
    syn cluster phpClIdentifier add=phpSuperglobal
    syn match phpSuperglobal contained display /\$\@<=GLOBALS\>/
    syn match phpSuperglobal contained display /\$\@<=_GET\>/
    syn match phpSuperglobal contained display /\$\@<=_POST\>/
    syn match phpSuperglobal contained display /\$\@<=_COOKIE\>/
    syn match phpSuperglobal contained display /\$\@<=_REQUEST\>/
    syn match phpSuperglobal contained display /\$\@<=_FILES\>/
    syn match phpSuperglobal contained display /\$\@<=_SESSION\>/
    syn match phpSuperglobal contained display /\$\@<=_SERVER\>/
    syn match phpSuperglobal contained display /\$\@<=_ENV\>/
    syn match phpSuperglobal contained display /\$\@<=this\>/
    syn match phpSuperglobal contained display /\$\@<=HTTP_RAW_POST_DATA >/

    " Built In Variables: {{{2
    syn cluster phpClIdentifier add=phpBuiltinVar
    syn match phpBuiltinVar contained display /\$\@<=argc\>/
    syn match phpBuiltinVar contained display /\$\@<=argv\>/
    syn match phpBuiltinVar contained display /\$\@<=php_errormsg\>/
    syn match phpBuiltinVar contained display /\$\@<=http_response_header>/

    " Long Arrays: {{{2
    syn cluster phpClIdentifier add=phpLongVar
    syn match phpLongVar contained display /\$\@<=HTTP_GET_VARS\>/
    syn match phpLongVar contained display /\$\@<=HTTP_POST_VARS\>/
    syn match phpLongVar contained display /\$\@<=HTTP_POST_FILES\>/
    syn match phpLongVar contained display /\$\@<=HTTP_COOKIE_VARS\>/
    syn match phpLongVar contained display /\$\@<=HTTP_SESSION_VARS\>/
    syn match phpLongVar contained display /\$\@<=HTTP_SERVER_VARS\>/
    syn match phpLongVar contained display /\$\@<=HTTP_ENV_VARS\>/

    " Server Variables: {{{2
    " TODO: check these against the latest PHP manual
    syn cluster phpClIdentifier add=phpEnvVar
    syn match phpEnvVar contained display /\C\$\@<=GATEWAY_INTERFACE\>/
    syn match phpEnvVar contained display /\C\$\@<=SERVER_NAME\>/
    syn match phpEnvVar contained display /\C\$\@<=SERVER_SOFTWARE\>/
    syn match phpEnvVar contained display /\C\$\@<=SERVER_PROTOCOL\>/
    syn match phpEnvVar contained display /\C\$\@<=REQUEST_METHOD\>/
    syn match phpEnvVar contained display /\C\$\@<=QUERY_STRING\>/
    syn match phpEnvVar contained display /\C\$\@<=DOCUMENT_ROOT\>/
    syn match phpEnvVar contained display /\C\$\@<=HTTP_ACCEPT\>/
    syn match phpEnvVar contained display /\C\$\@<=HTTP_ACCEPT_CHARSET\>/
    syn match phpEnvVar contained display /\C\$\@<=HTTP_ENCODING\>/
    syn match phpEnvVar contained display /\C\$\@<=HTTP_ACCEPT_LANGUAGE\>/
    syn match phpEnvVar contained display /\C\$\@<=HTTP_CONNECTION\>/
    syn match phpEnvVar contained display /\C\$\@<=HTTP_HOST\>/
    syn match phpEnvVar contained display /\C\$\@<=HTTP_REFERER\>/
    syn match phpEnvVar contained display /\C\$\@<=HTTP_USER_AGENT\>/
    syn match phpEnvVar contained display /\C\$\@<=REMOTE_ADDR\>/
    syn match phpEnvVar contained display /\C\$\@<=REMOTE_PORT\>/
    syn match phpEnvVar contained display /\C\$\@<=SCRIPT_FILENAME\>/
    syn match phpEnvVar contained display /\C\$\@<=SERVER_ADMIN\>/
    syn match phpEnvVar contained display /\C\$\@<=SERVER_PORT\>/
    syn match phpEnvVar contained display /\C\$\@<=SERVER_SIGNATURE\>/
    syn match phpEnvVar contained display /\C\$\@<=PATH_TRANSLATED\>/
    syn match phpEnvVar contained display /\C\$\@<=SCRIPT_NAME\>/
    syn match phpEnvVar contained display /\C\$\@<=REQUEST_URI\>/
    syn match phpEnvVar contained display /\C\$\@<=PHP_SELF\>/
  endif

  " }}}2

" PHP Syntax: type-casting: (string)$foo {{{1

  syn cluster phpClValues add=phpType
  syn keyword phpType contained null bool boolean int integer real double float string object
  " only match 'array' as a type when it *isn't* followed by '('
  syn match phpType contained /\<array\>\%(\_s*(\)\@!/

" PHP Syntax: function/static calls: {{{1

  " Note: I could have forced function calls to be matched only when a '('
  " follows, but I think users would want PHP functions highlighted in more
  " places, rather than less, so I have just added the :\@! to make sure it is
  " not part of a static method call
  " Note: this didn't work properly ... if the match didn't include the
  " '(...)', then functions in @phpClFunctions can't have a nextgroup on them
  syn cluster phpClExpressions add=@phpClFunctions
"  syn cluster phpClExpressions add=phpFunctionCall
"  syn match phpFunctionCall contained /\<\%(\h\w*\)(\_.*)/
"        \ contains=@phpClFunctions

  " Also, a match when a word is part of a :: reference:
  syn cluster phpClValues add=phpStaticUsage
  syn cluster phpClExpressions add=phpStaticUsage
  syn cluster phpClStructureHere add=phpStaticUsage
  syn match phpStaticUsage contained display /\<\%(\h\w*\)\@>\%(\_s*::\)\@=/
        \ transparent contains=@phpClClasses


  " a match for a static function call
  syn cluster phpClValues add=phpStaticAccess
  syn cluster phpClExpressions add=phpStaticVariable,phpStaticCall
  syn cluster phpClPropertyHere add=phpStaticAccess
  syn cluster phpClMethodHere add=phpStaticCall

  " also allowed in function prototypes
  syn cluster phpClDefineFuncProtoArgs add=phpStaticAccess

  syn match phpStaticAccess contained extend display /::\_s*\%(\h\w*\|\%#\)/ contains=phpDoubleColon
  syn match phpStaticCall contained extend display /::\_s*\h\w*\ze\_s*(/
        \ contains=phpDoubleColon,@phpClMethods

  " a match for a static variable usage
  syn match phpStaticVariable contained display /::\_s*\$\h\w*/ extend
        \ contains=phpDoubleColon,phpIdentifier

  " a match for a static constant usage

  syn match phpDoubleColon contained display /::/
  hi link phpDoubleColon phpDefine


" PHP Syntax: magic classes (self/parent): {{{1

  syn cluster phpClClasses add=phpMagicClass
  syn keyword phpMagicClass contained self parent

  " Note: 'self' and 'parent' are also matched in other places because they
  " could be confusing otherwise ...
  syn cluster phpClValues add=phpMagicClass

" PHP Syntax: control structures: {{{1

  syn cluster phpClCode add=phpConditional
  syn keyword phpConditional contained declare enddeclare if else elseif endif

  syn cluster phpClCode add=phpRepeat
  syn keyword phpRepeat contained foreach endforeach
        \ do while endwhile for endfor
        \ switch endswitch

  " override 'foreach' if we need use a special colour for the '(...)' region
  if s:alt_arrays || s:alt_control_parents
    syn keyword phpRepeat contained foreach nextgroup=phpForeachRegion skipwhite skipempty
    syn keyword phpAs contained as containedin=phpForeachRegion
    hi link phpAs phpRepeat
  else
    " otherwise, allow 'as' anywhere
    syn cluster phpClExpressions add=phpAs
    syn keyword phpAs contained as
  endif

  if s:strict_blocks
    " need an alternate parenthesis block for 'for' structure
    " when using strict blocks
    syn keyword phpRepeat contained for nextgroup=phpForRegion skipwhite skipempty

    " if looking for errors with semicolons, add the other 'nextgroups' as well
    if s:no_empty_construct
      syn keyword phpRepeat contained while nextgroup=phpConstructRegion skipwhite skipempty
      syn keyword phpRepeat contained switch nextgroup=phpSwitchConstructRegion skipwhite skipempty
      syn keyword phpConditional contained if elseif nextgroup=phpConstructRegion skipwhite skipempty
      syn keyword phpConditional contained else nextgroup=phpSemicolonNotAllowedHere skipwhite skipempty
      syn keyword phpRepeat contained do nextgroup=phpDoBlock,phpSemicolonNotAllowedHere skipwhite skipempty
      if s:folding == 2
        syn region phpDoBlock matchgroup=phpBrace start=/{/ end=/}/ keepend extend
              \ contained transparent
              \ nextgroup=phpDoWhile skipwhite skipempty
"              \ matchgroup=phpHTMLError end=/?>/
              \ fold
        syn region phpSwitchBlock matchgroup=phpBrace start=/{/ end=/}/ keepend extend
              \ contained contains=@phpClInSwitch,@phpClCode
              \ fold
      else
        syn region phpDoBlock matchgroup=phpBrace start=/{/ end=/}/ keepend extend
              \ contained transparent
              \ nextgroup=phpDoWhile skipwhite skipempty
"              \ matchgroup=phpHTMLError end=/?>/
        syn region phpSwitchBlock matchgroup=phpBrace start=/{/ end=/}/ keepend extend
              \ contained contains=@phpClInSwitch,@phpClCode

        " TODO: thoroughly test this feature ...
        if s:fold_manual
          syn region phpDoBlock matchgroup=phpBrace start='{\ze\s*//\s*fold\s*$\c' end='}' keepend extend
                \ contained transparent
                \ nextgroup=phpDoWhile skipwhite skipempty
"               \ matchgroup=phpHTMLError end=/?>/
                \ fold
          syn region phpSwitchBlock matchgroup=phpBrace start='{\ze\s*//\s*fold\s*$\c' end='}' keepend extend
                \ contained contains=@phpClInSwitch,@phpClCode
                \ fold
        endif
      endif
      syn keyword phpDoWhile contained while nextgroup=phpDoWhileConstructRegion skipwhite skipempty
      hi link phpDoWhile phpRepeat
    endif
  endif


" PHP Syntax: statements: {{{1

  " if we are not using smart semicolons, we can implement these using
  " keywords
  if ! s:smart_semicolon
    syn cluster phpClCode add=phpStatement
    syn keyword phpStatement contained return break continue exit die throw

    syn cluster phpClInSwitch add=phpCase
    syn keyword phpCase contained case default

  else
    " if we *are* using smart semicolons, we'll need to use regions instead
    syn cluster phpClCode add=phpStatementRegion
    syn cluster phpClInSwitch add=phpCaseRegion

    " with or without error on mis-matched /})]/ at end?
    " Note: by containing phpSemicolonError, the semicolon error is
    " automatically taken care of by the phpSemicolonError item

    " return/break/continue/exit/die: {{{2
    " Note: having an error ending at 'private/var/final' etc, makes things much
    " much faster for writing classes.
    if s:strict_blocks
      syn region phpStatementRegion extend keepend contained
            \ contains=@phpClExpressions,phpSemicolonError
            \ matchgroup=phpStatement end=/;/ end=/\ze?>/
            \ start=/\$\@<!\<return\>/
            \ start=/\$\@<!\<break\>/
            \ start=/\$\@<!\<continue\>/
            \ start=/\$\@<!\<exit\>/
            \ start=/\$\@<!\<die\>/
            \ start=/\$\@<!\<throw\>/
            \ matchgroup=Error
              \ end=/[$>]\@<!\<\%(protected\|public\|private\|var\|final\|abstract\|static\)\>/
              \ end=/}/ end=/)/ end=/\]/
              \ end=/,/
"              \ end=/;\_s*\%([.*\^|&,:!=<>]\|?>\@!\|\/[/*]\@!\|++\@!\|--\@!\)/
    else
      syn region phpStatementRegion extend keepend contained
            \ contains=@phpClExpressions,phpSemicolonError
            \ matchgroup=phpStatement end=/;/
            \ start=/\$\@<!\<return\>/
            \ start=/\$\@<!\<break\>/
            \ start=/\$\@<!\<continue\>/
            \ start=/\$\@<!\<exit\>/
            \ start=/\$\@<!\<die\>/
            \ start=/\$\@<!\<throw\>/
"              \ end=/;\_s*\%([.*\^|&,:!=<>]\|?>\@!\|\/[/*]\@!\|++\@!\|--\@!\)/
    endif " }}}2
    " case: {{{2
    if s:strict_blocks
      syn region phpCaseRegion extend keepend contained display
            \ contains=@phpClExpressions,phpSemicolonError,phpColonError
            \ matchgroup=phpCase start=/\$\@<!\<case\>/ end=/[;:]/ skip=/::/
            \ matchgroup=Error
              \ end=/}/ end=/)/ end=/\]/
"              \ end=/;\_s*\%([.*\^|&,:!=<>]\|?>\@!\|\/[/*]\@!\|++\@!\|--\@!\)/
    else
      syn region phpCaseRegion extend keepend contained display
            \ contains=@phpClExpressions,phpSemicolonError,phpColonError
            \ matchgroup=phpCase start=/\$\@<!\<case\>/ end=/[;:]/
    endif " }}}2
    " default: {{{2
    if s:strict_blocks
      syn region phpCaseRegion extend keepend contained display
            \ contains=phpComment,phpSemicolonError,phpColonError
            \ matchgroup=phpCase start=/\$\@<!\<default\>/ end=/[;:]/
            \ matchgroup=Error end=/}/ end=/)/ end=/\]/
"              \ end=/;\_s*\%([.*\^|&,:!=<>]\|?>\@!\|\/[/*]\@!\|++\@!\|--\@!\)/
    else
      syn region phpCaseRegion extend keepend contained display
            \ contains=phpComment,phpSemicolonError,phpColonError
            \ matchgroup=phpCase start=/\$\@<!\<default\>/ end=/[;:]/
    endif " }}}2

  endif

  " if we *aren't* using strict blocks, allow a 'case' or 'default'
  " anywhere in regular code
  if ! s:strict_blocks
    syn cluster phpClCode add=@phpClInSwitch
  endif


" PHP Syntax: semicolons: {{{1

  if s:show_semicolon
    " highlight the semicolon anywhere it appears in regular code
    syn cluster phpClExpressions add=phpSemicolon
    syn match phpSemicolon /;/ contained display contains=phpSemicolonError

    " match a semicolon or colon which is followed by one of:
    "   = ! . +-*/ &|^ < > , ? :
    if s:show_semicolon_error
      " match a semicolon or colon which is followed by one of:
      "   = ! . +-*/ &|^ < > , ? :
      syn match phpSemicolonError contained display extend
            \ ";\_s*\%(\%(\%(//.*$\|#.*$\|/\*\_.\{-}\*/\)\_s*\)*\)\@>\%([.*/\^|&,:!=<>]\|?>\@!\|++\@!\|--\@!\)"
      syn match phpColonError contained display extend
            \ "::\@!\_s*\%(\%(\%(//.*$\|#.*$\|/\*\_.\{-}\*/\)\_s*\)*\)\@>\%([.*/\^|&,:!=<>]\|?>\@!\|++\@!\|--\@!\)"
    endif
    hi link phpSemicolonError Error
    hi link phpColonError Error

    " need to sync back one or two linebreaks to capture the semicolon
    " error properly
    syn sync linebreaks=2
  endif

  " a special match for when a semicolon is not allowed here
  " Note: this is contained/nextgrouped by other items, not included
  " directly
  if s:no_empty_construct
    syn match phpSemicolonNotAllowedHere /;/ contained display
  endif


" PHP Syntax: constants: {{{1

  " Magic Constants {{{2
    syn cluster phpClConstants add=phpMagicConstant
    syn case match
    syn keyword phpMagicConstant contained __LINE__ __FILE__ __FUNCTION__ __METHOD__ __CLASS__ __DIR__ __NAMESPACE__
    syn case ignore
  " }}}2

  " Built-in Constants {{{2
  " TODO: check these against the latest PHP manual
    syn cluster phpClConstants add=phpCoreConstant
    syn case match
    " Core
    syn keyword phpCoreConstant E_ERROR E_RECOVERABLE_ERROR E_WARNING E_PARSE E_NOTICE E_STRICT E_DEPRECATED E_CORE_ERROR E_CORE_WARNING E_COMPILE_ERROR E_COMPILE_WARNING E_USER_ERROR E_USER_WARNING E_USER_NOTICE E_USER_DEPRECATED E_ALL TRUE FALSE NULL ZEND_THREAD_SAFE ZEND_DEBUG_BUILD PHP_VERSION PHP_MAJOR_VERSION PHP_MINOR_VERSION PHP_RELEASE_VERSION PHP_EXTRA_VERSION PHP_VERSION_ID PHP_ZTS PHP_DEBUG PHP_OS PHP_SAPI DEFAULT_INCLUDE_PATH PEAR_INSTALL_DIR PEAR_EXTENSION_DIR PHP_EXTENSION_DIR PHP_PREFIX PHP_BINDIR PHP_LIBDIR PHP_DATADIR PHP_SYSCONFDIR PHP_LOCALSTATEDIR PHP_CONFIG_FILE_PATH PHP_CONFIG_FILE_SCAN_DIR PHP_SHLIB_SUFFIX PHP_EOL PHP_MAXPATHLEN PHP_INT_MAX PHP_INT_SIZE PHP_WINDOWS_VERSION_MAJOR PHP_WINDOWS_VERSION_MINOR PHP_WINDOWS_VERSION_BUILD PHP_WINDOWS_VERSION_PLATFORM PHP_WINDOWS_VERSION_SP_MAJOR PHP_WINDOWS_VERSION_SP_MINOR PHP_WINDOWS_VERSION_SUITEMASK PHP_WINDOWS_VERSION_PRODUCTTYPE PHP_WINDOWS_NT_DOMAIN_CONTROLLER PHP_WINDOWS_NT_SERVER PHP_WINDOWS_NT_WORKSTATION PHP_OUTPUT_HANDLER_START PHP_OUTPUT_HANDLER_CONT PHP_OUTPUT_HANDLER_END PHP_OUTPUT_HANDLER_CLEAN PHP_OUTPUT_HANDLER_CLEANABLE PHP_OUTPUT_HANDLER_DISABLED PHP_OUTPUT_HANDLER_FINAL PHP_OUTPUT_HANDLER_FLUSH PHP_OUTPUT_HANDLER_FLUSHABLE PHP_OUTPUT_HANDLER_REMOVABLE PHP_OUTPUT_HANDLER_STARTED PHP_OUTPUT_HANDLER_STDFLAGS PHP_OUTPUT_HANDLER_WRITE UPLOAD_ERR_OK UPLOAD_ERR_INI_SIZE UPLOAD_ERR_FORM_SIZE UPLOAD_ERR_PARTIAL UPLOAD_ERR_NO_FILE UPLOAD_ERR_NO_TMP_DIR UPLOAD_ERR_CANT_WRITE UPLOAD_ERR_EXTENSION STDIN STDOUT STDERR __COMPILER_HALT_OFFSET__ contained

    " calendar
    syn keyword phpCoreConstant CAL_GREGORIAN CAL_JULIAN CAL_JEWISH CAL_FRENCH CAL_NUM_CALS CAL_DOW_DAYNO CAL_DOW_SHORT CAL_DOW_LONG CAL_MONTH_GREGORIAN_SHORT CAL_MONTH_GREGORIAN_LONG CAL_MONTH_JULIAN_SHORT CAL_MONTH_JULIAN_LONG CAL_MONTH_JEWISH CAL_MONTH_FRENCH CAL_EASTER_DEFAULT CAL_EASTER_ROMAN CAL_EASTER_ALWAYS_GREGORIAN CAL_EASTER_ALWAYS_JULIAN CAL_JEWISH_ADD_ALAFIM_GERESH CAL_JEWISH_ADD_ALAFIM CAL_JEWISH_ADD_GERESHAYIM contained

    " com_dotnet
    syn keyword phpCoreConstant CLSCTX_INPROC_SERVER CLSCTX_INPROC_HANDLER CLSCTX_LOCAL_SERVER CLSCTX_REMOTE_SERVER CLSCTX_SERVER CLSCTX_ALL VT_NULL VT_EMPTY VT_UI1 VT_I1 VT_UI2 VT_I2 VT_UI4 VT_I4 VT_R4 VT_R8 VT_BOOL VT_ERROR VT_CY VT_DATE VT_BSTR VT_DECIMAL VT_UNKNOWN VT_DISPATCH VT_VARIANT VT_INT VT_UINT VT_ARRAY VT_BYREF CP_ACP CP_MACCP CP_OEMCP CP_UTF7 CP_UTF8 CP_SYMBOL CP_THREAD_ACP VARCMP_LT VARCMP_EQ VARCMP_GT VARCMP_NULL NORM_IGNORECASE NORM_IGNORENONSPACE NORM_IGNORESYMBOLS NORM_IGNOREWIDTH NORM_IGNOREKANATYPE DISP_E_DIVBYZERO DISP_E_OVERFLOW DISP_E_BADINDEX MK_E_UNAVAILABLE contained

    " curl
    syn keyword phpCoreConstant CURLOPT_IPRESOLVE CURL_IPRESOLVE_WHATEVER CURL_IPRESOLVE_V4 CURL_IPRESOLVE_V6 CURLOPT_DNS_USE_GLOBAL_CACHE CURLOPT_DNS_CACHE_TIMEOUT CURLOPT_PORT CURLOPT_FILE CURLOPT_READDATA CURLOPT_INFILE CURLOPT_INFILESIZE CURLOPT_URL CURLOPT_PROXY CURLOPT_VERBOSE CURLOPT_HEADER CURLOPT_HTTPHEADER CURLOPT_NOPROGRESS CURLOPT_PROGRESSFUNCTION CURLOPT_NOBODY CURLOPT_FAILONERROR CURLOPT_UPLOAD CURLOPT_POST CURLOPT_FTPLISTONLY CURLOPT_FTPAPPEND CURLOPT_NETRC CURLOPT_FOLLOWLOCATION CURLOPT_PUT CURLOPT_USERPWD CURLOPT_PROXYUSERPWD CURLOPT_RANGE CURLOPT_TIMEOUT CURLOPT_TIMEOUT_MS CURLOPT_POSTFIELDS CURLOPT_REFERER CURLOPT_USERAGENT CURLOPT_FTPPORT CURLOPT_FTP_USE_EPSV CURLOPT_LOW_SPEED_LIMIT CURLOPT_LOW_SPEED_TIME CURLOPT_RESUME_FROM CURLOPT_COOKIE CURLOPT_COOKIESESSION CURLOPT_AUTOREFERER CURLOPT_SSLCERT CURLOPT_SSLCERTPASSWD CURLOPT_WRITEHEADER CURLOPT_SSL_VERIFYHOST CURLOPT_COOKIEFILE CURLOPT_SSLVERSION CURLOPT_TIMECONDITION CURLOPT_TIMEVALUE CURLOPT_CUSTOMREQUEST CURLOPT_STDERR CURLOPT_TRANSFERTEXT CURLOPT_RETURNTRANSFER CURLOPT_QUOTE CURLOPT_POSTQUOTE CURLOPT_INTERFACE CURLOPT_KRB4LEVEL CURLOPT_HTTPPROXYTUNNEL CURLOPT_FILETIME CURLOPT_WRITEFUNCTION CURLOPT_READFUNCTION CURLOPT_HEADERFUNCTION CURLOPT_MAXREDIRS CURLOPT_MAXCONNECTS CURLOPT_CLOSEPOLICY CURLOPT_FRESH_CONNECT CURLOPT_FORBID_REUSE CURLOPT_RANDOM_FILE CURLOPT_EGDSOCKET CURLOPT_CONNECTTIMEOUT CURLOPT_CONNECTTIMEOUT_MS CURLOPT_SSL_VERIFYPEER CURLOPT_CAINFO CURLOPT_CAPATH CURLOPT_COOKIEJAR CURLOPT_SSL_CIPHER_LIST CURLOPT_BINARYTRANSFER CURLOPT_NOSIGNAL CURLOPT_PROXYTYPE CURLOPT_BUFFERSIZE CURLOPT_HTTPGET CURLOPT_HTTP_VERSION CURLOPT_SSLKEY CURLOPT_SSLKEYTYPE CURLOPT_SSLKEYPASSWD CURLOPT_SSLENGINE CURLOPT_SSLENGINE_DEFAULT CURLOPT_SSLCERTTYPE CURLOPT_CRLF CURLOPT_ENCODING CURLOPT_PROXYPORT CURLOPT_UNRESTRICTED_AUTH CURLOPT_FTP_USE_EPRT CURLOPT_TCP_NODELAY CURLOPT_HTTP200ALIASES CURL_TIMECOND_IFMODSINCE CURL_TIMECOND_IFUNMODSINCE CURL_TIMECOND_LASTMOD CURLOPT_HTTPAUTH CURLAUTH_BASIC CURLAUTH_DIGEST CURLAUTH_GSSNEGOTIATE CURLAUTH_NTLM CURLAUTH_ANY CURLAUTH_ANYSAFE CURLOPT_PROXYAUTH CURLOPT_FTP_CREATE_MISSING_DIRS CURLOPT_PRIVATE CURLCLOSEPOLICY_LEAST_RECENTLY_USED CURLCLOSEPOLICY_LEAST_TRAFFIC CURLCLOSEPOLICY_SLOWEST CURLCLOSEPOLICY_CALLBACK CURLCLOSEPOLICY_OLDEST CURLINFO_EFFECTIVE_URL CURLINFO_HTTP_CODE CURLINFO_HEADER_SIZE CURLINFO_REQUEST_SIZE CURLINFO_TOTAL_TIME CURLINFO_NAMELOOKUP_TIME CURLINFO_CONNECT_TIME CURLINFO_PRETRANSFER_TIME CURLINFO_SIZE_UPLOAD CURLINFO_SIZE_DOWNLOAD CURLINFO_SPEED_DOWNLOAD CURLINFO_SPEED_UPLOAD CURLINFO_FILETIME CURLINFO_SSL_VERIFYRESULT CURLINFO_CONTENT_LENGTH_DOWNLOAD CURLINFO_CONTENT_LENGTH_UPLOAD CURLINFO_STARTTRANSFER_TIME CURLINFO_CONTENT_TYPE CURLINFO_REDIRECT_TIME CURLINFO_REDIRECT_COUNT CURLINFO_HEADER_OUT CURLINFO_PRIVATE CURL_VERSION_IPV6 CURL_VERSION_KERBEROS4 CURL_VERSION_SSL CURL_VERSION_LIBZ CURLVERSION_NOW CURLE_OK CURLE_UNSUPPORTED_PROTOCOL CURLE_FAILED_INIT CURLE_URL_MALFORMAT CURLE_URL_MALFORMAT_USER CURLE_COULDNT_RESOLVE_PROXY CURLE_COULDNT_RESOLVE_HOST CURLE_COULDNT_CONNECT CURLE_FTP_WEIRD_SERVER_REPLY CURLE_FTP_ACCESS_DENIED CURLE_FTP_USER_PASSWORD_INCORRECT CURLE_FTP_WEIRD_PASS_REPLY CURLE_FTP_WEIRD_USER_REPLY CURLE_FTP_WEIRD_PASV_REPLY CURLE_FTP_WEIRD_227_FORMAT CURLE_FTP_CANT_GET_HOST CURLE_FTP_CANT_RECONNECT CURLE_FTP_COULDNT_SET_BINARY CURLE_PARTIAL_FILE CURLE_FTP_COULDNT_RETR_FILE CURLE_FTP_WRITE_ERROR CURLE_FTP_QUOTE_ERROR CURLE_HTTP_NOT_FOUND CURLE_WRITE_ERROR CURLE_MALFORMAT_USER CURLE_FTP_COULDNT_STOR_FILE CURLE_READ_ERROR CURLE_OUT_OF_MEMORY CURLE_OPERATION_TIMEOUTED CURLE_FTP_COULDNT_SET_ASCII CURLE_FTP_PORT_FAILED CURLE_FTP_COULDNT_USE_REST CURLE_FTP_COULDNT_GET_SIZE CURLE_HTTP_RANGE_ERROR CURLE_HTTP_POST_ERROR CURLE_SSL_CONNECT_ERROR CURLE_FTP_BAD_DOWNLOAD_RESUME CURLE_FILE_COULDNT_READ_FILE CURLE_LDAP_CANNOT_BIND CURLE_LDAP_SEARCH_FAILED CURLE_LIBRARY_NOT_FOUND CURLE_FUNCTION_NOT_FOUND CURLE_ABORTED_BY_CALLBACK CURLE_BAD_FUNCTION_ARGUMENT CURLE_BAD_CALLING_ORDER CURLE_HTTP_PORT_FAILED CURLE_BAD_PASSWORD_ENTERED CURLE_TOO_MANY_REDIRECTS CURLE_UNKNOWN_TELNET_OPTION CURLE_TELNET_OPTION_SYNTAX CURLE_OBSOLETE CURLE_SSL_PEER_CERTIFICATE CURLE_GOT_NOTHING CURLE_SSL_ENGINE_NOTFOUND CURLE_SSL_ENGINE_SETFAILED CURLE_SEND_ERROR CURLE_RECV_ERROR CURLE_SHARE_IN_USE CURLE_SSL_CERTPROBLEM CURLE_SSL_CIPHER CURLE_SSL_CACERT CURLE_BAD_CONTENT_ENCODING CURLE_LDAP_INVALID_URL CURLE_FILESIZE_EXCEEDED CURLE_FTP_SSL_FAILED CURLPROXY_HTTP CURLPROXY_SOCKS4 CURLPROXY_SOCKS5 CURL_NETRC_OPTIONAL CURL_NETRC_IGNORED CURL_NETRC_REQUIRED CURL_HTTP_VERSION_NONE CURL_HTTP_VERSION_1_0 CURL_HTTP_VERSION_1_1 CURLM_CALL_MULTI_PERFORM CURLM_OK CURLM_BAD_HANDLE CURLM_BAD_EASY_HANDLE CURLM_OUT_OF_MEMORY CURLM_INTERNAL_ERROR CURLMSG_DONE CURLOPT_FTPSSLAUTH CURLFTPAUTH_DEFAULT CURLFTPAUTH_SSL CURLFTPAUTH_TLS CURLOPT_FTP_SSL CURLFTPSSL_NONE CURLFTPSSL_TRY CURLFTPSSL_CONTROL CURLFTPSSL_ALL CURLSSH_AUTH_NONE CURLSSH_AUTH_PUBLICKEY CURLSSH_AUTH_PASSWORD CURLSSH_AUTH_HOST CURLSSH_AUTH_KEYBOARD CURLSSH_AUTH_DEFAULT CURLOPT_SSH_AUTH_TYPES CURLOPT_KEYPASSWD CURLOPT_SSH_PUBLIC_KEYFILE CURLOPT_SSH_PRIVATE_KEYFILE CURLOPT_SSH_HOST_PUBLIC_KEY_MD5 CURLE_SSH CURLOPT_REDIR_PROTOCOLS CURLOPT_PROTOCOLS CURLPROTO_HTTP CURLPROTO_HTTPS CURLPROTO_FTP CURLPROTO_FTPS CURLPROTO_SCP CURLPROTO_SFTP CURLPROTO_TELNET CURLPROTO_LDAP CURLPROTO_LDAPS CURLPROTO_DICT CURLPROTO_FILE CURLPROTO_TFTP CURLPROTO_ALL CURLOPT_FTP_FILEMETHOD CURLFTPMETHOD_MULTICWD CURLFTPMETHOD_NOCWD CURLFTPMETHOD_SINGLECWD CURLOPT_MAX_RECV_SPEED_LARGE CURLOPT_MAX_SEND_SPEED_LARGE contained

    " date
    syn keyword phpCoreConstant  DATE_ATOM DATE_COOKIE DATE_ISO8601 DATE_RFC822 DATE_RFC850 DATE_RFC1036 DATE_RFC1123 DATE_RFC2822 DATE_RFC3339 DATE_RSS DATE_W3C SUNFUNCS_RET_TIMESTAMP SUNFUNCS_RET_STRING SUNFUNCS_RET_DOUBLE ATOM COOKIE ISO8601 RFC822 RFC850 RFC1036 RFC1123 RFC2822 RFC3339 RSS W3C AFRICA AMERICA ANTARCTICA ARCTIC ASIA ATLANTIC AUSTRALIA EUROPE INDIAN PACIFIC UTC ALL ALL_WITH_BC PER_COUNTRY EXCLUDE_START_DATE contained

    " dom
    syn keyword phpCoreConstant XML_ELEMENT_NODE XML_ATTRIBUTE_NODE XML_TEXT_NODE XML_CDATA_SECTION_NODE XML_ENTITY_REF_NODE XML_ENTITY_NODE XML_PI_NODE XML_COMMENT_NODE XML_DOCUMENT_NODE XML_DOCUMENT_TYPE_NODE XML_DOCUMENT_FRAG_NODE XML_NOTATION_NODE XML_HTML_DOCUMENT_NODE XML_DTD_NODE XML_ELEMENT_DECL_NODE XML_ATTRIBUTE_DECL_NODE XML_ENTITY_DECL_NODE XML_NAMESPACE_DECL_NODE XML_LOCAL_NAMESPACE XML_ATTRIBUTE_CDATA XML_ATTRIBUTE_ID XML_ATTRIBUTE_IDREF XML_ATTRIBUTE_IDREFS XML_ATTRIBUTE_ENTITY XML_ATTRIBUTE_NMTOKEN XML_ATTRIBUTE_NMTOKENS XML_ATTRIBUTE_ENUMERATION XML_ATTRIBUTE_NOTATION DOM_PHP_ERR DOM_INDEX_SIZE_ERR DOMSTRING_SIZE_ERR DOM_HIERARCHY_REQUEST_ERR DOM_WRONG_DOCUMENT_ERR DOM_INVALID_CHARACTER_ERR DOM_NO_DATA_ALLOWED_ERR DOM_NO_MODIFICATION_ALLOWED_ERR DOM_NOT_FOUND_ERR DOM_NOT_SUPPORTED_ERR DOM_INUSE_ATTRIBUTE_ERR DOM_INVALID_STATE_ERR DOM_SYNTAX_ERR DOM_INVALID_MODIFICATION_ERR DOM_NAMESPACE_ERR DOM_INVALID_ACCESS_ERR DOM_VALIDATION_ERR contained

    " exif
    syn keyword phpCoreConstant EXIF_USE_MBSTRING contained

    " fileinfo
    syn keyword phpCoreConstant FILEINFO_NONE FILEINFO_SYMLINK FILEINFO_MIME FILEINFO_MIME_TYPE FILEINFO_MIME_ENCODING FILEINFO_DEVICES FILEINFO_CONTINUE FILEINFO_PRESERVE_ATIME FILEINFO_RAW contained

    " filter
    syn keyword phpCoreConstant INPUT_POST INPUT_GET INPUT_COOKIE INPUT_ENV INPUT_SERVER INPUT_SESSION INPUT_REQUEST FILTER_FLAG_NONE FILTER_REQUIRE_SCALAR FILTER_REQUIRE_ARRAY FILTER_FORCE_ARRAY FILTER_NULL_ON_FAILURE FILTER_VALIDATE_INT FILTER_VALIDATE_BOOLEAN FILTER_VALIDATE_FLOAT FILTER_VALIDATE_REGEXP FILTER_VALIDATE_URL FILTER_VALIDATE_EMAIL FILTER_VALIDATE_IP FILTER_DEFAULT FILTER_UNSAFE_RAW FILTER_SANITIZE_STRING FILTER_SANITIZE_STRIPPED FILTER_SANITIZE_ENCODED FILTER_SANITIZE_SPECIAL_CHARS FILTER_SANITIZE_EMAIL FILTER_SANITIZE_URL FILTER_SANITIZE_NUMBER_INT FILTER_SANITIZE_NUMBER_FLOAT FILTER_SANITIZE_MAGIC_QUOTES FILTER_CALLBACK FILTER_FLAG_ALLOW_OCTAL FILTER_FLAG_ALLOW_HEX FILTER_FLAG_STRIP_LOW FILTER_FLAG_STRIP_HIGH FILTER_FLAG_ENCODE_LOW FILTER_FLAG_ENCODE_HIGH FILTER_FLAG_ENCODE_AMP FILTER_FLAG_NO_ENCODE_QUOTES FILTER_FLAG_EMPTY_STRING_NULL FILTER_FLAG_ALLOW_FRACTION FILTER_FLAG_ALLOW_THOUSAND FILTER_FLAG_ALLOW_SCIENTIFIC FILTER_FLAG_SCHEME_REQUIRED FILTER_FLAG_HOST_REQUIRED FILTER_FLAG_PATH_REQUIRED FILTER_FLAG_QUERY_REQUIRED FILTER_FLAG_IPV4 FILTER_FLAG_IPV6 FILTER_FLAG_NO_RES_RANGE FILTER_FLAG_NO_PRIV_RANGE contained

    " ftp
    syn keyword phpCoreConstant FTP_ASCII FTP_TEXT FTP_BINARY FTP_IMAGE FTP_AUTORESUME FTP_TIMEOUT_SEC FTP_AUTOSEEK FTP_FAILED FTP_FINISHED FTP_MOREDATA contained

    " gd
    syn keyword phpCoreConstant IMG_GIF IMG_JPG IMG_JPEG IMG_PNG IMG_WBMP IMG_XPM IMG_COLOR_TILED IMG_COLOR_STYLED IMG_COLOR_BRUSHED IMG_COLOR_STYLEDBRUSHED IMG_COLOR_TRANSPARENT IMG_ARC_ROUNDED IMG_ARC_PIE IMG_ARC_CHORD IMG_ARC_NOFILL IMG_ARC_EDGED IMG_GD2_RAW IMG_GD2_COMPRESSED IMG_EFFECT_REPLACE IMG_EFFECT_ALPHABLEND IMG_EFFECT_NORMAL IMG_EFFECT_OVERLAY GD_BUNDLED IMG_FILTER_NEGATE IMG_FILTER_GRAYSCALE IMG_FILTER_BRIGHTNESS IMG_FILTER_CONTRAST IMG_FILTER_COLORIZE IMG_FILTER_EDGEDETECT IMG_FILTER_GAUSSIAN_BLUR IMG_FILTER_SELECTIVE_BLUR IMG_FILTER_EMBOSS IMG_FILTER_MEAN_REMOVAL IMG_FILTER_SMOOTH IMG_FILTER_PIXELATE GD_VERSION GD_MAJOR_VERSION GD_MINOR_VERSION GD_RELEASE_VERSION GD_EXTRA_VERSION PNG_NO_FILTER PNG_FILTER_NONE PNG_FILTER_SUB PNG_FILTER_UP PNG_FILTER_AVG PNG_FILTER_PAETH PNG_ALL_FILTERS contained

    " gmp
    syn keyword phpCoreConstant GMP_ROUND_ZERO GMP_ROUND_PLUSINF GMP_ROUND_MINUSINF GMP_VERSION contained

    " hash
    syn keyword phpCoreConstant HASH_HMAC MHASH_CRC32 MHASH_MD5 MHASH_SHA1 MHASH_HAVAL256 MHASH_RIPEMD160 MHASH_TIGER MHASH_GOST MHASH_CRC32B MHASH_HAVAL224 MHASH_HAVAL192 MHASH_HAVAL160 MHASH_HAVAL128 MHASH_TIGER128 MHASH_TIGER160 MHASH_MD4 MHASH_SHA256 MHASH_ADLER32 MHASH_SHA224 MHASH_SHA512 MHASH_SHA384 MHASH_WHIRLPOOL MHASH_RIPEMD128 MHASH_RIPEMD256 MHASH_RIPEMD320 MHASH_SNEFRU256 MHASH_MD2 contained

    " iconv
    syn keyword phpCoreConstant ICONV_IMPL ICONV_VERSION ICONV_MIME_DECODE_STRICT ICONV_MIME_DECODE_CONTINUE_ON_ERROR contained

    " imap
    syn keyword phpCoreConstant NIL IMAP_OPENTIMEOUT IMAP_READTIMEOUT IMAP_WRITETIMEOUT IMAP_CLOSETIMEOUT OP_DEBUG OP_READONLY OP_ANONYMOUS OP_SHORTCACHE OP_SILENT OP_PROTOTYPE OP_HALFOPEN OP_EXPUNGE OP_SECURE CL_EXPUNGE FT_UID FT_PEEK FT_NOT FT_INTERNAL FT_PREFETCHTEXT ST_UID ST_SILENT ST_SET CP_UID CP_MOVE SE_UID SE_FREE SE_NOPREFETCH SO_FREE SO_NOSERVER SA_MESSAGES SA_RECENT SA_UNSEEN SA_UIDNEXT SA_UIDVALIDITY SA_ALL LATT_NOINFERIORS LATT_NOSELECT LATT_MARKED LATT_UNMARKED LATT_REFERRAL LATT_HASCHILDREN LATT_HASNOCHILDREN SORTDATE SORTARRIVAL SORTFROM SORTSUBJECT SORTTO SORTCC SORTSIZE TYPETEXT TYPEMULTIPART TYPEMESSAGE TYPEAPPLICATION TYPEAUDIO TYPEIMAGE TYPEVIDEO TYPEMODEL TYPEOTHER ENC7BIT ENC8BIT ENCBINARY ENCBASE64 ENCQUOTEDPRINTABLE ENCOTHER IMAP_GC_ELT IMAP_GC_ENV IMAP_GC_TEXTS contained

    " intl
    syn keyword phpCoreConstant INTL_MAX_LOCALE_LEN ULOC_ACTUAL_LOCALE ULOC_VALID_LOCALE GRAPHEME_EXTR_COUNT GRAPHEME_EXTR_MAXBYTES GRAPHEME_EXTR_MAXCHARS U_USING_FALLBACK_WARNING U_ERROR_WARNING_START U_USING_DEFAULT_WARNING U_SAFECLONE_ALLOCATED_WARNING U_STATE_OLD_WARNING U_STRING_NOT_TERMINATED_WARNING U_SORT_KEY_TOO_SHORT_WARNING U_AMBIGUOUS_ALIAS_WARNING U_DIFFERENT_UCA_VERSION U_ERROR_WARNING_LIMIT U_ZERO_ERROR U_ILLEGAL_ARGUMENT_ERROR U_MISSING_RESOURCE_ERROR U_INVALID_FORMAT_ERROR U_FILE_ACCESS_ERROR U_INTERNAL_PROGRAM_ERROR U_MESSAGE_PARSE_ERROR U_MEMORY_ALLOCATION_ERROR U_INDEX_OUTOFBOUNDS_ERROR U_PARSE_ERROR U_INVALID_CHAR_FOUND U_TRUNCATED_CHAR_FOUND U_ILLEGAL_CHAR_FOUND U_INVALID_TABLE_FORMAT U_INVALID_TABLE_FILE U_BUFFER_OVERFLOW_ERROR U_UNSUPPORTED_ERROR U_RESOURCE_TYPE_MISMATCH U_ILLEGAL_ESCAPE_SEQUENCE U_UNSUPPORTED_ESCAPE_SEQUENCE U_NO_SPACE_AVAILABLE U_CE_NOT_FOUND_ERROR U_PRIMARY_TOO_LONG_ERROR U_STATE_TOO_OLD_ERROR U_TOO_MANY_ALIASES_ERROR U_ENUM_OUT_OF_SYNC_ERROR U_INVARIANT_CONVERSION_ERROR U_INVALID_STATE_ERROR U_COLLATOR_VERSION_MISMATCH U_USELESS_COLLATOR_ERROR U_NO_WRITE_PERMISSION U_STANDARD_ERROR_LIMIT U_BAD_VARIABLE_DEFINITION U_PARSE_ERROR_START U_MALFORMED_RULE U_MALFORMED_SET U_MALFORMED_SYMBOL_REFERENCE U_MALFORMED_UNICODE_ESCAPE U_MALFORMED_VARIABLE_DEFINITION U_MALFORMED_VARIABLE_REFERENCE U_MISMATCHED_SEGMENT_DELIMITERS U_MISPLACED_ANCHOR_START U_MISPLACED_CURSOR_OFFSET U_MISPLACED_QUANTIFIER U_MISSING_OPERATOR U_MISSING_SEGMENT_CLOSE U_MULTIPLE_ANTE_CONTEXTS U_MULTIPLE_CURSORS U_MULTIPLE_POST_CONTEXTS U_TRAILING_BACKSLASH U_UNDEFINED_SEGMENT_REFERENCE U_UNDEFINED_VARIABLE U_UNQUOTED_SPECIAL U_UNTERMINATED_QUOTE U_RULE_MASK_ERROR U_MISPLACED_COMPOUND_FILTER U_MULTIPLE_COMPOUND_FILTERS U_INVALID_RBT_SYNTAX U_INVALID_PROPERTY_PATTERN U_MALFORMED_PRAGMA U_UNCLOSED_SEGMENT U_ILLEGAL_CHAR_IN_SEGMENT U_VARIABLE_RANGE_EXHAUSTED U_VARIABLE_RANGE_OVERLAP U_ILLEGAL_CHARACTER U_INTERNAL_TRANSLITERATOR_ERROR U_INVALID_ID U_INVALID_FUNCTION U_PARSE_ERROR_LIMIT U_UNEXPECTED_TOKEN U_FMT_PARSE_ERROR_START U_MULTIPLE_DECIMAL_SEPARATORS U_MULTIPLE_DECIMAL_SEPERATORS U_MULTIPLE_EXPONENTIAL_SYMBOLS U_MALFORMED_EXPONENTIAL_PATTERN U_MULTIPLE_PERCENT_SYMBOLS U_MULTIPLE_PERMILL_SYMBOLS U_MULTIPLE_PAD_SPECIFIERS U_PATTERN_SYNTAX_ERROR U_ILLEGAL_PAD_POSITION U_UNMATCHED_BRACES U_UNSUPPORTED_PROPERTY U_UNSUPPORTED_ATTRIBUTE U_FMT_PARSE_ERROR_LIMIT U_BRK_INTERNAL_ERROR U_BRK_ERROR_START U_BRK_HEX_DIGITS_EXPECTED U_BRK_SEMICOLON_EXPECTED U_BRK_RULE_SYNTAX U_BRK_UNCLOSED_SET U_BRK_ASSIGN_ERROR U_BRK_VARIABLE_REDFINITION U_BRK_MISMATCHED_PAREN U_BRK_NEW_LINE_IN_QUOTED_STRING U_BRK_UNDEFINED_VARIABLE U_BRK_INIT_ERROR U_BRK_RULE_EMPTY_SET U_BRK_UNRECOGNIZED_OPTION U_BRK_MALFORMED_RULE_TAG U_BRK_ERROR_LIMIT U_REGEX_INTERNAL_ERROR U_REGEX_ERROR_START U_REGEX_RULE_SYNTAX U_REGEX_INVALID_STATE U_REGEX_BAD_ESCAPE_SEQUENCE U_REGEX_PROPERTY_SYNTAX U_REGEX_UNIMPLEMENTED U_REGEX_MISMATCHED_PAREN U_REGEX_NUMBER_TOO_BIG U_REGEX_BAD_INTERVAL U_REGEX_MAX_LT_MIN U_REGEX_INVALID_BACK_REF U_REGEX_INVALID_FLAG U_REGEX_LOOK_BEHIND_LIMIT U_REGEX_SET_CONTAINS_STRING U_REGEX_ERROR_LIMIT U_STRINGPREP_PROHIBITED_ERROR U_STRINGPREP_UNASSIGNED_ERROR U_STRINGPREP_CHECK_BIDI_ERROR U_ERROR_LIMIT IDNA_DEFAULT IDNA_ALLOW_UNASSIGNED IDNA_USE_STD3_RULES DEFAULT_VALUE PRIMARY SECONDARY TERTIARY DEFAULT_STRENGTH QUATERNARY IDENTICAL OFF ON SHIFTED NON_IGNORABLE LOWER_FIRST UPPER_FIRST FRENCH_COLLATION ALTERNATE_HANDLING CASE_FIRST CASE_LEVEL NORMALIZATION_MODE STRENGTH HIRAGANA_QUATERNARY_MODE NUMERIC_COLLATION SORT_REGULAR SORT_STRING SORT_NUMERIC PATTERN_DECIMAL DECIMAL CURRENCY PERCENT SCIENTIFIC SPELLOUT ORDINAL DURATION PATTERN_RULEBASED IGNORE DEFAULT_STYLE ROUND_CEILING ROUND_FLOOR ROUND_DOWN ROUND_UP ROUND_HALFEVEN ROUND_HALFDOWN ROUND_HALFUP PAD_BEFORE_PREFIX PAD_AFTER_PREFIX PAD_BEFORE_SUFFIX PAD_AFTER_SUFFIX PARSE_INT_ONLY GROUPING_USED DECIMAL_ALWAYS_SHOWN MAX_INTEGER_DIGITS MIN_INTEGER_DIGITS INTEGER_DIGITS MAX_FRACTION_DIGITS MIN_FRACTION_DIGITS FRACTION_DIGITS MULTIPLIER GROUPING_SIZE ROUNDING_MODE ROUNDING_INCREMENT FORMAT_WIDTH PADDING_POSITION SECONDARY_GROUPING_SIZE SIGNIFICANT_DIGITS_USED MIN_SIGNIFICANT_DIGITS MAX_SIGNIFICANT_DIGITS LENIENT_PARSE POSITIVE_PREFIX POSITIVE_SUFFIX NEGATIVE_PREFIX NEGATIVE_SUFFIX PADDING_CHARACTER CURRENCY_CODE DEFAULT_RULESET PUBLIC_RULESETS DECIMAL_SEPARATOR_SYMBOL GROUPING_SEPARATOR_SYMBOL PATTERN_SEPARATOR_SYMBOL PERCENT_SYMBOL ZERO_DIGIT_SYMBOL DIGIT_SYMBOL MINUS_SIGN_SYMBOL PLUS_SIGN_SYMBOL CURRENCY_SYMBOL INTL_CURRENCY_SYMBOL MONETARY_SEPARATOR_SYMBOL EXPONENTIAL_SYMBOL PERMILL_SYMBOL PAD_ESCAPE_SYMBOL INFINITY_SYMBOL NAN_SYMBOL SIGNIFICANT_DIGIT_SYMBOL MONETARY_GROUPING_SEPARATOR_SYMBOL TYPE_DEFAULT TYPE_INT32 TYPE_INT64 TYPE_DOUBLE TYPE_CURRENCY NONE FORM_D NFD FORM_KD NFKD FORM_C NFC FORM_KC NFKC ACTUAL_LOCALE VALID_LOCALE DEFAULT_LOCALE LANG_TAG EXTLANG_TAG SCRIPT_TAG REGION_TAG VARIANT_TAG GRANDFATHERED_LANG_TAG PRIVATE_TAG FULL LONG MEDIUM SHORT GREGORIAN TRADITIONAL U_IDNA_DOMAIN_NAME_TOO_LONG_ERROR IDNA_CHECK_BIDI IDNA_CHECK_CONTEXTJ IDNA_NONTRANSITIONAL_TO_ASCII IDNA_NONTRANSITIONAL_TO_UNICODE INTL_IDNA_VARIANT_2003 INTL_IDNA_VARIANT_UTS46 IDNA_ERROR_EMPTY_LABEL IDNA_ERROR_LABEL_TOO_LONG IDNA_ERROR_DOMAIN_NAME_TOO_LONG IDNA_ERROR_LEADING_HYPHEN IDNA_ERROR_TRAILING_HYPHEN IDNA_ERROR_HYPHEN_3_4 IDNA_ERROR_LEADING_COMBINING_MARK IDNA_ERROR_DISALLOWED IDNA_ERROR_PUNYCODE IDNA_ERROR_LABEL_HAS_DOT IDNA_ERROR_INVALID_ACE_LABEL IDNA_ERROR_BIDI IDNA_ERROR_CONTEXTJ contained

    " json
    syn keyword phpCoreConstant JSON_HEX_TAG JSON_HEX_AMP JSON_HEX_APOS JSON_HEX_QUOT JSON_FORCE_OBJECT JSON_PRETTY_PRINT JSON_UNESCAPED_SLASHES JSON_NUMERIC_CHECK JSON_UNESCAPED_UNICODE JSON_BIGINT_AS_STRING JSON_ERROR_NONE JSON_ERROR_DEPTH JSON_ERROR_STATE_MISMATCH JSON_ERROR_CTRL_CHAR JSON_ERROR_SYNTAX contained

    " ldap
    syn keyword phpCoreConstant LDAP_DEREF_NEVER LDAP_DEREF_SEARCHING LDAP_DEREF_FINDING LDAP_DEREF_ALWAYS LDAP_OPT_DEREF LDAP_OPT_SIZELIMIT LDAP_OPT_TIMELIMIT LDAP_OPT_NETWORK_TIMEOUT LDAP_OPT_PROTOCOL_VERSION LDAP_OPT_ERROR_NUMBER LDAP_OPT_REFERRALS LDAP_OPT_RESTART LDAP_OPT_HOST_NAME LDAP_OPT_ERROR_STRING LDAP_OPT_MATCHED_DN LDAP_OPT_SERVER_CONTROLS LDAP_OPT_CLIENT_CONTROLS LDAP_OPT_DEBUG_LEVEL contained

    " libxml
    syn keyword phpCoreConstant LIBXML_VERSION LIBXML_DOTTED_VERSION LIBXML_LOADED_VERSION LIBXML_NOENT LIBXML_DTDLOAD LIBXML_DTDATTR LIBXML_DTDVALID LIBXML_NOERROR LIBXML_NOWARNING LIBXML_NOBLANKS LIBXML_XINCLUDE LIBXML_NSCLEAN LIBXML_NOCDATA LIBXML_NONET LIBXML_COMPACT LIBXML_NOXMLDECL LIBXML_NOEMPTYTAG LIBXML_HTML_NODEFDTD LIBXML_HTML_NOIMPLIED LIBXML_PEDANTIC LIBXML_ERR_NONE LIBXML_ERR_WARNING LIBXML_ERR_ERROR LIBXML_ERR_FATAL contained

    " mbstring
    syn keyword phpCoreConstant MB_OVERLOAD_MAIL MB_OVERLOAD_STRING MB_OVERLOAD_REGEX MB_CASE_UPPER MB_CASE_LOWER MB_CASE_TITLE contained

    " mcrypt
    syn keyword phpCoreConstant  MCRYPT_ENCRYPT MCRYPT_DECRYPT MCRYPT_DEV_RANDOM MCRYPT_DEV_URANDOM MCRYPT_RAND MCRYPT_3DES MCRYPT_ARCFOUR_IV MCRYPT_ARCFOUR MCRYPT_BLOWFISH MCRYPT_BLOWFISH_COMPAT MCRYPT_CAST_128 MCRYPT_CAST_256 MCRYPT_CRYPT MCRYPT_DES MCRYPT_ENIGNA MCRYPT_GOST MCRYPT_LOKI97 MCRYPT_PANAMA MCRYPT_RC2 MCRYPT_RIJNDAEL_128 MCRYPT_RIJNDAEL_192 MCRYPT_RIJNDAEL_256 MCRYPT_SAFER64 MCRYPT_SAFER128 MCRYPT_SAFERPLUS MCRYPT_SERPENT MCRYPT_THREEWAY MCRYPT_TRIPLEDES MCRYPT_TWOFISH MCRYPT_WAKE MCRYPT_XTEA MCRYPT_IDEA MCRYPT_MARS MCRYPT_RC6 MCRYPT_SKIPJACK MCRYPT_MODE_CBC MCRYPT_MODE_CFB MCRYPT_MODE_ECB MCRYPT_MODE_NOFB MCRYPT_MODE_OFB MCRYPT_MODE_STREAM contained

    " mysql
    syn keyword phpCoreConstant MYSQL_ASSOC MYSQL_NUM MYSQL_BOTH MYSQL_CLIENT_COMPRESS MYSQL_CLIENT_SSL MYSQL_CLIENT_INTERACTIVE MYSQL_CLIENT_IGNORE_SPACE contained

    " mysqli
    syn keyword phpCoreConstant MYSQLI_READ_DEFAULT_GROUP MYSQLI_READ_DEFAULT_FILE MYSQLI_OPT_CONNECT_TIMEOUT MYSQLI_OPT_LOCAL_INFILE MYSQLI_INIT_COMMAND MYSQLI_OPT_NET_CMD_BUFFER_SIZE MYSQLI_OPT_NET_READ_BUFFER_SIZE MYSQLI_OPT_INT_AND_FLOAT_NATIVE MYSQLI_CLIENT_SSL MYSQLI_CLIENT_COMPRESS MYSQLI_CLIENT_INTERACTIVE MYSQLI_CLIENT_IGNORE_SPACE MYSQLI_CLIENT_NO_SCHEMA MYSQLI_CLIENT_FOUND_ROWS MYSQLI_STORE_RESULT MYSQLI_USE_RESULT MYSQLI_ASYNC MYSQLI_ASSOC MYSQLI_NUM MYSQLI_BOTH MYSQLI_STMT_ATTR_UPDATE_MAX_LENGTH MYSQLI_STMT_ATTR_CURSOR_TYPE MYSQLI_CURSOR_TYPE_NO_CURSOR MYSQLI_CURSOR_TYPE_READ_ONLY MYSQLI_CURSOR_TYPE_FOR_UPDATE MYSQLI_CURSOR_TYPE_SCROLLABLE MYSQLI_STMT_ATTR_PREFETCH_ROWS MYSQLI_NOT_NULL_FLAG MYSQLI_PRI_KEY_FLAG MYSQLI_UNIQUE_KEY_FLAG MYSQLI_MULTIPLE_KEY_FLAG MYSQLI_BLOB_FLAG MYSQLI_UNSIGNED_FLAG MYSQLI_ZEROFILL_FLAG MYSQLI_AUTO_INCREMENT_FLAG MYSQLI_TIMESTAMP_FLAG MYSQLI_SET_FLAG MYSQLI_NUM_FLAG MYSQLI_PART_KEY_FLAG MYSQLI_GROUP_FLAG MYSQLI_ENUM_FLAG MYSQLI_BINARY_FLAG MYSQLI_NO_DEFAULT_VALUE_FLAG MYSQLI_ON_UPDATE_NOW_FLAG MYSQLI_TYPE_DECIMAL MYSQLI_TYPE_TINY MYSQLI_TYPE_SHORT MYSQLI_TYPE_LONG MYSQLI_TYPE_FLOAT MYSQLI_TYPE_DOUBLE MYSQLI_TYPE_NULL MYSQLI_TYPE_TIMESTAMP MYSQLI_TYPE_LONGLONG MYSQLI_TYPE_INT24 MYSQLI_TYPE_DATE MYSQLI_TYPE_TIME MYSQLI_TYPE_DATETIME MYSQLI_TYPE_YEAR MYSQLI_TYPE_NEWDATE MYSQLI_TYPE_ENUM MYSQLI_TYPE_SET MYSQLI_TYPE_TINY_BLOB MYSQLI_TYPE_MEDIUM_BLOB MYSQLI_TYPE_LONG_BLOB MYSQLI_TYPE_BLOB MYSQLI_TYPE_VAR_STRING MYSQLI_TYPE_STRING MYSQLI_TYPE_CHAR MYSQLI_TYPE_INTERVAL MYSQLI_TYPE_GEOMETRY MYSQLI_TYPE_NEWDECIMAL MYSQLI_TYPE_BIT MYSQLI_SET_CHARSET_NAME MYSQLI_NO_DATA MYSQLI_DATA_TRUNCATED MYSQLI_REPORT_INDEX MYSQLI_REPORT_ERROR MYSQLI_REPORT_STRICT MYSQLI_REPORT_ALL MYSQLI_REPORT_OFF MYSQLI_DEBUG_TRACE_ENABLED MYSQLI_SERVER_QUERY_NO_GOOD_INDEX_USED MYSQLI_SERVER_QUERY_NO_INDEX_USED MYSQLI_SERVER_QUERY_WAS_SLOW MYSQLI_REFRESH_GRANT MYSQLI_REFRESH_LOG MYSQLI_REFRESH_TABLES MYSQLI_REFRESH_HOSTS MYSQLI_REFRESH_STATUS MYSQLI_REFRESH_THREADS MYSQLI_REFRESH_SLAVE MYSQLI_REFRESH_MASTER MYSQLI_REFRESH_BACKUP_LOG contained

    " odbc
    syn keyword phpCoreConstant ODBC_TYPE ODBC_BINMODE_PASSTHRU ODBC_BINMODE_RETURN ODBC_BINMODE_CONVERT SQL_ODBC_CURSORS SQL_CUR_USE_DRIVER SQL_CUR_USE_IF_NEEDED SQL_CUR_USE_ODBC SQL_CONCURRENCY SQL_CONCUR_READ_ONLY SQL_CONCUR_LOCK SQL_CONCUR_ROWVER SQL_CONCUR_VALUES SQL_CURSOR_TYPE SQL_CURSOR_FORWARD_ONLY SQL_CURSOR_KEYSET_DRIVEN SQL_CURSOR_DYNAMIC SQL_CURSOR_STATIC SQL_KEYSET_SIZE SQL_FETCH_FIRST SQL_FETCH_NEXT SQL_CHAR SQL_VARCHAR SQL_LONGVARCHAR SQL_DECIMAL SQL_NUMERIC SQL_BIT SQL_TINYINT SQL_SMALLINT SQL_INTEGER SQL_BIGINT SQL_REAL SQL_FLOAT SQL_DOUBLE SQL_BINARY SQL_VARBINARY SQL_LONGVARBINARY SQL_DATE SQL_TIME SQL_TIMESTAMP contained

    " openssl
    syn keyword phpCoreConstant OPENSSL_VERSION_TEXT OPENSSL_VERSION_NUMBER X509_PURPOSE_SSL_CLIENT X509_PURPOSE_SSL_SERVER X509_PURPOSE_NS_SSL_SERVER X509_PURPOSE_SMIME_SIGN X509_PURPOSE_SMIME_ENCRYPT X509_PURPOSE_CRL_SIGN X509_PURPOSE_ANY OPENSSL_ALGO_SHA1 OPENSSL_ALGO_MD5 OPENSSL_ALGO_MD4 OPENSSL_ALGO_MD2 OPENSSL_ALGO_DSS1 PKCS7_DETACHED PKCS7_TEXT PKCS7_NOINTERN PKCS7_NOVERIFY PKCS7_NOCHAIN PKCS7_NOCERTS PKCS7_NOATTR PKCS7_BINARY PKCS7_NOSIGS OPENSSL_PKCS1_PADDING OPENSSL_SSLV23_PADDING OPENSSL_NO_PADDING OPENSSL_PKCS1_OAEP_PADDING OPENSSL_CIPHER_RC2_40 OPENSSL_CIPHER_RC2_128 OPENSSL_CIPHER_RC2_64 OPENSSL_CIPHER_DES OPENSSL_CIPHER_3DES OPENSSL_KEYTYPE_RSA OPENSSL_KEYTYPE_DSA OPENSSL_KEYTYPE_DH OPENSSL_KEYTYPE_EC OPENSSL_CIPHER_AES_128_CBC OPENSSL_CIPHER_AES_192_CBC OPENSSL_CIPHER_AES_256_CBC OPENSSL_RAW_DATA OPENSSL_ZERO_PADDING contained

    " pcre
    syn keyword phpCoreConstant PREG_PATTERN_ORDER PREG_SET_ORDER PREG_OFFSET_CAPTURE PREG_SPLIT_NO_EMPTY PREG_SPLIT_DELIM_CAPTURE PREG_SPLIT_OFFSET_CAPTURE PREG_GREP_INVERT PREG_NO_ERROR PREG_INTERNAL_ERROR PREG_BACKTRACK_LIMIT_ERROR PREG_RECURSION_LIMIT_ERROR PREG_BAD_UTF8_ERROR PREG_BAD_UTF8_OFFSET_ERROR PCRE_VERSION contained

    " PDO
    syn keyword phpCoreConstant PARAM_BOOL PARAM_NULL PARAM_INT PARAM_STR PARAM_LOB PARAM_STMT PARAM_INPUT_OUTPUT PARAM_EVT_ALLOC PARAM_EVT_FREE PARAM_EVT_EXEC_PRE PARAM_EVT_EXEC_POST PARAM_EVT_FETCH_PRE PARAM_EVT_FETCH_POST PARAM_EVT_NORMALIZE FETCH_LAZY FETCH_ASSOC FETCH_NUM FETCH_BOTH FETCH_OBJ FETCH_BOUND FETCH_COLUMN FETCH_CLASS FETCH_INTO FETCH_FUNC FETCH_GROUP FETCH_UNIQUE FETCH_KEY_PAIR FETCH_CLASSTYPE FETCH_SERIALIZE FETCH_PROPS_LATE FETCH_NAMED ATTR_AUTOCOMMIT ATTR_PREFETCH ATTR_TIMEOUT ATTR_ERRMODE ATTR_SERVER_VERSION ATTR_CLIENT_VERSION ATTR_SERVER_INFO ATTR_CONNECTION_STATUS ATTR_CASE ATTR_CURSOR_NAME ATTR_CURSOR ATTR_ORACLE_NULLS ATTR_PERSISTENT ATTR_STATEMENT_CLASS ATTR_FETCH_TABLE_NAMES ATTR_FETCH_CATALOG_NAMES ATTR_DRIVER_NAME ATTR_STRINGIFY_FETCHES ATTR_MAX_COLUMN_LEN ATTR_EMULATE_PREPARES ATTR_DEFAULT_FETCH_MODE ERRMODE_SILENT ERRMODE_WARNING ERRMODE_EXCEPTION CASE_NATURAL CASE_LOWER CASE_UPPER NULL_NATURAL NULL_EMPTY_STRING NULL_TO_STRING ERR_NONE FETCH_ORI_NEXT FETCH_ORI_PRIOR FETCH_ORI_FIRST FETCH_ORI_LAST FETCH_ORI_ABS FETCH_ORI_REL CURSOR_FWDONLY CURSOR_SCROLL MYSQL_ATTR_USE_BUFFERED_QUERY MYSQL_ATTR_LOCAL_INFILE MYSQL_ATTR_DIRECT_QUERY MYSQL_ATTR_FOUND_ROWS MYSQL_ATTR_IGNORE_SPACE ODBC_ATTR_USE_CURSOR_LIBRARY ODBC_ATTR_ASSUME_UTF8 ODBC_SQL_USE_IF_NEEDED ODBC_SQL_USE_DRIVER ODBC_SQL_USE_ODBC PGSQL_ATTR_DISABLE_NATIVE_PREPARED_STATEMENT contained

    " pgsql
    syn keyword phpCoreConstant PGSQL_CONNECT_FORCE_NEW PGSQL_ASSOC PGSQL_NUM PGSQL_BOTH PGSQL_CONNECTION_BAD PGSQL_CONNECTION_OK PGSQL_TRANSACTION_IDLE PGSQL_TRANSACTION_ACTIVE PGSQL_TRANSACTION_INTRANS PGSQL_TRANSACTION_INERROR PGSQL_TRANSACTION_UNKNOWN PGSQL_ERRORS_TERSE PGSQL_ERRORS_DEFAULT PGSQL_ERRORS_VERBOSE PGSQL_SEEK_SET PGSQL_SEEK_CUR PGSQL_SEEK_END PGSQL_STATUS_LONG PGSQL_STATUS_STRING PGSQL_EMPTY_QUERY PGSQL_COMMAND_OK PGSQL_TUPLES_OK PGSQL_COPY_OUT PGSQL_COPY_IN PGSQL_BAD_RESPONSE PGSQL_NONFATAL_ERROR PGSQL_FATAL_ERROR PGSQL_DIAG_SEVERITY PGSQL_DIAG_SQLSTATE PGSQL_DIAG_MESSAGE_PRIMARY PGSQL_DIAG_MESSAGE_DETAIL PGSQL_DIAG_MESSAGE_HINT PGSQL_DIAG_STATEMENT_POSITION PGSQL_DIAG_INTERNAL_POSITION PGSQL_DIAG_INTERNAL_QUERY PGSQL_DIAG_CONTEXT PGSQL_DIAG_SOURCE_FILE PGSQL_DIAG_SOURCE_LINE PGSQL_DIAG_SOURCE_FUNCTION PGSQL_CONV_IGNORE_DEFAULT PGSQL_CONV_FORCE_NULL PGSQL_CONV_IGNORE_NOT_NULL PGSQL_DML_NO_CONV PGSQL_DML_EXEC PGSQL_DML_ASYNC PGSQL_DML_STRING contained

    " Phar
    syn keyword phpCoreConstant CURRENT_MODE_MASK CURRENT_AS_PATHNAME CURRENT_AS_FILEINFO CURRENT_AS_SELF KEY_MODE_MASK KEY_AS_PATHNAME KEY_AS_FILENAME NEW_CURRENT_AND_KEY SKIP_DOTS UNIX_PATHS BZ2 GZ NONE PHAR TAR ZIP COMPRESSED PHP PHPS MD5 OPENSSL SHA1 SHA256 SHA512 contained

    " Reflection
    syn keyword phpCoreConstant IS_DEPRECATED IS_STATIC IS_PUBLIC IS_PROTECTED IS_PRIVATE IS_ABSTRACT IS_FINAL IS_IMPLICIT_ABSTRACT IS_EXPLICIT_ABSTRACT contained

    " soap
    syn keyword phpCoreConstant SOAP_1_1 SOAP_1_2 SOAP_PERSISTENCE_SESSION SOAP_PERSISTENCE_REQUEST SOAP_FUNCTIONS_ALL SOAP_ENCODED SOAP_LITERAL SOAP_RPC SOAP_DOCUMENT SOAP_ACTOR_NEXT SOAP_ACTOR_NONE SOAP_ACTOR_UNLIMATERECEIVER SOAP_COMPRESSION_ACCEPT SOAP_COMPRESSION_GZIP SOAP_COMPRESSION_DEFLATE SOAP_AUTHENTICATION_BASIC SOAP_AUTHENTICATION_DIGEST UNKNOWN_TYPE XSD_STRING XSD_BOOLEAN XSD_DECIMAL XSD_FLOAT XSD_DOUBLE XSD_DURATION XSD_DATETIME XSD_TIME XSD_DATE XSD_GYEARMONTH XSD_GYEAR XSD_GMONTHDAY XSD_GDAY XSD_GMONTH XSD_HEXBINARY XSD_BASE64BINARY XSD_ANYURI XSD_QNAME XSD_NOTATION XSD_NORMALIZEDSTRING XSD_TOKEN XSD_LANGUAGE XSD_NMTOKEN XSD_NAME XSD_NCNAME XSD_ID XSD_IDREF XSD_IDREFS XSD_ENTITY XSD_ENTITIES XSD_INTEGER XSD_NONPOSITIVEINTEGER XSD_NEGATIVEINTEGER XSD_LONG XSD_INT XSD_SHORT XSD_BYTE XSD_NONNEGATIVEINTEGER XSD_UNSIGNEDLONG XSD_UNSIGNEDINT XSD_UNSIGNEDSHORT XSD_UNSIGNEDBYTE XSD_POSITIVEINTEGER XSD_NMTOKENS XSD_ANYTYPE XSD_ANYXML APACHE_MAP SOAP_ENC_OBJECT SOAP_ENC_ARRAY XSD_1999_TIMEINSTANT XSD_NAMESPACE XSD_1999_NAMESPACE SOAP_SINGLE_ELEMENT_ARRAYS SOAP_WAIT_ONE_WAY_CALLS SOAP_USE_XSI_ARRAY_TYPE WSDL_CACHE_NONE WSDL_CACHE_DISK WSDL_CACHE_MEMORY WSDL_CACHE_BOTH contained

    " sockets
    syn keyword phpCoreConstant AF_UNIX AF_INET AF_INET6 SOCK_STREAM SOCK_DGRAM SOCK_RAW SOCK_SEQPACKET SOCK_RDM MSG_OOB MSG_WAITALL MSG_PEEK MSG_DONTROUTE SO_DEBUG SO_REUSEADDR SO_KEEPALIVE SO_DONTROUTE SO_LINGER SO_BROADCAST SO_OOBINLINE SO_SNDBUF SO_RCVBUF SO_SNDLOWAT SO_RCVLOWAT SO_SNDTIMEO SO_RCVTIMEO SO_TYPE SO_ERROR SOL_SOCKET SOMAXCONN TCP_NODELAY PHP_NORMAL_READ PHP_BINARY_READ SOCKET_EINTR SOCKET_EBADF SOCKET_EACCES SOCKET_EFAULT SOCKET_EINVAL SOCKET_EMFILE SOCKET_EWOULDBLOCK SOCKET_EINPROGRESS SOCKET_EALREADY SOCKET_ENOTSOCK SOCKET_EDESTADDRREQ SOCKET_EMSGSIZE SOCKET_EPROTOTYPE SOCKET_ENOPROTOOPT SOCKET_EPROTONOSUPPORT SOCKET_ESOCKTNOSUPPORT SOCKET_EOPNOTSUPP SOCKET_EPFNOSUPPORT SOCKET_EAFNOSUPPORT SOCKET_EADDRINUSE SOCKET_EADDRNOTAVAIL SOCKET_ENETDOWN SOCKET_ENETUNREACH SOCKET_ENETRESET SOCKET_ECONNABORTED SOCKET_ECONNRESET SOCKET_ENOBUFS SOCKET_EISCONN SOCKET_ENOTCONN SOCKET_ESHUTDOWN SOCKET_ETOOMANYREFS SOCKET_ETIMEDOUT SOCKET_ECONNREFUSED SOCKET_ELOOP SOCKET_ENAMETOOLONG SOCKET_EHOSTDOWN SOCKET_EHOSTUNREACH SOCKET_ENOTEMPTY SOCKET_EPROCLIM SOCKET_EUSERS SOCKET_EDQUOT SOCKET_ESTALE SOCKET_EREMOTE SOCKET_EDISCON SOCKET_SYSNOTREADY SOCKET_VERNOTSUPPORTED SOCKET_NOTINITIALISED SOCKET_HOST_NOT_FOUND SOCKET_TRY_AGAIN SOCKET_NO_RECOVERY SOCKET_NO_DATA SOCKET_NO_ADDRESS SOL_TCP SOL_UDP contained

    " SPL
    syn keyword phpCoreConstant LEAVES_ONLY SELF_FIRST CHILD_FIRST CATCH_GET_CHILD CALL_TOSTRING TOSTRING_USE_KEY TOSTRING_USE_CURRENT TOSTRING_USE_INNER FULL_CACHE USE_KEY MATCH GET_MATCH ALL_MATCHES SPLIT REPLACE BYPASS_CURRENT BYPASS_KEY PREFIX_LEFT PREFIX_MID_HAS_NEXT PREFIX_MID_LAST PREFIX_END_HAS_NEXT PREFIX_END_LAST PREFIX_RIGHT STD_PROP_LIST ARRAY_AS_PROPS CHILD_ARRAYS_ONLY CURRENT_MODE_MASK CURRENT_AS_PATHNAME CURRENT_AS_FILEINFO CURRENT_AS_SELF KEY_MODE_MASK KEY_AS_PATHNAME KEY_AS_FILENAME NEW_CURRENT_AND_KEY SKIP_DOTS UNIX_PATHS DROP_NEW_LINE READ_AHEAD SKIP_EMPTY READ_CSV IT_MODE_LIFO IT_MODE_FIFO IT_MODE_DELETE IT_MODE_KEEP EXTR_BOTH EXTR_PRIORITY EXTR_DATA MIT_NEED_ANY MIT_NEED_ALL MIT_KEYS_NUMERIC MIT_KEYS_ASSOC contained

    " standard
    syn keyword phpCoreConstant CONNECTION_ABORTED CONNECTION_NORMAL CONNECTION_TIMEOUT INI_USER INI_PERDIR INI_SYSTEM INI_ALL INI_SCANNER_NORMAL INI_SCANNER_RAW PHP_URL_SCHEME PHP_URL_HOST PHP_URL_PORT PHP_URL_USER PHP_URL_PASS PHP_URL_PATH PHP_URL_QUERY PHP_URL_FRAGMENT PHP_SESSION_ACTIVE PHP_SESSION_DISABLED PHP_SESSION_NONE M_E M_LOG2E M_LOG10E M_LN2 M_LN10 M_PI M_PI_2 M_PI_4 M_1_PI M_2_PI M_SQRTPI M_2_SQRTPI M_LNPI M_EULER M_SQRT2 M_SQRT1_2 M_SQRT3 INF NAN PHP_ROUND_HALF_UP PHP_ROUND_HALF_DOWN PHP_ROUND_HALF_EVEN PHP_ROUND_HALF_ODD INFO_GENERAL INFO_CREDITS INFO_CONFIGURATION INFO_MODULES INFO_ENVIRONMENT INFO_VARIABLES INFO_LICENSE INFO_ALL CREDITS_GROUP CREDITS_GENERAL CREDITS_SAPI CREDITS_MODULES CREDITS_DOCS CREDITS_FULLPAGE CREDITS_QA CREDITS_ALL HTML_SPECIALCHARS HTML_ENTITIES ENT_COMPAT ENT_QUOTES ENT_NOQUOTES ENT_IGNORE ENT_DISALLOWED ENT_HTML401 ENT_HTML5 ENT_SUBSTITUTE ENT_XML1 ENT_XHTML STR_PAD_LEFT STR_PAD_RIGHT STR_PAD_BOTH PATHINFO_DIRNAME PATHINFO_BASENAME PATHINFO_EXTENSION PATHINFO_FILENAME CHAR_MAX LC_CTYPE LC_NUMERIC LC_TIME LC_COLLATE LC_MONETARY LC_ALL SEEK_SET SEEK_CUR SEEK_END LOCK_SH LOCK_EX LOCK_UN LOCK_NB STREAM_NOTIFY_CONNECT STREAM_NOTIFY_AUTH_REQUIRED STREAM_NOTIFY_AUTH_RESULT STREAM_NOTIFY_MIME_TYPE_IS STREAM_NOTIFY_FILE_SIZE_IS STREAM_NOTIFY_REDIRECTED STREAM_NOTIFY_PROGRESS STREAM_NOTIFY_FAILURE STREAM_NOTIFY_COMPLETED STREAM_NOTIFY_RESOLVE STREAM_NOTIFY_SEVERITY_INFO STREAM_NOTIFY_SEVERITY_WARN STREAM_NOTIFY_SEVERITY_ERR STREAM_FILTER_READ STREAM_FILTER_WRITE STREAM_FILTER_ALL STREAM_CLIENT_PERSISTENT STREAM_CLIENT_ASYNC_CONNECT STREAM_CLIENT_CONNECT STREAM_CRYPTO_METHOD_SSLv2_CLIENT STREAM_CRYPTO_METHOD_SSLv3_CLIENT STREAM_CRYPTO_METHOD_SSLv23_CLIENT STREAM_CRYPTO_METHOD_TLS_CLIENT STREAM_CRYPTO_METHOD_SSLv2_SERVER STREAM_CRYPTO_METHOD_SSLv3_SERVER STREAM_CRYPTO_METHOD_SSLv23_SERVER STREAM_CRYPTO_METHOD_TLS_SERVER STREAM_SHUT_RD STREAM_SHUT_WR STREAM_SHUT_RDWR STREAM_PF_INET STREAM_PF_INET6 STREAM_PF_UNIX STREAM_IPPROTO_IP STREAM_SOCK_STREAM STREAM_SOCK_DGRAM STREAM_SOCK_RAW STREAM_SOCK_SEQPACKET STREAM_SOCK_RDM STREAM_PEEK STREAM_OOB STREAM_SERVER_BIND STREAM_SERVER_LISTEN FILE_USE_INCLUDE_PATH FILE_IGNORE_NEW_LINES FILE_SKIP_EMPTY_LINES FILE_APPEND FILE_NO_DEFAULT_CONTEXT FILE_TEXT FILE_BINARY FNM_NOESCAPE FNM_PATHNAME FNM_PERIOD FNM_CASEFOLD PSFS_PASS_ON PSFS_FEED_ME PSFS_ERR_FATAL PSFS_FLAG_NORMAL PSFS_FLAG_FLUSH_INC PSFS_FLAG_FLUSH_CLOSE CRYPT_SALT_LENGTH CRYPT_STD_DES CRYPT_EXT_DES CRYPT_MD5 CRYPT_BLOWFISH DIRECTORY_SEPARATOR PATH_SEPARATOR GLOB_BRACE GLOB_MARK GLOB_NOSORT GLOB_NOCHECK GLOB_NOESCAPE GLOB_ERR GLOB_ONLYDIR GLOB_AVAILABLE_FLAGS LOG_EMERG LOG_ALERT LOG_CRIT LOG_ERR LOG_WARNING LOG_NOTICE LOG_INFO LOG_DEBUG LOG_KERN LOG_USER LOG_MAIL LOG_DAEMON LOG_AUTH LOG_SYSLOG LOG_LPR LOG_NEWS LOG_UUCP LOG_CRON LOG_AUTHPRIV LOG_PID LOG_CONS LOG_ODELAY LOG_NDELAY LOG_NOWAIT LOG_PERROR EXTR_OVERWRITE EXTR_SKIP EXTR_PREFIX_SAME EXTR_PREFIX_ALL EXTR_PREFIX_INVALID EXTR_PREFIX_IF_EXISTS EXTR_IF_EXISTS EXTR_REFS SORT_ASC SORT_DESC SORT_REGULAR SORT_NUMERIC SORT_STRING SORT_LOCALE_STRING CASE_LOWER CASE_UPPER COUNT_NORMAL COUNT_RECURSIVE ASSERT_ACTIVE ASSERT_CALLBACK ASSERT_BAIL ASSERT_WARNING ASSERT_QUIET_EVAL STREAM_USE_PATH STREAM_IGNORE_URL STREAM_ENFORCE_SAFE_MODE STREAM_REPORT_ERRORS STREAM_MUST_SEEK STREAM_URL_STAT_LINK STREAM_URL_STAT_QUIET STREAM_MKDIR_RECURSIVE STREAM_IS_URL STREAM_OPTION_BLOCKING STREAM_OPTION_READ_TIMEOUT STREAM_OPTION_READ_BUFFER STREAM_OPTION_WRITE_BUFFER STREAM_BUFFER_NONE STREAM_BUFFER_LINE STREAM_BUFFER_FULL STREAM_CAST_AS_STREAM STREAM_CAST_FOR_SELECT STREAM_META_ACCESS STREAM_META_GROUP STREAM_META_GROUP_NAME STREAM_META_OWNER STREAM_META_OWNER_NAME STREAM_META_TOUCH IMAGETYPE_GIF IMAGETYPE_JPEG IMAGETYPE_PNG IMAGETYPE_SWF IMAGETYPE_PSD IMAGETYPE_BMP IMAGETYPE_TIFF_II IMAGETYPE_TIFF_MM IMAGETYPE_JPC IMAGETYPE_JP2 IMAGETYPE_JPX IMAGETYPE_JB2 IMAGETYPE_SWC IMAGETYPE_IFF IMAGETYPE_WBMP IMAGETYPE_JPEG2000 IMAGETYPE_XBM IMAGETYPE_ICO IMAGETYPE_UNKNOWN IMAGETYPE_COUNT DNS_A DNS_NS DNS_CNAME DNS_SOA DNS_PTR DNS_HINFO DNS_MX DNS_TXT DNS_SRV DNS_NAPTR DNS_AAAA DNS_A6 DNS_ANY DNS_ALL IPPROTO_IP IPPROTO_IPV6 IPV6_MULTICAST_HOPS IPV6_MULTICAST_IF IPV6_MULTICAST_LOOP IPV6_MULTICAST_TTL IP_MULTICAST_IF IP_MULTICAST_LOOP IP_MULTICAST_TTL MCAST_JOIN_GROUP MCAST_LEAVE_GROUP MCAST_BLOCK_SOURCE MCAST_UNBLOCK_SOURCE MCAST_JOIN_SOURCE_GROUP MCAST_LEAVE_SOURCE_GROUP contained

    " sqlite
    syn keyword phpCoreConstant SQLITE_BOTH SQLITE_NUM SQLITE_ASSOC SQLITE_OK SQLITE_ERROR SQLITE_INTERNAL SQLITE_PERM SQLITE_ABORT SQLITE_BUSY SQLITE_LOCKED SQLITE_NOMEM SQLITE_READONLY SQLITE_INTERRUPT SQLITE_IOERR SQLITE_CORRUPT SQLITE_NOTFOUND SQLITE_FULL SQLITE_CANTOPEN SQLITE_PROTOCOL SQLITE_EMPTY SQLITE_SCHEMA SQLITE_TOOBIG SQLITE_CONSTRAINT SQLITE_MISMATCH SQLITE_MISUSE SQLITE_NOLFS SQLITE_AUTH SQLITE_NOTADB SQLITE_FORMAT SQLITE_ROW SQLITE_DONE contained

    " sqlite3
    syn keyword phpCoreConstant SQLITE3_ASSOC SQLITE3_NUM SQLITE3_BOTH SQLITE3_INTEGER SQLITE3_FLOAT SQLITE3_TEXT SQLITE3_BLOB SQLITE3_NULL SQLITE3_OPEN_READONLY SQLITE3_OPEN_READWRITE SQLITE3_OPEN_CREATE contained

    " tidy
    syn keyword phpCoreConstant TIDY_TAG_UNKNOWN TIDY_TAG_A TIDY_TAG_ABBR TIDY_TAG_ACRONYM TIDY_TAG_ADDRESS TIDY_TAG_ALIGN TIDY_TAG_APPLET TIDY_TAG_AREA TIDY_TAG_B TIDY_TAG_BASE TIDY_TAG_BASEFONT TIDY_TAG_BDO TIDY_TAG_BGSOUND TIDY_TAG_BIG TIDY_TAG_BLINK TIDY_TAG_BLOCKQUOTE TIDY_TAG_BODY TIDY_TAG_BR TIDY_TAG_BUTTON TIDY_TAG_CAPTION TIDY_TAG_CENTER TIDY_TAG_CITE TIDY_TAG_CODE TIDY_TAG_COL TIDY_TAG_COLGROUP TIDY_TAG_COMMENT TIDY_TAG_DD TIDY_TAG_DEL TIDY_TAG_DFN TIDY_TAG_DIR TIDY_TAG_DIV TIDY_TAG_DL TIDY_TAG_DT TIDY_TAG_EM TIDY_TAG_EMBED TIDY_TAG_FIELDSET TIDY_TAG_FONT TIDY_TAG_FORM TIDY_TAG_FRAME TIDY_TAG_FRAMESET TIDY_TAG_H1 TIDY_TAG_H2 TIDY_TAG_H3 TIDY_TAG_H4 TIDY_TAG_H5 TIDY_TAG_H6 TIDY_TAG_HEAD TIDY_TAG_HR TIDY_TAG_HTML TIDY_TAG_I TIDY_TAG_IFRAME TIDY_TAG_ILAYER TIDY_TAG_IMG TIDY_TAG_INPUT TIDY_TAG_INS TIDY_TAG_ISINDEX TIDY_TAG_KBD TIDY_TAG_KEYGEN TIDY_TAG_LABEL TIDY_TAG_LAYER TIDY_TAG_LEGEND TIDY_TAG_LI TIDY_TAG_LINK TIDY_TAG_LISTING TIDY_TAG_MAP TIDY_TAG_MARQUEE TIDY_TAG_MENU TIDY_TAG_META TIDY_TAG_MULTICOL TIDY_TAG_NOBR TIDY_TAG_NOEMBED TIDY_TAG_NOFRAMES TIDY_TAG_NOLAYER TIDY_TAG_NOSAVE TIDY_TAG_NOSCRIPT TIDY_TAG_OBJECT TIDY_TAG_OL TIDY_TAG_OPTGROUP TIDY_TAG_OPTION TIDY_TAG_P TIDY_TAG_PARAM TIDY_TAG_PLAINTEXT TIDY_TAG_PRE TIDY_TAG_Q TIDY_TAG_RB TIDY_TAG_RBC TIDY_TAG_RP TIDY_TAG_RT TIDY_TAG_RTC TIDY_TAG_RUBY TIDY_TAG_S TIDY_TAG_SAMP TIDY_TAG_SCRIPT TIDY_TAG_SELECT TIDY_TAG_SERVER TIDY_TAG_SERVLET TIDY_TAG_SMALL TIDY_TAG_SPACER TIDY_TAG_SPAN TIDY_TAG_STRIKE TIDY_TAG_STRONG TIDY_TAG_STYLE TIDY_TAG_SUB TIDY_TAG_SUP TIDY_TAG_TABLE TIDY_TAG_TBODY TIDY_TAG_TD TIDY_TAG_TEXTAREA TIDY_TAG_TFOOT TIDY_TAG_TH TIDY_TAG_THEAD TIDY_TAG_TITLE TIDY_TAG_TR TIDY_TAG_TT TIDY_TAG_U TIDY_TAG_UL TIDY_TAG_VAR TIDY_TAG_WBR TIDY_TAG_XMP TIDY_NODETYPE_ROOT TIDY_NODETYPE_DOCTYPE TIDY_NODETYPE_COMMENT TIDY_NODETYPE_PROCINS TIDY_NODETYPE_TEXT TIDY_NODETYPE_START TIDY_NODETYPE_END TIDY_NODETYPE_STARTEND TIDY_NODETYPE_CDATA TIDY_NODETYPE_SECTION TIDY_NODETYPE_ASP TIDY_NODETYPE_JSTE TIDY_NODETYPE_PHP TIDY_NODETYPE_XMLDECL contained

    " tokenizer
    syn keyword phpCoreConstant T_REQUIRE_ONCE T_REQUIRE T_EVAL T_INCLUDE_ONCE T_INCLUDE T_LOGICAL_OR T_LOGICAL_XOR T_LOGICAL_AND T_PRINT T_SR_EQUAL T_SL_EQUAL T_XOR_EQUAL T_OR_EQUAL T_AND_EQUAL T_MOD_EQUAL T_CONCAT_EQUAL T_DIV_EQUAL T_MUL_EQUAL T_MINUS_EQUAL T_PLUS_EQUAL T_BOOLEAN_OR T_BOOLEAN_AND T_IS_NOT_IDENTICAL T_IS_IDENTICAL T_IS_NOT_EQUAL T_IS_EQUAL T_IS_GREATER_OR_EQUAL T_IS_SMALLER_OR_EQUAL T_SR T_SL T_INSTANCEOF T_UNSET_CAST T_BOOL_CAST T_OBJECT_CAST T_ARRAY_CAST T_STRING_CAST T_DOUBLE_CAST T_INT_CAST T_DEC T_INC T_CLONE T_NEW T_EXIT T_IF T_ELSEIF T_ELSE T_ENDIF T_LNUMBER T_DNUMBER T_STRING T_STRING_VARNAME T_VARIABLE T_NUM_STRING T_INLINE_HTML T_CHARACTER T_BAD_CHARACTER T_ENCAPSED_AND_WHITESPACE T_CONSTANT_ENCAPSED_STRING T_ECHO T_DO T_WHILE T_ENDWHILE T_FOR T_ENDFOR T_FOREACH T_ENDFOREACH T_DECLARE T_ENDDECLARE T_AS T_SWITCH T_ENDSWITCH T_CASE T_DEFAULT T_BREAK T_CONTINUE T_GOTO T_FUNCTION T_CONST T_RETURN T_TRY T_CATCH T_THROW T_USE T_GLOBAL T_PUBLIC T_PROTECTED T_PRIVATE T_FINAL T_ABSTRACT T_STATIC T_VAR T_UNSET T_ISSET T_EMPTY T_HALT_COMPILER T_CLASS T_INTERFACE T_EXTENDS T_IMPLEMENTS T_OBJECT_OPERATOR T_DOUBLE_ARROW T_LIST T_ARRAY T_CLASS_C T_METHOD_C T_FUNC_C T_LINE T_FILE T_COMMENT T_DOC_COMMENT T_OPEN_TAG T_OPEN_TAG_WITH_ECHO T_CLOSE_TAG T_WHITESPACE T_START_HEREDOC T_END_HEREDOC T_DOLLAR_OPEN_CURLY_BRACES T_CURLY_OPEN T_PAAMAYIM_NEKUDOTAYIM T_NAMESPACE T_NS_C T_DIR T_NS_SEPARATOR T_DOUBLE_COLON contained

    " xml
    syn keyword phpCoreConstant XML_ERROR_NONE XML_ERROR_NO_MEMORY XML_ERROR_SYNTAX XML_ERROR_NO_ELEMENTS XML_ERROR_INVALID_TOKEN XML_ERROR_UNCLOSED_TOKEN XML_ERROR_PARTIAL_CHAR XML_ERROR_TAG_MISMATCH XML_ERROR_DUPLICATE_ATTRIBUTE XML_ERROR_JUNK_AFTER_DOC_ELEMENT XML_ERROR_PARAM_ENTITY_REF XML_ERROR_UNDEFINED_ENTITY XML_ERROR_RECURSIVE_ENTITY_REF XML_ERROR_ASYNC_ENTITY XML_ERROR_BAD_CHAR_REF XML_ERROR_BINARY_ENTITY_REF XML_ERROR_ATTRIBUTE_EXTERNAL_ENTITY_REF XML_ERROR_MISPLACED_XML_PI XML_ERROR_UNKNOWN_ENCODING XML_ERROR_INCORRECT_ENCODING XML_ERROR_UNCLOSED_CDATA_SECTION XML_ERROR_EXTERNAL_ENTITY_HANDLING XML_OPTION_CASE_FOLDING XML_OPTION_TARGET_ENCODING XML_OPTION_SKIP_TAGSTART XML_OPTION_SKIP_WHITE XML_SAX_IMPL contained

    " xmlreader
    syn keyword phpCoreConstant NONE ELEMENT ATTRIBUTE TEXT CDATA ENTITY_REF ENTITY PI COMMENT DOC DOC_TYPE DOC_FRAGMENT NOTATION WHITESPACE SIGNIFICANT_WHITESPACE END_ELEMENT END_ENTITY XML_DECLARATION LOADDTD DEFAULTATTRS VALIDATE SUBST_ENTITIES contained

    " xsl
    syn keyword phpCoreConstant XSL_CLONE_AUTO XSL_CLONE_NEVER XSL_CLONE_ALWAYS LIBXSLT_VERSION LIBXSLT_DOTTED_VERSION LIBEXSLT_VERSION LIBEXSLT_DOTTED_VERSION contained

    " zip
    syn keyword phpCoreConstant CREATE EXCL CHECKCONS OVERWRITE FL_NOCASE FL_NODIR FL_COMPRESSED FL_UNCHANGED CM_DEFAULT CM_STORE CM_SHRINK CM_REDUCE_1 CM_REDUCE_2 CM_REDUCE_3 CM_REDUCE_4 CM_IMPLODE CM_DEFLATE CM_DEFLATE64 CM_PKWARE_IMPLODE ER_OK ER_MULTIDISK ER_RENAME ER_CLOSE ER_SEEK ER_READ ER_WRITE ER_CRC ER_ZIPCLOSED ER_NOENT ER_EXISTS ER_OPEN ER_TMPOPEN ER_ZLIB ER_MEMORY ER_CHANGED ER_COMPNOTSUPP ER_EOF ER_INVAL ER_NOZIP ER_INTERNAL ER_INCONS ER_REMOVE ER_DELETED contained

    " zlib
    syn keyword phpCoreConstant FORCE_GZIP FORCE_DEFLATE ZLIB_ENCODING_DEFLATE ZLIB_ENCODING_GZIP ZLIB_ENCODING_RAW contained
    syn case ignore
  " }}}2

" PHP Syntax: functions {{{1

  syn cluster phpClFunctions add=phpFunctions
    " Core
    syn keyword phpFunctions zend_version func_num_args func_get_arg func_get_args strlen strcmp strncmp strcasecmp strncasecmp each error_reporting define defined get_class get_called_class get_parent_class method_exists property_exists class_exists interface_exists function_exists class_alias get_included_files get_required_files is_subclass_of is_a get_class_vars get_object_vars get_class_methods get_declared_traits trait_exists trigger_error user_error set_error_handler restore_error_handler set_exception_handler restore_exception_handler get_declared_classes get_declared_interfaces get_defined_functions get_defined_vars create_function get_resource_type get_loaded_extensions extension_loaded get_extension_funcs get_defined_constants debug_backtrace debug_print_backtrace gc_collect_cycles gc_enabled gc_enable gc_disable contained
    syn keyword phpClasses Traversable IteratorAggregate Iterator ArrayAccess Serializable Exception ErrorException Closure contained

    " bcmath
    syn keyword phpFunctions bcadd bcsub bcmul bcdiv bcmod bcpow bcsqrt bcscale bccomp bcpowmod contained

    " bz2
    syn keyword phpFunctions bzopen bzread bzwrite bzflush bzclose bzerrno bzerrstr bzerror bzcompress bzdecompress contained

    " calendar
    syn keyword phpFunctions jdtogregorian gregoriantojd jdtojulian juliantojd jdtojewish jewishtojd jdtofrench frenchtojd jddayofweek jdmonthname easter_date easter_days unixtojd jdtounix cal_to_jd cal_from_jd cal_days_in_month cal_info contained

    " com_dotnet
    syn keyword phpFunctions variant_set variant_add variant_cat variant_sub variant_mul variant_and variant_div variant_eqv variant_idiv variant_imp variant_mod variant_or variant_pow variant_xor variant_abs variant_fix variant_int variant_neg variant_not variant_round variant_cmp variant_date_to_timestamp variant_date_from_timestamp variant_get_type variant_set_type variant_cast com_create_guid com_event_sink com_print_typeinfo com_message_pump com_load_typelib com_get_active_object contained
    syn keyword phpClasses COMPersistHelper com_exception com_safearray_proxy variant com dotnet contained

    " ctype
    syn keyword phpFunctions ctype_alnum ctype_alpha ctype_cntrl ctype_digit ctype_lower ctype_graph ctype_print ctype_punct ctype_space ctype_upper ctype_xdigit contained

    " curl
    syn keyword phpFunctions curl_init curl_copy_handle curl_version curl_setopt curl_setopt_array curl_exec curl_getinfo curl_error curl_errno curl_close curl_multi_init curl_multi_add_handle curl_multi_remove_handle curl_multi_select curl_multi_exec curl_multi_getcontent curl_multi_info_read curl_multi_close contained

    " date
    syn keyword phpFunctions strtotime date idate gmdate mktime gmmktime checkdate strftime gmstrftime time localtime getdate date_create date_create_from_format date_parse date_parse_from_format date_get_last_errors date_format date_modify date_add date_sub date_timezone_get date_timezone_set date_offset_get date_diff date_time_set date_date_set date_isodate_set date_timestamp_set date_timestamp_get timezone_open timezone_name_get timezone_name_from_abbr timezone_offset_get timezone_transitions_get timezone_location_get timezone_identifiers_list timezone_abbreviations_list timezone_version_get date_interval_create_from_date_string date_interval_format date_default_timezone_set date_default_timezone_get date_sunrise date_sunset date_sun_info contained
    syn keyword phpClasses DateTime DateTimeZone DateInterval DatePeriod contained

    " dba
    syn keyword phpFunctions dba_close dba_delete dba_exists dba_fetch dba_firstkey dba_handlers dba_insert dba_key_split dba_list dba_nextkey dba_open dba_optimize dba_popen dba_replace dba_sync contained

    " dom
    syn keyword phpFunctions dom_import_simplexml contained
    syn keyword phpClasses DOMException DOMStringList DOMNameList DOMImplementationList DOMImplementationSource DOMImplementation DOMNode DOMNameSpaceNode DOMDocumentFragment DOMDocument DOMNodeList DOMNamedNodeMap DOMCharacterData DOMAttr DOMElement DOMText DOMComment DOMTypeinfo DOMUserDataHandler DOMDomError DOMErrorHandler DOMLocator DOMConfiguration DOMCdataSection DOMDocumentType DOMNotation DOMEntity DOMEntityReference DOMProcessingInstruction DOMStringExtend DOMXPath contained

    " enchant
    syn keyword phpFunctions enchant_broker_describe enchant_broker_dict_exists enchant_broker_free_dictenchant_broker_free enchant_broker_get_error enchant_broker_init enchant_broker_list_dicts enchant_broker_request_dict enchant_broker_request_pwl_dict enchant_broker_set_ordering enchant_dict_add_to_personal enchant_dict_add_to_session enchant_dict_check enchant_dict_describe enchant_dict_get_error enchant_dict_is_in_session enchant_dict_quick_check enchant_dict_store_replacement enchant_dict_suggest contained

    " ereg
    syn keyword phpFunctions ereg ereg_replace eregi eregi_replace split spliti sql_regcase contained

    " exif
    syn keyword phpFunctions exif_imagetype exif_read_data exif_tagname exif_thumbnail read_exif_data contained

    " fileinfo
    syn keyword phpFunctions finfo_open finfo_close finfo_set_flags finfo_file finfo_buffer mime_content_type contained
    syn keyword phpClasses finfo contained

    " filter
    syn keyword phpFunctions filter_input filter_var filter_input_array filter_var_array filter_list filter_has_var filter_id contained

    " ftp
    syn keyword phpFunctions ftp_connect ftp_login ftp_pwd ftp_cdup ftp_chdir ftp_exec ftp_raw ftp_mkdir ftp_rmdir ftp_chmod ftp_alloc ftp_nlist ftp_rawlist ftp_systype ftp_pasv ftp_get ftp_fget ftp_put ftp_fput ftp_size ftp_mdtm ftp_rename ftp_delete ftp_site ftp_close ftp_set_option ftp_get_option ftp_nb_fget ftp_nb_get ftp_nb_continue ftp_nb_put ftp_nb_fput ftp_quit contained

    " gd
    syn keyword phpFunctions gd_info imagearc imageellipse imagechar imagecharup imagecolorat imagecolorallocate imagepalettecopy imagecreatefromstring imagecolorclosest imagecolorclosesthwb imagecolordeallocate imagecolorresolve imagecolorexact imagecolorset imagecolortransparent imagecolorstotal imagecolorsforindex imagecopy imagecopymerge imagecopymergegray imagecopyresized imagecreate imagecreatetruecolor imageistruecolor imagetruecolortopalette imagesetthickness imagefilledarc imagefilledellipse imagealphablending imagesavealpha imagecolorallocatealpha imagecolorresolvealpha imagecolorclosestalpha imagecolorexactalpha imagecopyresampled imagerotate imageantialias imagesettile imagesetbrush imagesetstyle imagecreatefrompng imagecreatefromgif imagecreatefromwbmp imagecreatefromxbm imagecreatefromgd imagecreatefromgd2 imagecreatefromgd2part imagepng imagegif imagewbmp imagegd imagegd2 imagedestroy imagegammacorrect imagefill imagefilledpolygon imagefilledrectangle imagefilltoborder imagefontwidth imagefontheight imageinterlace imageline imageloadfont imagepolygon imagerectangle imagesetpixel imagestring imagestringup imagesx imagesy imagedashedline imagetypes png2wbmp image2wbmp imagelayereffect imagexbm imagecolormatch imagefilter imageconvolution getimagesizefrom string contained

    " gettext
    syn keyword phpFunctions textdomain gettext dgettext dcgettext bindtextdomain ngettext dngettext dcngettext bind_textdomain_codeset contained

    " gmp
    syn keyword phpFunctions gmp_init gmp_intval gmp_strval gmp_add gmp_sub gmp_mul gmp_div_qr gmp_div_q gmp_div_r gmp_div gmp_mod gmp_divexact gmp_neg gmp_abs gmp_fact gmp_sqrt gmp_sqrtrem gmp_pow gmp_powm gmp_perfect_square gmp_prob_prime gmp_gcd gmp_gcdext gmp_invert gmp_jacobi gmp_legendre gmp_cmp gmp_sign gmp_random gmp_and gmp_or gmp_com gmp_xor gmp_setbit gmp_clrbit gmp_scan0 gmp_scan1 gmp_testbit gmp_popcount gmp_hamdist gmp_nextprime contained

    " hash
    syn keyword phpFunctions hash hash_file hash_hmac hash_hmac_file hash_init hash_update hash_update_stream hash_update_file hash_final hash_copy hash_algos mhash_keygen_s2k mhash_get_block_size mhash_get_hash_name mhash_count mhash contained

    " iconv
    syn keyword phpFunctions iconv ob_iconv_handler iconv_get_encoding iconv_set_encoding iconv_strlen iconv_substr iconv_strpos iconv_strrpos iconv_mime_encode iconv_mime_decode iconv_mime_decode_headers contained

    " imap
    syn keyword phpFunctions  imap_open imap_reopen imap_close imap_num_msg imap_num_recent imap_headers imap_headerinfo imap_rfc822_parse_headers imap_rfc822_write_address imap_rfc822_parse_adrlist imap_body imap_bodystruct imap_fetchbody imap_savebody imap_fetchheader imap_fetchstructure imap_gc imap_expunge imap_delete imap_undelete imap_check imap_mail_copy imap_mail_move imap_mail_compose imap_createmailbox imap_renamemailbox imap_deletemailbox imap_subscribe imap_unsubscribe imap_append imap_ping imap_base64 imap_qprint imap_8bit imap_binary imap_utf8 imap_status imap_mailboxmsginfo imap_setflag_full imap_clearflag_full imap_sort imap_uid imap_msgno imap_list imap_lsub imap_fetch_overview imap_alerts imap_errors imap_last_error imap_search imap_utf7_decode imap_utf7_encode imap_utf8_to_mutf7 imap_mutf7_to_utf8 imap_mime_header_decode imap_thread imap_timeout imap_get_quota imap_get_quotaroot imap_set_quota imap_setacl imap_getacl imap_mail imap_header imap_listmailbox imap_getmailboxes imap_scanmailbox imap_listsubscribed imap_getsubscribed imap_fetchtext imap_scan imap_create imap_rename contained

    " intl
    syn keyword phpFunctions collator_create collator_compare collator_get_attribute collator_set_attribute collator_get_strength collator_set_strength collator_sort collator_sort_with_sort_keys collator_asort collator_get_locale collator_get_error_code collator_get_error_message numfmt_create numfmt_format numfmt_parse numfmt_format_currency numfmt_parse_currency numfmt_set_attribute numfmt_get_attribute numfmt_set_text_attribute numfmt_get_text_attribute numfmt_set_symbol numfmt_get_symbol numfmt_set_pattern numfmt_get_pattern numfmt_get_locale numfmt_get_error_code numfmt_get_error_message normalizer_normalize normalizer_is_normalized locale_get_default locale_set_default locale_get_primary_language locale_get_script locale_get_region locale_get_keywords locale_get_display_script locale_get_display_region locale_get_display_name locale_get_display_language locale_get_display_variant locale_compose locale_parse locale_get_all_variants locale_filter_matches locale_canonicalize locale_lookup locale_accept_from_http msgfmt_create msgfmt_format msgfmt_format_message msgfmt_parse msgfmt_parse_message msgfmt_set_pattern msgfmt_get_pattern msgfmt_get_locale msgfmt_get_error_code msgfmt_get_error_message datefmt_create datefmt_get_datetype datefmt_get_timetype datefmt_get_calendar datefmt_set_calendar datefmt_get_locale datefmt_get_timezone_id datefmt_set_timezone_id datefmt_get_pattern datefmt_set_pattern datefmt_is_lenient datefmt_set_lenient datefmt_format datefmt_parse datefmt_localtime datefmt_get_error_code datefmt_get_error_message grapheme_strlen grapheme_strpos grapheme_stripos grapheme_strrpos grapheme_strripos grapheme_substr grapheme_strstr grapheme_stristr grapheme_extract idn_to_ascii idn_to_utf8 intl_get_error_code intl_get_error_message intl_is_failure intl_error_name transliterator_create transliterator_create_from_rules trasliterator_create_inverse transliterator_get_error_code transliterator_get_error_message transliterator_list_ids transliterator_transliterate contained
    syn keyword phpClasses Collator NumberFormatter Normalizer Locale MessageFormatter IntlDateFormatter Transliterator Spoofchecker contained

    " json
    syn keyword phpFunctions json_encode json_decode json_last_error contained
    syn keyword phpClasses JsonSerializable

    " ldap
    syn keyword phpFunctions ldap_connect ldap_close ldap_bind ldap_unbind ldap_read ldap_list ldap_search ldap_free_result ldap_count_entries ldap_first_entry ldap_next_entry ldap_get_entries ldap_first_attribute ldap_next_attribute ldap_get_attributes ldap_get_values ldap_get_values_len ldap_get_dn ldap_explode_dn ldap_dn2ufn ldap_add ldap_delete ldap_modify ldap_mod_add ldap_mod_replace ldap_mod_del ldap_errno ldap_err2str ldap_error ldap_compare ldap_sort ldap_rename ldap_get_option ldap_set_option ldap_first_reference ldap_next_reference ldap_parse_reference ldap_parse_result ldap_start_tls ldap_control_paged_result ldap_control_paged_result_response contained

    " libxml
    syn keyword phpFunctions libxml_set_streams_context libxml_use_internal_errors libxml_get_last_error libxml_clear_errors libxml_get_errors libxml_disable_entity_loader libxml_set_external_entity_loader contained
    syn keyword phpClasses LibXMLError contained

    " mbstring
    syn keyword phpFunctions mb_convert_case mb_strtoupper mb_strtolower mb_language mb_internal_encoding mb_http_input mb_http_output mb_detect_order mb_substitute_character mb_parse_str mb_output_handler mb_preferred_mime_name mb_strlen mb_strpos mb_strrpos mb_stripos mb_strripos mb_strstr mb_strrchr mb_stristr mb_strrichr mb_substr_count mb_substr mb_strcut mb_strwidth mb_strimwidth mb_convert_encoding mb_detect_encoding mb_list_encodings mb_encoding_aliases mb_convert_kana mb_encode_mimeheader mb_decode_mimeheader mb_convert_variables mb_encode_numericentity mb_decode_numericentity mb_send_mail mb_get_info mb_check_encoding mb_regex_encoding mb_regex_set_options mb_ereg mb_eregi mb_ereg_replace mb_eregi_replace mb_split mb_ereg_match mb_ereg_search mb_ereg_search_pos mb_ereg_search_regs mb_ereg_search_init mb_ereg_search_getregs mb_ereg_search_getpos mb_ereg_search_setpos mbregex_encoding mbereg mberegi mbereg_replace mberegi_replace mbsplit mbereg_match mbereg_search mbereg_search_pos mbereg_search_regs mbereg_search_init mbereg_search_getregs mbereg_search_getpos mbereg_search_setpos contained

    " mcrypt
    syn keyword phpFunctions mcrypt_ecb mcrypt_cbc mcrypt_cfb mcrypt_ofb mcrypt_get_key_size mcrypt_get_block_size mcrypt_get_cipher_name mcrypt_create_iv mcrypt_list_algorithms mcrypt_list_modes mcrypt_get_iv_size mcrypt_encrypt mcrypt_decrypt mcrypt_module_open mcrypt_generic_init mcrypt_generic mdecrypt_generic mcrypt_generic_end mcrypt_generic_deinit mcrypt_enc_self_test mcrypt_enc_is_block_algorithm_mode mcrypt_enc_is_block_algorithm mcrypt_enc_is_block_mode mcrypt_enc_get_block_size mcrypt_enc_get_key_size mcrypt_enc_get_supported_key_sizes mcrypt_enc_get_iv_size mcrypt_enc_get_algorithms_name mcrypt_enc_get_modes_name mcrypt_module_self_test mcrypt_module_is_block_algorithm_mode mcrypt_module_is_block_algorithm mcrypt_module_is_block_mode mcrypt_module_get_algo_block_size mcrypt_module_get_algo_key_size mcrypt_module_get_supported_key_sizes mcrypt_module_close contained

    " mysql
    syn keyword phpFunctions mysql_connect mysql_pconnect mysql_close mysql_select_db mysql_query mysql_unbuffered_query mysql_db_query mysql_list_dbs mysql_list_tables mysql_list_fields mysql_list_processes mysql_error mysql_errno mysql_affected_rows mysql_insert_id mysql_result mysql_num_rows mysql_num_fields mysql_fetch_row mysql_fetch_array mysql_fetch_assoc mysql_fetch_object mysql_data_seek mysql_fetch_lengths mysql_fetch_field mysql_field_seek mysql_free_result mysql_field_name mysql_field_table mysql_field_len mysql_field_type mysql_field_flags mysql_escape_string mysql_real_escape_string mysql_stat mysql_thread_id mysql_client_encoding mysql_ping mysql_get_client_info mysql_get_host_info mysql_get_proto_info mysql_get_server_info mysql_info mysql_set_charset mysql mysql_fieldname mysql_fieldtable mysql_fieldlen mysql_fieldtype mysql_fieldflags mysql_selectdb mysql_freeresult mysql_numfields mysql_numrows mysql_listdbs mysql_listtables mysql_listfields mysql_db_name mysql_dbname mysql_tablename mysql_table_name contained

    " mysqli
    syn keyword phpFunctions mysqli_affected_rows mysqli_autocommit mysqli_change_user mysqli_character_set_name mysqli_close mysqli_commit mysqli_connect mysqli_connect_errno mysqli_connect_error mysqli_data_seek mysqli_dump_debug_info mysqli_debug mysqli_errno mysqli_error mysqli_stmt_execute mysqli_execute mysqli_fetch_field mysqli_fetch_fields mysqli_fetch_field_direct mysqli_fetch_lengths mysqli_fetch_all mysqli_fetch_array mysqli_fetch_assoc mysqli_fetch_object mysqli_fetch_row mysqli_field_count mysqli_field_seek mysqli_field_tell mysqli_free_result mysqli_get_cache_stats mysqli_get_connection_stats mysqli_get_client_stats mysqli_get_charset mysqli_get_client_info mysqli_get_client_version mysqli_get_host_info mysqli_get_proto_info mysqli_get_server_info mysqli_get_server_version mysqli_get_warnings mysqli_init mysqli_info mysqli_insert_id mysqli_kill mysqli_more_results mysqli_multi_query mysqli_next_result mysqli_num_fields mysqli_num_rows mysqli_options mysqli_ping mysqli_poll mysqli_prepare mysqli_report mysqli_query mysqli_real_connect mysqli_real_escape_string mysqli_real_query mysqli_reap_async_query mysqli_rollback mysqli_select_db mysqli_set_charset mysqli_stmt_attr_get mysqli_stmt_attr_set mysqli_stmt_field_count mysqli_stmt_init mysqli_stmt_prepare mysqli_stmt_result_metadata mysqli_stmt_send_long_data mysqli_stmt_bind_param mysqli_stmt_bind_result mysqli_stmt_fetch mysqli_stmt_free_result mysqli_stmt_get_result mysqli_stmt_get_warnings mysqli_stmt_insert_id mysqli_stmt_reset mysqli_stmt_param_count mysqli_sqlstate mysqli_stat mysqli_stmt_affected_rows mysqli_stmt_close mysqli_stmt_data_seek mysqli_stmt_errno mysqli_stmt_error mysqli_stmt_more_results mysqli_stmt_next_result mysqli_stmt_num_rows mysqli_stmt_sqlstate mysqli_stmt_store_result mysqli_store_result mysqli_thread_id mysqli_thread_safe mysqli_use_result mysqli_warning_count mysqli_refresh mysqli_bind_param mysqli_bind_result mysqli_client_encoding mysqli_escape_string mysqli_fetch mysqli_param_count mysqli_get_metadata mysqli_send_long_data mysqli_set_opt mysqli_error_list mysqli_stmt_error_list contained
    syn keyword phpClasses mysqli_sql_exception mysqli_driver mysqli mysqli_warning mysqli_result mysqli_stmt contained

    " odbc
    syn keyword phpFunctions odbc_autocommit odbc_binmode odbc_close odbc_close_all odbc_columns odbc_commit odbc_connect odbc_cursor odbc_data_source odbc_execute odbc_error odbc_errormsg odbc_exec odbc_fetch_array odbc_fetch_object odbc_fetch_row odbc_fetch_into odbc_field_len odbc_field_scale odbc_field_name odbc_field_type odbc_field_num odbc_free_result odbc_gettypeinfo odbc_longreadlen odbc_next_result odbc_num_fields odbc_num_rows odbc_pconnect odbc_prepare odbc_result odbc_result_all odbc_rollback odbc_setoption odbc_specialcolumns odbc_statistics odbc_tables odbc_primarykeys odbc_columnprivileges odbc_tableprivileges odbc_foreignkeys odbc_procedures odbc_procedurecolumns odbc_do odbc_field_precision contained

    " openssl
    syn keyword phpFunctions openssl_pkey_free openssl_pkey_new openssl_pkey_export openssl_pkey_export_to_file openssl_pkey_get_private openssl_pkey_get_public openssl_pkey_get_details openssl_free_key openssl_get_privatekey openssl_get_publickey openssl_x509_read openssl_x509_free openssl_x509_parse openssl_x509_checkpurpose openssl_x509_check_private_key openssl_x509_export openssl_x509_export_to_file openssl_pkcs12_export openssl_pkcs12_export_to_file openssl_pkcs12_read openssl_csr_new openssl_csr_export openssl_csr_export_to_file openssl_csr_sign openssl_csr_get_subject openssl_csr_get_public_key openssl_digest openssl_encrypt openssl_decrypt openssl_sign openssl_verify openssl_seal openssl_open openssl_pkcs7_verify openssl_pkcs7_decrypt openssl_pkcs7_sign openssl_pkcs7_encrypt openssl_private_encrypt openssl_private_decrypt openssl_public_encrypt openssl_public_decrypt openssl_get_md_methods openssl_get_cipher_methods openssl_dh_compute_key openssl_random_pseudo_bytes openssl_error_string contained

    " pcre
    syn keyword phpFunctions preg_match preg_match_all preg_replace preg_replace_callback preg_filter preg_split preg_quote preg_grep preg_last_error contained

    " PDO
    syn keyword phpFunctions pdo_drivers contained
    syn keyword phpClasses PDOException PDO PDOStatement PDORow contained

    " pgsql
    syn keyword phpFunctions pg_connect pg_pconnect pg_close pg_connection_status pg_connection_busy pg_connection_reset pg_host pg_dbname pg_port pg_tty pg_options pg_version pg_ping pg_parameter_status pg_transaction_status pg_query pg_query_params pg_prepare pg_execute pg_send_query pg_send_query_params pg_send_prepare pg_send_execute pg_cancel_query pg_fetch_result pg_fetch_row pg_fetch_assoc pg_fetch_array pg_fetch_object pg_fetch_all pg_fetch_all_columns pg_affected_rows pg_get_result pg_result_seek pg_result_status pg_free_result pg_last_oid pg_num_rows pg_num_fields pg_field_name pg_field_num pg_field_size pg_field_type pg_field_type_oid pg_field_prtlen pg_field_is_null pg_field_table pg_get_notify pg_get_pid pg_result_error pg_result_error_field pg_last_error pg_last_notice pg_put_line pg_end_copy pg_copy_to pg_copy_from pg_trace pg_untrace pg_lo_create pg_lo_unlink pg_lo_open pg_lo_close pg_lo_read pg_lo_write pg_lo_read_all pg_lo_import pg_lo_export pg_lo_seek pg_lo_tell pg_escape_string pg_escape_bytea pg_unescape_bytea pg_set_error_verbosity pg_client_encoding pg_set_client_encoding pg_meta_data pg_convert pg_insert pg_update pg_delete pg_select pg_exec pg_getlastoid pg_cmdtuples pg_errormessage pg_numrows pg_numfields pg_fieldname pg_fieldsize pg_fieldtype pg_fieldnum pg_fieldprtlen pg_fieldisnull pg_freeresult pg_result pg_loreadall pg_locreate pg_lounlink pg_loopen pg_loclose pg_loread pg_lowrite pg_loimport pg_loexport pg_clientencoding pg_setclientencoding contained

    " Phar
    syn keyword phpClasses PharException Phar PharData PharFileInfo contained

    " readline
    syn keyword phpFunctions readline readline_add_history readline_callback_handler_install readline_callback_handler_remove readline_callback_read_char readline_clear_history readline_completion_function readline_info readline_list_history readline_on_new_line readline_read_history readline_redisplay readline_write_history contained

    " recode
    syn keyword phpFunctions recode recode_file recode_string contained

    " Reflection
    syn keyword phpClasses ReflectionException Reflection Reflector ReflectionFunctionAbstract ReflectionFunction ReflectionParameter ReflectionMethod ReflectionClass ReflectionObject ReflectionProperty ReflectionExtension ReflectionZendExtension contained

    " session
    syn keyword phpFunctions session_name session_module_name session_save_path session_id session_regenerate_id session_decode session_register session_unregister session_is_registered session_encode session_start session_destroy session_unset session_set_save_handler session_cache_limiter session_cache_expire session_set_cookie_params session_get_cookie_params session_write_close session_commit session_status session_register_shutdown contained
    syn keyword phpClasses SessionHandler SessionHandlerInterface contained

    " shmop
    syn keyword phpFunctions shmop_open shmop_read shmop_close shmop_size shmop_write shmop_delete contained

    " SimpleXML
    syn keyword phpFunctions simplexml_load_file simplexml_load_string simplexml_import_dom contained
    syn keyword phpClasses SimpleXMLElement SimpleXMLIterator contained

    " soap
    syn keyword phpFunctions use_soap_error_handler is_soap_fault contained
    syn keyword phpClasses SoapClient SoapVar SoapServer SoapFault SoapParam SoapHeader contained

    " sockets
    syn keyword phpFunctions socket_select socket_create socket_create_listen socket_create_pair socket_accept socket_set_nonblock socket_set_block socket_listen socket_close socket_write socket_read socket_getsockname socket_getpeername socket_connect socket_strerror socket_bind socket_recv socket_send socket_recvfrom socket_sendto socket_get_option socket_set_option socket_shutdown socket_last_error socket_clear_error socket_getopt socket_setopt contained

    " SPL
    syn keyword phpFunctions spl_classes spl_autoload spl_autoload_extensions spl_autoload_register spl_autoload_unregister spl_autoload_functions spl_autoload_call class_parents class_implements spl_object_hash iterator_to_array iterator_count iterator_apply class_uses contained
    syn keyword phpClasses LogicException BadFunctionCallException BadMethodCallException DomainException InvalidArgumentException LengthException OutOfRangeException RuntimeException OutOfBoundsException OverflowException RangeException UnderflowException UnexpectedValueException RecursiveIterator RecursiveIteratorIterator OuterIterator IteratorIterator FilterIterator RecursiveFilterIterator ParentIterator Countable SeekableIterator LimitIterator CachingIterator RecursiveCachingIterator NoRewindIterator AppendIterator InfiniteIterator RegexIterator RecursiveRegexIterator EmptyIterator RecursiveTreeIterator ArrayObject ArrayIterator RecursiveArrayIterator SplFileInfo DirectoryIterator FilesystemIterator RecursiveDirectoryIterator GlobIterator SplFileObject SplTempFileObject SplDoublyLinkedList SplQueue SplStack SplHeap SplMinHeap SplMaxHeap SplPriorityQueue SplFixedArray SplObserver SplSubject SplObjectStorage MultipleIterator CallbackFilterIterator RecursiveCallbackFilterIterator contained

    " standard
    syn keyword phpFunctions constant bin2hex hex2bin sleep usleep time_nanosleep time_sleep_until flush wordwrap htmlspecialchars htmlentities html_entity_decode htmlspecialchars_decode get_html_translation_table sha1 sha1_file md5 md5_file crc32 iptcparse iptcembed getimagesize image_type_to_mime_type image_type_to_extension phpinfo phpversion phpcredits php_logo_guid php_real_logo_guid php_egg_logo_guid zend_logo_guid php_sapi_name php_uname php_ini_scanned_files php_ini_loaded_file strnatcmp strnatcasecmp substr_count strspn strcspn strtok strtoupper strtolower strpos stripos strrpos strripos strrev hebrev hebrevc nl2br basename dirname pathinfo stripslashes stripcslashes strstr stristr strrchr str_shuffle str_word_count str_split strpbrk substr_compare strcoll substr substr_replace quotemeta ucfirst lcfirst ucwords strtr addslashes addcslashes rtrim str_replace str_ireplace str_repeat count_chars chunk_split trim ltrim strip_tags similar_text explode implode join setlocale localeconv soundex levenshtein chr ord parse_str str_getcsv str_pad chop strchr sprintf printf vprintf vsprintf fprintf vfprintf sscanf fscanf parse_url urlencode urldecode rawurlencode rawurldecode http_response_code http_build_query linkinfo link unlink exec system escapeshellcmd escapeshellarg passthru shell_exec proc_open proc_close proc_terminate proc_get_status rand srand getrandmax mt_rand mt_srand mt_getrandmax getservbyname getservbyport getprotobyname getprotobynumber getmyuid getmygid getmypid getmyinode getlastmod base64_decode base64_encode convert_uuencode convert_uudecode abs ceil floor round sin cos tan asin acos atan atanh atan2 sinh cosh tanh asinh acosh expm1 log1p pi is_finite is_nan is_infinite pow exp log log10 sqrt hypot deg2rad rad2deg bindec hexdec octdec decbin decoct dechex base_convert number_format fmod inet_ntop inet_pton ip2long long2ip getenv putenv getopt microtime gettimeofday uniqid quoted_printable_decode quoted_printable_encode convert_cyr_string get_current_user set_time_limit get_cfg_var magic_quotes_runtime set_magic_quotes_runtime get_magic_quotes_gpc get_magic_quotes_runtime import_request_variables error_log error_get_last call_user_func call_user_func_array call_user_method call_user_method_array forward_static_call forward_static_call_array serialize unserialize var_dump var_export debug_zval_dump print_r memory_get_usage memory_get_peak_usage register_shutdown_function register_tick_function unregister_tick_function highlight_file show_source highlight_string php_strip_whitespace ini_get ini_get_all ini_set ini_alter ini_restore get_include_path set_include_path restore_include_path setcookie setrawcookie header header_remove header_register_callback headers_sent headers_list connection_aborted connection_status ignore_user_abort parse_ini_file parse_ini_string is_uploaded_file move_uploaded_file gethostbyaddr gethostbyname gethostbynamel gethostname dns_check_record checkdnsrr dns_get_mx getmxrr dns_get_record intval floatval doubleval strval gettype settype is_null is_resource is_bool is_long is_float is_int is_integer is_double is_real is_numeric is_string is_array is_object is_scalar is_callable pclose popen readfile rewind rmdir umask fclose feof fgetc fgets fgetss fread fopen fpassthru ftruncate fstat fseek ftell fflush fwrite fputs mkdir rename copy tempnam tmpfile file file_get_contents file_put_contents stream_select stream_context_create stream_context_set_params stream_context_get_params stream_context_set_option stream_context_get_options stream_context_get_default stream_context_set_default stream_filter_prepend stream_filter_append stream_filter_remove stream_set_chunk_size stream_socket_client stream_socket_server stream_socket_accept stream_socket_get_name stream_socket_recvfrom stream_socket_sendto stream_socket_enable_crypto stream_socket_shutdown stream_socket_pair stream_copy_to_stream stream_get_contents stream_supports_lock fgetcsv fputcsv flock get_meta_tags stream_set_write_buffer set_file_buffer set_socket_blocking stream_set_blocking socket_import_stream socket_set_blocking stream_get_meta_data stream_get_line stream_wrapper_register stream_register_wrapper stream_wrapper_unregister stream_wrapper_restore stream_get_wrappers stream_get_transports stream_is_local get_headers stream_set_timeout socket_set_timeout socket_get_status realpath fnmatch fsockopen pfsockopen pack unpack get_browser crypt opendir closedir chdir getcwd rewinddir readdir dir scandir glob fileatime filectime filegroup fileinode filemtime fileowner fileperms filesize filetype file_exists is_writable is_writeable is_readable is_executable is_file is_dir is_link stat lstat chown chgrp chmod touch clearstatcache disk_total_space disk_free_space diskfreespace mail ezmlm_hash openlog syslog closelog define_syslog_variables lcg_value metaphone ob_start ob_flush ob_clean ob_end_flush ob_end_clean ob_get_flush ob_get_clean ob_get_length ob_get_level ob_get_status ob_get_contents ob_implicit_flush ob_list_handlers ksort krsort natsort natcasesort asort arsort sort rsort usort uasort uksort shuffle array_walk array_walk_recursive count end prev next reset current key min max in_array array_search extract compact array_fill array_fill_keys range array_multisort array_push array_pop array_shift array_unshift array_splice array_slice array_merge array_merge_recursive array_replace array_replace_recursive array_keys array_values array_count_values array_reverse array_reduce array_pad array_flip array_change_key_case array_rand array_unique array_intersect array_intersect_key array_intersect_ukey array_uintersect array_intersect_assoc array_uintersect_assoc array_intersect_uassoc array_uintersect_uassoc array_diff array_diff_key array_diff_ukey array_udiff array_diff_assoc array_udiff_assoc array_diff_uassoc array_udiff_uassoc array_sum array_product array_filter array_map array_chunk array_combine array_key_exists pos sizeof key_exists assert assert_options version_compare str_rot13 stream_get_filters stream_filter_register stream_bucket_make_writeable stream_bucket_prepend stream_bucket_append stream_bucket_new output_add_rewrite_var output_reset_rewrite_vars sys_get_temp_dir apache_child_terminate getallheaders apache_request_headers apache_response_headers contained
    syn keyword phpClasses __PHP_Incomplete_Class php_user_filter Directory contained

    " SQLite
    syn keyword phpFunctions sqlite_open sqlite_popen sqlite_close sqlite_query sqlite_exec sqlite_array_query sqlite_single_query sqlite_fetch_array sqlite_fetch_object sqlite_fetch_single sqlite_fetch_string sqlite_fetch_all sqlite_current sqlite_column sqlite_libversion sqlite_libencoding sqlite_changes sqlite_last_insert_rowid sqlite_num_rows sqlite_num_fields sqlite_field_name sqlite_seek sqlite_rewind sqlite_next sqlite_prev sqlite_valid sqlite_has_more sqlite_has_prev sqlite_escape_string sqlite_busy_timeout sqlite_last_error sqlite_error_string sqlite_unbuffered_query sqlite_create_aggregate sqlite_create_function sqlite_factory sqlite_udf_encode_binary sqlite_udf_decode_binary sqlite_fetch_column_types contained
    syn keyword phpClasses SQLiteDatabase SQLiteResult SQLiteUnbuffered SQLiteException contained

    " sqlite3
    syn keyword phpClasses SQLite3 SQLite3Stmt SQLite3Result contained

    " tidy
    syn keyword phpFunctions tidy_getopt tidy_parse_string tidy_parse_file tidy_get_output tidy_get_error_buffer tidy_clean_repair tidy_repair_string tidy_repair_file tidy_diagnose tidy_get_release tidy_get_config tidy_get_status tidy_get_html_ver tidy_is_xhtml tidy_is_xml tidy_error_count tidy_warning_count tidy_access_count tidy_config_count tidy_get_root tidy_get_head tidy_get_html tidy_get_body ob_tidyhandler contained
    syn keyword phpClasses tidy tidyNode contained

    " tokenizer
    syn keyword phpFunctions token_get_all token_name contained

    " xml
    syn keyword phpFunctions  xml_parser_create xml_parser_create_ns xml_set_object xml_set_element_handler xml_set_character_data_handler xml_set_processing_instruction_handler xml_set_default_handler xml_set_unparsed_entity_decl_handler xml_set_notation_decl_handler xml_set_external_entity_ref_handler xml_set_start_namespace_decl_handler xml_set_end_namespace_decl_handler xml_parse xml_parse_into_struct xml_get_error_code xml_error_string xml_get_current_line_number xml_get_current_column_number xml_get_current_byte_index xml_parser_free xml_parser_set_option xml_parser_get_option utf8_encode utf8_decode contained

    " xmlreader
    syn keyword phpClasses XMLReader contained

    " xmlwriter
    syn keyword phpFunctions  xmlwriter_open_uri xmlwriter_open_memory xmlwriter_set_indent xmlwriter_set_indent_string xmlwriter_start_comment xmlwriter_end_comment xmlwriter_start_attribute xmlwriter_end_attribute xmlwriter_write_attribute xmlwriter_start_attribute_ns xmlwriter_write_attribute_ns xmlwriter_start_element xmlwriter_end_element xmlwriter_full_end_element xmlwriter_start_element_ns xmlwriter_write_element xmlwriter_write_element_ns xmlwriter_start_pi xmlwriter_end_pi xmlwriter_write_pi xmlwriter_start_cdata xmlwriter_end_cdata xmlwriter_write_cdata xmlwriter_text xmlwriter_write_raw xmlwriter_start_document xmlwriter_end_document xmlwriter_write_comment xmlwriter_start_dtd xmlwriter_end_dtd xmlwriter_write_dtd xmlwriter_start_dtd_element xmlwriter_end_dtd_element xmlwriter_write_dtd_element xmlwriter_start_dtd_attlist xmlwriter_end_dtd_attlist xmlwriter_write_dtd_attlist xmlwriter_start_dtd_entity xmlwriter_end_dtd_entity xmlwriter_write_dtd_entity xmlwriter_output_memory xmlwriter_flush contained
    syn keyword phpClasses XMLWriter contained

    " xmlrpc
    syn keyword phpFunctions xmlrpc_encode xmlrpc_decode xmlrpc_decode_request xmlrpc_encode_request xmlrpc_get_type xmlrpc_set_type xmlrpc_is_fault xmlrpc_server_create xmlrpc_server_destroy xmlrpc_server_register_method xmlrpc_server_call_method xmlrpc_parse_method_descriptions xmlrpc_server_add_introspection_data xmlrpc_server_register_introspection_callback contained

    " xsl
    syn keyword phpClasses XSLTProcessor contained

    " zip
    syn keyword phpFunctions zip_open zip_close zip_read zip_entry_open zip_entry_close zip_entry_read zip_entry_filesize zip_entry_name zip_entry_compressedsize zip_entry_compressionmethod contained
    syn keyword phpClasses ZipArchive contained

    " zlib
    syn keyword phpFunctions readgzfile gzrewind gzclose gzeof gzgetc gzgets gzgetss gzread gzopen gzpassthru gzseek gztell gzwrite gzputs gzfile gzcompress gzuncompress gzdeflate gzinflate gzencode ob_gzhandler zlib_get_coding_type zlib_decode zlib_encode contained

  " }}}2

  if s:show_baselib
    syn keyword	phpMethods	query next_record num_rows affected_rows nf f p np num_fields haltmsg seek link_id query_id metadata table_names nextid connect halt free register unregister is_registered delete url purl self_url pself_url hidden_session add_query padd_query reimport_get_vars reimport_post_vars reimport_cookie_vars set_container set_tokenname release_token put_headers get_id get_id put_id freeze thaw gc reimport_any_vars start url purl login_if is_authenticated auth_preauth auth_loginform auth_validatelogin auth_refreshlogin auth_registerform auth_doregister start check have_perm permsum perm_invalid	contained
    syn keyword	phpFunctions	page_open page_close sess_load sess_save	contained
  endif


" }}}1

" {{{1 REVIEW: }}}1


" Keyword
syn cluster phpClInClass add=phpClassDefine
syn keyword	phpClassDefine contained var const
hi link phpClassDefine phpDefine

if s:alt_arrays
  syn cluster phpClExpressions add=phpArrayRegion
  syn cluster phpClValues add=phpArrayRegionSimple
  " TODO: should the error highlighting be optional???
  if s:fold_arrays
    syn region phpArrayRegionSimple contained matchgroup=phpArrayParens start=/\<array\_s*(/ end=/)/
          \ keepend extend contains=@phpClValues,phpArrayPair,phpArrayComma
          \ matchgroup=Error end=/;/
          \ fold
    syn region phpArrayRegion contained matchgroup=phpArrayParens start=/\<array\_s*(/ end=/)/
          \ keepend extend contains=@phpClExpressions,phpArrayPair,phpArrayComma
          \ matchgroup=Error end=/;/
          \ fold
  else
    syn region phpArrayRegionSimple contained matchgroup=phpArrayParens start=/\<array\_s*(/ end=/)/
          \ keepend extend contains=@phpClValues,phpArrayPair,phpArrayComma
          \ matchgroup=Error end=/;/
    syn region phpArrayRegion contained matchgroup=phpArrayParens start=/\<array\_s*(/ end=/)/
          \ keepend extend contains=@phpClExpressions,phpArrayPair,phpArrayComma
          \ matchgroup=Error end=/;/
  endif
  syn match phpArrayComma contained display /,/

  syn cluster phpClExpressions add=phpListRegion
  " need to make a region for the 'list' keyword as well!!!
  " TODO: should the error highlighting be optional???
  " TODO: only allow variables and stuff inside the list() construct
  syn region phpListRegion contained matchgroup=phpList start=/\<list(/ end=/)/
        \ keepend extend contains=@phpClExpressions,phpListComma
        \ matchgroup=Error end=/;/
  syn match phpListComma contained display /,/
else
  " need to use a match instead of keyword here ... to stop it
  " from blocking a match later on.
  syn cluster phpClExpressions add=phpArray
  syn match phpArray contained display /\<array\>/

  syn keyword phpList contained list
endif

" Operators


" Peter Hodge - added support for array-building operator
" to stop the relations from mixing this up
if s:alt_arrays
  " highlight misuse of the '=>' operator
  syn cluster phpClExpressions add=phpArrayPairError
  syn match	phpArrayPairError /=>/ contained display

  " the next match is used only in the correct places
  syn match	phpArrayPair /=>/ contained display
else
  syn match phpOperator /=>/ contained display
endif

" relations
" Peter Hodge, June 17 2006
" - altered relations to match strict comparisons (=== and !==)
" - highlight the 'instanceof' operator as a relation operator
"   rather than a structure, if comparison support is a priority.
syn cluster phpClExpressions add=phpRelation
syn match phpRelation contained display /===\=/
syn match phpRelation contained display /!==\=/
syn match phpRelation contained display /<<\@!=\=/
syn match phpRelation contained display />>\@!=\=/

" 'instanceof' is also a relation, but may have alternate colours
syn cluster phpClExpressions add=phpInstanceof
syn keyword phpInstanceof contained instanceof
      \ nextgroup=@phpClStructures,phpStructureHere skipwhite skipempty

" how to treat '->'?

" Note: this is always needed for inside strings
syn match phpPropertySelector contained display /->/

if ! s:smart_members
  " NOTE: this match is for ANY '->' match, however the more specific
  " phpPropertySelector or phpDynamicSelector may match instead
  syn cluster phpClExpressions add=phpMemberSelector
  syn match phpMemberSelector contained display /->/
        \ nextgroup=@phpClProperties,@phpClMembers,phpMemberHere skipwhite skipempty

else
  " by default all -> matches are property access
  syn cluster phpClExpressions add=phpPropertySelector

  " make a match for a whole property name also
  syn cluster phpClExpressions add=phpPropertyAccess
  syn match phpPropertyAccess contained display /->\_s*\h\w*/
        \ contains=phpPropertySelector,@phpClProperties,phpPropertyHere

  " try match them as method calls first though
  " NOTE: have taken out phpMethods (because it just wasn't accurate)
  " but have added phpSpecialMethods because they are always special
  syn cluster phpClExpressions add=phpMethodCall
  syn cluster phpClMethodHere add=phpMethodCall
  syn match phpMethodCall contained display /->\_s*\h\w*\_s*(\@=/
        \ contained display contains=phpMemberSelector,@phpClMethods
  syn match phpMethodCall contained display /->\_s*\$\h\w*\_s*(\@=/
        \ contained display contains=phpIdentifier,phpMemberSelector
  syn match phpMemberSelector contained display /->/

  " for a dynamic {} property/method
  if s:alt_properties
    syn cluster phpClExpressions add=phpDynamicSelectorRegion
    syn region phpDynamicSelectorRegion contained keepend extend
          \ matchgroup=phpDynamicSelector start=/->\_s*{/ end=/}/
          \ contains=@phpClExpressions
  endif

"  " highlight incorrect use of -> as an error
"  syn cluster phpClExpressions add=phpMemberError
"  syn match phpMemberError /->\%#\@!\%(\_s*\)\@>[a-z{_$]\@!/ contained display

endif

syn region phpIdentifierComplex contained display matchgroup=phpVarSelector start=/\${/ end=/}/
      \ keepend extend
      \ contains=@phpClExpressions

" create an identifier match for double-quoted strings:

" Methoden

" Peter Hodge - added 'clone' keyword here
" Define
syn cluster phpClExpressions add=phpObjectOperator
syn keyword	phpObjectOperator contained new
      \ nextgroup=@phpClClasses,@phpClInterfaces,phpStructureHere skipwhite skipempty
syn keyword	phpObjectOperator contained clone

" Todo
syn keyword	phpTodo	contained todo fixme xxx containedin=phpComment

" Parent
if s:strict_blocks
  syn cluster phpClExpressions add=phpBlockRegion
  if s:folding == 2
      syn region phpBlockRegion matchgroup=phpBrace start=/{/ end=/}/ keepend extend
            \ transparent contained
            \ fold
  else
      syn region phpBlockRegion matchgroup=phpBrace start=/{/ end=/}/ keepend extend
            \ transparent contained
      if s:fold_manual
        syn region phpBlockRegion matchgroup=phpBrace start='{\ze\s*//\s*fold\s*$\c' end='}' keepend extend
              \ transparent contained
              \ fold
      endif
  endif

  " parenthesis for a foreach() block, not found automatically
  " (is triggered by a nextgroup=phpForeachRegion)
  " Note: the 'display' option on a foreach region (the part inside the '()')
  " would be bad, because it is possible for that to be spread over several
  " lines (well, I do it myself)
  if s:alt_arrays || s:alt_control_parents
    syn region phpForeachRegion matchgroup=phpControlParent start=/(/ end=/)/ keepend extend
            \ contained contains=@phpClExpressions,phpArrayPair
            \ nextgroup=phpSemicolonNotAllowedHere skipwhite skipempty
  endif

  " parenthesis for a for() block, not found automatically
  " (is triggered by a nextgroup=phpForRegion)
  if s:alt_arrays || s:alt_control_parents
    syn region phpForRegion matchgroup=phpControlParent
            \ start=/(/ end=/)/ keepend extend display
            \ contained contains=@phpClExpressions,phpForSemicolon
            \ nextgroup=phpSemicolonNotAllowedHere skipwhite skipempty
    syn match phpForSemicolon contained display /[,;]/
    hi! link phpForSemicolon phpConditional
  endif

  " special parent regions for 'if/while' blocks so we can catch a semicolon
  " which shouldn't be at the end
  " Note: having endings on those keywords helps speed things up alot.
  if s:no_empty_construct
    syn region phpConstructRegion keepend extend contained contains=@phpClExpressions
          \ nextgroup=phpSemicolonNotAllowedHere skipwhite skipempty
          \ matchgroup=phpControlParent start=/(/ end=/)/
          \ matchgroup=Error end=/}/ end=/\]/
            \ end=/\$\@<!\<\%(protected\|public\|private\)\>/
            \ end=/\$\@<!\<\%(final\|abstract\|static\|global\)\>/
            \ end=/\$\@<!\<\%(class\|function\|interface\|extends\)\>/
            \ end=/\$\@<!\<\%(return\|break\|continue\|case\|default\|echo\)\>/
    syn region phpSwitchConstructRegion keepend extend contained contains=@phpClExpressions
          \ nextgroup=phpSemicolonNotAllowedHere,phpSwitchBlock skipwhite skipempty
          \ matchgroup=phpControlParent start=/(/ end=/)/
          \ matchgroup=Error end=/}/ end=/\]/
            \ end=/\$\@<!\<\%(protected\|public\|private\)\>/
            \ end=/\$\@<!\<\%(final\|abstract\|static\|global\)\>/
            \ end=/\$\@<!\<\%(class\|function\|interface\|extends\)\>/
            \ end=/\$\@<!\<\%(return\|break\|continue\|case\|default\|echo\)\>/
    syn region phpDoWhileConstructRegion keepend extend contained contains=@phpClExpressions
          \ matchgroup=phpControlParent start=/(/ end=/)\_s*;/
          \ matchgroup=Error end=/}/ end=/\]/ end=/;/
            \ end=/\$\@<!\<\%(protected\|public\|private\)\>/
            \ end=/\$\@<!\<\%(final\|abstract\|static\|global\)\>/
            \ end=/\$\@<!\<\%(class\|function\|interface\|extends\)\>/
            \ end=/\$\@<!\<\%(return\|break\|continue\|case\|default\|echo\)\>/
  endif

  " match up ( and ), as well as [ and ]
  syn cluster phpClExpressions add=phpParentRegion,phpBracketRegion
  syn region phpParentRegion contained keepend extend contains=@phpClExpressions
        \ matchgroup=phpParent start=/(/ end=/)/
        \ matchgroup=Error end=/;/ end=/}/ end=/\]/
  " NOTE: the 'dispay' option on a [] region isn't so dangerous, as they are
  " normally only one line
  " TODO: does the 'display' option break folding for php_fold_arrays? The
  " answer is YES
  syn region phpBracketRegion contained keepend extend contains=@phpClExpressions
        \ matchgroup=phpParent start=/\[/ end=/\]/
        \ matchgroup=Error end=/;/

  " when a closing }, ) or ] is out of place ...
  if s:parent_error_close
    syn cluster phpClValues add=phpBraceError,phpParentError
    syn match phpBraceError  contained display /}/
    syn match phpParentError contained display /)/
    syn match phpParentError contained display /\]/
  endif

else
  syn match phpParent contained display /{/
  syn match phpParent contained display /}/
  syn match phpParent contained display /\[/
  syn match phpParent contained display /\]/
  syn match phpParent contained display /(/
  syn match phpParent contained display /)/
endif

syn cluster	phpClTop      add=phpFoldFunction,phpFoldClass,phpFoldInterface

" PHP Region
if s:long_tags
  syn region phpRegion matchgroup=phpRegionDelimiter start=/<?php\w\@!/ end=/?>/
        \ keepend extend contains=@phpClTop
else
  syn region phpRegion matchgroup=phpRegionDelimiter start=/<?\(php\w\@!\|=\)\=/ end=/?>/
        \ keepend extend contains=@phpClTop
endif

syn region phpRegionSc matchgroup=phpRegionDelimiter
      \ start=#<script language="php"># end=#</script>#
      \ contains=@phpClTop keepend extend

if s:asp_tags
  syn region phpRegionAsp matchgroup=phpRegionDelimiter start=/<%=\=/ end=/%>/
        \ keepend extend contains=@phpClTop
endif

if s:strict_blocks
  syn cluster phpClValues add=phpHTMLError
  syn match phpHTMLError /?>/ contained
endif

" if using strict blocks, need to look out for HTML inside
" blocks
if s:strict_blocks
  " only allow in base-level code (not inside () or [])
  syn cluster phpClCode add=htmlRegion
  if s:long_tags
    " only match full php tags
    syn region htmlRegion contained contains=TOP matchgroup=phpRegionDelimiter
          \ start=/?>/ end=/<?php\w\@!/ keepend extend
  else
    " match any php tags
    syn region htmlRegion contained contains=TOP matchgroup=phpRegionDelimiter
          \ start=/?>/ end=/<?\%(php\w\@!\|=\)\=/ keepend extend
  endif

  if s:asp_tags
    syn region htmlRegion contained contains=TOP matchgroup=phpRegionDelimiter
          \ start=/%>/ end=/<%=\=/ keepend extend
  endif
endif

" if strict curly-braces matching is enabled, then match braces
" properly
if s:strict_blocks
  " DEFINITIONS FOR:
  "   function ...() {
  "   class ... {
  "     method ...() {
  " these need to be done piece-by-piece so that we can use 'nextgroups'
  " to match the { } code blocks - we want to use special colors for them!
  " {{{1

  " Match the 'final' and 'abstract' keywords first, they can be inside the
  " global scope or inside a class declaration
  syn cluster phpClTop add=phpStructureType
  syn cluster phpClInClass add=phpStructureType
  syn keyword phpStructureType contained abstract final

  " the phpStructure keywords (class/interface) can be found anywhere in
  " global scope
  syn cluster phpClTop add=phpStructure

  " CLASSES: class myFoo extends baseFoo implements foo, Iterator { }: {{{2
  " I MATCH: <class myFoo> extends baseFoo implements foo, Iterator { }: {{{3

    " 2: match the start of the class declaration
    syn keyword phpStructure contained class
          \ nextgroup=phpDefineClassName skipwhite skipempty

    " 3: an empty placeholder for any class name (which in turn can contain
    " any of the known PHP class names)
    " NOTE: allow matching the class block immediately after the class name
    syn cluster phpClClassHere add=phpDefineClassName
    syn match phpDefineClassName /\h\w*/ contained contains=@phpClStructures
          \ nextgroup=@phpClDefineClassBlock skipwhite skipempty

  " II MATCH: class myFoo <extends baseFoo> implements foo, Iterator { }: {{{3

      " match the 'extends' keyword and follow it by the match
      " for class names in a declaration (as above)
      syn keyword phpStructure contained extends
            \ nextgroup=phpDefineClassName skipwhite skipempty

  " III MATCH: class myFoo extends baseFoo <implements foo, Iterator> { }: {{{3

      " 1: match the 'implements' keyword and follow it by the match
      " for class names in a declaration (as above)
      syn keyword phpStructure contained implements
            \ nextgroup=@phpClDefineClassImplements skipwhite skipempty

      " 2: define a place-holding for interfaces which matches any valid
      " interface name and also contains the recognized names
      syn cluster phpClDefineClassImplements add=phpDefineClassImplementsName
      syn cluster phpClInterfaceHere add=phpDefineClassImplementsName
      syn cluster phpClClassHere add=phpDefineClassImplementsName
      syn match phpDefineClassImplementsName /\h\w*/ contained contains=@phpClStructures
            \ nextgroup=@phpClDefineClassImplements skipwhite skipempty

      " 3: allow a comma in the list
      syn cluster phpClDefineClassImplements add=phpDefineClassImplementsComma
      syn match phpDefineClassImplementsComma /,/ contained
            \ nextgroup=@phpClDefineClassImplements skipwhite skipempty

      " 4: there might be a '#' or '//'-style comment in-between!
      syn cluster phpClDefineClassImplements add=phpDefineClassImplementsCommentOneLine
      syn region phpDefineClassImplementsCommentOneLine
            \ start=/#/ start=,//, end=/$/ end=/.\ze?>/ oneline
            \ contained contains=phpComment
            \ nextgroup=@phpClDefineClassImplements skipwhite skipempty

      " 5: there might a C-style comment (/*...*/) in-between
      syn cluster phpClDefineClassImplements add=phpDefineClassImplementsCommentCStyle
      syn region phpDefineClassImplementsCommentCStyle start=,/\*, end=,\*/, keepend
            \ contained contains=@Spell
            \ nextgroup=@phpClDefineClassImplements skipwhite skipempty
      hi link phpDefineClassImplementsCommentCStyle phpComment

      " 6: add the block to the list so it can match here also
      syn cluster phpClDefineClassImplements add=phpClassBlock

  " IV MATCH: class myFoo extends baseFoo implements foo, Iterator <{ }>: {{{3

    " 1: there might be a '#' or '//'-style comment in-between!
    syn cluster phpClDefineClassBlock add=phpDefineClassBlockCommentOneline
    syn region phpDefineClassBlockCommentOneline start=/#/ start=,//, end=/$/ end=/.\ze?>/ oneline
          \ contained contains=phpComment
          \ nextgroup=@phpClDefineClassBlock skipwhite skipempty

    " 2: there might a C-style comment (/*...*/) in-between
    syn cluster phpClDefineClassBlock add=phpDefineClassBlockCommentCStyle
    syn region phpDefineClassBlockCommentCStyle start=,/\*, end=,\*/, keepend
          \ contained contains=@Spell
          \ nextgroup=@phpClDefineClassBlock skipwhite skipempty
    hi link phpDefineClassBlockCommentCStyle phpComment

    " 3: look for the actual { } block
    syn cluster phpClDefineClassBlock add=phpClassBlock
    if (s:folding == 1) || (s:folding == 2)
      syn region phpClassBlock matchgroup=phpBraceClass start=/{/ end=/}/ keepend extend
            \ contained contains=@phpClInClass
            \ matchgroup=phpHTMLError end=/?>/
            \ fold
    else
      syn region phpClassBlock matchgroup=phpBraceClass start=/{/ end=/}/ keepend extend
            \ contained contains=@phpClInClass
            \ matchgroup=phpHTMLError end=/?>/
      if s:fold_manual
        syn region phpClassBlock matchgroup=phpBraceClass start='{\ze\s*//\s*fold\s*$\c' end='}' keepend extend
              \ contained contains=@phpClInClass
              \ matchgroup=phpHTMLError end=/?>/
              \ fold
      endif
    endif


  " }}}2

  " INTERFACES: interface myFoo extends baseFoo { }: {{{2
  " I MATCH: <interface myFoo> extends baseFoo { }: {{{3

    " 1: match the start of the interface declaration
    syn keyword phpStructure contained interface
          \ nextgroup=phpDefineInterfaceName skipwhite skipempty

    " 2: an empty placeholder for any interface name (which in turn can contain
    " any of the known PHP class names)
    " NOTE: allow matching the class block immediately after the class name
    " NOTE: maybe one day will make a separate block for interface bodies
    syn cluster phpClClassHere add=phpDefineInterfaceName
    syn cluster phpClInterfaceHere add=phpDefineInterfaceName
    syn match phpDefineInterfaceName /\h\w*/ contained contains=@phpClStructures
          \ nextgroup=@phpClDefineClassBlock skipwhite skipempty

  " II MATCH: interface myFoo <extends baseFoo> { }: {{{3

    " NOTE: this is handled in the class syntax handling above

  " IV MATCH: class myFoo extends baseFoo implements foo, Iterator <{ }>: {{{3

    " NOTE: this is handled in the class syntax handling above

  " }}}2

  " FUNCTIONS: function & somefunc($a = 0, &$b) { }: {{{2
  " I MATCH: <function> & somefunc($a = 0, &$b) { }: {{{3

    " if we are finding functions anywhere, allow this match only
    syn cluster phpClCode add=phpDefine

    syn keyword phpDefine function contained
          \ nextgroup=@phpClDefineFuncName,phpDefineFuncByRef
          \ skipwhite skipempty

  " II MATCH: function <&> somefunc($a = 0, &$b) { }: {{{3

    " second, there might be a '&' return-by-reference option, so add
    " a match for that.
    syn match phpDefineFuncByRef /&/ contained nextgroup=@phpClDefineFuncName skipwhite skipnl
    hi link phpDefineFuncByRef phpAssignByRef


  " III MATCH: function & <somefunc>($a = 0, &$b) { }: {{{3

    " what can go inside a function name? Anything that does will need
    " a 'nextgroup=phpDefineFuncProto' argument!

    " first up, an empty placeholder to match any valid function name.
    "     It should contain the special user-defineable function names.
    syn cluster phpClDefineFuncName add=phpDefineFuncName
    syn cluster phpClFunctionHere add=phpDefineFuncName
    syn match phpDefineFuncName /\h\w*/ contained
          \ contains=@phpClFunctions
          \ nextgroup=phpDefineFuncProto
          \ skipwhite skipempty
    " TODO: allow adding comments between 'function' and 'someFunc'


  " IV MATCH: function & somefunc<(>$a = 0, &$b<)> { }: {{{3
  " match the parenthesis surrounding the function arguments
  if s:folding
    syn region phpDefineFuncProto contained contains=@phpClDefineFuncProtoArgs
          \ matchgroup=phpParent start=/(/ end=/)/ keepend extend
          \ nextgroup=@phpClDefineFuncBlock
          \ skipwhite skipempty
          \ fold
  else
    syn region phpDefineFuncProto contained contains=@phpClDefineFuncProtoArgs
          \ matchgroup=phpParent start=/(/ end=/)/ keepend extend
          \ nextgroup=@phpClDefineFuncBlock
          \ skipwhite skipempty
  endif
  " TODO: allow comments in this cluster


  " V MATCH: function & somefunc(<stdClass> $a = 0, &$b) { }: {{{3
  " first: any valid class name
  syn cluster phpClDefineFuncProtoArgs add=@phpClClasses,@phpClInterfaces

  " we still need to match an 'array' keyword, because it can be used for
  " parameter type-requirements
  syn cluster phpClDefineFuncProtoArgs add=phpProtoArrayCheck
  syn match phpProtoArrayCheck /\<array\>/ contained
  hi link phpProtoArrayCheck phpArray

  " VI MATCH: function & somefunc(stdClass <$a => 0, <&$b>) { }: {{{3

    " 1: match the by-ref '&'
    syn cluster phpClDefineFuncProtoArgs add=phpProtoArgByRef
    syn match phpProtoArgByRef /&/ display contained
    hi link phpProtoArgByRef phpAssignByRef

    " 2: match a valid identifier
    syn cluster phpClDefineFuncProtoArgs add=phpIdentifier,phpAssign

  " VII MATCH: function & somefunc(stdClass $a = <0>, &$b) { }: {{{3
  " What about other items? numbers? strings? arrays()?
  syn cluster phpClDefineFuncProtoArgs add=@phpClProtoValues

    " 1: simple types (null, boolean)
    syn cluster phpClProtoValues add=phpNull
    syn cluster phpClProtoValues add=phpBoolean

    " 2: numbers and strings and constants
    syn cluster phpClProtoValues add=phpNumber,phpFloat
    syn cluster phpClProtoValues add=phpStringSingle,phpStringDouble
    syn cluster phpClProtoValues add=@phpClConstants

    " 3: arrays must be done separately to ensure ( and ) match correctly
    " (but only if using alt colors for arrays)
    if s:alt_arrays
      syn cluster phpClProtoValues add=phpProtoArray
      syn region phpProtoArray matchgroup=phpArrayParens start=/\<array\_s*(/ end=/)/ keepend extend
          \ contained contains=@phpClProtoValues,phpArrayPair

      " don't allow arbitrary parenthesis here!!
      syn cluster phpClProtoValues add=phpProtoParentError
      syn match phpProtoParentError /(/ contained display
      hi link phpProtoParentError phpParentError
    else
      syn cluster phpClProtoValues add=phpArray

      " need to allow arbitrary parenthesis for arrays
      syn cluster phpClProtoValues add=phpParentRegion
    endif

    " 4: comments
    syn cluster phpClProtoValues add=phpComment


  " VIII MATCH: function & somefunc(</* foo */>) { }: {{{3
  " What about comment items?
  syn cluster phpClDefineFuncProtoArgs add=phpComment

  " IX MATCH: function & somefunc(stdclass $a = 0, &$b) <{ }>: {{{3

    " 1: there might be a '#' or '//'-style comment in-between!
    syn cluster phpClDefineFuncBlock add=phpDefineFuncBlockCommentOneline
    syn region phpDefineFuncBlockCommentOneline start=/#/ start=,//, end=/$/ end=/.\ze?>/ oneline
          \ contained contains=phpComment
          \ nextgroup=@phpClDefineFuncBlock skipwhite skipempty

    " 2: there might a C-style comment (/*...*/) in-between
    syn cluster phpClDefineFuncBlock add=phpDefineFuncBlockCommentCStyle
    syn region phpDefineFuncBlockCommentCStyle start=,/\*, end=,\*/, keepend
          \ contained contains=@Spell
          \ nextgroup=@phpClDefineFuncBlock skipwhite skipempty
    hi link phpDefineFuncBlockCommentCStyle phpComment

    " 3: look for the actual { } block
    "    NOTE: how the function block will end at the next function
    "    declaration: this helps stop the region extending indefinitely,
    "    forcing the recalculation of all { } blocks for the rest of the file.
    "    Otherwise, inserting an open-brace will
    "    NOTE: that the error can't happen on a 'final', 'abstract', 'class',
    "    or 'interface' keyword because they can't be contained in a function
    syn cluster phpClDefineFuncBlock add=phpFuncBlock

    let s:foldHere = s:folding ? 'fold' : ''
    let s:endEarly = s:nested_functions ? '' : 'matchgroup=Error end=/\%(^\|\s\)function\>/'

"    if s:folding
"      if s:nested_functions
"        syn region phpFuncBlock keepend extend matchgroup=phpBraceFunc start=/{/ end=/}/
"              \ matchgroup=Error end=/\%(^\|\s\)\%(public\|private\|protected\)\>/
"              \ contained contains=@phpClInFunction
"              \ fold
"      else
"        syn region phpFuncBlock keepend extend matchgroup=phpBraceFunc start=/{/ end=/}/
"              \ matchgroup=Error end=/\%(^\|\s\)function\>/
"              \ matchgroup=Error end=/\%(^\|\s\)\%(public\|private\|protected\)\>/
"              \ contained contains=@phpClInFunction
"              \ fold
"      endif
"    else
"      if s:nested_functions
"        syn region phpFuncBlock keepend extend matchgroup=phpBraceFunc start=/{/ end=/}/
"              \ matchgroup=Error end=/\%(^\|\s\)\%(public\|private\|protected\)\>/
"              \ contained contains=@phpClInFunction
"      else
"        syn region phpFuncBlock keepend extend matchgroup=phpBraceFunc start=/{/ end=/}/
"              \ matchgroup=Error end=/\%(^\|\s\)function\>/
"              \ matchgroup=Error end=/\%(^\|\s\)p\%(ublic\|rivate\|rotected\)\>/
"              \ contained contains=@phpClInFunction
"      endif
"    endif

        execute 'syn region phpFuncBlock keepend extend matchgroup=phpBraceFunc'
              \ 'end=/}/ start=/{/'
              \ 'matchgroup=Error end=/\%(^\|\s\)\%(public\|private\|protected\)\>/'
              \ s:endEarly
              \ 'contained contains=@phpClInFunction'
              \ s:foldHere
        " for manual folding, we use an alternate start
        if s:fold_manual
          execute 'syn region phpFuncBlock keepend extend matchgroup=phpBraceFunc'
                \ 'start=#{\ze\s*//\s*fold\s*$\c# end=/}/'
                \ 'matchgroup=Error end=/\%(^\|\s\)\%(public\|private\|protected\)\>/'
                \ s:endEarly
                \ 'contained contains=@phpClInFunction'
                \ s:foldHere
        endif
    unlet s:foldHere s:endEarly

  " }}}2

  " METHODS: protected function & somefunc($a = 0, &$b) { }: {{{2
  " I MATCH: <protected function> somefunc($a = 0, &$b) { }: {{{3

    " 1: match the final / abstract / private keywords at start
    " TODO: rename 'phpStorageClass' to Typedef (for global and static keywords)
    " and rename 'phpStorageClass2' to 'phpStorageClass'
    syn cluster phpClInClass add=phpStorageClass2
    syn keyword phpStorageClass2 contained private protected public static final abstract
    hi link phpStorageClass2 phpStorageClass

    syn keyword phpDefineMethod function contained containedin=phpClassBlock
          \ nextgroup=@phpClDefineMethodName,phpDefineMethodByRef
          \ skipwhite skipempty
    " TODO: add phpDefineFunction in the proper place
    hi link phpDefineFunction phpDefine
    hi link phpDefineMethod phpDefineFunction

  " II MATCH: protected function <&> somefunc($a = 0, &$b) { }: {{{3
  " second, there might be a '&' return-by-reference option, so add
  " a match for that.
  syn match phpDefineMethodByRef /&/ contained
        \ nextgroup=@phpClDefineMethodName skipwhite skipnl
  hi link phpDefineMethodByRef phpDefineFuncByRef

  " III MATCH: protected function & <somefunc>($a = 0, &$b) { }: {{{3
  " what can go inside a method name? Anything that does will need
  " a 'nextgroup=phpDefineMethodProto' argument!

    " An empty placeholder to match any valid method name.
    " It should contain the special user-defineable method names.
    " NOTE: how we are just re-using 'function' block instead of
    " making more stuff to have a special 'method' block also.
    " I don't think it would be worthwhile at this stage.
    " NOTE: phpSpecialFunction must be included as well, because
    " that's a reserved function name and will break things.
    " TODO: cater for a new group, phpReservedFunction
    syn cluster phpClDefineMethodName add=phpDefineMethodName
    syn cluster phpClMethodHere add=phpDefineMethodName
    syn match phpDefineMethodName /\h\w*/ contained
          \ contains=phpSpecialFunction,@phpClMethods
          \ nextgroup=phpDefineFuncProto
          \ skipwhite skipempty
    " TODO: allow adding comments between 'function' and 'someFunc'

  " }}}2

  " EXCEPTIONS: try/catch { } {{{2

    syn cluster phpClCode add=phpException

    " 1: match the start of a try block
    syn keyword phpException try contained nextgroup=@phpClTryBlock skipwhite skipnl

    " TODO: 2: allow having comments preceding the { } block?

    " 3: match the try block
    syn cluster phpClTryBlock add=phpTryBlock
    " TODO: manual folding from here (search for \<fold\>)
    if s:folding == 2
      syn region phpTryBlock matchgroup=phpBraceException start=/{/ end=/}/ keepend extend
            \ contained transparent
            \ fold
    else
      syn region phpTryBlock matchgroup=phpBraceException start=/{/ end=/}/ keepend extend
            \ contained transparent
    endif

    " 3: match the start of the catch block
    syn keyword phpException catch contained nextgroup=phpCatchRegion skipwhite skipnl
    syn region phpCatchRegion matchgroup=phpParent start=/(/ end=/)/ keepend extend
          \ contained contains=@phpClExpressions
          \ nextgroup=@phpClCatchBlock skipwhite skipnl

    " TODO: 4: allow having comments preceding the { } block?

    " 5: match the catch block
    syn cluster phpClCatchBlock add=phpCatchBlock
    if s:folding == 2
      syn region phpCatchBlock matchgroup=phpBraceException start=/{/ end=/}/ keepend extend
            \ contained transparent
            \ fold
    else
      syn region phpCatchBlock matchgroup=phpBraceException start=/{/ end=/}/ keepend extend
            \ contained transparent
    endif

  " }}}2

  " }}}1

  " make sure 'static' and 'global' work inside a function block
  " TODO: refactor this?
  syn keyword phpStorageClass static global contained

  " set foldmethod if folding
  if s:folding
    set foldmethod=syntax
  endif
else
  " Fold
  if s:folding == 1 " {{{1
  " match one line constructs here and skip them at folding
    syn keyword	phpSCKeyword	abstract final private protected public static trait contained
    syn keyword	phpFCKeyword	function	contained
    syn keyword	phpStorageClass	global	contained
    syn match	phpDefine	"\(\s\|^\)\(abstract\s\+\|final\s\+\|private\s\+\|protected\s\+\|public\s\+\|static\s\+\)*function\(\s\+.*[;}]\)\@="	contained contains=phpSCKeyword
    syn match	phpStructure	"\(\s\|^\)\(abstract\s\+\|final\s\+\)*class\(\s\+.*}\)\@="	contained
    syn match	phpStructure	"\(\s\|^\)interface\(\s\+.*}\)\@="	contained
    syn match	phpException	"\(\s\|^\)try\(\s\+.*}\)\@="	contained
    syn match	phpException	"\(\s\|^\)catch\(\s\+.*}\)\@="	contained

    set foldmethod=syntax
    syn region	phpFoldHtmlInside contained transparent contains=@htmlTop
          \ matchgroup=phpRegionDelimiter start="?>" end="<?\(php\w\@!\)\="
    syn region	phpFoldFunction contained transparent fold extend
          \ matchgroup=StorageClass
          \ start="^\z(\s*\)\(abstract\s\+\|final\s\+\|private\s\+\|protected\s\+\|public\s\+\|static\s\+\)*function\s\([^};]*$\)\@="rs=e-9
          \ matchgroup=Delimiter end="^\z1}"
          \ contains=@phpClInFunction,phpFoldHtmlInside,phpFCKeyword
    syn region	phpFoldFunction	matchgroup=Define start="^function\s\([^};]*$\)\@="
          \ matchgroup=Delimiter end="^}"
          \ contains=@phpClInFunction,phpFoldHtmlInside contained transparent fold extend
    syn region	phpFoldClass	matchgroup=Structure start="^\z(\s*\)\(abstract\s\+\|final\s\+\)*class\s\+\([^}]*$\)\@=" matchgroup=Delimiter end="^\z1}"
          \ contains=@phpClInFunction,phpFoldFunction,phpSCKeyword contained transparent fold extend
    syn region	phpFoldInterface	matchgroup=Structure start="^\z(\s*\)interface\s\+\([^}]*$\)\@=" matchgroup=Delimiter end="^\z1}" contains=@phpClFunction,phpFoldFunction contained transparent fold extend
    syn region	phpFoldCatch	matchgroup=Exception start="^\z(\s*\)catch\%([^}]*$\)\@=" matchgroup=Delimiter end="^\z1}" contains=@phpClFunction,phpFoldFunction contained transparent fold extend
    syn region	phpFoldTry	matchgroup=Exception start="^\z(\s*\)try\s\+\([^}]*$\)\@=" matchgroup=Delimiter end="^\z1}" contains=@phpClFunction,phpFoldFunction contained transparent fold extend

  elseif s:folding == 2 " {{{1
    syn keyword	phpDefine	function	contained
    syn keyword	phpStructure	abstract class interface	contained
    syn keyword	phpException	catch throw try	contained
    syn keyword	phpStorageClass	final global private protected public static	contained

    set foldmethod=syntax
    syn region	phpFoldHtmlInside	matchgroup=phpRegionDelimiter start="?>" end="<?\(php\w\@!\)\=" contained transparent contains=@htmlTop
    syn region	phpParent	matchgroup=Delimiter start="{" end="}" keepend extend contained contains=@phpClFunction,phpFoldHtmlInside transparent fold

  elseif s:folding == 3 " {{{1
    " match one line constructs here and skip them at folding
    syn keyword	phpSCKeyword	abstract final private protected public static	contained
    syn keyword	phpFCKeyword	function	contained
    syn keyword	phpStorageClass	global static contained
    syn keyword	phpException	catch throw try	contained

    syn match	phpDefine	"\(\s\|^\)\(abstract\s\+\|final\s\+\|private\s\+\|protected\s\+\|public\s\+\|static\s\+\)*function\(\s\+.*[;}]\)\@="	contained contains=phpSCKeyword
    syn match	phpStructure	"\(\s\|^\)\(abstract\s\+\|final\s\+\)*class\(\s\+.*}\)\@="	contained
    syn match	phpStructure	"\(\s\|^\)interface\(\s\+.*}\)\@="	contained
    syn match	phpException	"\(\s\|^\)try\(\s\+.*}\)\@="	contained
    syn match	phpException	"\(\s\|^\)catch\(\s\+.*}\)\@="	contained

    " fold these:
    set foldmethod=syntax
    syn region	phpFoldFunction	matchgroup=StorageClass start="^\z(\s*\)\(abstract\s\+\|final\s\+\|private\s\+\|protected\s\+\|public\s\+\|static\s\+\)*function\s\([^};]*$\)\@="rs=e-9 matchgroup=Delimiter end="^\z1}" contains=@phpClFunction,phpFoldHtmlInside,phpFCKeyword contained transparent fold extend
    syn region	phpFoldFunction	matchgroup=Define start="^function\s\([^};]*$\)\@=" matchgroup=Delimiter end="^}" contains=@phpClFunction,phpFoldHtmlInside contained transparent fold extend

    " don't fold these:
    syn region	phpFoldHtmlInside	matchgroup=phpRegionDelimiter start="?>" end="<?\(php\w\@!\)\=" contained transparent contains=@htmlTop
    syn region	phpFoldClass	matchgroup=Structure start="^\z(\s*\)\(abstract\s\+\|final\s\+\)*class\s\+\([^}]*$\)\@=" matchgroup=Delimiter end="^\z1}" contains=@phpClFunction,phpFoldFunction,phpSCKeyword contained transparent extend
    syn region	phpFoldInterface	matchgroup=Structure start="^\z(\s*\)interface\s\+\([^}]*$\)\@=" matchgroup=Delimiter end="^\z1}" contains=@phpClFunction,phpFoldFunction contained transparent extend
    syn region	phpFoldCatch	matchgroup=Exception start="^\z(\s*\)catch\s\+\([^}]*$\)\@=" matchgroup=Delimiter end="^\z1}" contains=@phpClFunction,phpFoldFunction contained transparent extend
    syn region	phpFoldTry	matchgroup=Exception start="^\z(\s*\)try\s\+\([^}]*$\)\@=" matchgroup=Delimiter end="^\z1}" contains=@phpClFunction,phpFoldFunction contained transparent extend

  else " {{{1
    syn keyword	phpDefine       contained function
    syn keyword	phpStructure	contained abstract class interface use trait
    syn keyword	phpException	contained catch throw try
    syn keyword	phpStorageClass	contained final global private protected public static
  endif " }}} 1

  " always need these
  syn keyword phpStructure contained extends implements
endif

" ================================================================
" Peter Hodge - June 9, 2006
" Some of these changes (highlighting isset/unset/echo etc) are not so
" critical, but they make things more colourful. :-)


" different syntax highlighting for 'echo', 'print', 'switch', 'die' and 'list' keywords
" to better indicate what they are.
" TODO: convert 'echo' and 'include' to regions so that it cannot contain other control
" structures
"syn cluster phpClCode add=phpEcho
"syn keyword phpEcho contained echo
syn cluster phpClCode add=phpEchoRegion
if s:strict_blocks
  syn region phpEchoRegion contained keepend extend contains=@phpClExpressions,phpEchoComma
        \ matchgroup=phpEcho start=/\$\@<!\<echo\>/ end=/;/ end=/\ze?>/
        \ matchgroup=Error end=/[})\]]/
else
  syn cluster phpClCode add=phpEcho
  syn keyword phpEcho contained echo
endif

syn match phpEchoComma contained display /,/
hi! link phpEchoComma phpEcho

syn cluster phpClExpressions add=phpPrint,phpInclude
syn keyword phpPrint contained print
syn keyword phpInclude contained include include_once require require_once namespace use

" match when a '(type)' is used to cast the type of something

" Highlighting for PHP5's user-definable magic class methods
syn cluster phpClMethods add=phpSpecialMethods
syn keyword phpSpecialMethods contained containedin=phpRegion __construct __destruct __call __callStatic __get __set __isset __unset __sleep __wakeup __toString __invoke __set_state __clone

" these methods are used by the SPL Interfaces
syn cluster phpClMethods add=phpSPLMethods
" Serializable
syn keyword phpSPLMethods contained serialize unserialize
" ArrayAccess
syn keyword phpSPLMethods contained offsetSet offsetGet offsetExists offsetUnset
" Iterator
syn keyword phpSPLMethods contained current next key valid rewind
" IteratorAggregate
syn keyword phpSPLMethods contained getIterator
" RecursiveIterator
syn keyword phpSPLMethods contained hasChildren getChildren current next key valid rewind
" OuterIterator
syn keyword phpSPLMethods contained getInnerIterator current next key valid rewind
" SeekableIterator
syn keyword phpSPLMethods contained seek current next key valid rewind
" Countable
syn keyword phpSPLMethods contained count
" SplObserver
syn keyword phpSPLMethods contained update
" SplSubject
syn keyword phpSPLMethods contained attach detach notify
" Reflector
syn keyword phpSPLMethods contained export
hi link phpSPLMethods phpSpecialMethods

syn keyword phpSpecialFunction contained __autoload

" Highlighting for PHP5's built-in classes
" - built-in classes harvested from get_declared_classes() in 5.1.4
syn cluster phpClClasses add=phpClasses
syn keyword phpClasses contained containedin=phpRegion
	\ stdClass __PHP_Incomplete_Class php_user_filter Directory ArrayObject
	\ Exception ErrorException LogicException BadFunctionCallException BadMethodCallException DomainException
	\ RecursiveIteratorIterator IteratorIterator FilterIterator RecursiveFilterIterator ParentIterator LimitIterator
	\ CachingIterator RecursiveCachingIterator NoRewindIterator AppendIterator InfiniteIterator EmptyIterator
	\ ArrayIterator RecursiveArrayIterator DirectoryIterator RecursiveDirectoryIterator
	\ InvalidArgumentException LengthException OutOfRangeException RuntimeException OutOfBoundsException
	\ OverflowException RangeException UnderflowException UnexpectedValueException
	\ PDO PDOException PDOStatement PDORow
	\ Reflection ReflectionFunction ReflectionParameter ReflectionMethod ReflectionClass
	\ ReflectionObject ReflectionProperty ReflectionExtension ReflectionException
	\ SplFileInfo SplFileObject SplTempFileObject SplObjectStorage
	\ XMLWriter LibXMLError XMLReader SimpleXMLElement SimpleXMLIterator
	\ DOMException DOMStringList DOMNameList DOMDomError DOMErrorHandler
	\ DOMImplementation DOMImplementationList DOMImplementationSource
	\ DOMNode DOMNameSpaceNode DOMDocumentFragment DOMDocument DOMNodeList DOMNamedNodeMap
	\ DOMCharacterData DOMAttr DOMElement DOMText DOMComment DOMTypeinfo DOMUserDataHandler
	\ DOMLocator DOMConfiguration DOMCdataSection DOMDocumentType DOMNotation DOMEntity
	\ DOMEntityReference DOMProcessingInstruction DOMStringExtend DOMXPath
  \ DateTime DateTimeZone

" Highlighting for PHP5's built-in interfaces
" - built-in classes harvested from get_declared_interfaces() in 5.1.4
syn cluster phpClInterfaces add=phpInterfaces
syn keyword phpInterfaces contained
	\ Iterator IteratorAggregate RecursiveIterator OuterIterator SeekableIterator
	\ Traversable ArrayAccess Serializable Countable SplObserver SplSubject Reflector
"
" add php_errormsg as a special variable


"syn cluster phpClExpressions add=phpProperty
"syn match phpProperty /->\_s*\%(\$\=\h\w*\)\@>\ze\_s*(\@!/ display extend
"      \ contained contains=phpPropertySelector,phpIdentifier,@phpClProperties
"syn match phpPropertySelector /->/ contained display

" for going in string where can be followed by () without making it a method
" call
"syn match phpPropertySelectorInString /->/ contained display
"hi link phpPropertySelectorInString phpPropertySelector

if s:special_functions
  " Highlighting for PHP built-in functions which exhibit special behaviours
  " - isset()/unset()/empty() are not real functions.
  " - compact()/extract() directly manipulate variables in the local scope where
  "   regular functions would not be able to.
  " - eval() and assert()
  " - user_error()/trigger_error() can be overloaded by set_error_handler and also
  "   have the capacity to terminate your script when type is E_USER_ERROR.
  syn cluster phpClFunctions add=phpSpecialFunction
  syn keyword phpSpecialFunction contained
        \ user_error trigger_error isset unset empty eval assert extract compact __halt_compiler
endif

" special highlighting for '=&' operator
syn cluster phpClExpressions add=phpAssignByRef
syn match phpAssignByRef /=\_s*&/ contained display

" call-time pass-by-reference
syn match phpAssignByRef /&\$\@=/	contained display

" highlighting for the '@' error-supressing operator
syn cluster phpClExpressions add=phpSupressErrors
syn match phpSupressErrors /@/ contained display

" ================================================================

" Sync
if s:sync == -1
"  syn sync match phpSyncKeyword grouphere phpRegion /\ze\$\@<!\<class\>/
"  syn sync match phpSyncKeyword grouphere phpRegion /\ze\$\@<!\<interface\>/

  " best things to look for are the class/interface keywords or
  " private/protected/public keywords, as we can be 100% confident where we
  " are when we find them
  if s:strict_blocks
    syn sync match phpClassStart grouphere phpClassBlock
          \ /\$\@<!\<class\%(\%(\s\+\w\+\)\+\)\@>\s*{/
    " Note: the 'var' and 'const' sync methods have been causing Vim to miss
    " out the '?>' at the end of a file, so I had to drop them out.  I'm not
    " sure if it syncs faster
"    syn sync match phpSyncKeyword grouphere phpClassBlock /\ze\$\@<!\<var\>/
"    syn sync match phpSyncKeyword grouphere phpClassBlock /\ze\$\@<!\<const\>/
"    syn sync match phpSyncKeyword grouphere phpClassBlock
"          \ /\$\@<!\<p\%(rivate\|rotected\|ublic\)\>/
  endif

  syn sync match phpSyncStartOfFile grouphere NONE /\%^/

  " watch out for strings and comments in syncing process
  " TODO: make sure this actually works
  syn sync region phpSyncComment start=/\/\// start=/#/ end=/$/
  syn sync region phpSyncString start=/\z(['"]\)/ skip=/\\./ end=/\z1/

  if s:long_tags
    syn sync match phpRegionSync grouphere phpRegion "^\s*<?php\s*$"
  else
    syn sync match phpRegionSync grouphere phpRegion "^\s*<?\(php\w\@!\)\=\s*$"
  endif
"  syn sync match phpRegionSync grouphere phpRegionSc +^\s*<script language="php">\s*$+
"  if s:asp_tags
"    syn sync match phpRegionSync grouphere phpRegionAsp "^\s*<%\(=\)\=\s*$"
"  endif
"  syn sync match phpRegionSync grouphere NONE "^\s*?>\s*$"
"  syn sync match phpRegionSync grouphere NONE "^\s*%>\s*$"
"  syn sync match phpRegionSync grouphere phpRegion "function\s.*(.*\$"
"  "syn sync match phpRegionSync grouphere NONE "/\i*>\s*$"

" Sync backwards a certain number of lines?
"elseif s:sync > 0
"  exec "syn sync minlines=" . s:sync

else
  syn sync fromstart
endif

" Define the default highlighting.
" For version 5.7 and earlier: only when not done already
" For version 5.8 and later: only when an item doesn't have highlighting yet
if version >= 508 || !exists("did_php_syn_inits")
  if version < 508
    let did_php_syn_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    "command -nargs=+ HiLink hi def link <args>
    command -nargs=+ HiLink hi link <args>
  endif

  " Peter Hodge, June 17 2006
  " - I'm optimizing these highlight links for the default
  "   colorscheme, or 'elflord' when it would make a major
  "   difference.
  "   After most HiLinks I have noted which color the group
  "   will revert back to under default or elflord.

  " TODO: remove this testing
  let s:is_elflord = (exists('g:colors_name') && g:colors_name == 'elflord')

  if exists("php_oldStyle")
    hi phpOperator guifg=SeaGreen ctermfg=DarkGreen
    hi phpIdentifier guifg=DarkGray ctermfg=Brown
"   hi phpIdentifierSimply guifg=DarkGray ctermfg=Brown
    hi phpVarSelector guifg=SeaGreen ctermfg=DarkGreen

    hi phpRelation guifg=SeaGreen ctermfg=DarkGreen

    hi phpSuperglobal guifg=Red ctermfg=DarkRed
  else
    HiLink phpOperator          Operator    " => Statement(Yellow) / Operator(Red)
    HiLink phpIdentifier        Identifier  " => Identifier(Cyan)
    HiLink phpIdentifierErratic	phpIdentifier

    HiLink phpVarSelector       Operator
    HiLink phpVarSelectorDeref  PreProc
    HiLink phpVarSelectorError  Error

    HiLink phpType              Type

    " list() / arrays
    HiLink phpList              phpType
    HiLink phpArray             phpType
    if s:alt_arrays
      HiLink phpArrayParens phpArray
      HiLink phpArrayPair phpArray

      if s:alt_arrays == 2
        HiLink phpArrayComma phpArrayParens
      endif
    else
      HiLink phpArrayParens phpParent
      HiLink phpArrayPair phpOperator
    endif
    HiLink phpListComma phpArrayComma
    HiLink phpArrayPairError Error

    if s:alt_comparisons
      if s:is_elflord
        HiLink phpRelation	Statement " => Yellow
      else
        HiLink phpRelation	Constant  " => Constant (SlateBlue)
      endif
    else
      HiLink phpRelation     phpOperator
    endif

    " special variables support:
    if s:special_vars
      " NOTE: this is better highlighted using the 'Operator' colour ...
      HiLink phpSuperglobal Operator         " => Special (orange/red)
    else
      HiLink phpSuperglobal phpIdentifier
    endif
  endif

  " support for other variables
  HiLink phpBuiltinVar phpSuperglobal
  HiLink phpLongVar    phpSuperglobal
  HiLink phpEnvVar     phpSuperglobal

  " language:
  HiLink phpComment       Comment       " Slateblue

  HiLink phpSemicolon      Macro        " => PreProc (LightMagenta)
  HiLink phpSemicolonNotAllowedHere Error

  HiLink phpDefine         Define       " => PreProc (LightMagenta)
  HiLink phpObjectOperator phpDefine
  HiLink phpInclude        Include      " => PreProc (LightMagenta)

  HiLink phpEcho           Macro        " => PreProc (LightMagenta)
  HiLink phpPrint          phpEcho

  HiLink phpParent        Delimiter     " => Special (Red)
  if s:alt_control_parents
    HiLink phpControlParent phpConditional
  else
    HiLink phpControlParent phpParent
  endif
  HiLink phpBrace         phpParent     " => Special (Red)
  HiLink phpBraceError    Error         " => Error

  if s:alt_blocks
    HiLink phpBraceFunc      phpDefine
    HiLink phpBraceClass     phpStructure
    HiLink phpBraceException phpException
  else
    HiLink phpBraceFunc      phpBrace
    HiLink phpBraceClass     phpBrace
    HiLink phpBraceException phpBrace
  endif

  " other operations
  HiLink phpSupressErrors     PreProc   " LightMagenta

  if s:alt_refs
    HiLink phpAssignByRef     Type      " Green
  else
    HiLink phpAssignByRef     Operator  " Red
  endif

  HiLink phpMemberSelector    Structure " => Type (Green)
  if s:alt_properties
    HiLink phpPropertySelector  Function  " => Identifier (Cyan) / (White)
    HiLink phpDynamicSelector   Operator  " => Operator (Red) / (White)
  else
    HiLink phpPropertySelector  phpMemberSelector
    HiLink phpDynamicSelector   phpMemberSelector
  endif


  " execution control structures
  HiLink phpConditional   Conditional   " => Statement (Yellow) / Repeat (White)
  HiLink phpRepeat        Repeat        " => Statement (Yellow) / Repeat (White)
  HiLink phpStatement     Statement     " (Yellow / Brown)
  HiLink phpCase          Label         " => Statement (Yellow / Brown)
  HiLink phpException     Exception     " => Statement (Yellow)

  " constants
  HiLink phpMagicConstant Constant      " Pink / Magenta
  HiLink phpCoreConstant  Constant      " Pink / Magenta
  HiLink phpNumber        Number        " => Constant (Pink)
  HiLink phpFloat         Float         " => Constant (Pink)
  HiLink phpBoolean       phpType
  HiLink phpNull          phpType

  HiLink phpStringSingle         String
  HiLink phpStringDouble         phpStringSingle
  HiLink phpStringDoubleConstant phpStringSingle
  HiLink phpBacktick             phpStringSingle

  HiLink phpStringLiteral SpecialChar

  HiLink phpSpecialChar   SpecialChar   " => Special (Orange / Red)

  " keywords (mainly class / function definitions)
  HiLink phpStorageClass  StorageClass  " => Type (Green)
  HiLink phpSCKeyword     phpStorageClass

  HiLink phpStructure     Structure     " => Type (Green)
  HiLink phpStructureType phpStructure

  HiLink phpFCKeyword     phpDefine
  HiLink phpMagicClass    StorageClass
  if s:alt_comparisons
    HiLink phpInstanceof  phpRelation
  else
    HiLink phpInstanceof  phpMagicClass
  endif

  if s:show_quotes
    HiLink phpQuoteSingle   String
    HiLink phpQuoteDouble   String
  else
    HiLink phpQuoteSingle   Normal
    HiLink phpQuoteDouble   Normal
  endif

  " always highlight backtick quotes like an operator
  " (seeing as it executes stuff)
  HiLink phpQuoteBacktick phpOperator

  " built-in langauge functions / classes
  HiLink phpFunctions       Function        " => Identifier (Cyan) / Function (White)
  HiLink phpClasses         phpFunctions
  HiLink phpMethods         phpFunctions
  HiLink phpInterfaces      phpCoreConstant
  HiLink phpSpecialFunction SpecialComment  " => Special (Orange / Red)
  HiLink phpSpecialMethods  phpSpecialFunction

  " other items
  HiLink phpMemberError     Error
  HiLink phpParentError     Error
  HiLink phpHTMLError       Error
  HiLink phpOctalError      Error
  HiLink phpTodo            Todo

  " Peter Hodge June 17, 2006:
  " changed matchgroup for phpRegion from Delimiter to phpRegionDelimiter
  HiLink phpRegionDelimiter   Debug               " => Special (Orange / Red)

  " changed matchgroup for phpHereDoc to phpHereDocDelimiter
  HiLink phpHereDocDelimiter  phpRegionDelimiter  " => Special (Orange / Red)

  delcommand HiLink
endif

" optional support for PCRE extension (preg_* functions)
if s:show_pcre
    " ===================================================
    " Note: I have deliberately neglected to support the '\cx' functionality
    "       - it would do more harm than good by complicating this already-
    "       mind-numbing syntax file when nobody really needs this feature in
    "       PHP.
    " TODO: add support for '\cx' sequences (I changed my mind)

    " 1) Allow for dropping out of SQ and concatenating a variable {{{

      " flag a lone quote as an error!
      syn match pregError /'/ display contained containedin=pregPattern_S
      syn match pregError /"/ display contained containedin=pregPattern_D

      " find real concatenations (overrides the errors)
      syn region pregConcat matchgroup=phpQuoteSingle start=#'\ze\%(\%(\_s*\|\/\*.\{-}\*\/\|\/\/.*\n\)*\)\@>\.# end=/'/
        \ skip=/\['.\{-}'\]\|('.\{-}'[,)]/
        \ keepend extend
        \ contained containedin=pregPattern_S
        \ contains=@phpClExpressions
      syn region pregConcat matchgroup=phpQuoteDouble start=/"/ end=/"/
        \ skip=/\[".\{-}"\]\|(".\{-}"[,)]/
        \ keepend extend
        \ contained containedin=pregPattern_D
        \ contains=@phpClExpressions
    " }}}

    " 2) look for special characters {{{

      " TODO: re-examine how \$ is going to fit into a double-quoted string ...
      syn match pregSpecial /\$/ contained containedin=pregPattern_S display
      syn match pregSpecial /\$/ contained containedin=pregPattern_D display
        \ contains=phpIdentifierInString,phpIdentifierInStringComplex
      syn match pregSpecial /\^/ contained containedin=@pregPattern_Q display
      syn match pregSpecial /|/  contained containedin=@pregPattern_Q display
      syn match pregDot     /\./ contained containedin=@pregPattern_Q display

      " TODO: move these things out of here???
      " find a ] character at the start of a character range ...
      syn match pregClassIncStartBracket /\]/ contained display containedin=@pregClassIncStart_Q
      syn match pregClassExcStartBracket /\]/ contained display containedin=@pregClassExcStart_Q
      hi link pregClassIncStartBracket pregClassInc
      hi link pregClassExcStartBracket pregClassExc
    " }}}

    " 3) look for escape sequences {{{

      " look for any escape sequence inside the pattern and mark them as errors
      " by default, all escape sequences are errors
      " NOTE: adding 'display' to this next one can break the highlighting
      " (because it contains sequences such as \" which aren't supposed to end
      " the string)
      syn match pregEscapeUnknown /\\./ contained containedin=@pregPattern_Q

      " TODO: when \$ is encountered, the \ is a PHP escape and prevents
      " variable expansion, but the '$' becomes the end-of-line wildcard.
      " \\$ will match a literal '$', but the '$' might be part of a variable
      " name also. \\\$ is the proper way to match

      " TODO: deprecate these clusters?
      " TODO: deprecate pregClass_any
      syn cluster pregClass_any add=@pregClassInc,pregClassExc
      syn cluster pregClassRange_any_S add=pregClassIncRange_S,pregClassExcRange_S
      syn cluster pregClassRange_any_D add=pregClassIncRange_D,pregClassExcRange_D

      syn match pregClassEscapeUnknown /\\[^\^\-\]]/ contained containedin=@pregClass_any_Q display
      syn match pregClassEscape /\\[^a-zA-Z0-9]/ contained containedin=@pregClass_any_Q display extend

      " known escape sequences:
      syn match pregClassIncEscapeKnown /\C\\[abtnfret]/ contained display
            \ containedin=@pregClassInc_Q,@pregClassIncRange_Q
      syn match pregClassIncEscapeRange /\\[dsw]/ contained display
            \ containedin=@pregClassInc_Q,@pregClassIncRange_Q
      syn match pregClassExcEscapeKnown /\C\\[abtnfret]/ contained display
            \ containedin=@pregClassExc_Q,@pregClassExcRange_Q
      syn match pregClassExcEscapeRange /\\[dsw]/ contained display
            \ containedin=@pregClassExc_Q,@pregClassExcRange_Q

      " ... including hex sequences
      syn match pregClassIncEscapeKnown /\C\\x\x\{0,2}/ contained display
        \ containedin=@pregClassInc_Q,@pregClassIncRange_Q
      syn match pregClassExcEscapeKnown /\C\\x\x\{0,2}/ contained display
        \ containedin=@pregClassExc_Q,@pregClassExcRange_Q

      " ... and octal sequences
      syn match pregClassIncEscapeKnown /\\\o\{1,3}/ contained display
        \ containedin=@pregClassInc_Q,@pregClassIncRange_Q
      syn match pregClassExcEscapeKnown /\\\o\{1,3}/ contained display
        \ containedin=@pregClassExc_Q,@pregClassExcRange_Q

      syn match pregClassEscapeMainQuote /\\'/ contained transparent display contains=pregEscapePHP
        \ containedin=@pregClass_any_S,@pregClassRange_any_S
      syn match pregClassEscapeMainQuote /\\"/ contained transparent display contains=pregEscapePHP
        \ containedin=@pregClass_any_D,@pregClassRange_any_D

      syn match pregClassEscape /\\\\\ze\\'/ contained display
        \ containedin=@pregClass_any_S contains=pregEscapePHP
        \ nextgroup=pregClassEscapeMainQuote
      syn match pregClassEscape /\\\\\ze\\"/ contained display
        \ containedin=@pregClass_any_D contains=pregEscapePHP
        \ nextgroup=pregClassEscapeMainQuote

      syn match pregClassEscapeDouble1 /\\\\\ze\\\\/ contained containedin=@pregClass_any_Q display
        \ contains=pregEscapePHP
        \ nextgroup=pregClassEscapeDouble2
      syn match pregClassEscapeDouble2 /\\\\/ contained transparent display
        \ containedin=@pregClassRange_any_S,@pregClassRange_any_D
        \ contains=pregEscapePHP
      hi link pregClassEscapeDouble1 pregClassEscape

      " in the unknown escapes, match those that make a special character
      " take on its literal meaning (except for <single-quote> which is covered next)
      " NOTE: am changing these from being contained inside pregEscapeUnknown
      " to being in the main scope to make SQ and DQ containment easier
      syn match pregEscapeLiteral /\\[^A-Za-z0-9]/ contained containedin=@pregPattern_Q display
      syn match pregEscapeLiteral /\\\{4}/ contained containedin=@pregPattern_Q display

      " for single-quoted strings
      syn match pregEscapeLiteral /\\"/ contained containedin=pregPattern_S display
      syn match pregEscapeLiteral /\\\\\\'/ contained containedin=pregPattern_S display contains=pregEscapePHP

      " for double-quoted strings
      syn match pregEscapeLiteral /\\'/ contained containedin=pregPattern_D display
      syn match pregEscapeLiteral /\\\\\\"/ contained containedin=pregPattern_D display contains=pregEscapePHP

      syn match pregEscapeMainQuote /\\'/ contained containedin=pregPattern_S display
      syn match pregEscapeMainQuote /\\"/ contained containedin=pregPattern_D display

      " match the escaped strings which are known
      syn match pregBackreference /\\[1-9][0-9]\=/ contained containedin=pregEscapeUnknown display
      syn match pregEscapeSpecial /\C\\[rnt]/ contained containedin=pregEscapeUnknown display
      syn match pregEscapeSpecial /\C\\x\x\{0,2}/ contained containedin=pregEscapeUnknown display
      syn match pregEscapeSpecial /\\\%(0\o\{0,2}\|\o\o\o\)/ contained containedin=pregEscapeUnknown display
      syn match pregEscapeRange   /\\[wsd]/ contained containedin=pregEscapeUnknown display
      syn match pregEscapeAnchor  /\C\\[AbBGzZ]/ contained containedin=pregEscapeUnknown display

      " unicode characters
      syn match pregEscapeUnicode /\C\\X/ contained containedin=pregEscapeUnknown display
      syn match pregEscapeUnicodeError /\c\\p{\^\=\w\+}/ contained display
            \ containedin=pregEscapeUnknown,pregClassEscapeUnknown
      syn match pregEscapeUnicode /\\p{^\=/ contained containedin=pregEscapeUnicodeError display
      syn match pregEscapeUnicode /\CC[cfnos]\=/ contained containedin=pregEscapeUnicodeError display
      syn match pregEscapeUnicode /\CL[lmotu]\=/ contained containedin=pregEscapeUnicodeError display
      syn match pregEscapeUnicode /\CM[cen]\=/ contained containedin=pregEscapeUnicodeError display
      syn match pregEscapeUnicode /\CN[dlo]\=/ contained containedin=pregEscapeUnicodeError display
      syn match pregEscapeUnicode /\CP[cdefios]\=/ contained containedin=pregEscapeUnicodeError display
      syn match pregEscapeUnicode /\CS[ckmo]\=/ contained containedin=pregEscapeUnicodeError display
      syn match pregEscapeUnicode /\CZ[lps]\=/ contained containedin=pregEscapeUnicodeError display
      syn match pregEscapeUnicode /}/ contained containedin=pregEscapeUnicodeError display
      " shorthand
      syn match pregEscapeUnicode /\C\\[pP][CLMNPSZ]/ contained display
            \ containedin=pregEscapeUnknown,pregClassEscapeUnknown

      " match the PHP escaping in literal escapes
      syn match pregEscapePHP /\\./he=s+1 contained display containedin=pregEscapeMainQuote
      syn match pregEscapePHP /\\\\/he=s+1 contained display containedin=pregEscapeLiteral

      " this captures confusing usage of escape characters:
      " - need to make sure they don't capture the quote character because
      "   that wouldn't right
      syn match pregEscapeNotNeeded /\\\ze\\[^\\']/ contained display containedin=pregPattern_S,@pregClass_any_S
      syn match pregEscapeNotNeeded /\\\ze\\[^\\"]/ contained display containedin=pregPattern_D,@pregClass_any_D

      " a triple-backslash can be dangerous: it is not obvious that
      " the meaning of the 3rd backslash is dependent on the following
      " character; if the following character is changed to a
      " single-quote or backslash, it will change the meaning of the 3
      " backslashes
      syn match pregEscapeLiteral /\\\{3}\ze[^\\']/ contained display containedin=pregPattern_S
      syn match pregEscapeLiteral /\\\{3}\ze[^\\"]/ contained display containedin=pregPattern_D
      syn match pregClassEscape /\\\{3}\ze[^\\']/ contained display contains=pregClassEscapePHP containedin=@pregClass_any_S
      syn match pregClassEscape /\\\{3}\ze[^\\"]/ contained display contains=pregClassEscapePHP containedin=@pregClass_any_D
      syn match pregClassEscapePHP /\\\\/he=s+1 contained
      hi link pregClassEscapePHP  pregEscapePHP
    " }}}

    " 4) Look for quantifiers ?*+{1,2} {{{

      syn match pregQuantifier /\*?\=/ contained containedin=@pregPattern_Q display
      syn match pregQuantifier /+?\=/  contained containedin=@pregPattern_Q display
      syn match pregQuantifier /??\=/  contained containedin=@pregPattern_Q display

      syn match pregQuantifierComplex /{\d\+\(,\d*\)\=}/ contained containedin=@pregPattern_Q display
      syn match pregQuantifierComplex /{,\d\+}/ contained containedin=@pregPattern_Q display
      syn match pregQuantifier /\d\+/ contained containedin=pregQuantifierComplex display
    " }}}

    " 5) Look for sub-patterns {{{
      syn match pregParens /(/ contained containedin=@pregPattern_Q display
      syn match pregParens /(?<[=!]/ contained containedin=@pregPattern_Q display extend
      syn match pregParens /(?[:>=!]/ contained containedin=@pregPattern_Q display extend
      syn match pregParens /(?(?<\=[=!]/ contained containedin=@pregPattern_Q display extend

      " recursion
      syn match pregParens /(?R)/ contained containedin=@pregPattern_Q display extend
      syn match pregParens /(?[1-9]\d\=)/ contained containedin=@pregPattern_Q display extend
            \ contains=pregBackreferenceNumber

      " conditional sub-patterns
      syn match pregParens /(?(\d\+)/ contained containedin=@pregPattern_Q display
            \ contains=pregBackreferenceNumber
      syn match pregBackreferenceNumber /\d\+/ contained display
      " TODO: move hi link out of here?
      hi link pregBackreferenceNumber pregBackreference
      syn match pregParens /(?\a\+\(-\a\+\)\=[):]/ contained containedin=@pregPattern_Q display
        \ contains=pregOption
      syn match pregParens /(?-\a\+[):]/ contained containedin=@pregPattern_Q display
        \ contains=pregOption
      syn match pregParens /)/ contained containedin=@pregPattern_Q display

      " find a named backreference
      syn match pregBackreference contained containedin=@pregPattern_Q /(?P>\w\+)/ display
            \ contains=pregNamedBackreference
      syn match pregParens contained containedin=@pregPattern_Q /(?P<\w\+>/ display
            \ contains=pregNamedBackreference

      syn match pregNamedBackreference /(?P>\zs\w\+\ze)/ contained display
      syn match pregNamedBackreference /(?P<\zs\w\+\ze>/ contained display
      hi link pregNamedBackreference pregEscapeRange
    " }}}

    " 6) Look for PCRE patterns {{{
      syn cluster phpClFunctions add=phpPREGFunctions

      " look for preg_* functions which take a single pattern
      syn keyword phpPREGFunctions contained preg_match preg_match_all preg_split preg_grep
            \ nextgroup=phpPREGOpenParent,phpPREGRegion

      " special case for preg_replace functions which can take an array of
      " patterns
      syn keyword phpPREGFunctions contained preg_replace preg_replace_callback
            \ nextgroup=phpPREGOpenParentMulti,phpPREGRegionMulti skipwhite skipempty

      if s:strict_blocks
        " regions for ( ) after name of preg_* function
        syn region phpPREGRegion matchgroup=phpParent start=/(/ end=/)/ keepend extend
              \ contained contains=@phpClExpressions,phpPREGStringStarter
        syn region phpPREGRegionMulti matchgroup=phpParent start=/(/ end=/)/ keepend extend
              \ contained contains=@phpClExpressions,phpPREGStringStarter,phpPREGArray

        " match an array of preg patterns
        if s:alt_arrays
          syn region phpPREGArray matchgroup=phpArrayParens start=/\%((\_s*\)\@<=array\_s*(/ end=/)/
                \ keepend extend
                \ contained
                \ contains=@phpClExpressions,phpPREGStringStarter,phpPREGArrayComma,phpPREGArrayComment
        else
          syn match phpPREGArray /\%((\_s*\)\@<=array/ contained
                \ nextgroup=phpPREGArrayRegion skipwhite skipempty

          syn region phpPREGArrayRegion matchgroup=phpParent start=/(/ end=/)/
                \ keepend extend
                \ contained
                \ contains=phpPREGStringStarter,phpPREGArrayComment,phpPREGArrayComma
        endif
        hi link phpPREGArray phpArray

        " a special match to open a pattern string immediately after a '('
        " TODO: will this work as a match instead?
"        syn region phpPREGStringStarter start=/\%((\_s*\)\@<=\z(['"]\)/ end=/\z1/ extend
"              \ contained contains=@phpPREGString_any
        syn match phpPREGStringStarter /\%((\_s*\)\@<=['"]/ extend
              \ contained contains=@phpPREGString_any

        " TODO: move 'hi link' commands out of here
        hi link phpPREGArrayComma phpArrayComma
      else
        " highlight the opening parenthesis
        syn match phpPREGOpenParent /(/ contained nextgroup=@phpPREGString_any display
        hi link phpPREGOpenParent phpParent
        syn match phpPREGOpenParentMulti /(/ contained display
              \ nextgroup=@phpPREGString_any,phpPREGArray skipwhite skipnl skipempty
        hi link phpPREGOpenParentMulti phpPREGOpenParent

        " TODO: move 'hi link' commands out of here
        " match an array of preg patterns
        syn keyword phpPREGArray array contained nextgroup=phpPREGArrayOpenParent
        hi link phpPREGArray phpType
        syn match phpPREGArrayOpenParent /(/ contained display
          \ nextgroup=@phpPREGArrayString_any skipwhite skipnl skipempty
        hi link phpPREGArrayOpenParent phpPREGOpenParent
      endif

      " match a phpString (single or double-quoted) which is able to contain a
      " pregPattern
      " NOTE: we can only error on comma-ending as long as the delimiter is
      " not a comma!!!
      syn cluster phpPREGString_any add=phpPREGStringSingle,phpPREGStringDouble
      syn region phpPREGStringSingle matchgroup=phpQuoteSingle start=/'\ze\z(.\)/ end=/'/
        \ keepend extend contained contains=pregPattern_S
        \ matchgroup=Error end=/\z1\@!,/
      syn region phpPREGStringDouble matchgroup=phpQuoteSingle start=/"\ze\z(.\)/ end=/"/
        \ keepend extend contained contains=pregPattern_D
        \ matchgroup=Error end=/\z1\@!,/

      " match a single-quoted string inside an array, followed by a comma
      " and another string
      " TODO: remove hi link commands from here
      syn cluster phpPREGArrayString_any add=phpPREGArrayStringSingle,phpPREGArrayStringDouble
      syn region phpPREGArrayStringSingle matchgroup=phpQuoteSingle start=/'/ end=/'/
        \ keepend extend contained contains=pregPattern_S
        \ nextgroup=phpPREGArrayComma skipwhite skipnl skipempty
      hi link phpPREGArrayStringSingle phpPREGStringSingle
      syn region phpPREGArrayStringDouble matchgroup=phpQuoteDouble start=/"/ end=/"/
        \ keepend extend contained contains=pregPattern_D
        \ nextgroup=phpPREGArrayComma skipwhite skipnl skipempty
      hi link phpPREGArrayStringDouble phpPREGStringDouble

      " use the comma inside a pattern array to trigger off the next pattern
      syn match phpPREGArrayComma /,/ contained
            \ nextgroup=@phpPREGArrayString_any skipwhite skipnl skipempty

      " use the comments inside a pattern array to trigger off the next pattern
      syn region phpPREGArrayComment start=#//# end=#$# contained keepend extend contains=@Spell
            \ nextgroup=@phpPREGArrayString_any skipwhite skipnl skipempty
      syn region phpPREGArrayComment start=#/\*# end=#\*/# contained keepend extend contains=@Spell
            \ nextgroup=@phpPREGArrayString_any skipwhite skipnl skipempty
      hi link phpPREGArrayComment phpComment
    " }}}

    " 7) Look for pattern delimiters {{{
      syn cluster pregPattern_Q add=pregPattern_S,pregPattern_D

      " add a region which starts with any valid delimiter character
      " and ends when the delimiter character is met again
      syn region pregPattern_S matchgroup=pregDelimiter
        \ start=/\z([ !"#$%&*+,-./:;=?@^_`|~]\)/ start=/\z(\\'\)/
        \ end=/\z1/ skip=/\\\\\{2,3}\|\\\\\z1\=\|\\\z1/ keepend extend
        \ contained nextgroup=pregOptionError_S
        \ contains=pregCommentMultiline
      " repeat above command, but this time instead of the multi-line comment,
      " make it 'oneline'
      syn region pregPattern_S matchgroup=pregDelimiter
        \ start=/\z([ !"#$%&*+,-./:;=?@^_`|~]\)/ start=/\z(\\'\)/
        \ end=/\z1/ skip=/\\\\\{2,3}\|\\\\\z1\=\|\\\z1/ keepend extend
        \ contained nextgroup=pregOptionError_S
        \ oneline

      function! s:pregPattern_S(open, close)
        execute 'syntax region pregPattern_S matchgroup=pregDelimiter'
              \ 'start=/' . a:open . '/'
              \ 'end=/' . a:close . '/'
              \ 'skip=/\\\{4}\|\\\\\=./ keepend extend'
              \ 'contained nextgroup=pregOptionError_S'
      endfunction
      function! s:pregPattern_D(open, close)
        execute 'syntax region pregPattern_D matchgroup=pregDelimiter'
              \ 'start=/' . a:open . '/'
              \ 'end=/' . a:close . '/'
              \ 'skip=/\\\{4}\|\\\\\=./ keepend extend'
              \ 'contained nextgroup=pregOptionError_D'
      endfunction
      call s:pregPattern_S('(', ')')
      call s:pregPattern_S('<', '>')
      call s:pregPattern_S('\[', '\]')
      call s:pregPattern_S('{', '}')
      call s:pregPattern_D('(', ')')
      call s:pregPattern_D('<', '>')
      call s:pregPattern_D('\[', '\]')
      call s:pregPattern_D('{', '}')

      " TODO: make a cluster for the things which go inside double-quoted
      " strings!
      syn region pregPattern_D matchgroup=pregDelimiter
        \ start=/\z([ !'#$%&*+,-./:;=?@^_`|~]\)/ start=/\z(\\"\)/
        \ end=/\z1/ skip=/\\\\\{2,3}\|\\\\\z1\=\|\\\z1/
        \ keepend extend
        \ contained nextgroup=pregOptionError_D
        \ contains=phpIdentifierInString,phpIdentifierInStringComplex,pregCommentMultiline
      " repeat above command, but this time instead of the multi-line comment,
      " make it 'oneline'
      syn region pregPattern_D matchgroup=pregDelimiter
        \ start=/\z([ !'#$%&*+,-./:;=?@^_`|~]\)/ start=/\z(\\"\)/
        \ end=/\z1/ skip=/\\\\\{2,3}\|\\\\\z1\=\|\\\z1/
        \ keepend extend
        \ contained nextgroup=pregOptionError_D
        \ contains=phpIdentifierInString,phpIdentifierInStringComplex
        \ oneline

      " TODO: work out how to have '$' as delimiter in a double-quoted string
"      syn region pregPattern_D matchgroup=pregDelimiter
"        \ start=/\\\$\|\$[a-z_]\@!\%({[a-z_$]\)\@!/
"        \ end=/\\\$\|\$[a-z_]\@!\%({[a-z_$]\)\@!/ skip=/\\\{4}\|\\\{3}[^$]\|\\\\\$/
"        \ keepend extend
"        \ contained nextgroup=pregOptionError_D
"        \ contains=phpIdentifierInString,phpIdentifierInStringComplex

      " TODO move hi link out of here
      hi link pregPattern_S pregPattern
      hi link pregPattern_D pregPattern
    " }}}

    " 8) Look for character classes {{{
      " Inc[lusive] and Exc[lusive] character classes:
      "  if the first char is ']'
      " that is tricky so is handled by another match below
      syn cluster pregClassInc_Q add=pregClassInc_S,pregClassInc_D
      syn cluster pregClassExc_Q add=pregClassExc_S,pregClassExc_D
      syn cluster pregClass_any_S add=pregClassInc_S,pregClassExc_S
      syn cluster pregClass_any_D add=pregClassInc_D,pregClassExc_D
      syn cluster pregClass_any_Q add=@pregClassInc_Q,@pregClassExc_Q

      " TODO: does that 'skip' need to be copied to the line below?
      syn region pregClassInc_S matchgroup=pregClassParent start=/\[\ze[^\^\]]/ end=/\]/ skip=/\\\%(\\\\\]\)\@!\&\\./
            \ keepend display contained containedin=pregPattern_S
      syn region pregClassInc_D matchgroup=pregClassParent start=/\[\ze[^\^\]]/ end=/\]/ skip=/\\./
            \ keepend display contained containedin=pregPattern_D
      " TODO: move these out of here???
      hi link pregClassInc_S pregClassInc
      hi link pregClassInc_D pregClassInc
      hi link pregClassExc_S pregClassExc
      hi link pregClassExc_D pregClassExc

      syn region pregClassExc_S matchgroup=pregClassParent start=/\[\^\]\@!/ end=/\]/ skip=/\\./
        \ keepend display contained containedin=pregPattern_S
      syn region pregClassExc_D matchgroup=pregClassParent start=/\[\^\]\@!/ end=/\]/ skip=/\\./
        \ keepend display contained containedin=pregPattern_D

      " TODO: move hi link commands out of here

      " TODO: just use one match for all character classes???
      " this is an alternate form of the character class region,
      " it is not contained in @pregPattern_Q and can only be activated
      " by a nextgroup=pregClassInc.
      " 'EXECUTE'ed:
      "syntax region pregClassInc_S start=/\ze./ matchgroup=pregClassParent end=/\]/ skip=/\\\\\|\\]/ contained display
      "syntax region pregClassInc_D start=/\ze./ matchgroup=pregClassParent end=/\]/ skip=/\\\\\|\\]/ contained display
      "syntax region pregClassExc_S start=/\ze./ matchgroup=pregClassParent end=/\]/ skip=/\\\\\|\\]/ contained display
      "syntax region pregClassExc_D start=/\ze./ matchgroup=pregClassParent end=/\]/ skip=/\\\\\|\\]/ contained display
      let s:command = 'syntax region pregClass<TYPE> start=/\ze./ matchgroup=pregClassParent end=/\]/'
        \ . ' skip=/\\\\\|\\]/ contained display keepend'
      execute substitute(s:command, '<TYPE>', 'Inc_S', 'g')
      execute substitute(s:command, '<TYPE>', 'Inc_D', 'g')
      execute substitute(s:command, '<TYPE>', 'Exc_S', 'g')
      execute substitute(s:command, '<TYPE>', 'Exc_D', 'g')
      unlet! s:command

      " this is a special match to start off the character class
      " region when the very first character inside it is ']',
      " because otherwise the character class region would end
      " immediately
      syn cluster pregClassIncStart_Q add=pregClassIncStart_S,pregClassIncStart_D
      syn cluster pregClassExcStart_Q add=pregClassExcStart_S,pregClassExcStart_D
      let s:command = 'syntax match pregClassIncStart_<QUOTE> /\[\]/ contained display'
        \ . ' containedin=pregPattern_<QUOTE> nextgroup=pregClassInc_<QUOTE>,pregClassIncEnd'
      execute substitute(s:command, '<QUOTE>', 'S', 'g')
      execute substitute(s:command, '<QUOTE>', 'D', 'g')
      let s:command = 'syntax match pregClassExcStart_<QUOTE> /\[\^\]/ contained display'
        \ . ' containedin=pregPattern_<QUOTE> nextgroup=pregClassExc_<QUOTE>,pregClassExcEnd'
      execute substitute(s:command, '<QUOTE>', 'S', 'g')
      execute substitute(s:command, '<QUOTE>', 'D', 'g')
      unlet! s:command

      " TODO: move hi link commands out of here
      hi link pregClassIncStart_S pregClassParent
      hi link pregClassIncStart_D pregClassParent
      hi link pregClassExcStart_S pregClassParent
      hi link pregClassExcStart_D pregClassParent

      " this is a special match to end off the character class immediately
      " should a ']' be followed immediately by another ']'
      " TODO: move hi link commands out of here
      syn match pregClassIncEnd /\]/ contained display
      hi link pregClassIncEnd pregClassParent
      syn match pregClassExcEnd /\]/ contained display
      hi link pregClassExcEnd pregClassParent

      " add the range-matching string here
      syn cluster pregClassIncRange_Q add=pregClassIncRange_S,pregClassIncRange_D
      syn cluster pregClassExcRange_Q add=pregClassExcRange_S,pregClassExcRange_D
      syn match pregClassIncRange_S contained display
        \ containedin=pregClassInc_S,pregClassIncStart_S
        \ /\%([^\\]\|\\\%(\\\{2}[\\']\=\|x\x\{0,2}\|\o\{1,3}\|[^dsw]\)\)-\%(\\\{3,4}\|\\[^dsw]\|[^\\\]]\)/
      syn match pregClassIncRange_D contained display
        \ containedin=pregClassInc_D,pregClassIncStart_D
        \ /\%([^\\]\|\\\%(\\\{2}[\\"]\=\|x\x\{0,2}\|\o\{1,3}\|[^dsw]\)\)-\%(\\\{3,4}\|\\[^dsw]\|[^\\\]]\)/
      syn match pregClassExcRange_S contained display
        \ containedin=pregClassExc_S,pregClassExcStart_S
        \ /\%([^\\]\|\\\%(\\\{2}[\\']\=\|x\x\{0,2}\|\o\{1,3}\|[^dsw]\)\)-\%(\\\{3,4}\|\\[^dsw]\|[^\\\]]\)/
      syn match pregClassExcRange_D contained display
        \ containedin=pregClassExc_D,pregClassExcStart_D
        \ /\%([^\\]\|\\\%(\\\{2}[\\']\=\|x\x\{0,2}\|\o\{1,3}\|[^dsw]\)\)-\%(\\\{3,4}\|\\[^dsw]\|[^\\\]]\)/
      hi link pregClassIncRange_S pregClassIncRange
      hi link pregClassIncRange_D pregClassIncRange
      hi link pregClassExcRange_S pregClassExcRange
      hi link pregClassExcRange_D pregClassExcRange

      " what about the pre-defined sets using [:space:]?
      syn region pregClassSetRegion matchgroup=pregClassSet start=/\[:/ end=/:\]/
            \ extend keepend
            \ contained containedin=@pregClass_any_Q contains=pregClassSet
      hi link pregClassSetRegion Error
      syn keyword pregClassSet contained
            \ alnum digit punct
            \ alpha graph space
            \ blank lower upper
            \ cntrl print xdigit
      hi link pregClassSet pregEscapeRange

      " highlighted a lone single/double quote as an error
      syn match pregClassQuoteError contained display /'/ containedin=@pregClass_any_S
      syn match pregClassQuoteError contained display /"/ containedin=@pregClass_any_D
      hi link pregClassQuoteError Error

    " }}}

    " 9) Look for escaping using \Q and \E {{{
      syn region pregNonSpecial_S matchgroup=pregParens start=/\C\\Q/ end=/\C\\E/
            \ contained containedin=pregPattern_S
      syn region pregNonSpecial_D matchgroup=pregParens start=/\C\\Q/ end=/\C\\E/
            \ contained containedin=pregPattern_D
      hi link pregNonSpecial_S pregNonSpecial
      hi link pregNonSpecial_D pregNonSpecial
      hi link pregNonSpecial pregPattern

	  " I'm just going to rebuild escapes here to make it easier
	  syn match pregError /'/ contained containedin=pregNonSpecial_S display
	  syn match pregError /"/ contained containedin=pregNonSpecial_D display
	  syn match pregNonSpecialEscape /\\['\\]/ contained containedin=pregNonSpecial_S display
	  syn match pregNonSpecialEscape /\\["\\$]/ contained containedin=pregNonSpecial_D display
	  syn match pregNonSpecialEscapePHP /\\./he=s+1 contained containedin=pregNonSpecialEscape display
	  syn match pregNonSpecialEscapePHP /\\[rnt]/ contained containedin=pregNonSpecial_D display
      hi link pregNonSpecialEscapePHP pregEscapePHP
    " }}}

    " 10) Match PCRE pattern options {{{
      syn match pregOptionError_S /\%(\\[\\']\|[^']\)\+/ contained contains=pregOption display
      syn match pregOptionError_D /\%(\\[\\"]\|[^"]\)\+/ contained display
            \ contains=pregOption,phpIdentifierInString,phpIdentifierInStringComplex
      syn match pregOption /\C[eimsuxADSUX]\+/ contained display
      " TODO: move hi links out of here?
      hi link pregOptionError_S pregOptionError
      hi link pregOptionError_D pregOptionError
    " }}}

    " 11) PCRE pattern comments {{{
      syn match pregComment /\v\(\?\#[^)]*\)/ contained containedin=@pregPattern_Q contains=@Spell

      " TODO: multi-line comments must be turned on explicitly!?
      " syntax match pregComment /\v\#(.*)@>/ contained containedin=@pregPattern_Q
"      if exists('b:php_preg_multiline')
        syntax match pregCommentMultiline /\#\(.*\)\@>/ contained contains=@Spell
        hi! link pregCommentMultiline pregComment
"      endif
    " }}}

    " 12) highlight links {{{
      command -nargs=+ HiLink hi link <args>

      HiLink phpPREGFunctions phpFunctions
      HiLink phpPREGOpenParent phpParent
      HiLink phpPREGStringSingle phpStringSingle
      HiLink phpPREGStringDouble phpStringDouble

      HiLink pregError Error
      HiLink pregAmbiguous Todo

      HiLink pregDelimiter Statement

      HiLink pregOptionError Error
      HiLink pregOption Type

      HiLink pregComment phpComment

      HiLink pregEscapeDelimiter pregDelimiter
      HiLink pregEscapeUnknown pregAmbiguous
      HiLink pregEscapeLiteral Comment
      HiLink pregEscapeSpecial Number
      HiLink pregEscapeAnchor  Typedef
      HiLink pregEscapeRange   Identifier
      HiLink pregEscapePHP	   phpSpecialChar
      HiLink pregEscapeUnicode pregEscapeRange
      HiLink pregEscapeUnicodeError pregError

      HiLink pregEscapeNotNeeded pregEscapePHP

      HiLink pregPattern	Normal
      HiLink pregSpecial	Typedef
      HiLink pregDot        Typedef
      HiLink pregParens	PreProc
      HiLink pregBackreference pregParens

      HiLink pregQuantifier        Typedef
      HiLink pregQuantifierComplex Typedef

      HiLink pregClassParent  pregParens
      HiLink pregClassInc     pregClassParent
      HiLink pregClassExc     pregClassParent
      HiLink pregClassIncRange Identifier
      HiLink pregClassExcRange Identifier
      HiLink pregClassEscape   Comment
      HiLink pregClassIncEscapeKnown pregEscapeSpecial
      HiLink pregClassIncEscapeRange pregClassIncRange
      HiLink pregClassExcEscapeKnown Type
      HiLink pregClassExcEscapeRange pregClassExcRange
      HiLink pregClassEscapeUnknown pregAmbiguous

      delcommand HiLink
    " }}}
endif

" ================================================================

let b:current_syntax = "php"

if main_syntax == 'php'
  unlet main_syntax
endif

" vim: sw=2 sts=2 et fdm=marker fdc=1
