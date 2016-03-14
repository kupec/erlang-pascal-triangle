-module(pascalFormatterTest).
-include_lib("eunit/include/eunit.hrl").

format_test_() ->
    F = fun(N) -> pascalFormatter:format(pascal:triangle(N)) end,
    [
    ?_assertEqual(F(0), "1"),
    ?_assertEqual(F(1), string:join([
                                        " 1",
                                        "1 1"
                                    ], "\n")
                  ),
    ?_assertEqual(F(4), string:join([
                                        "    1",
                                        "   1 1",
                                        "  1 2 1",
                                        " 1 3 3 1",
                                        "1 4 6 4 1"
                                    ], "\n")
)
    ].


lastLinePositions_test_() ->
    F = fun(N) -> pascalFormatter:lastLinePositions(pascal:triangle(N)) end,
    [
    ?_assertEqual(F(0), [ {left, 0, right, 1} ]),
    ?_assertEqual(F(1), [ {left, 0, right, 1}, {left, 2, right, 3} ]),
    ?_assertEqual(F(5), [
                          {left,  0, right,  1}, % 1
                          {left,  2, right,  3}, % 5
                          {left,  4, right,  6}, % 10
                          {left,  7, right,  9}, % 10
                          {left, 10, right, 11}, % 5
                          {left, 12, right, 13}  % 1
                        ])
    ].


findPositions_test_() ->
    F = fun(N) -> pascalFormatter:findPositions(pascal:triangle(N)) end,
    [
    ?_assertEqual(F(0), [ [ {left, 0, right, 1} ] ]),
    ?_assertEqual(F(1), [
                         [ {left, 1, right, 2} ],
                         [ {left, 0, right, 1}, {left, 2, right, 3} ]
                        ]),
    ?_assertEqual(F(2), [
                         [ {left, 2, right, 3} ],
                         [ {left, 1, right, 2}, {left, 3, right, 4} ],
                         [ {left, 0, right, 1}, {left, 2, right, 3} , {left, 4, right, 5} ]
                        ])
    ].
