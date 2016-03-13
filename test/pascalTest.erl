-module(pascalTest).
-include_lib("eunit/include/eunit.hrl").

triangleLine_test_() ->
    F = fun pascal:triangleLine/1,
    [
    ?_assertEqual(F(0), [1]),
    ?_assertEqual(F(1), [1, 1]),
    ?_assertEqual(F(2), [1, 2, 1]),
    ?_assertEqual(F(5), [1, 5, 10, 10, 5, 1])
    ].

