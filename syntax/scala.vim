" Vim syntax file
" Language   : Scala (http://scala-lang.org/)
" Maintainers: Stefan Matthias Aust, Julien Wetterwald
" Last Change: 2007 June 13

if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

syn case match
syn sync minlines=50

" most Scala keywords
syn keyword scalaKeyword case
syn keyword scalaKeyword catch
syn keyword scalaKeyword do
syn keyword scalaKeyword else
syn keyword scalaKeyword extends
syn keyword scalaKeyword final
syn keyword scalaKeyword finally
syn keyword scalaKeyword for
syn keyword scalaKeyword forSome
syn keyword scalaKeyword if
syn keyword scalaKeyword match
syn keyword scalaKeyword new
syn keyword scalaKeyword null
syn keyword scalaKeyword require
syn keyword scalaKeyword return
syn keyword scalaKeyword super
syn keyword scalaKeyword this
syn keyword scalaKeyword throw
syn keyword scalaKeyword try
syn keyword scalaKeyword type
syn keyword scalaKeyword while
syn keyword scalaKeyword with
syn keyword scalaKeyword yield
syn keyword scalaKeywordModifier abstract
syn keyword scalaKeywordModifier override
syn keyword scalaKeywordModifier final
syn keyword scalaKeywordModifier implicit
syn keyword scalaKeywordModifier lazy
syn keyword scalaKeywordModifier private
syn keyword scalaKeywordModifier protected
syn keyword scalaKeywordModifier sealed
syn match scalaKeyword "=>"
syn match scalaKeyword "⇒"
syn match scalaKeyword "<-"
syn match scalaKeyword "←"
syn match scalaKeyword "\<_\>"

syn match scalaOperator ":\{2,\}" "this is not a type

" package and import statements
syn keyword scalaPackage package nextgroup=scalaFqn skipwhite
syn keyword scalaImport import nextgroup=scalaFqn skipwhite
syn match scalaFqn "\<[._$a-zA-Z0-9,]*" contained nextgroup=scalaFqnSet
syn region scalaFqnSet start="{" end="}" contained

" boolean literals
syn keyword scalaBoolean true false

" definitions
syn keyword scalaDef def nextgroup=scalaDefName skipwhite
syn keyword scalaVal val nextgroup=scalaValName skipwhite
syn keyword scalaVar var nextgroup=scalaVarName skipwhite
syn keyword scalaClass class nextgroup=scalaClassName skipwhite
syn keyword scalaObject object nextgroup=scalaClassName skipwhite
syn keyword scalaTrait trait nextgroup=scalaClassName skipwhite
syn keyword scalaTypeAlias type nextgroup=scalaTypeAliasName skipwhite
syn match scalaDefName "[^ =:;([]\+" contained nextgroup=scalaDefSpecializer skipwhite
syn match scalaValName "[^ =:;([]\+" contained
syn match scalaVarName "[^ =:;([]\+" contained
syn match scalaClassName "[^ =:;(\[]\+" contained nextgroup=scalaClassSpecializer skipwhite
syn match scalaTypeAliasName "[^ =:;([]\+" contained nextgroup=scalaTypeAliasSpecializer skipwhite
syn region scalaDefSpecializer start="\[" end="\]" contained contains=scalaDefSpecializer
syn region scalaClassSpecializer start="\[" end="\]" contained contains=scalaClassSpecializer
syn region scalaTypeAliasSpecializer start="\[" end="\]" contained contains=scalaTypeAliasSpecializer
syn match scalaBackTick "`[^`]\+`"

" type constructor (actually anything with an uppercase letter)
syn match scalaConstructor "\<[A-Z][_$a-zA-Z0-9]*\>" nextgroup=scalaConstructorSpecializer
syn region scalaConstructorSpecializer start="\[" end="\]" contained contains=scalaConstructorSpecializer

" method call
syn match scalaRoot "\<[a-zA-Z][_$a-zA-Z0-9]*\."me=e-1
syn match scalaMethodCall "\.[a-z][_$a-zA-Z0-9]*"ms=s+1

" type declarations in val/var/def
syn match scalaType ":\s*\(=>\s*\)\?[._$a-zA-Z0-9]\+\(\[[^]]*\]\+\)\?\(\s*\(<:\|>:\|#\|=>\)\s*[._$a-zA-Z0-9]\+\(\[[^]]*\]\+\)*\)*"ms=s+1

" comments
syn match scalaTodo "[tT][oO][dD][oO]" contained
syn match scalaLineComment "//.*" contains=scalaTodo
syn region scalaComment start="/\*" end="\*/" contains=scalaTodo
syn case ignore
syn include @scalaHtml syntax/html.vim
syn case match
syn region scalaDocComment start="/\*\*" end="\*/" contains=scalaDocTags,scalaTodo,@scalaHtml,scalaDocMarkup keepend
syn match scalaDocMarkup ".*" contained
syn region scalaDocTags start="{@\(link\|linkplain\|inherit[Dd]oc\|doc[rR]oot\|value\)" end="}" contained
syn match scalaDocTags "@[a-z]\+" contained

" annotations
syn match scalaAnnotation "@[a-zA-Z]\+"

syn match scalaEmptyString "\"\""

" multi-line string literals
syn region scalaMultiLineString start="\"\"\"" end="\"\"\"\"\@!" contains=scalaUnicode
syn match scalaUnicode "\\u[0-9a-fA-F]\{4}" contained

" string literals with escapes
syn region scalaString start="\"[^"]" skip="\\\"" end="\"" contains=scalaStringEscape " TODO end \n or not?
syn match scalaStringEscape "\\u[0-9a-fA-F]\{4}" contained
syn match scalaStringEscape "\\[nrfvb\\\"]" contained

" symbol and character literals
syn match scalaSymbol "'[_a-zA-Z0-9][_a-zA-Z0-9]*\>"
syn match scalaChar "'[^'\\]'\|'\\.'\|'\\u[0-9a-fA-F]\{4}'"

" number literals
syn match scalaNumber "\<\(0[0-7]*\|0[xX]\x\+\|\d\+\)[lL]\=\>"
syn match scalaNumber "\(\<\d\+\.\d*\|\.\d\+\)\([eE][-+]\=\d\+\)\=[fFdD]\="
syn match scalaNumber "\<\d\+[eE][-+]\=\d\+[fFdD]\=\>"
syn match scalaNumber "\<\d\+\([eE][-+]\=\d\+\)\=[fFdD]\>"

" xml literals
syn match scalaXmlTag "<[a-zA-Z]\_[^>]*/>" contains=scalaXmlQuote,scalaXmlEscape,scalaXmlString
syn region scalaXmlString start="\"" end="\"" contained
syn match scalaXmlStart "<[a-zA-Z]\_[^>]*>" contained contains=scalaXmlQuote,scalaXmlEscape,scalaXmlString
syn region scalaXml start="<\([a-zA-Z]\_[^>]*\_[^/]\|[a-zA-Z]\)>" matchgroup=scalaXmlStart end="</\_[^>]\+>" contains=scalaXmlEscape,scalaXmlQuote,scalaXml,scalaXmlStart,scalaXmlComment
syn region scalaXmlEscape matchgroup=scalaXmlEscapeSpecial start="{" matchgroup=scalaXmlEscapeSpecial end="}" contained contains=TOP
syn match scalaXmlQuote "&[^;]\+;" contained
syn match scalaXmlComment "<!--\_[^>]*-->" contained

" REPL
syn match scalaREPLCmdLine "\<scala>\>"

syn sync fromstart

" map Scala groups to standard groups
hi def link scalaKeyword Keyword
hi def link scalaKeywordModifier Keyword
hi def link scalaAnnotation Include
hi def link scalaPackage Include
hi def link scalaImport Include
hi def link scalaREPLCmdLine Include
hi def link scalaDocTags Comment
hi def link scalaBackTick Include
hi def link scalaBoolean Boolean
hi def link scalaOperator Normal
hi def link scalaNumber Number
hi def link scalaEmptyString String
hi def link scalaString String
hi def link scalaChar String
hi def link scalaMultiLineString String
hi def link scalaStringEscape Special
hi def link scalaSymbol Constant
hi def link scalaUnicode Special
hi def link scalaComment Comment
hi def link scalaLineComment Comment
hi def link scalaDocComment Comment
hi def link scalaDocMarkup Comment
hi def link scalaTodo Todo
hi def link scalaType Type
hi def link scalaTypeSpecializer scalaType
hi def link scalaXml String
hi def link scalaXmlTag Include
hi def link scalaXmlString String
hi def link scalaXmlStart Include
hi def link scalaXmlEscape Normal
hi def link scalaXmlEscapeSpecial Special
hi def link scalaXmlQuote Special
hi def link scalaXmlComment Comment
hi def link scalaDef Keyword
hi def link scalaVar Keyword
hi def link scalaVarName Underlined
hi def link scalaVal Keyword
hi def link scalaValName Constant
hi def link scalaClass Keyword
hi def link scalaObject Keyword
hi def link scalaTrait Keyword
hi def link scalaTypeAlias Keyword
hi def link scalaDefName Function
hi def link scalaDefSpecializer Function
hi def link scalaClassName Type
hi def link scalaClassSpecializer Type
hi def link scalaTypeAliasName Type
hi def link scalaTypeAliasSpecializer Type
hi def link scalaConstructor Type
hi def link scalaConstructorSpecializer scalaConstructor

let b:current_syntax = "scala"

" you might like to put these lines in your .vimrc
"
" customize colors a little bit (should be a different file)
" hi scalaNew gui=underline
" hi scalaMethodCall gui=italic
" hi scalaValName gui=underline
" hi scalaVarName gui=underline
