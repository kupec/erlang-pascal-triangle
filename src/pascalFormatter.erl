-module(pascalFormatter).
-export([
        format/1,
        findPositions/1,
        lastLinePositions/1
        ]).

format(Triangle) ->
    Positions = findPositions(Triangle),
    TriangleFormat = layoutPascalTriangle(Triangle, Positions),
    string:join(TriangleFormat, "\n").


findPositions([ [1] ]) -> [ [ {left, 0, right, 1} ] ];
findPositions(Triangle) ->
    N = triangleOrder(Triangle),
    LastLinePositions = lastLinePositions(Triangle),
    findPositions([], LastLinePositions, N).


triangleOrder(Triangle) -> length(Triangle) - 1.


lastLinePositions([ [1] ]) -> [ {left, 0, right, 1} ];
lastLinePositions(Triangle) ->
    N = triangleOrder(Triangle),
    LastLineSpaces = triangleLineLengths(Triangle, N - 1),
    LastLineLengths = triangleLineLengths(Triangle, N),
    lastLinePositions([], N + 1, 0, [0] ++ LastLineSpaces, LastLineLengths).


triangleLineLengths(Triangle, Index) ->
    Line = lists:nth(Index + 1, Triangle),
    LengthOfNumberString = fun(Number) -> length(integer_to_list(Number)) end,
    lists:map(LengthOfNumberString, Line).


lastLinePositions(Result, 0, _LastRight, _LineSpaces, _LineLengths) -> Result;
lastLinePositions(Result, Count, LastRight, [Space | LineSpaces], [Length | LineLengths]) ->
    Left = LastRight + Space,
    Right = Left + Length,
    NextResult = Result ++ [{left, Left, right, Right}],
    lastLinePositions(NextResult, Count - 1, Right, LineSpaces, LineLengths).


findPositions(Result, LastPositions, 0) -> [LastPositions | Result];
findPositions(Result, LastPositions, Count) ->
    LinePositions = evalLinePositions(LastPositions, Count),
    findPositions([LastPositions | Result], LinePositions, Count - 1).


evalLinePositions(LastPositions, Count) -> evalLinePositions([], LastPositions, Count).


evalLinePositions(Result, _LastPositions, 0) -> Result;
evalLinePositions(Result, [P1, P2 | LastPositions], Count) ->
    {left, _, right, R1} = P1,
    {left, L2, right, _} = P2,

    Left = R1,
    Right = L2,

    NextResult = Result ++ [ {left, Left, right, Right} ],
    evalLinePositions(NextResult, [P2 | LastPositions], Count - 1).


layoutPascalTriangle(Triangle, Positions) -> layoutPascalTriangle([], Triangle, Positions).


layoutPascalTriangle(Result, [], []) -> Result;
layoutPascalTriangle(Result, [Line | RestTriangle], [Layout | RestPositions]) ->
    FormattedLine = layoutTriangleLine(Line, Layout),
    layoutPascalTriangle(Result ++ [FormattedLine], RestTriangle, RestPositions).


layoutTriangleLine(Line, Layout) -> layoutTriangleLine([], 0, Line, Layout).


layoutTriangleLine(Result, _Offset, [], []) -> Result;
layoutTriangleLine(Result, Offset, [Number | Line], [Position | Layout]) ->
    {left, Left, right, Right} = Position,
    SpaceCount = Left - Offset,
    Length = Right - Left,

    WhiteSpaces = string:copies(" ", SpaceCount),
    NumberFormat = justifyString(Length, integer_to_list(Number)),

    NextResult = Result ++ string:concat(WhiteSpaces, NumberFormat),
    layoutTriangleLine(NextResult, Right, Line, Layout).

justifyString(Length, String) ->
    AlignSpaces = max(0, Length - length(String)),
    LeftSpaces = AlignSpaces div 2,
    RightSpaces = AlignSpaces - LeftSpaces,

    Left = string:copies(" ", LeftSpaces),
    Right = string:copies(" ", RightSpaces),
    string:concat(string:concat(Left, String), Right).
