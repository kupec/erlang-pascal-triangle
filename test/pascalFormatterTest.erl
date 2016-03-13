-module(pascalFormatterTest).
-include_lib("eunit/include/eunit.hrl").

format_test_() ->
    F = fun(N) -> pascalFormatter:format(pascal:triangle(N)) end,
    [
    ?_assertEqual(F(0),
"1
"
),
    ?_assertEqual(F(1),
" 1 
1 1
"
),
    ?_assertEqual(F(4),
"    1    
   1  1  
  1  2 1 
 1 3 3 1 
1 4 6 4 1
"
)
    ].
