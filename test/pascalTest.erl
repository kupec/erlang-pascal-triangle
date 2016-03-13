-module(pascalTest).
-include_lib("eunit/include/eunit.hrl").

triangleLine_test_() ->
    [
    ?_assertEqual(pascal:triangleLine(0), [1]),
    ?_assertEqual(pascal:triangleLine(1), [1, 1]),
    ?_assertEqual(pascal:triangleLine(2), [1, 2, 1]),
    ?_assertEqual(pascal:triangleLine(5), [1, 5, 10, 10, 5, 1])
    ].
