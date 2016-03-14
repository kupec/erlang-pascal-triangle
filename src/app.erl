-module(app).
-export([start/0]).

-define(VERSION, "0.1").

start() ->
    printAppVersion(),

    Order = readTriangleOrder(),

    Triangle = pascal:triangle(Order),

    printTriangle(Triangle).

printAppVersion() ->
    io:fwrite("Pascal Triangle~n"),
    io:fwrite("Version ~s~n", [?VERSION]).

readTriangleOrder() ->
    {ok, [Order]} = io:fread("Type a number: ", "~d"),
    Order.

printTriangle(Triangle) ->
    Output = pascalFormatter:format(Triangle),
    io:fwrite("~s~n", [Output]).

