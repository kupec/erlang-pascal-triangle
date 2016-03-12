-module(pascal).
-export([start/0]).

start() ->
    % {ok, [N]} = io:fread("Type a number: ", "~d"),
    % oles = alignAtoms(10, []).
    Strings = ["a", "bc", "defg", "qw", "qwerty", "qa"],
    Wholes = [2, 1, 2, 1, 2, 1, 2],

    Line = align:buildLine(Strings, Wholes),
    io:fwrite("Hello:~n|~s|~n", [Line]).


