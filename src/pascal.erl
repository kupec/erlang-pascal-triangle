-module(pascal).
-export([triangleLine/1]).

triangleLine(0) -> [1];
triangleLine(N) -> triangleLine([], 0, N).

triangleLine(Result, Length, Length) -> Result ++ [1];
triangleLine(Result, Index, Length) ->
    NextResult = Result ++ [combination(Length, Index)],
    triangleLine(NextResult, Index + 1, Length).

combination(_, 0) -> 1;
combination(N, N) -> 1;
combination(N, K) -> factorial(N) div factorial(K) div factorial(N-K).

factorial(0) -> 1;
factorial(N) -> factorial(1, N).

factorial(Result, 1) -> Result;
factorial(Result, N) -> factorial(Result * N, N - 1).

