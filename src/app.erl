-module(app).
-export([start/0]).

-define(VERSION, "0.1").

start() ->
    io:fwrite("Pascal Triangle~n"),
    io:fwrite("Version ~s~n", [?VERSION]),

    {ok, [N]} = io:fread("Type a number: ", "~d"),
    W = findOptimalTriangleWidth(N),
    Triangle = formPascalTriangle(W, N),

    io:fwrite("~s", [Triangle]).

findOptimalTriangleWidth(0) -> 1;
findOptimalTriangleWidth(N) ->
    LastLineLength = charLengthTriangleLine(N),
    PreLastLineLength = charLengthTriangleLine(N - 1),
    LastLineLength + PreLastLineLength.

charLengthTriangleLine(N) ->
    Line = pascal:triangleLine(N),
    String = lists:concat(Line),
    length(String).

formPascalTriangle(W, N) ->
    Triangle = formPascalTriangle([], W, N, collapse),
    lists:concat(Triangle).

formPascalTriangle(Result, _, -1, _) -> Result;
formPascalTriangle(Result, W, N, JustifyOption) ->
    PascalLine = pascal:triangleLine(N),
    Line = align:justify(W, PascalLine, JustifyOption),
    NextResult = [Line, "\n"] ++ Result,
    formPascalTriangle(NextResult, W, N - 1, simple).

