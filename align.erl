-module(align).
-export([
    buildLine/2
]).

buildLine(Strings, Wholes) ->
    Spaces = stringifyWholes(Wholes),
    AlignedStrings = mixLists(Spaces, Strings),

    lists:concat(AlignedStrings).

stringifyWholes(Wholes) -> stringifyWholes([], Wholes).

stringifyWholes(Result, []) -> Result;
stringifyWholes(Result, [Whole|Rest]) ->
    Space = repeatChar(" ", Whole),
    NextResult = Result ++ [Space],
    stringifyWholes(NextResult, Rest).


repeatChar(Char, Length) -> repeatChar(Char, Length, "").

repeatChar(_, 0, Result) -> Result;
repeatChar(Char, Length, Result) ->
    NextResult = string:concat(Result, Char),
    repeatChar(Char, Length - 1, NextResult).

mixLists(First, Second) -> mixLists([], First, Second).

mixLists(Result, First, []) -> Result ++ First;
mixLists(Result, [], Second) -> Result ++ Second;
mixLists(Result, [F|FRest], [S|SRest]) ->
    NextResult = [F, S] ++ Result,
    mixLists(NextResult, FRest, SRest).

