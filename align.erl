-module(align).
-export([
    buildLine/2,
    justify/2
]).

% export
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
    NextResult = Result ++ [F, S],
    mixLists(NextResult, FRest, SRest).

% export
justify(Length, Strings) ->
    SpaceCount = getSpaceCount(Length, Strings),
    NumWholes = length(Strings) + 1,
    Wholes = splitNumToList(SpaceCount, NumWholes),
    buildLine(Strings, Wholes).

getSpaceCount(Length, Strings) ->
    TotalChars = lists:concat(Strings),
    max(0, Length - length(TotalChars)).

splitNumToList(Number, Length) ->
    Common = Number div Length,
    Shares = Number rem Length,
    formSplitList(Common, Shares, Length).

formSplitList(Common, Shares, Length) -> formSplitList([], Common, Shares, Length).

formSplitList(Result, _, _, 0) -> Result;
formSplitList(Result, Common, 0, Length) ->
    NextResult = Result ++ [Common],
    formSplitList(NextResult, Common, 0, Length - 1);
formSplitList(Result, Common, Shares, Length) ->
    NextResult = Result ++ [Common + 1],
    formSplitList(NextResult, Common, Shares - 1, Length - 1).

