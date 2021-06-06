-module(demo).
-export([double/1, times/2, echo/0]). % 1 means function has 1 argument

% this is a comment
% Everything after % is ignored.

double(X) ->
    times(X, 2).

times(X, N) ->
    X * N.

echo() ->
    receive
        {Pid, Msg} ->
            Pid ! Msg,
            echo()
    end.


