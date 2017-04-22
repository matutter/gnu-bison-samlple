
%skeleton "lalr1.cc" /* -*- C++ -*- */
%require "3.0.4"
%define parser_class_name {calc_parser}

%output  "calc.tab.cc"
%defines "calc.tab.hh"

%define api.token.constructor
%define api.value.type variant
%define parse.assert

%code requires {
  #include <string>
  class calc_driver;
}

// The parsing context.
%param { calc_driver& driver }

%locations
%initial-action {
  // Initialize the initial location.
  @$.begin.filename = @$.end.filename = &driver.file;
};

%define parse.trace
%define parse.error verbose

%code {
  #include "calc.driver.hh"
}

%define api.token.prefix {TOK_}
%token
  END  0  "end of file"
  ASSIGN  ":="
  MINUS   "-"
  PLUS    "+"
  STAR    "*"
  SLASH   "/"
  LPAREN  "("
  RPAREN  ")"
;

%token <std::string> IDENTIFIER "identifier"
%token <int> NUMBER "number"
%type  <int> exp

%printer { yyoutput << $$; } <*>;

%%

%start unit;
unit: assignments exp  { driver.result = $2; };

assignments:
  %empty                 {}
| assignments assignment {};

assignment:
  "identifier" ":=" exp { driver.variables[$1] = $3; };

%left "+" "-";
%left "*" "/";
exp:
  exp "+" exp   { $$ = $1 + $3; }
| exp "-" exp   { $$ = $1 - $3; }
| exp "*" exp   { $$ = $1 * $3; }
| exp "/" exp   { $$ = $1 / $3; }
| "(" exp ")"   { std::swap ($$, $2); }
| "identifier"  { $$ = driver.variables[$1]; }
| "number"      { std::swap ($$, $1); };

%%

void yy::calc_parser::error (const location_type& l,const std::string& m) {
  driver.error (l, m);
}

