-module(app).
-export([start/0]).

-define(VERSION, "0.1").

start() ->
    io:fwrite("Pascal Triangle~n"),
    io:fwrite("Version ~s~n", [?VERSION]),

    {ok, [N]} = io:fread("Type a number: ", "~d"),
    Triangle = pascal:triangle(N),

    TriangleFormat = formPascalTriangle(Triangle),

    io:fwrite("~s", [TriangleFormat]).


formPascalTriangle(Triangle) ->
    W = findOptimalTriangleWidth(Triangle),
    TriangleFormat = formPascalTriangle([], Triangle, W, collapse),
    lists:concat(TriangleFormat).


findOptimalTriangleWidth([ [1] ]) -> 1;
findOptimalTriangleWidth(Triangle) ->
    N = length(Triangle) - 1,
    LastLineLength = triangleLineCharsLength(Triangle, N),
    PreLastLineLength = triangleLineCharsLength(Triangle, N - 1),
    LastLineLength + PreLastLineLength.

triangleLineCharsLength(Triangle, LineIndex) ->
    Line = lists:nth(LineIndex + 1, Triangle),
    String = lists:concat(Line),
    length(String).

formPascalTriangle(Result, [], _, _) -> Result;
formPascalTriangle(Result, Triangle, W, JustifyOption) ->
    PascalLine = lists:last(Triangle),
    Line = align:justify(W, PascalLine, JustifyOption),
    NextResult = [Line, "\n"] ++ Result,
    TruncTriangle = lists:delete(PascalLine, Triangle),
    formPascalTriangle(NextResult, TruncTriangle, W, simple).

