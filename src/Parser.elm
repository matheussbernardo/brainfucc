module Parser exposing
    ( Commands(..)
    , parse
    )


type Commands
    = GoRight
    | GoLeft
    | Increment
    | Decrement
    | Print
    | Read
    | LoopL
    | LoopR
    | Comment Char


parse : String -> List Commands
parse code =
    let
        charToBf chr =
            case chr of
                '>' ->
                    GoRight

                '<' ->
                    GoLeft

                '+' ->
                    Increment

                '-' ->
                    Decrement

                '.' ->
                    Print

                ',' ->
                    Read

                '[' ->
                    LoopL

                ']' ->
                    LoopR

                c ->
                    Comment c
    in
    List.map charToBf (String.toList code)
