-module(pascalFormatter).
-export([
        format/1
        ]).

format(Triangle) ->
    W = optimalWidth(Triangle),
    TriangleFormat = formPascalTriangle([], Triangle, W, collapse),
    lists:concat(TriangleFormat).


optimalWidth([ [1] ]) -> 1;
optimalWidth(Triangle) ->
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

