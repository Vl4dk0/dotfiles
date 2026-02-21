" Syntax file for CL language
" Clear previous syntax
syntax clear

" Keywords
syntax keyword clKeyword incl mod loc fun header theory thm pred axiom proved proof ind indm inst use case cut
syntax match clKeywordBackslash /\\items/
syntax match clKeywordBackslash /\\eq/
syntax match clKeywordBackslash /\\item/
syntax match clKeywordBackslash /\\ft/
syntax match clKeywordBackslash /\\end/
syntax match clKeywordBackslash /\\it/
syntax match clKeywordBackslash /\\bf/
syntax match clKeywordBackslash /\\para/
syntax match clKeywordBackslash /\\item/
highlight link clKeyword Keyword
highlight link clKeywordBackslash Keyword

" Highlights but shouldn't
syntax keyword clSpecialKeyword Define with do and if else while While
highlight link clSpecialKeyword None

" Constants
syntax keyword clConstant Foo
highlight link clConstant Constant

" Function definitions - fun <name> | fun/<number> <name>
" only <name> be highlighted
" doesnt work
syntax match clFunction /\<fun\(\/\d\+\)\?\s\+\zs\w\+\>/
highlight link clFunction Function

" Function names in calls
syntax match clFunctionName /\<\w\+\ze(.*)/
highlight link clFunctionName Function

" Comments
syntax match clComment /\<rem\>.*$/
syntax match clComment /\<loc\s\+rem\>.*$/
highlight link clComment Comment

" Strings and special constants - highlight the quotes too
" doesnt work
syntax region clString start=/'/ end=/'/ oneline
highlight link clString String

" Numbers
syntax match clNumber /\<\d\+\>/ 
highlight link clNumber Number

" Quantifiers
syntax match clQuantifier /\\a\>/ containedin=ALL
syntax match clQuantifier /\\e\>/ containedin=ALL
highlight link clQuantifier Operator

" Arrows and logical operators
syntax match clOperator /<-/
syntax match clOperator /=/
syntax match clOperator /!=/ 
syntax match clOperator /&/
syntax match clOperator /\\\//
syntax match clOperator /++/
syntax match clOperator /mod/
syntax match clOperator /\~/
highlight link clOperator Operator
