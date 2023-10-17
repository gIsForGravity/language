{
  open Parser
}

let blank = [' ' '\t' '\n' '\r']
let digit = ['0'-'9']
let ident = ['A'-'Z' 'a'-'z' '_' '-']['A'-'Z' 'a'-'z' '_' '-' '0'-'9']+

rule token = parse
| blank+   { token lexbuf }
| digit+   { INT_LIT (int_of_string(Lexing.lexeme lexbuf)) }

| '='      { ASSIGN_EQUALS }

| '+'      { PLUS }
| '-'      { MINUS }
| '*'      { TIMES }
| '/'      { DIV }

| '('      { LPAREN }
| ')'      { RPAREN }

| "true"   { BOOL_LIT true }
| "false"  { BOOL_LIT false }

| "=="     { BOOL_EQUALS }
| "&&"     { AND }
| "||"     { OR }
| '!'      { NOT }

| '?'      { TERNARY_QUESTIONMARK }
| ':'      { TERNARY_COLON }

| ';'      { ENDLINE }
| eof      { EOF }
| ";;"     { EOF }
| "println"  { PRINTLN }
| "print"    { PRINT }
| ident      { IDENT (Lexing.lexeme lexbuf) }
| _          { failwith (Printf.sprintf "unexpected character: %s" (Lexing.lexeme lexbuf)) }
