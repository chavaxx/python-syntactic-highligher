Definitions.
I = [0-9]+
Variable = [A-Z-a-z]+[0-9_]*
Keyword= False|None|True|and|as|assert|async|await|break|class|continue|def|del|elif|else|except|finally|for|from|global|if|import|in|is|lambda|nonlocal|not|or|pass|raise|return|try|while|with|yield
Bindigit= [0-1]+
Octidigit= [0-7]+
Hexadigit = [a-f]*|[A-F]*|[0-9]*
Delimiter= \(|\)|\[|\]|\{|\}|\,|\:|\.|\;|\@|\=|\->|\+=|\-=|\*=|\/=|\//=|\@=|\&=|\^=|\>>=|\<<=|\**=
Operator= \+|\-|\*|\**|\/|\//|\%|\<<|\>>|\&|\||\^|\~|\:=|\<|\>|\<=|\>=|\==|\!=
Datatype= str|int|float|complex|list|tuple|range|dict|set|frozenset|bool|bytes|bytearray|memoryview
SpecialCharacters = \\a|\b|\f|\n|\r|\t|\v|\ooo|\\xhh|\s
%Print, es una keyword pero lo maneje por separado para poder darle un color distinto
Print=print
Rules.

%[\s]+ : skip_token.
{I} : {token, {integer, TokenLine, TokenChars}}.
{Keyword} : {token, {keyword, TokenLine, TokenChars}}.
{Datatype} : {token, {datatype, TokenLine, TokenChars}}.
{SpecialCharacters} : {token, {specialCaracter, TokenLine, TokenChars}}.
{Print} : {token, {print, TokenLine, TokenChars}}.
{Variable} : {token, {variable, TokenLine, TokenChars}}.
0[b|B]{Bindigit}+(\_{Bindigit}+)* : {token, {binary, TokenLine, TokenChars}}.
0[o|O]{Octidigit}+(\_{Octidigit}+)* : {token, {octal, TokenLine, TokenChars}}.
0[x|X]{Hexadigit}+(\_{Hexadigit}+)* : {token, {hexadecimal, TokenLine, TokenChars}}.
{I}+[e|E]+[\+|\-]+{0-9}+ : {token, {exponent, TokenLine, TokenChars}}.
% float en python 3 casos 
{I}+\.{I}+|{I}+[eE][+-]?{I}+|{I}+\.{I}+[eE][+-]?{I}+ : {token, {float, TokenLine, TokenChars}}.
{I}+j|{I}+\.{I}+j|{I}+[eE][+-]?{I}+j|{I}+\.{I}+[eE][+-]?{I}+j : {token, {imaginaryliteral, TokenLine, TokenChars}}.
{Delimiter} : {token, {delimiter, TokenLine, TokenChars}}.
{Operator} : {token, {operator, TokenLine, TokenChars}}.


%strings and chars
'([^']|(\\'))*' : {token, {charlist, TokenLine, TokenChars}}.
"([^"]|(\\"))*" : {token, {string, TokenLine, TokenChars}}.

%comments (falta el single line)
#.* : {token, {comment, TokenLine, TokenChars}}.
"""([^"]|(\\")|\n)*""" : {token, {multilineComment, TokenLine, TokenChars}}.



%special strings 
[fF]"[^"]*" : {token, {fstring, TokenLine, TokenChars}}.
[uU]"[^"]*" : {token, {ustring, TokenLine, TokenChars}}.
[rR]"[^"]*" : {token, {rstring, TokenLine, TokenChars}}.
(fr|Fr|fR|FR)"[^"]*" : {token, {frstring, TokenLine, TokenChars}}.
(rF|rf|Rf|RF)"[^"]*" : {token, {rfstring, TokenLine, TokenChars}}.

% Ascii  characters not used in Python

\$|\? : {token, {errorAscii, TokenLine, TokenChars}}.

Erlang code.