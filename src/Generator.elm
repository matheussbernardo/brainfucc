module Generator exposing (footer, generate, header)

import Parser exposing (Commands(..))


header : String
header =
    """
#include "stdio.h"

int main()
{
    char tape[20000] = {0};
    char *ptr = tape;
"""


footer : String
footer =
    """
return 0;
}
"""


generate : List Commands -> List String
generate brainfuck_code =
    let
        transform_to_c : Commands -> String
        transform_to_c command =
            case command of
                GoRight ->
                    "    " ++ "++prt;\n"

                GoLeft ->
                    "    " ++ "--prt;\n"

                Increment ->
                    "    " ++ "++*ptr;\n"

                Decrement ->
                    "    " ++ "--*ptr;\n"

                Print ->
                    "    " ++ "putchar(*ptr);\n"

                Read ->
                    "    " ++ "*ptr=getchar();\n"

                LoopL ->
                    "    " ++ "while (*ptr) {\n"

                LoopR ->
                    "    " ++ "}\n"

                Comment c ->
                    ""
    in
    header :: List.map transform_to_c brainfuck_code ++ [ footer ]
