-module(app).
-export([start/0]).

-define(VERSION, "0.1").

start() ->
    io:fwrite("Pascal Triangle~n"),
    io:fwrite("Version ~s~n", [?VERSION]),

    {ok, [N]} = io:fread("Type a number: ", "~d"),
    Triangle = pascal:triangle(N),

    TriangleFormat = pascalFormatter:format(Triangle),

    io:fwrite("~s", [TriangleFormat]).

