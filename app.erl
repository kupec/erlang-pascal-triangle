-module(app).
-export([start/0]).

start() ->
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
    Triangle = formPascalTriangle([], W, N),
    lists:concat(Triangle).

formPascalTriangle(Result, _, -1) -> Result;
formPascalTriangle(Result, W, N) ->
    PascalLine = pascal:triangleLine(N),
    Line = align:justify(W, PascalLine),
    NextResult = [Line, "\n"] ++ Result,
    formPascalTriangle(NextResult, W, N - 1).

