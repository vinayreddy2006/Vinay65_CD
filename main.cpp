#include <iostream>

extern int yyparse();

int main() {
    std::cout << "Enter Expression eg:- VINAY a = b, c, t;):\n";
    yyparse();
    return 0;
}
